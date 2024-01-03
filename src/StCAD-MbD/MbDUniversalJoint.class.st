Class {
	#name : #MbDUniversalJoint,
	#superclass : #MbDJoint,
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #accessing }
MbDUniversalJoint >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Universal Joint '
]

{ #category : #'initialize-release' }
MbDUniversalJoint >> initializeGlobally [
	constraints isEmpty
		ifTrue: 
			[self owns: (MbDAtPointConstraintIJ withFrmI: frmI frmJ: frmJ axis: 1).
			self owns: (MbDAtPointConstraintIJ withFrmI: frmI frmJ: frmJ axis: 2).
			self owns: (MbDAtPointConstraintIJ withFrmI: frmI frmJ: frmJ axis: 3).
			self owns: (MbDDirectionCosineConstraintIJ withFrmI: frmI frmJ: frmJ axisI: 3 axisJ: 3).
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]
