Class {
	#name : #GEOSimulationData,
	#superclass : #GEOData,
	#instVars : [
		'errorTolPosKine',
		'errorTolAccKine',
		'iterMaxPosKine',
		'iterMaxAccKine',
		'tstart',
		'hmin',
		'hmax',
		'tend',
		'hout',
		'corAbsTol',
		'corRelTol',
		'intAbsTol',
		'intRelTol',
		'iterMaxDyn',
		'orderMax',
		'translationLimit',
		'rotationLimit'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'VisualWorks metadata' }
GEOSimulationData class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOSimulationData >> corAbsTol [
	corAbsTol == nil ifTrue: [corAbsTol := 1.0d-6].
	^corAbsTol
]

{ #category : #accessing }
GEOSimulationData >> corAbsTol: double [ 
	corAbsTol := double
]

{ #category : #accessing }
GEOSimulationData >> corRelTol [
	corRelTol == nil ifTrue: [corRelTol := 1.0d-6].
	^corRelTol
]

{ #category : #accessing }
GEOSimulationData >> corRelTol: double [ 
	corRelTol := double
]

{ #category : #accessing }
GEOSimulationData >> errorTol [
	intRelTol == nil ifTrue: [intRelTol := 1.0d-6].
	^intRelTol
]

{ #category : #accessing }
GEOSimulationData >> errorTol: double [ 
	errorTolPosKine := double.
	errorTolAccKine := double.
	corAbsTol := double.
	corRelTol := double.
	intAbsTol := double.
	intRelTol := double
]

{ #category : #accessing }
GEOSimulationData >> errorTolAccKine [
	errorTolAccKine == nil ifTrue: [errorTolAccKine := 1.0d-6].
	^errorTolAccKine
]

{ #category : #accessing }
GEOSimulationData >> errorTolAccKine: double [ 
	errorTolAccKine := double
]

{ #category : #accessing }
GEOSimulationData >> errorTolPosKine [
	errorTolPosKine == nil ifTrue: [errorTolPosKine := 1.0d-6].
	^errorTolPosKine
]

{ #category : #accessing }
GEOSimulationData >> errorTolPosKine: double [ 
	errorTolPosKine := double
]

{ #category : #accessing }
GEOSimulationData >> hmax [
	hmax == nil ifTrue: [hmax := 1.0d].
	^hmax
]

{ #category : #accessing }
GEOSimulationData >> hmax: double [ 
	hmax := double
]

{ #category : #accessing }
GEOSimulationData >> hmin [
	hmin == nil ifTrue: [hmin := 1.0d-9].
	^hmin
]

{ #category : #accessing }
GEOSimulationData >> hmin: double [ 
	hmin := double
]

{ #category : #accessing }
GEOSimulationData >> hout [
	hout == nil ifTrue: [hout := 0.1d].
	^hout
]

{ #category : #accessing }
GEOSimulationData >> hout: double [ 
	hout := double
]

{ #category : #'initialize-release' }
GEOSimulationData >> initialize [
	"Do nothing."
]

{ #category : #accessing }
GEOSimulationData >> intAbsTol [
	intAbsTol == nil ifTrue: [intAbsTol := 1.0d-6].
	^intAbsTol
]

{ #category : #accessing }
GEOSimulationData >> intAbsTol: double [ 
	intAbsTol := double
]

{ #category : #accessing }
GEOSimulationData >> intRelTol [
	intRelTol == nil ifTrue: [intRelTol := 1.0d-6].
	^intRelTol
]

{ #category : #accessing }
GEOSimulationData >> intRelTol: double [ 
	intRelTol := double
]

{ #category : #accessing }
GEOSimulationData >> iterMaxAccKine [
	iterMaxAccKine == nil ifTrue: [iterMaxAccKine := 25].
	^iterMaxAccKine
]

{ #category : #accessing }
GEOSimulationData >> iterMaxAccKine: integer [ 
	iterMaxAccKine := integer
]

{ #category : #accessing }
GEOSimulationData >> iterMaxDyn [
	iterMaxDyn == nil ifTrue: [iterMaxDyn := 4].
	^iterMaxDyn
]

{ #category : #accessing }
GEOSimulationData >> iterMaxDyn: integer [ 
	iterMaxDyn := integer
]

{ #category : #accessing }
GEOSimulationData >> iterMaxPosKine [
	iterMaxPosKine == nil ifTrue: [iterMaxPosKine := 25].
	^iterMaxPosKine
]

{ #category : #accessing }
GEOSimulationData >> iterMaxPosKine: integer [ 
	iterMaxPosKine := integer
]

{ #category : #accessing }
GEOSimulationData >> orderMax [
	orderMax == nil ifTrue: [orderMax := 5].
	^orderMax
]

{ #category : #accessing }
GEOSimulationData >> orderMax: integer [ 
	orderMax := integer
]

{ #category : #accessing }
GEOSimulationData >> rotationLimit [
	rotationLimit == nil ifTrue: [rotationLimit := 0.5d].
	^rotationLimit
]

{ #category : #accessing }
GEOSimulationData >> rotationLimit: double [ 
	rotationLimit := double
]

{ #category : #printing }
GEOSimulationData >> storeOn: aStream level: level [ 
	aStream storeLevel: level title: 'SimulationParameters'.
	aStream
		storeLevel: level + 1
		title: 'tstart'
		object: self tstart.
	aStream
		storeLevel: level + 1
		title: 'tend'
		object: self tend.
	aStream
		storeLevel: level + 1
		title: 'hmin'
		object: self hmin.
	aStream
		storeLevel: level + 1
		title: 'hmax'
		object: self hmax.
	aStream
		storeLevel: level + 1
		title: 'hout'
		object: self hout.
	aStream
		storeLevel: level + 1
		title: 'errorTol'
		object: self errorTol
]

{ #category : #printing }
GEOSimulationData >> storePOVOn: aStream level: level [ 
	"Do nothing."
]

{ #category : #accessing }
GEOSimulationData >> tend [
	tend == nil ifTrue: [tend := 1.0d].
	^tend
]

{ #category : #accessing }
GEOSimulationData >> tend: double [ 
	tend := double
]

{ #category : #accessing }
GEOSimulationData >> translationLimit [
	translationLimit == nil ifTrue: [translationLimit := 1.0d10].
	^translationLimit
]

{ #category : #accessing }
GEOSimulationData >> translationLimit: double [ 
	translationLimit := double
]

{ #category : #accessing }
GEOSimulationData >> tstart [
	tstart == nil ifTrue: [tstart := 0.0d].
	^tstart
]

{ #category : #accessing }
GEOSimulationData >> tstart: double [ 
	tstart := double
]
