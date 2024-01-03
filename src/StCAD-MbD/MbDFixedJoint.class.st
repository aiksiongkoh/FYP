Class {
	#name : #MbDFixedJoint,
	#superclass : #MbDJoint,
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #accessing }
MbDFixedJoint >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Fixed Joint '
]

{ #category : #'initialize-release' }
MbDFixedJoint >> initializeGlobally [
	constraints isEmpty
		ifTrue: 
			[self owns: (MbDAtPointConstraintIJ withFrmI: frmI frmJ: frmJ axis: 1).
			self owns: (MbDAtPointConstraintIJ withFrmI: frmI frmJ: frmJ axis: 2).
			self owns: (MbDAtPointConstraintIJ withFrmI: frmI frmJ: frmJ axis: 3).
			self owns: (MbDDirectionCosineConstraintIJ withFrmI: frmI frmJ: frmJ axisI: 2 axisJ: 1).
			self owns: (MbDDirectionCosineConstraintIJ withFrmI: frmI frmJ: frmJ axisI: 3 axisJ: 1).
			self owns: (MbDDirectionCosineConstraintIJ withFrmI: frmI frmJ: frmJ axisI: 3 axisJ: 2).
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]
