Class {
	#name : #MbDSmallAngleyIecJec,
	#superclass : #MbDAngleIeJe,
	#instVars : [
		'they',
		'aA13IeJe'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDSmallAngleyIecJec class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDSmallAngleyIecJec class >> withFrmI: afrmI frmJ: afrmJ [ 
	| instance |
	self allSubclasses
		do: 
			[:subclass | 
			instance := subclass withFrmI: afrmI frmJ: afrmJ.
			instance notNil ifTrue: [^instance]]
]

{ #category : #calc }
MbDSmallAngleyIecJec >> calcPostDynCorrectorIteration [
	they := aA13IeJe value
]

{ #category : #'initialize-release' }
MbDSmallAngleyIecJec >> initialize [
	self subclassResponsibility
]

{ #category : #'initialize-release' }
MbDSmallAngleyIecJec >> initializeGlobally [
	aA13IeJe initializeGlobally
]

{ #category : #'initialize-release' }
MbDSmallAngleyIecJec >> initializeLocally [
	aA13IeJe initializeLocally
]

{ #category : #dynamic }
MbDSmallAngleyIecJec >> postDynCorrectorIteration [
	aA13IeJe postDynCorrectorIteration.
	super postDynCorrectorIteration
]

{ #category : #dynamic }
MbDSmallAngleyIecJec >> postDynOutput [
	aA13IeJe postDynOutput.
	super postDynOutput
]

{ #category : #dynamic }
MbDSmallAngleyIecJec >> postDynPredictor [
	aA13IeJe postDynPredictor.
	super postDynPredictor
]

{ #category : #'input-output' }
MbDSmallAngleyIecJec >> postInput [
	aA13IeJe postInput.
	super postInput
]

{ #category : #posIC }
MbDSmallAngleyIecJec >> postPosICIteration [
	aA13IeJe postPosICIteration.
	super postPosICIteration
]

{ #category : #static }
MbDSmallAngleyIecJec >> postStaticIteration [
	aA13IeJe postStaticIteration.
	super postStaticIteration
]

{ #category : #accIC }
MbDSmallAngleyIecJec >> preAccIC [
	aA13IeJe preAccIC.
	super preAccIC
]

{ #category : #dynamic }
MbDSmallAngleyIecJec >> preDynOutput [
	aA13IeJe preDynOutput.
	super preDynOutput
]

{ #category : #posIC }
MbDSmallAngleyIecJec >> prePosIC [
	aA13IeJe prePosIC.
	super prePosIC
]

{ #category : #static }
MbDSmallAngleyIecJec >> preStatic [
	aA13IeJe preStatic.
	super preStatic
]

{ #category : #velIC }
MbDSmallAngleyIecJec >> preVelIC [
	aA13IeJe preVelIC.
	super preVelIC
]

{ #category : #dynamic }
MbDSmallAngleyIecJec >> simUpdateAll [
	aA13IeJe simUpdateAll.
	super simUpdateAll
]

{ #category : #accessing }
MbDSmallAngleyIecJec >> they [
	^they
]

{ #category : #accessing }
MbDSmallAngleyIecJec >> value [
	^they
]

{ #category : #'initialize-release' }
MbDSmallAngleyIecJec >> withFrmI: afrmI frmJ: afrmJ [ 
	frmI := afrmI.
	frmJ := afrmJ.
	aA13IeJe withFrmI: afrmI frmJ: afrmJ axisI: 1 axisJ: 3
]
