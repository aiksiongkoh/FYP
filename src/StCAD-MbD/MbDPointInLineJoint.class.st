Class {
	#name : #MbDPointInLineJoint,
	#superclass : #MbDInLineJoint,
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #accessing }
MbDPointInLineJoint >> classString [
	"Used to access the descriptive name of the joint."

	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: PointInLine Joint '
]

{ #category : #'initialize-release' }
MbDPointInLineJoint >> initializeGlobally [
	constraints isEmpty
		ifTrue: 
			[self owns: (MbDTranslationConstraintIJ withFrmI: frmI frmJ: frmJ axis: 1).
			self owns: (MbDTranslationConstraintIJ withFrmI: frmI frmJ: frmJ axis: 2).
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]
