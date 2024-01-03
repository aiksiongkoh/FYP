Class {
	#name : #MbDTranslation,
	#superclass : #MbDPrescribedMotion,
	#category : #'StCAD-MbD-MbDMotion'
}

{ #category : #accessing }
MbDTranslation >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Translation '
]

{ #category : #'initialize-release' }
MbDTranslation >> initializeGlobally [
	constraints isEmpty
		ifTrue: 
			[self initMotions.
			self owns: (MbDTranslationConstraintIJ withFrmI: frmI frmJ: frmJ axis: 1).
			self owns: (MbDTranslationConstraintIJ withFrmI: frmI frmJ: frmJ axis: 2).
			self owns: (MbDTranslationConstraintIJ withFrmI: frmI frmJ: frmJ axis: 3).
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]
