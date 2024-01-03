Class {
	#name : #MbDInContactCVCVJoint,
	#superclass : #MbDIntermittentCVCVJoint,
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #dynamic }
MbDInContactCVCVJoint >> becomeSeparatedCVCVJoint [
	self changeClassToThatOf: MbDFullySeparatedCVCVJoint basicNew.
	frmI becomeNoContactEndFrame.
	frmJ becomeNoContactEndFrame.
	constraints become: unusedConstraints
]

{ #category : #dynamic }
MbDInContactCVCVJoint >> calcLSScoeffs [
	"Least squares fit with quadratic equation."
	"y(tout) = a0 + a1*tout + a2*tout*tout."

	| n xs ys t tpast |
	n := interpolator nStep + 1.
	xs := FullRow new: n.
	ys := FullRow new: n.
	t := interpolator time.
	tpast := interpolator timeNodes.
	xs at: 1 put: t.
	ys at: 1 put: contactForce.
	2 to: n
		do: 
			[:i | 
			xs at: i put: (tpast at: i - 1).
			ys at: i put: (contactForcePast at: i - 1)].
	leastSquaresFit
		x: IndependentVariable new
		order: 2
		xs: xs
		ys: ys
]

{ #category : #dynamic }
MbDInContactCVCVJoint >> checkForDynDiscontinuityBetween: tprevious and: t [ 
	"Check contactForce less than zero and decreasing."

	| forTol direction |
	forTol := self contactForceTol.
	^(contactForce < forTol negated 
		and: [contactForce < (contactForcePast at: 1)]) 
			ifTrue: 
				["Lift off."

				newtonRaphson := MbDZeroContactForceNewtonRaphson2 new.
				newtonRaphson system: self.
				newtonRaphson run.
				direction := tprevious < t ifTrue: [1.0d] ifFalse: [-1.0d].
				direction * tstart <= (direction * tprevious) 
					ifTrue: 
						["
				Make tstart a shade larger than tprevious."

						tstart := (direction * tprevious) nextLargerNumber / direction].
				(direction * tstart min: direction * t) / direction]
			ifFalse: [t]
]

{ #category : #'initialize-release' }
MbDInContactCVCVJoint >> connectsI: mkrII toJ: mkrJJ [ 
	super connectsI: mkrII toJ: mkrJJ.
	frmI becomeContactEndFrame.
	frmJ becomeContactEndFrame
]

{ #category : #dynamic }
MbDInContactCVCVJoint >> discontinuityAt: tstartNew addTypeTo: collection [ 
	tstart = tstartNew 
		ifTrue: 
			[contactForce := self contactForce.
			TheMbDSystem logContactForce: contactForce.
			self becomeSeparatedCVCVJoint.
			collection add: #LIFTOFF]
		ifFalse: [self becomeStartingInContactCVCVJoint]
]

{ #category : #dynamic }
MbDInContactCVCVJoint >> preDynStep [
	TheMbDSystem logContactForce: contactForce
]

{ #category : #posIC }
MbDInContactCVCVJoint >> preICRestart [
	contactForce < 0.0d
		ifTrue: 
			[unusedConstraints become: constraints.
			self becomeSeparatedCVCVJoint]
]

{ #category : #accIC }
MbDInContactCVCVJoint >> recordContactForceAndSeparationDistance [
	contactForce := self contactForce.
	separation := 0.0d
]

{ #category : #dynamic }
MbDInContactCVCVJoint >> suggestSmallerOrAcceptDynStepSize: hnew [ 
	| timeNew contactForceNew h |
	timeNew := interpolator time + (interpolator direction * hnew).
	contactForceNew := self contactForceAt: timeNew.
	^(contactForceNew < 0.0d and: [contactForceNew < contactForce])
		ifTrue: 
			["Lift off. Take a conservative step."
			h := interpolator currentStepSize abs.
			hnew min: h]
		ifFalse: [hnew]
]
