Class {
	#name : #MbDZRotation,
	#superclass : #MbDPrescribedMotion,
	#category : #'StCAD-MbD-MbDMotion'
}

{ #category : #accessing }
MbDZRotation >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Z Rotation '
]

{ #category : #'initialize-release' }
MbDZRotation >> initializeGlobally [
	constraints isEmpty
		ifTrue: 
			[self initMotions.
			self owns: (MbDDirectionCosineConstraintIJ withFrmI: frmI frmJ: frmJ axisI: 2 axisJ: 1).
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]
