Class {
	#name : #MbDFullySeparatedCVCVJoint,
	#superclass : #MbDSeparatedCVCVJoint,
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #'VisualWorks metadata' }
MbDFullySeparatedCVCVJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #dynamic }
MbDFullySeparatedCVCVJoint >> becomeInCollisionCVCVJoint [
	self changeClassToThatOf: MbDInCollisionCVCVJoint basicNew.
	frmI becomeNoContactEndFrame.
	frmJ becomeNoContactEndFrame
]

{ #category : #dynamic }
MbDFullySeparatedCVCVJoint >> checkForDynDiscontinuityBetween: tprevious and: t [ 
	"Check separation is less than zero and decreasing."

	| sepTol direction |
	sepTol := self separationTol.
	^(separation <= sepTol negated and: [separation < (separationPast at: 1)]) 
		ifTrue: 
			["Collision."

			newtonRaphson := MbDZeroSeparationNewtonRaphson2 new.
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

{ #category : #dynamic }
MbDFullySeparatedCVCVJoint >> discontinuityAt: tstartNew addTypeTo1: collection [ 
	tstart = tstartNew ifFalse: [^self].
	separation := rIeJe
				calcSeparationDistance;
				separationDistance.
	TheMbDSystem logSeparationDistance: separation.
	collection add: #REBOUND
]

{ #category : #dynamic }
MbDFullySeparatedCVCVJoint >> discontinuityAt: tstartNew addTypeTo2: collection [ 
	| tstartPast1 hout dtstart dtstartTol |
	tstart = tstartNew ifFalse: [^self].
	separation := rIeJe
				calcSeparationDistance;
				separationDistance.
	TheMbDSystem logSeparationDistance: separation.
	tstartPast1 := TheMbDSystem pastStartTimes at: 1.
	hout := TheMbDSystem outputStepSize.
	dtstart := (tstart - tstartPast1) abs.
	dtstartTol := 0.1d * hout.
	dtstart < dtstartTol 
		ifTrue: 
			["Rapid collisions"

			self halt: 'Check for vIeJeOKez.'.
			self becomeStartingInContactCVCVJoint.
			collection add: #TOUCHDOWN]
		ifFalse: [collection add: #REBOUND]
]

{ #category : #dynamic }
MbDFullySeparatedCVCVJoint >> discontinuityAt: tstartNew addTypeTo3: collection [ 
	| pastStartTimes hout dstartTol |
	tstart = tstartNew ifFalse: [^self].
	separation := rIeJe
				calcSeparationDistance;
				separationDistance.
	TheMbDSystem logSeparationDistance: separation.
	pastStartTimes := TheMbDSystem pastStartTimes.
	hout := TheMbDSystem outputStepSize.
	dstartTol := 0.1d * hout.
	(pastStartTimes size >= 3 
		and: [((pastStartTimes at: 3) - tstartNew) abs < dstartTol]) 
			ifTrue: 
				["Rapid collisions causing decay."

				"Multiple collisions from other joints may cause this too!"

				self becomeStartingInContactCVCVJoint.
				collection add: #TOUCHDOWN]
			ifFalse: [collection add: #REBOUND]
]

{ #category : #dynamic }
MbDFullySeparatedCVCVJoint >> discontinuityAt: tstartNew addTypeTo: collection [ 
	| pastStartTimes hout dstartTol |
	tstart = tstartNew ifFalse: [^self].
	separation := rIeJe
				calcSeparationDistance;
				separationDistance.
	TheMbDSystem logSeparationDistance: separation.
	pastStartTimes := TheMbDSystem pastStartTimes.
	hout := TheMbDSystem outputStepSize.
	dstartTol := 0.1d * hout.
	(pastStartTimes size >= 3 
		and: [((pastStartTimes at: 3) - tstartNew) abs < dstartTol]) 
			ifTrue: 
				["Rapid collisions causing decay."

				"Multiple collisions from other joints may cause this too!"

				self becomeStartingInContactCVCVJoint.
				collection add: #TOUCHDOWN]
			ifFalse: [collection add: #REBOUND]
]

{ #category : #accIC }
MbDFullySeparatedCVCVJoint >> discontinuityAtICAddTo1: collection [ 
	self halt: 'check for impact.'.
	separation < -1.0d-6 ifTrue: [collection add: #TOUCHDOWN]
]

{ #category : #accIC }
MbDFullySeparatedCVCVJoint >> discontinuityAtICAddTo2: collection [ 
	separation < 1.0d-6 
		ifTrue: 
			[separation > -1.0d-6 
				ifTrue: 
					["Small separation"

					self vIeJeOIez value < 1.0d-6 
						ifTrue: 
							[self vIeJeOIez value > -1.0d-6 
								ifTrue: 
									["Small relative velocity"

									(contactForcePast isEmpty or: [contactForcePast first negative not]) 
										ifTrue: 
											[self becomeStartingInContactCVCVJoint.
											collection add: #TOUCHDOWN]]
								ifFalse: 
									[self becomeInCollisionCVCVJoint.
									collection add: #REBOUND]]]
				ifFalse: 
					[self becomeStartingInContactCVCVJoint.
					collection add: #TOUCHDOWN]]
]

{ #category : #accIC }
MbDFullySeparatedCVCVJoint >> discontinuityAtICAddTo: collection [ 
	| sepTol velTol accTol vIeJeOIez |
	sepTol := self separationTol.
	velTol := 10.0d * sepTol.
	accTol := 100.0d * sepTol.
	separation < sepTol 
		ifTrue: 
			[separation > sepTol negated 
				ifTrue: 
					["Small separation"

					vIeJeOIez := self vIeJeOIez.
					vIeJeOIez < velTol 
						ifTrue: 
							[vIeJeOIez > velTol negated 
								ifTrue: 
									["Small relative velocity"

									self aIeJeOIez < accTol negated 
										ifTrue: 
											[self becomeStartingInContactCVCVJoint.
											collection add: #TOUCHDOWN]]
								ifFalse: 
									[coeffRestitution = 0.0d 
										ifTrue: 
											[self becomeStartingInContactCVCVJoint.
											collection add: #TOUCHDOWN]
										ifFalse: 
											[self becomeInCollisionCVCVJoint.
											collection add: #REBOUND]]]]
				ifFalse: 
					[separationPast isEmpty 
						ifTrue: 
							[self becomeStartingInContactCVCVJoint.
							collection add: #TOUCHDOWN]
						ifFalse: 
							[self 
								logString: #'MbD: \CVCV separation distance have not be calculated accurately. \Make the Maximum Time Step smaller to prevent excessive step sizes.'.
							SimulationStoppingError raiseSignal]]]
]

{ #category : #dynamic }
MbDFullySeparatedCVCVJoint >> preDynStep [
	TheMbDSystem logSeparationDistance: separation
]

{ #category : #posIC }
MbDFullySeparatedCVCVJoint >> preICRestart [
	| sepTol |
	sepTol := self separationTol.
	separation <= sepTol negated 
		ifTrue: [self becomeStartingInContactCVCVJoint]
]

{ #category : #accessing }
MbDFullySeparatedCVCVJoint >> separationAt: tout [ 
	| answer |
	answer := self separationDerivative: 0 at: tout.
	"Transcript cr; show: 'separationAt:'; show: answer printString."
	^answer
]

{ #category : #accessing }
MbDFullySeparatedCVCVJoint >> separationDerivative: n at: tout [ 
	^interpolator
		derivative: n
		at: tout
		present: separation
		past: separationPast
]

{ #category : #dynamic }
MbDFullySeparatedCVCVJoint >> suggestSmallerOrAcceptDynStepSize: hnew [ 
	| timeNew separationNew sepTol h |
	timeNew := interpolator time + (interpolator direction * hnew).
	separationNew := self separationAt: timeNew.
	sepTol := self separationTol.
	^(separation <= sepTol negated and: [separationNew < separation]) 
		ifTrue: 
			["Collision. Take a conservative step."

			h := interpolator currentStepSize abs.
			hnew min: h]
		ifFalse: [hnew]
]
