Class {
	#name : #MbDAllowZRotation,
	#superclass : #MbDPrescribedMotion,
	#category : #'StCAD-MbD-MbDMotion'
}

{ #category : #'VisualWorks metadata' }
MbDAllowZRotation class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDAllowZRotation >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Allow Z Rotation '
]

{ #category : #'initialize-release' }
MbDAllowZRotation >> initializeGlobally [
	constraints isEmpty
		ifTrue: 
			[self initMotions.
			self owns: (MbDAllowZRotationConstraintIqctJqc withFrmI: frmI frmJ: frmJ axisI: 2 axisJ: 1).
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]
