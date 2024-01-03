Class {
	#name : #MbDTranslationConstraintIJ,
	#superclass : #MbDConstraintIJ,
	#instVars : [
		'riIeJeIe'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #calc }
MbDTranslationConstraintIJ >> calcPostDynCorrectorIteration [
	aG := riIeJeIe value - aConstant
]

{ #category : #accessing }
MbDTranslationConstraintIJ >> classString [
	"Used to access the descriptive name of the constraint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: in-plane constraint '
]

{ #category : #'initialize-release' }
MbDTranslationConstraintIJ >> initialize [
	super initialize.
	riIeJeIe := self dispCompClass new
]

{ #category : #'initialize-release' }
MbDTranslationConstraintIJ >> initializeGlobally [
	riIeJeIe initializeGlobally
]

{ #category : #'initialize-release' }
MbDTranslationConstraintIJ >> initializeLocally [
	riIeJeIe initializeLocally
]

{ #category : #dynamic }
MbDTranslationConstraintIJ >> postDynCorrectorIteration [
	riIeJeIe postDynCorrectorIteration.
	super postDynCorrectorIteration
]

{ #category : #dynamic }
MbDTranslationConstraintIJ >> postDynOutput [
	riIeJeIe postDynOutput.
	super postDynOutput
]

{ #category : #dynamic }
MbDTranslationConstraintIJ >> postDynPredictor [
	riIeJeIe postDynPredictor.
	super postDynPredictor
]

{ #category : #'input-output' }
MbDTranslationConstraintIJ >> postInput [
	riIeJeIe postInput.
	super postInput
]

{ #category : #posIC }
MbDTranslationConstraintIJ >> postPosICIteration [
	riIeJeIe postPosICIteration.
	super postPosICIteration
]

{ #category : #static }
MbDTranslationConstraintIJ >> postStaticIteration [
	riIeJeIe postStaticIteration.
	super postStaticIteration
]

{ #category : #accIC }
MbDTranslationConstraintIJ >> preAccIC [
	riIeJeIe preAccIC.
	super preAccIC
]

{ #category : #dynamic }
MbDTranslationConstraintIJ >> preDynOutput [
	riIeJeIe preDynOutput.
	super preDynOutput
]

{ #category : #posIC }
MbDTranslationConstraintIJ >> prePosIC [
	riIeJeIe prePosIC.
	super prePosIC
]

{ #category : #static }
MbDTranslationConstraintIJ >> preStatic [
	riIeJeIe preStatic.
	super preStatic
]

{ #category : #velIC }
MbDTranslationConstraintIJ >> preVelIC [
	riIeJeIe preVelIC.
	super preVelIC
]

{ #category : #dynamic }
MbDTranslationConstraintIJ >> simUpdateAll [
	riIeJeIe simUpdateAll.
	super simUpdateAll
]

{ #category : #accessing }
MbDTranslationConstraintIJ >> type [
	^#displacement
]

{ #category : #'initialize-release' }
MbDTranslationConstraintIJ >> withFrmI: afrmI frmJ: afrmJ axis: aaxis [ 
	frmI := afrmI.
	frmJ := afrmJ.
	riIeJeIe
		withFrmI: afrmI
		frmJ: afrmJ
		frmK: afrmI
		axisK: aaxis
]
