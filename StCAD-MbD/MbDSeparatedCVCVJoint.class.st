Class {
	#name : #MbDSeparatedCVCVJoint,
	#superclass : #MbDIntermittentCVCVJoint,
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #'VisualWorks metadata' }
MbDSeparatedCVCVJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #dynamic }
MbDSeparatedCVCVJoint >> becomeStartingInContactCVCVJoint [
	self changeClassToThatOf: MbDStartingInContactCVCVJoint basicNew.
	frmI becomeContactEndFrame.
	frmJ becomeContactEndFrame.
	constraints become: unusedConstraints.
	constraints do: [:a | a activateConstraint]
]

{ #category : #'initialize-release' }
MbDSeparatedCVCVJoint >> connectsI: mkrII toJ: mkrJJ [ 
	super connectsI: mkrII toJ: mkrJJ.
	frmI becomeNoContactEndFrame.
	frmJ becomeNoContactEndFrame
]

{ #category : #'initialize-release' }
MbDSeparatedCVCVJoint >> initializeGlobally [
	unusedConstraints isEmpty 
		ifTrue: 
			[super initializeGlobally.
			unusedConstraints become: constraints.
			TheMbDSystem hasChanged: true]
		ifFalse: 
			[rIeJe initializeGlobally.
			unusedConstraints do: [:constraint | constraint initializeGlobally]]
]

{ #category : #'initialize-release' }
MbDSeparatedCVCVJoint >> initializeLocally [
	unusedConstraints isEmpty 
		ifFalse: 
			[rIeJe initializeLocally.
			unusedConstraints do: [:constraint | constraint initializeLocally]]
]

{ #category : #posIC }
MbDSeparatedCVCVJoint >> prePosIC [
	rIeJe calcSeparationDistance.
	frmI becomeNoContactEndFrame.
	frmJ becomeNoContactEndFrame
]

{ #category : #accIC }
MbDSeparatedCVCVJoint >> recordContactForceAndSeparationDistance [
	contactForce := 0.0d.
	separation := rIeJe calcSeparationDistance; separationDistance
]
