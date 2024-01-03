"
ratioPlusOne := ratio + 1

ratio is the fraction 
# teeth on I      diameter of I
----------------- = --------------------
# teeth on J     diameter of J
"
Class {
	#name : #MbDParallelGearConstraintIJ,
	#superclass : #MbDConstraintIJ,
	#instVars : [
		'orbitIeJe',
		'thezIeJe',
		'ratioPlusOne'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #calc }
MbDParallelGearConstraintIJ >> calcPostDynCorrectorIteration [
	| phiz thez |
	phiz := orbitIeJe value.
	thez := thezIeJe value.
	aG := thez - (ratioPlusOne * phiz) - aConstant
]

{ #category : #accessing }
MbDParallelGearConstraintIJ >> classString [
	"Used to access the descriptive name of the constraint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: one parallel gear constraint '
]

{ #category : #'initialize-release' }
MbDParallelGearConstraintIJ >> initializeGlobally [
	orbitIeJe initializeGlobally.
	thezIeJe initializeGlobally
]

{ #category : #'initialize-release' }
MbDParallelGearConstraintIJ >> initializeLocally [
	orbitIeJe initializeLocally.
	thezIeJe initializeLocally
]

{ #category : #dynamic }
MbDParallelGearConstraintIJ >> postDynCorrectorIteration [
	orbitIeJe postDynCorrectorIteration.
	thezIeJe postDynCorrectorIteration.
	super postDynCorrectorIteration
]

{ #category : #dynamic }
MbDParallelGearConstraintIJ >> postDynOutput [
	orbitIeJe postDynOutput.
	thezIeJe postDynOutput.
	super postDynOutput
]

{ #category : #dynamic }
MbDParallelGearConstraintIJ >> postDynPredictor [
	orbitIeJe postDynPredictor.
	thezIeJe postDynPredictor.
	super postDynPredictor
]

{ #category : #'input-output' }
MbDParallelGearConstraintIJ >> postInput [
	orbitIeJe postInput.
	thezIeJe postInput.
	aConstant 
		ifNil: [aConstant := thezIeJe value - (ratioPlusOne * orbitIeJe value)].
	super postInput
]

{ #category : #posIC }
MbDParallelGearConstraintIJ >> postPosICIteration [
	orbitIeJe postPosICIteration.
	thezIeJe postPosICIteration.
	super postPosICIteration
]

{ #category : #static }
MbDParallelGearConstraintIJ >> postStaticIteration [
	orbitIeJe postStaticIteration.
	thezIeJe postStaticIteration.
	super postStaticIteration
]

{ #category : #accIC }
MbDParallelGearConstraintIJ >> preAccIC [
	orbitIeJe preAccIC.
	thezIeJe preAccIC.
	super preAccIC
]

{ #category : #dynamic }
MbDParallelGearConstraintIJ >> preDynOutput [
	orbitIeJe preDynOutput.
	thezIeJe preDynOutput.
	super preDynOutput
]

{ #category : #posIC }
MbDParallelGearConstraintIJ >> prePosIC [
	orbitIeJe prePosIC.
	thezIeJe prePosIC.
	super prePosIC
]

{ #category : #static }
MbDParallelGearConstraintIJ >> preStatic [
	orbitIeJe preStatic.
	thezIeJe preStatic.
	super preStatic
]

{ #category : #velIC }
MbDParallelGearConstraintIJ >> preVelIC [
	orbitIeJe preVelIC.
	thezIeJe preVelIC.
	super preVelIC
]

{ #category : #accessing }
MbDParallelGearConstraintIJ >> ratio [
	^ratioPlusOne - 1.0d
]

{ #category : #accessing }
MbDParallelGearConstraintIJ >> ratio: aDouble [ 
	ratioPlusOne := aDouble + 1.0d
]

{ #category : #dynamic }
MbDParallelGearConstraintIJ >> simUpdateAll [
	orbitIeJe simUpdateAll.
	thezIeJe simUpdateAll.
	super simUpdateAll
]

{ #category : #'initialize-release' }
MbDParallelGearConstraintIJ >> withFrmI: afrmI frmJ: afrmJ [ 
	frmI := afrmI.
	frmJ := afrmJ.
	orbitIeJe := MbDOrbitAnglezIecJec withFrmI: afrmI frmJ: afrmJ.
	thezIeJe := MbDAnglezIecJec withFrmI: afrmI frmJ: afrmJ
]
