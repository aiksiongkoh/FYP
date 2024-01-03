Class {
	#name : #MbDDistancexyConstraintIJ,
	#superclass : #MbDConstraintIJ,
	#instVars : [
		'xIeJeIe',
		'yIeJeIe'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #calc }
MbDDistancexyConstraintIJ >> calcPostDynCorrectorIteration [
	| x y |
	x := xIeJeIe value.
	y := yIeJeIe value.
	aG := x * x + (y * y) - (aConstant * aConstant)
]

{ #category : #accessing }
MbDDistancexyConstraintIJ >> classString [
	"Used to access the descriptive name of the constraint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: one distance_xy constraint '
]

{ #category : #'initialize-release' }
MbDDistancexyConstraintIJ >> initializeGlobally [
	xIeJeIe initializeGlobally.
	yIeJeIe initializeGlobally.
]

{ #category : #'initialize-release' }
MbDDistancexyConstraintIJ >> initializeLocally [
	xIeJeIe initializeLocally.
	yIeJeIe initializeLocally.
]

{ #category : #dynamic }
MbDDistancexyConstraintIJ >> postDynCorrectorIteration [
	xIeJeIe postDynCorrectorIteration.
	yIeJeIe postDynCorrectorIteration.
	super postDynCorrectorIteration
]

{ #category : #dynamic }
MbDDistancexyConstraintIJ >> postDynOutput [
	xIeJeIe postDynOutput.
	yIeJeIe postDynOutput.
	super postDynOutput
]

{ #category : #dynamic }
MbDDistancexyConstraintIJ >> postDynPredictor [
	xIeJeIe postDynPredictor.
	yIeJeIe postDynPredictor.
	super postDynPredictor
]

{ #category : #'input-output' }
MbDDistancexyConstraintIJ >> postInput [
	xIeJeIe postInput.
	yIeJeIe postInput.
	super postInput
]

{ #category : #posIC }
MbDDistancexyConstraintIJ >> postPosICIteration [
	xIeJeIe postPosICIteration.
	yIeJeIe postPosICIteration.
	super postPosICIteration
]

{ #category : #static }
MbDDistancexyConstraintIJ >> postStaticIteration [
	xIeJeIe postStaticIteration.
	yIeJeIe postStaticIteration.
	super postStaticIteration
]

{ #category : #accIC }
MbDDistancexyConstraintIJ >> preAccIC [
	xIeJeIe preAccIC.
	yIeJeIe preAccIC.
	super preAccIC
]

{ #category : #dynamic }
MbDDistancexyConstraintIJ >> preDynOutput [
	xIeJeIe preDynOutput.
	yIeJeIe preDynOutput.
	super preDynOutput
]

{ #category : #posIC }
MbDDistancexyConstraintIJ >> prePosIC [
	xIeJeIe prePosIC.
	yIeJeIe prePosIC.
	super prePosIC
]

{ #category : #static }
MbDDistancexyConstraintIJ >> preStatic [
	xIeJeIe preStatic.
	yIeJeIe preStatic.
	super preStatic
]

{ #category : #velIC }
MbDDistancexyConstraintIJ >> preVelIC [
	xIeJeIe preVelIC.
	yIeJeIe preVelIC.
	super preVelIC
]

{ #category : #dynamic }
MbDDistancexyConstraintIJ >> simUpdateAll [
	xIeJeIe simUpdateAll.
	yIeJeIe simUpdateAll.
	super simUpdateAll
]

{ #category : #accessing }
MbDDistancexyConstraintIJ >> type [
	^#displacement
]

{ #category : #'initialize-release' }
MbDDistancexyConstraintIJ >> withFrmI: afrmI frmJ: afrmJ [ 
	frmI := afrmI.
	frmJ := afrmJ.
	xIeJeIe := MbDDispCompIecJecIe 
				withFrmI: afrmI
				frmJ: afrmJ
				axis: 1.
	yIeJeIe := MbDDispCompIecJecIe 
				withFrmI: afrmI
				frmJ: afrmJ
				axis: 2
]
