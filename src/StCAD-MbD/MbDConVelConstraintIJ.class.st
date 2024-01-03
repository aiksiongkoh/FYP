Class {
	#name : #MbDConVelConstraintIJ,
	#superclass : #MbDConstraintIJ,
	#instVars : [
		'aA12IeJe',
		'aA21IeJe'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #accessing }
MbDConVelConstraintIJ >> addToJointForceI: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDConVelConstraintIJ >> addToJointForceJ: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDConVelConstraintIJ >> addpFIeiGOplamto: mat [ 
	"pGpXI is zero."
	"Do nothing."
]

{ #category : #calc }
MbDConVelConstraintIJ >> calcPostDynCorrectorIteration [
	aG := aA12IeJe aAijIeJe + aA21IeJe aAijIeJe - aConstant
]

{ #category : #accessing }
MbDConVelConstraintIJ >> classString [
	"Used to access the descriptive name of the constraint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: one constant velocity constraint '
]

{ #category : #'initialize-release' }
MbDConVelConstraintIJ >> initA12IeJe [
	self subclassResponsibility
]

{ #category : #'initialize-release' }
MbDConVelConstraintIJ >> initA21IeJe [
	self subclassResponsibility
]

{ #category : #'initialize-release' }
MbDConVelConstraintIJ >> initialize [
	super initialize.
	self initA12IeJe.
	self initA21IeJe
]

{ #category : #'initialize-release' }
MbDConVelConstraintIJ >> initializeGlobally [
	aA12IeJe initializeGlobally.
	aA21IeJe initializeGlobally
]

{ #category : #'initialize-release' }
MbDConVelConstraintIJ >> initializeLocally [
	aA12IeJe initializeLocally.
	aA21IeJe initializeLocally
]

{ #category : #dynamic }
MbDConVelConstraintIJ >> postDynCorrectorIteration [
	aA12IeJe postDynCorrectorIteration.
	aA21IeJe postDynCorrectorIteration.
	super postDynCorrectorIteration
]

{ #category : #dynamic }
MbDConVelConstraintIJ >> postDynOutput [
	aA12IeJe postDynOutput.
	aA21IeJe postDynOutput.
	super postDynOutput
]

{ #category : #dynamic }
MbDConVelConstraintIJ >> postDynPredictor [
	aA12IeJe postDynPredictor.
	aA21IeJe postDynPredictor.
	super postDynPredictor
]

{ #category : #'input-output' }
MbDConVelConstraintIJ >> postInput [
	aA12IeJe postInput.
	aA21IeJe postInput.
	super postInput
]

{ #category : #posIC }
MbDConVelConstraintIJ >> postPosICIteration [
	aA12IeJe postPosICIteration.
	aA21IeJe postPosICIteration.
	super postPosICIteration
]

{ #category : #static }
MbDConVelConstraintIJ >> postStaticIteration [
	aA12IeJe postStaticIteration.
	aA21IeJe postStaticIteration.
	super postStaticIteration
]

{ #category : #accIC }
MbDConVelConstraintIJ >> preAccIC [
	aA12IeJe preAccIC.
	aA21IeJe preAccIC.
	super preAccIC
]

{ #category : #dynamic }
MbDConVelConstraintIJ >> preDynOutput [
	aA12IeJe preDynOutput.
	aA21IeJe preDynOutput.
	super preDynOutput
]

{ #category : #posIC }
MbDConVelConstraintIJ >> prePosIC [
	aA12IeJe prePosIC.
	aA21IeJe prePosIC.
	super prePosIC
]

{ #category : #static }
MbDConVelConstraintIJ >> preStatic [
	aA12IeJe preStatic.
	aA21IeJe preStatic.
	super preStatic
]

{ #category : #velIC }
MbDConVelConstraintIJ >> preVelIC [
	aA12IeJe preVelIC.
	aA21IeJe preVelIC.
	super preVelIC
]

{ #category : #dynamic }
MbDConVelConstraintIJ >> simUpdateAll [
	aA12IeJe simUpdateAll.
	aA21IeJe simUpdateAll.
	super simUpdateAll
]

{ #category : #'initialize-release' }
MbDConVelConstraintIJ >> withFrmI: afrmI frmJ: afrmJ [ 
	frmI := afrmI.
	frmJ := afrmJ.
	aA12IeJe withFrmI: afrmI frmJ: afrmJ axisI: 1 axisJ: 2.
	aA21IeJe withFrmI: afrmI frmJ: afrmJ axisI: 2 axisJ: 1
]
