Class {
	#name : #MbDNoRotationJoint,
	#superclass : #MbDJoint,
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #accessing }
MbDNoRotationJoint >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: NoRotation Joint '
]

{ #category : #'initialize-release' }
MbDNoRotationJoint >> initializeGlobally [
	constraints isEmpty
		ifTrue: 
			[self owns: (MbDDirectionCosineConstraintIJ withFrmI: frmI frmJ: frmJ axisI: 2 axisJ: 1).
			self owns: (MbDDirectionCosineConstraintIJ withFrmI: frmI frmJ: frmJ axisI: 3 axisJ: 1).
			self owns: (MbDDirectionCosineConstraintIJ withFrmI: frmI frmJ: frmJ axisI: 3 axisJ: 2).
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]
