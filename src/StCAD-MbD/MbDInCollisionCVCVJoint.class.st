Class {
	#name : #MbDInCollisionCVCVJoint,
	#superclass : #MbDSeparatedCVCVJoint,
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #collision }
MbDInCollisionCVCVJoint >> becomeSeparatedCVCVJoint [
	self changeClassToThatOf: MbDFullySeparatedCVCVJoint basicNew.
	frmI becomeNoContactEndFrame.
	frmJ becomeNoContactEndFrame
]

{ #category : #collision }
MbDInCollisionCVCVJoint >> checkForCollisionDiscontinuityBetween: impulsePrevious and: impulse [ 
	"Find normal impulse (Pcz0) that makes impact velocity zero 
	(maxCompression)."
	"Stop collision at tend := (1 + E)*Pcz0."
	"When integrating backward, stop collision at tend := (1 + 
	(1/E))*Pcz0."

	| direction |
	direction := impulsePrevious < impulse
				ifTrue: [1.0d]
				ifFalse: [-1.0d].
	direction * impulseStart <= (direction * impulsePrevious)
		ifTrue: ["End of collision is unknown."
			direction * impactVelocity > 0
				ifTrue: 
					["Find maximum compression."
					"Find end of collision."
					newtonRaphson := MbDZeroImpactVelocityNewtonRaphson2 new.
					newtonRaphson system: self.
					newtonRaphson run.
					impulseStart := 1.0d + (coeffRestitution raisedTo: direction) * impulseStart.
					direction * impulseStart <= (direction * impulsePrevious)
						ifTrue: 
							["End of collision should be in interval."
							"Make impulseStart a shade larger than 
							impulsePrevious."
							impulseStart := (direction * impulsePrevious) nextLargerNumber / direction.
							^impulseStart]
						ifFalse: [direction * impulseStart <= (direction * impulse)
								ifTrue: ["End of collision found in interval."
									^impulseStart]
								ifFalse: ["Continue outbound compression."
									^impulse]]]
				ifFalse: ["Continue inbound compression."
					^impulse]]
		ifFalse: ["End of collision is known."
			direction * impulseStart <= (direction * impulse)
				ifTrue: ["End of collision found in interval."
					^impulseStart]
				ifFalse: ["Continue outbound compression."
					^impulse]]
]

{ #category : #'initialize-release' }
MbDInCollisionCVCVJoint >> connectsI: mkrII toJ: mkrJJ [ 
	self error: 'Simulation should not start in collision.'
]

{ #category : #collision }
MbDInCollisionCVCVJoint >> discontinuityAt: impulseStartNew addTypeTo: collection [ 
	| impactVelocityTol |
	impulseStart = impulseStartNew 
		ifTrue: 
			[self recordImpactVelocity.
			impactVelocityTol := self impactVelocityTol.
			impactVelocity abs <= impactVelocityTol 
				ifTrue: 
					[self becomeStartingInContactCVCVJoint.
					collection add: #TOUCHDOWN]
				ifFalse: 
					[collection add: #LIFTOFF.
					self becomeSeparatedCVCVJoint]]
]

{ #category : #collision }
MbDInCollisionCVCVJoint >> fillCollisionDerivativeICError: col [ 
	"Add contact friction later."
	"muv := #(0.0d 0.0d -1.0d)."

	| iqXI aAOIemuv iqEI prOIeOpEI prOIeOpEITaAOIemuv iqXJ iqEJ prOJeOpEJ prOJeOpEJTaAOIemuv |
	iqXI := frmI iqX.
	aAOIemuv := frmI aAOe timesFullColumn: #(0.0d 0.0d -1.0d).
	col at: iqXI plusFullColumn: aAOIemuv.
	iqEI := frmI iqE.
	prOIeOpEI := frmI prOeOpE.
	prOIeOpEITaAOIemuv := prOIeOpEI transposeTimesFullColumn: aAOIemuv.
	col at: iqEI plusFullColumn: prOIeOpEITaAOIemuv.
	iqXJ := frmJ iqX.
	col at: iqXJ minusFullColumn: aAOIemuv.
	iqEJ := frmJ iqE.
	prOJeOpEJ := frmJ prOeOpE.
	prOJeOpEJTaAOIemuv := prOJeOpEJ transposeTimesFullColumn: aAOIemuv.
	col at: iqEJ minusFullColumn: prOJeOpEJTaAOIemuv
]

{ #category : #collision }
MbDInCollisionCVCVJoint >> fillCollisionError: col [ 
	"Add contact friction later."
	"muv := #(0.0d 0.0d -1.0d)."

	| iqXI aAOIemuv iqEI prOIeOpEI prOIeOpEITaAOIemuv iqXJ iqEJ prOJeOpEJ prOJeOpEJTaAOIemuv |
	super fillCollisionError: col.
	iqXI := frmI iqX.
	aAOIemuv := frmI aAOe timesFullColumn: #(0.0d 0.0d -1.0d).
	col at: iqXI plusFullColumn: aAOIemuv.
	iqEI := frmI iqE.
	prOIeOpEI := frmI prOeOpE.
	prOIeOpEITaAOIemuv := prOIeOpEI transposeTimesFullColumn: aAOIemuv.
	col at: iqEI plusFullColumn: prOIeOpEITaAOIemuv.
	iqXJ := frmJ iqX.
	col at: iqXJ minusFullColumn: aAOIemuv.
	iqEJ := frmJ iqE.
	prOJeOpEJ := frmJ prOeOpE.
	prOJeOpEJTaAOIemuv := prOJeOpEJ transposeTimesFullColumn: aAOIemuv.
	col at: iqEJ minusFullColumn: prOJeOpEJTaAOIemuv
]

{ #category : #accessing }
MbDInCollisionCVCVJoint >> impactVelocityAt: tout [ 
	| answer |
	answer := self impactVelocityDerivative: 0 at: tout.
	"Transcript cr; show: 'impactVelocityAt:'; show: answer printString."
	^answer
]

{ #category : #accessing }
MbDInCollisionCVCVJoint >> impactVelocityDerivative: n at: tout [ 
	^interpolator
		derivative: n
		at: tout
		present: impactVelocity
		past: impactVelocityPast
]

{ #category : #accessing }
MbDInCollisionCVCVJoint >> impulseStart [
	^impulseStart
]

{ #category : #accessing }
MbDInCollisionCVCVJoint >> impulseStart: aDouble [ 
	impulseStart := aDouble
]

{ #category : #accessing }
MbDInCollisionCVCVJoint >> normalImpulse: aDouble [ 
	normalImpulse := aDouble
]

{ #category : #collision }
MbDInCollisionCVCVJoint >> postCollisionCorrectorIteration [
	"super postCollisionCorrectorIteration."

	impactVelocity := self vIeJeOIez
]

{ #category : #collision }
MbDInCollisionCVCVJoint >> postCollisionDerivativeIC [
	self recordImpactVelocity
]

{ #category : #collision }
MbDInCollisionCVCVJoint >> postCollisionPredictor [
	"super postCollisionPredictor."

	impactVelocity := self vIeJeOIez
]

{ #category : #collision }
MbDInCollisionCVCVJoint >> preCollision [
	super preCollision.
	interpolator := TheMbDSystem mbdSystemSolver opBDF.
	leastSquaresFit := nil.
	impactVelocity := self vIeJeOIez.
	impulseStart := 0.0d
]

{ #category : #collision }
MbDInCollisionCVCVJoint >> preCollisionDerivativeIC [
	super preCollisionDerivativeIC.
	impactVelocity := self vIeJeOIez
]

{ #category : #collision }
MbDInCollisionCVCVJoint >> recordImpactVelocity [
	impactVelocity := self vIeJeOIez.
	TheMbDSystem logImpactVelocity: impactVelocity
]

{ #category : #collision }
MbDInCollisionCVCVJoint >> storeCollisionState [
	impactVelocityPast addFirst: impactVelocity.
	[interpolator timeNodes size < impactVelocityPast size]
		whileTrue: [impactVelocityPast removeLast]
]
