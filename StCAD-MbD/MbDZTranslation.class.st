Class {
	#name : #MbDZTranslation,
	#superclass : #MbDPrescribedMotion,
	#category : #'StCAD-MbD-MbDMotion'
}

{ #category : #'VisualWorks metadata' }
MbDZTranslation class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDZTranslation >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Z Translation '
]

{ #category : #'initialize-release' }
MbDZTranslation >> initializeGlobally [
	constraints isEmpty
		ifTrue: 
			[self initMotions.
			self owns: (MbDTranslationConstraintIJ withFrmI: frmI frmJ: frmJ axis: 3).
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]
