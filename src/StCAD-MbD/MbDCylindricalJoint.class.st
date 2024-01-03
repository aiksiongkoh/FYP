Class {
	#name : #MbDCylindricalJoint,
	#superclass : #MbDInLineJoint,
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #accessing }
MbDCylindricalJoint >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Cylindrical Joint '
]

{ #category : #'initialize-release' }
MbDCylindricalJoint >> initializeGlobally [
	constraints isEmpty
		ifTrue: 
			[self owns: (MbDTranslationConstraintIJ withFrmI: frmI frmJ: frmJ axis: 1).
			self owns: (MbDTranslationConstraintIJ withFrmI: frmI frmJ: frmJ axis: 2).
			self owns: (MbDDirectionCosineConstraintIJ withFrmI: frmI frmJ: frmJ axisI: 3 axisJ: 1).
			self owns: (MbDDirectionCosineConstraintIJ withFrmI: frmI frmJ: frmJ axisI: 3 axisJ: 2).
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]
