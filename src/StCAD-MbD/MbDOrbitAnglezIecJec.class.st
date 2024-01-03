Class {
	#name : #MbDOrbitAnglezIecJec,
	#superclass : #MbDKinematicIeJe,
	#instVars : [
		'thez',
		'xIeJeIe',
		'yIeJeIe',
		'cosOverSSq',
		'sinOverSSq',
		'twoCosSinOverSSqSq',
		'dSqOverSSqSq'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDOrbitAnglezIecJec >> calcPostDynCorrectorIteration [
	| x y sumOfSquares diffOfSquares sumOfSquaresSquared thez0to2pi |
	x := xIeJeIe value.
	y := yIeJeIe value.
	sumOfSquares := x * x + (y * y).
	diffOfSquares := y * y - (x * x).
	sumOfSquaresSquared := sumOfSquares * sumOfSquares.
	thez0to2pi := Double arcTan0to2piY: y overX: x.
	thez := ((thez - thez0to2pi) / (2.0d * Double pi)) rounded 
				* (2.0d * Double pi) + thez0to2pi.
	cosOverSSq := x / sumOfSquares.
	sinOverSSq := y / sumOfSquares.
	twoCosSinOverSSqSq := 2.0d * x * y / sumOfSquaresSquared.
	dSqOverSSqSq := diffOfSquares / sumOfSquaresSquared
]

{ #category : #'initialize-release' }
MbDOrbitAnglezIecJec >> initializeGlobally [
	xIeJeIe initializeGlobally.
	yIeJeIe initializeGlobally
]

{ #category : #'initialize-release' }
MbDOrbitAnglezIecJec >> initializeLocally [
	xIeJeIe initializeLocally.
	yIeJeIe initializeLocally
]

{ #category : #dynamic }
MbDOrbitAnglezIecJec >> postDynCorrectorIteration [
	xIeJeIe postDynCorrectorIteration.
	yIeJeIe postDynCorrectorIteration.
	super postDynCorrectorIteration
]

{ #category : #dynamic }
MbDOrbitAnglezIecJec >> postDynOutput [
	xIeJeIe postDynOutput.
	yIeJeIe postDynOutput.
	super postDynOutput
]

{ #category : #dynamic }
MbDOrbitAnglezIecJec >> postDynPredictor [
	xIeJeIe postDynPredictor.
	yIeJeIe postDynPredictor.
	super postDynPredictor
]

{ #category : #'input-output' }
MbDOrbitAnglezIecJec >> postInput [
	| x y |
	xIeJeIe postInput.
	yIeJeIe postInput.
	thez == nil 
		ifTrue: 
			[x := xIeJeIe value.
			y := yIeJeIe value.
			thez := x > 0.0d 
						ifTrue: [Double arcTanMpiTOpiY: y overX: x]
						ifFalse: [Double arcTan0to2piY: y overX: x]].
	super postInput
]

{ #category : #posIC }
MbDOrbitAnglezIecJec >> postPosICIteration [
	xIeJeIe postPosICIteration.
	yIeJeIe postPosICIteration.
	super postPosICIteration
]

{ #category : #static }
MbDOrbitAnglezIecJec >> postStaticIteration [
	xIeJeIe postStaticIteration.
	yIeJeIe postStaticIteration.
	super postStaticIteration
]

{ #category : #accIC }
MbDOrbitAnglezIecJec >> preAccIC [
	thez == nil ifTrue: [self prePosIC].
	xIeJeIe preAccIC.
	yIeJeIe preAccIC.
	super preAccIC
]

{ #category : #dynamic }
MbDOrbitAnglezIecJec >> preDynOutput [
	xIeJeIe preDynOutput.
	yIeJeIe preDynOutput.
	super preDynOutput
]

{ #category : #posIC }
MbDOrbitAnglezIecJec >> prePosIC [
	| x y |
	xIeJeIe prePosIC.
	yIeJeIe prePosIC.
	thez == nil 
		ifTrue: 
			[x := xIeJeIe value.
			y := yIeJeIe value.
			thez := x > 0.0d 
						ifTrue: [Double arcTanMpiTOpiY: y overX: x]
						ifFalse: [Double arcTan0to2piY: y overX: x]].
	super prePosIC
]

{ #category : #static }
MbDOrbitAnglezIecJec >> preStatic [
	xIeJeIe preStatic.
	yIeJeIe preStatic.
	super preStatic
]

{ #category : #velIC }
MbDOrbitAnglezIecJec >> preVelIC [
	xIeJeIe preVelIC.
	yIeJeIe preVelIC.
	super preVelIC
]

{ #category : #dynamic }
MbDOrbitAnglezIecJec >> simUpdateAll [
	xIeJeIe simUpdateAll.
	yIeJeIe simUpdateAll.
	super simUpdateAll
]

{ #category : #accessing }
MbDOrbitAnglezIecJec >> thez [
	^thez
]

{ #category : #accessing }
MbDOrbitAnglezIecJec >> value [
	^thez
]

{ #category : #'initialize-release' }
MbDOrbitAnglezIecJec >> withFrmI: afrmI frmJ: afrmJ [ 
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
