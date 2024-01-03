Class {
	#name : #MbDAnglezIecJec,
	#superclass : #MbDAngleIeJe,
	#instVars : [
		'thez',
		'aA11IeJe',
		'aA21IeJe',
		'cosOverSSq',
		'sinOverSSq',
		'twoCosSinOverSSqSq',
		'dSqOverSSqSq'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDAnglezIecJec >> calcPostDynCorrectorIteration [
	| cthez sthez sumOfSquares diffOfSquares sumOfSquaresSquared thez0to2pi |
	cthez := aA11IeJe value.
	sthez := aA21IeJe value.
	sumOfSquares := cthez * cthez + (sthez * sthez).
	diffOfSquares := sthez * sthez - (cthez * cthez).
	sumOfSquaresSquared := sumOfSquares * sumOfSquares.
	thez0to2pi := Double arcTan0to2piY: sthez overX: cthez.
	thez := (thez - thez0to2pi / (2.0d * Double pi)) rounded * (2.0d * Double pi) + thez0to2pi.
	cosOverSSq := cthez / sumOfSquares.
	sinOverSSq := sthez / sumOfSquares.
	twoCosSinOverSSqSq := 2.0d * cthez * sthez / sumOfSquaresSquared.
	dSqOverSSqSq := diffOfSquares / sumOfSquaresSquared
]

{ #category : #'initialize-release' }
MbDAnglezIecJec >> initialize [
	self initDirectionCosines
]

{ #category : #'initialize-release' }
MbDAnglezIecJec >> initializeGlobally [
	aA11IeJe initializeGlobally.
	aA21IeJe initializeGlobally
]

{ #category : #'initialize-release' }
MbDAnglezIecJec >> initializeLocally [
	aA11IeJe initializeLocally.
	aA21IeJe initializeLocally
]

{ #category : #dynamic }
MbDAnglezIecJec >> postDynCorrectorIteration [
	aA11IeJe postDynCorrectorIteration.
	aA21IeJe postDynCorrectorIteration.
	super postDynCorrectorIteration
]

{ #category : #dynamic }
MbDAnglezIecJec >> postDynOutput [
	aA11IeJe postDynOutput.
	aA21IeJe postDynOutput.
	super postDynOutput
]

{ #category : #dynamic }
MbDAnglezIecJec >> postDynPredictor [
	aA11IeJe postDynPredictor.
	aA21IeJe postDynPredictor.
	super postDynPredictor
]

{ #category : #'input-output' }
MbDAnglezIecJec >> postInput [
	| cthez sthez |
	aA11IeJe postInput.
	aA21IeJe postInput.
	thez == nil
		ifTrue: 
			[cthez := aA11IeJe value.
			sthez := aA21IeJe value.
			thez := cthez > 0.0d
						ifTrue: [Double arcTanMpiTOpiY: sthez overX: cthez]
						ifFalse: [Double arcTan0to2piY: sthez overX: cthez]].
	super postInput
]

{ #category : #posIC }
MbDAnglezIecJec >> postPosICIteration [
	aA11IeJe postPosICIteration.
	aA21IeJe postPosICIteration.
	super postPosICIteration
]

{ #category : #static }
MbDAnglezIecJec >> postStaticIteration [
	aA11IeJe postStaticIteration.
	aA21IeJe postStaticIteration.
	super postStaticIteration
]

{ #category : #accIC }
MbDAnglezIecJec >> preAccIC [
	thez == nil ifTrue: [self prePosIC].
	aA11IeJe preAccIC.
	aA21IeJe preAccIC.
	super preAccIC
]

{ #category : #dynamic }
MbDAnglezIecJec >> preDynOutput [
	aA11IeJe preDynOutput.
	aA21IeJe preDynOutput.
	super preDynOutput
]

{ #category : #posIC }
MbDAnglezIecJec >> prePosIC [
	| cthez sthez |
	aA11IeJe prePosIC.
	aA21IeJe prePosIC.
	thez == nil
		ifTrue: 
			[cthez := aA11IeJe value.
			sthez := aA21IeJe value.
			thez := cthez > 0.0d
						ifTrue: [Double arcTanMpiTOpiY: sthez overX: cthez]
						ifFalse: [Double arcTan0to2piY: sthez overX: cthez]].
	super prePosIC
]

{ #category : #static }
MbDAnglezIecJec >> preStatic [
	aA11IeJe preStatic.
	aA21IeJe preStatic.
	super preStatic
]

{ #category : #velIC }
MbDAnglezIecJec >> preVelIC [
	aA11IeJe preVelIC.
	aA21IeJe preVelIC.
	super preVelIC
]

{ #category : #dynamic }
MbDAnglezIecJec >> simUpdateAll [
	aA11IeJe simUpdateAll.
	aA21IeJe simUpdateAll.
	super simUpdateAll
]

{ #category : #accessing }
MbDAnglezIecJec >> thez [
	^thez
]

{ #category : #accessing }
MbDAnglezIecJec >> value [
	^thez
]

{ #category : #'initialize-release' }
MbDAnglezIecJec >> withFrmI: afrmI frmJ: afrmJ [ 
	frmI := afrmI.
	frmJ := afrmJ.
	aA11IeJe withFrmI: afrmI frmJ: afrmJ axisI: 1 axisJ: 1.
	aA21IeJe withFrmI: afrmI frmJ: afrmJ axisI: 2 axisJ: 1
]
