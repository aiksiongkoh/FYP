Class {
	#name : #GEOTimePosVelAccData,
	#superclass : #GEOPosVelAccData,
	#instVars : [
		'time'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'VisualWorks metadata' }
GEOTimePosVelAccData class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOTimePosVelAccData >> aOf [
	^aOfO length
]

{ #category : #accessing }
GEOTimePosVelAccData >> aOfO1 [
	^aOfO at: 1
]

{ #category : #accessing }
GEOTimePosVelAccData >> aOfO2 [
	^aOfO at: 2
]

{ #category : #accessing }
GEOTimePosVelAccData >> aOfO3 [
	^aOfO at: 3
]

{ #category : #accessing }
GEOTimePosVelAccData >> alpOf [
	^self alpOfO length
]

{ #category : #accessing }
GEOTimePosVelAccData >> alpOfO1 [
	^alpOfO at: 1
]

{ #category : #accessing }
GEOTimePosVelAccData >> alpOfO2 [
	^alpOfO at: 2
]

{ #category : #accessing }
GEOTimePosVelAccData >> alpOfO3 [
	^alpOfO at: 3
]

{ #category : #accessing }
GEOTimePosVelAccData >> bryantOf1 [
	^aAOf bryantAngles at: 1
]

{ #category : #accessing }
GEOTimePosVelAccData >> bryantOf2 [
	^aAOf bryantAngles at: 2
]

{ #category : #accessing }
GEOTimePosVelAccData >> bryantOf3 [
	^aAOf bryantAngles at: 3
]

{ #category : #accessing }
GEOTimePosVelAccData >> dataTypes [
	| answer |
	answer := OrderedCollection new.
	answer add: #time.
	answer add: #rOfO1.
	answer add: #rOfO2.
	answer add: #rOfO3.
	answer add: #rOf.
	answer add: #vOfO1.
	answer add: #vOfO2.
	answer add: #vOfO3.
	answer add: #vOf.
	answer add: #vOfRadial.
	answer add: #aOfO1.
	answer add: #aOfO2.
	answer add: #aOfO3.
	answer add: #aOf.
	answer add: #bryantOf1.
	answer add: #bryantOf2.
	answer add: #bryantOf3.
	answer add: #omeOfO1.
	answer add: #omeOfO2.
	answer add: #omeOfO3.
	answer add: #omeOf.
	answer add: #alpOfO1.
	answer add: #alpOfO2.
	answer add: #alpOfO3.
	answer add: #alpOf.
	^answer
]

{ #category : #accessing }
GEOTimePosVelAccData >> omeOf [
	^omeOfO length
]

{ #category : #accessing }
GEOTimePosVelAccData >> omeOfO1 [
	^omeOfO at: 1
]

{ #category : #accessing }
GEOTimePosVelAccData >> omeOfO2 [
	^omeOfO at: 2
]

{ #category : #accessing }
GEOTimePosVelAccData >> omeOfO3 [
	^omeOfO at: 3
]

{ #category : #accessing }
GEOTimePosVelAccData >> rOf [
	^rOfO length
]

{ #category : #accessing }
GEOTimePosVelAccData >> rOfO1 [
	^rOfO at: 1
]

{ #category : #accessing }
GEOTimePosVelAccData >> rOfO2 [
	^rOfO at: 2
]

{ #category : #accessing }
GEOTimePosVelAccData >> rOfO3 [
	^rOfO at: 3
]

{ #category : #accessing }
GEOTimePosVelAccData >> time [
	^time
]

{ #category : #accessing }
GEOTimePosVelAccData >> time: double [ 
	time := double
]

{ #category : #accessing }
GEOTimePosVelAccData >> timetime [
	^time @ time
]

{ #category : #accessing }
GEOTimePosVelAccData >> vOf [
	^vOfO length
]

{ #category : #accessing }
GEOTimePosVelAccData >> vOfO1 [
	^vOfO at: 1
]

{ #category : #accessing }
GEOTimePosVelAccData >> vOfO2 [
	^vOfO at: 2
]

{ #category : #accessing }
GEOTimePosVelAccData >> vOfO3 [
	^vOfO at: 3
]

{ #category : #accessing }
GEOTimePosVelAccData >> vOfRadial [
	| ur |
	^rOfO length > 0
		ifTrue: 
			[ur := rOfO copy normalizeSelf.
			vOfO dot: ur]
		ifFalse: [vOfO length]
]

{ #category : #'ops on self' }
GEOTimePosVelAccData >> zeroSelf [
	super zeroSelf.
	time := 0.0d
]
