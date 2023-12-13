Class {
	#name : #MbDStartingInContactCVCVJoint,
	#superclass : #MbDInContactCVCVJoint,
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #'VisualWorks metadata' }
MbDStartingInContactCVCVJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #dynamic }
MbDStartingInContactCVCVJoint >> becomeStartingInContactCVCVJoint [
	"Do nothing."
]

{ #category : #accessing }
MbDStartingInContactCVCVJoint >> contactForceAt: tout [ 
	| answer |
	answer := self contactForceDerivative: 0 at: tout.	"Transcript cr; show: 'contactForceAt:'; show: answer printString."
	^answer
]

{ #category : #accessing }
MbDStartingInContactCVCVJoint >> contactForceDerivative: n at: tout [ 
	^interpolator
		derivative: n
		at: tout
		present: contactForce
		past: contactForcePast
]

{ #category : #accIC }
MbDStartingInContactCVCVJoint >> discontinuityAtICAddTo1: collection [ 
	contactForce < 0.0d ifTrue: [collection add: #LIFTOFF]
]

{ #category : #accIC }
MbDStartingInContactCVCVJoint >> discontinuityAtICAddTo: collection [ 
	| forTol |
	forTol := self contactForceTol.
	contactForce < forTol negated 
		ifTrue: 
			[self becomeSeparatedCVCVJoint.
			collection add: #LIFTOFF]
]

{ #category : #dynamic }
MbDStartingInContactCVCVJoint >> postDynStep [
	super postDynStep.
	TheMbDSystem mbdSystemSolver istep >= 3
		ifTrue: 
			[self changeClassToThatOf: MbDNormalInContactCVCVJoint basicNew.
			self calcLSScoeffs]
]
