Class {
	#name : #GEOAnimationData,
	#superclass : #GEOData,
	#instVars : [
		'nframe',
		'icurrent',
		'istart',
		'iend',
		'isForward',
		'framesPerSecond'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'instance creation' }
GEOAnimationData class >> new: integer [ 
	^super new initialize: integer
]

{ #category : #'VisualWorks metadata' }
GEOAnimationData class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOAnimationData >> framesPerSecond [
	^framesPerSecond
]

{ #category : #accessing }
GEOAnimationData >> framesPerSecond: integer [ 
	framesPerSecond := integer
]

{ #category : #accessing }
GEOAnimationData >> icurrent [
	^icurrent
]

{ #category : #accessing }
GEOAnimationData >> icurrent: integer [ 
	icurrent := integer
]

{ #category : #accessing }
GEOAnimationData >> iend [
	^iend
]

{ #category : #accessing }
GEOAnimationData >> iend: integer [ 
	iend := integer abs min: nframe
]

{ #category : #'initialize-release' }
GEOAnimationData >> initialize [
	nframe := 1000000.
	icurrent := 1.
	istart := 1.
	iend := 1000000.
	isForward := true.
	framesPerSecond := 30
]

{ #category : #'initialize-release' }
GEOAnimationData >> initialize: integer [ 
	nframe := integer.
	iend := integer
]

{ #category : #accessing }
GEOAnimationData >> isForward [
	^isForward
]

{ #category : #accessing }
GEOAnimationData >> isForward: bool [ 
	isForward := bool
]

{ #category : #accessing }
GEOAnimationData >> istart [
	^istart
]

{ #category : #accessing }
GEOAnimationData >> istart: integer [ 
	istart := integer.
	istart := integer abs min: nframe
]

{ #category : #accessing }
GEOAnimationData >> nframe [
	^nframe
]

{ #category : #accessing }
GEOAnimationData >> nframe: integer [ 
	nframe := 0 max: integer abs.
	istart notNil ifTrue: [istart := istart min: nframe].
	iend notNil ifTrue: [iend := iend min: nframe]
]

{ #category : #printing }
GEOAnimationData >> storeOn: aStream level: level [ 
	aStream storeLevel: level title: 'AnimationParameters'.
	aStream
		storeLevel: level + 1
		title: 'nframe'
		object: nframe.
	aStream
		storeLevel: level + 1
		title: 'icurrent'
		object: icurrent.
	aStream
		storeLevel: level + 1
		title: 'istart'
		object: istart.
	aStream
		storeLevel: level + 1
		title: 'iend'
		object: iend.
	aStream
		storeLevel: level + 1
		title: 'isForward'
		object: isForward.
	aStream
		storeLevel: level + 1
		title: 'framesPerSecond'
		object: framesPerSecond
]

{ #category : #printing }
GEOAnimationData >> storePOVOn: aStream level: level [ 
	"Do nothing."
]
