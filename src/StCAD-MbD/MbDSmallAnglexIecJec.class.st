Class {
	#name : #MbDSmallAnglexIecJec,
	#superclass : #MbDAngleIeJe,
	#instVars : [
		'thex',
		'aA23IeJe'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDSmallAnglexIecJec >> calcPostDynCorrectorIteration [
	thex := aA23IeJe value negated
]

{ #category : #'initialize-release' }
MbDSmallAnglexIecJec >> initialize [
	self subclassResponsibility
]

{ #category : #'initialize-release' }
MbDSmallAnglexIecJec >> initializeGlobally [
	aA23IeJe initializeGlobally
]

{ #category : #'initialize-release' }
MbDSmallAnglexIecJec >> initializeLocally [
	aA23IeJe initializeLocally
]

{ #category : #dynamic }
MbDSmallAnglexIecJec >> postDynCorrectorIteration [
	aA23IeJe postDynCorrectorIteration.
	super postDynCorrectorIteration
]

{ #category : #dynamic }
MbDSmallAnglexIecJec >> postDynOutput [
	aA23IeJe postDynOutput.
	super postDynOutput
]

{ #category : #dynamic }
MbDSmallAnglexIecJec >> postDynPredictor [
	aA23IeJe postDynPredictor.
	super postDynPredictor
]

{ #category : #'input-output' }
MbDSmallAnglexIecJec >> postInput [
	aA23IeJe postInput.
	super postInput
]

{ #category : #posIC }
MbDSmallAnglexIecJec >> postPosICIteration [
	aA23IeJe postPosICIteration.
	super postPosICIteration
]

{ #category : #static }
MbDSmallAnglexIecJec >> postStaticIteration [
	aA23IeJe postStaticIteration.
	super postStaticIteration
]

{ #category : #accIC }
MbDSmallAnglexIecJec >> preAccIC [
	aA23IeJe preAccIC.
	super preAccIC
]

{ #category : #dynamic }
MbDSmallAnglexIecJec >> preDynOutput [
	aA23IeJe preDynOutput.
	super preDynOutput
]

{ #category : #posIC }
MbDSmallAnglexIecJec >> prePosIC [
	aA23IeJe prePosIC.
	super prePosIC
]

{ #category : #static }
MbDSmallAnglexIecJec >> preStatic [
	aA23IeJe preStatic.
	super preStatic
]

{ #category : #velIC }
MbDSmallAnglexIecJec >> preVelIC [
	aA23IeJe preVelIC.
	super preVelIC
]

{ #category : #dynamic }
MbDSmallAnglexIecJec >> simUpdateAll [
	aA23IeJe simUpdateAll.
	super simUpdateAll
]

{ #category : #accessing }
MbDSmallAnglexIecJec >> thex [
	^thex
]

{ #category : #accessing }
MbDSmallAnglexIecJec >> value [
	^thex
]

{ #category : #'initialize-release' }
MbDSmallAnglexIecJec >> withFrmI: afrmI frmJ: afrmJ [ 
	frmI := afrmI.
	frmJ := afrmJ.
	aA23IeJe withFrmI: afrmI frmJ: afrmJ axisI: 2 axisJ: 3
]
