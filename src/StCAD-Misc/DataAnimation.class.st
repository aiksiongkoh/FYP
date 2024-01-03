Class {
	#name : #DataAnimation,
	#superclass : #Data,
	#instVars : [
		'nframe',
		'icurrent',
		'istart',
		'iend',
		'isForward',
		'framesPerSecond'
	],
	#category : #'StCAD-Misc'
}

{ #category : #accessing }
DataAnimation >> framesPerSecond [
	^framesPerSecond
]

{ #category : #accessing }
DataAnimation >> framesPerSecond: integer [ 
	framesPerSecond := integer
]

{ #category : #accessing }
DataAnimation >> icurrent [
	^icurrent
]

{ #category : #accessing }
DataAnimation >> icurrent: integer [ 
	icurrent := integer
]

{ #category : #accessing }
DataAnimation >> iend [
	^iend
]

{ #category : #accessing }
DataAnimation >> iend: integer [ 
	iend := integer abs min: nframe
]

{ #category : #'initialize-release' }
DataAnimation >> initialize [
	nframe := 1000000.
	icurrent := 1.
	istart := 1.
	iend := 1000000.
	isForward := true.
	framesPerSecond := 30
]

{ #category : #'initialize-release' }
DataAnimation >> initialize: integer [ 
	nframe := integer.
	iend := integer
]

{ #category : #accessing }
DataAnimation >> isForward [
	^isForward
]

{ #category : #accessing }
DataAnimation >> isForward: bool [ 
	isForward := bool
]

{ #category : #accessing }
DataAnimation >> istart [
	^istart
]

{ #category : #accessing }
DataAnimation >> istart: integer [ 
	istart := integer.
	istart := integer abs min: nframe
]

{ #category : #accessing }
DataAnimation >> nframe [
	^nframe
]

{ #category : #accessing }
DataAnimation >> nframe: integer [ 
	nframe := 0 max: integer abs.
	istart notNil ifTrue: [istart := istart min: nframe].
	iend notNil ifTrue: [iend := iend min: nframe]
]

{ #category : #printing }
DataAnimation >> storeOn: aStream level: level [ 
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
DataAnimation >> storePOVOn: aStream level: level [ 
	"Do nothing."
]
