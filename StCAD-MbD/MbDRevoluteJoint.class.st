Class {
	#name : #MbDRevoluteJoint,
	#superclass : #MbDJoint,
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #'VisualWorks metadata' }
MbDRevoluteJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDRevoluteJoint >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Revolute Joint '
]

{ #category : #'initialize-release' }
MbDRevoluteJoint >> initializeGlobally [
	constraints isEmpty
		ifTrue: 
			[self owns: (MbDAtPointConstraintIJ withFrmI: frmI frmJ: frmJ axis: 1).
			self owns: (MbDAtPointConstraintIJ withFrmI: frmI frmJ: frmJ axis: 2).
			self owns: (MbDAtPointConstraintIJ withFrmI: frmI frmJ: frmJ axis: 3).
			self owns: (MbDDirectionCosineConstraintIJ withFrmI: frmI frmJ: frmJ axisI: 3 axisJ: 1).
			self owns: (MbDDirectionCosineConstraintIJ withFrmI: frmI frmJ: frmJ axisI: 3 axisJ: 2).
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]

{ #category : #accessing }
MbDRevoluteJoint >> typeOfDOF [
	^#R
]
