Class {
	#name : #MbDAtPointConstraintIJ,
	#superclass : #MbDConstraintIJ,
	#instVars : [
		'axis',
		'riIeJeO'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #calc }
MbDAtPointConstraintIJ >> calcPostDynCorrectorIteration [
	aG := riIeJeO riIeJeO - aConstant
]

{ #category : #accessing }
MbDAtPointConstraintIJ >> classString [
	"Used to access the descriptive name of the constraint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: one displacement component constraint '
]

{ #category : #'initialize-release' }
MbDAtPointConstraintIJ >> initialize [
	super initialize.
	riIeJeO := self dispCompClass new
]

{ #category : #'initialize-release' }
MbDAtPointConstraintIJ >> initializeGlobally [
	riIeJeO initializeGlobally
]

{ #category : #'initialize-release' }
MbDAtPointConstraintIJ >> initializeLocally [
	riIeJeO initializeLocally
]

{ #category : #dynamic }
MbDAtPointConstraintIJ >> postDynCorrectorIteration [
	riIeJeO postDynCorrectorIteration.
	super postDynCorrectorIteration
]

{ #category : #dynamic }
MbDAtPointConstraintIJ >> postDynOutput [
	riIeJeO postDynOutput.
	super postDynOutput
]

{ #category : #dynamic }
MbDAtPointConstraintIJ >> postDynPredictor [
	riIeJeO postDynPredictor.
	super postDynPredictor
]

{ #category : #'input-output' }
MbDAtPointConstraintIJ >> postInput [
	riIeJeO postInput.
	super postInput
]

{ #category : #posIC }
MbDAtPointConstraintIJ >> postPosICIteration [
	riIeJeO postPosICIteration.
	super postPosICIteration
]

{ #category : #static }
MbDAtPointConstraintIJ >> postStaticIteration [
	riIeJeO postStaticIteration.
	super postStaticIteration
]

{ #category : #accIC }
MbDAtPointConstraintIJ >> preAccIC [
	riIeJeO preAccIC.
	super preAccIC
]

{ #category : #dynamic }
MbDAtPointConstraintIJ >> preDynOutput [
	riIeJeO preDynOutput.
	super preDynOutput
]

{ #category : #posIC }
MbDAtPointConstraintIJ >> prePosIC [
	riIeJeO prePosIC.
	super prePosIC
]

{ #category : #static }
MbDAtPointConstraintIJ >> preStatic [
	riIeJeO preStatic.
	super preStatic
]

{ #category : #velIC }
MbDAtPointConstraintIJ >> preVelIC [
	riIeJeO preVelIC.
	super preVelIC
]

{ #category : #dynamic }
MbDAtPointConstraintIJ >> simUpdateAll [
	riIeJeO simUpdateAll.
	super simUpdateAll
]

{ #category : #accessing }
MbDAtPointConstraintIJ >> type [
	^#displacement
]

{ #category : #'initialize-release' }
MbDAtPointConstraintIJ >> withFrmI: afrmI frmJ: afrmJ axis: aaxis [ 
	frmI := afrmI.
	frmJ := afrmJ.
	axis := aaxis.
	riIeJeO
		withFrmI: afrmI
		frmJ: afrmJ
		axis: aaxis
]
