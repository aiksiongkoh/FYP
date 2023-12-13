Class {
	#name : #GEORelPosVelAccData,
	#superclass : #GEOData,
	#instVars : [
		'time',
		'rFfF',
		'aAFf',
		'vFfF',
		'omeFfF',
		'aFfF',
		'alpFfF',
		'rOfO',
		'aAOf',
		'vOfO',
		'omeOfO',
		'aOfO',
		'alpOfO'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'VisualWorks metadata' }
GEORelPosVelAccData class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEORelPosVelAccData >> aAFf [
	aAFf == nil ifTrue: [self aAFf: (FullMatrix identity: 3)].
	^aAFf
]

{ #category : #accessing }
GEORelPosVelAccData >> aAFf: mat [ 
	aAFf := mat
]

{ #category : #accessing }
GEORelPosVelAccData >> aAOf [
	aAOf == nil ifTrue: [self aAOf: (FullMatrix identity: 3)].
	^aAOf
]

{ #category : #accessing }
GEORelPosVelAccData >> aAOf: mat [ 
	aAOf := mat
]

{ #category : #accessing }
GEORelPosVelAccData >> aFf [
	^aFfF length
]

{ #category : #accessing }
GEORelPosVelAccData >> aFfF [
	aFfF == nil ifTrue: [self aFfF: (FullColumn zero: 3)].
	^aFfF
]

{ #category : #accessing }
GEORelPosVelAccData >> aFfF1 [
	^aFfF at: 1
]

{ #category : #accessing }
GEORelPosVelAccData >> aFfF2 [
	^aFfF at: 2
]

{ #category : #accessing }
GEORelPosVelAccData >> aFfF3 [
	^aFfF at: 3
]

{ #category : #accessing }
GEORelPosVelAccData >> aFfF: col [ 
	aFfF := col
]

{ #category : #accessing }
GEORelPosVelAccData >> aOf [
	^aOfO length
]

{ #category : #accessing }
GEORelPosVelAccData >> aOfO [
	aOfO == nil ifTrue: [self aOfO: (FullColumn zero: 3)].
	^aOfO
]

{ #category : #accessing }
GEORelPosVelAccData >> aOfO1 [
	^aOfO at: 1
]

{ #category : #accessing }
GEORelPosVelAccData >> aOfO2 [
	^aOfO at: 2
]

{ #category : #accessing }
GEORelPosVelAccData >> aOfO3 [
	^aOfO at: 3
]

{ #category : #accessing }
GEORelPosVelAccData >> aOfO: col [ 
	aOfO := col
]

{ #category : #accessing }
GEORelPosVelAccData >> alpFf [
	^self alpFfF length
]

{ #category : #accessing }
GEORelPosVelAccData >> alpFfF [
	alpFfF == nil ifTrue: [self alpFfF: (FullColumn zero: 3)].
	^alpFfF
]

{ #category : #accessing }
GEORelPosVelAccData >> alpFfF1 [
	^alpFfF at: 1
]

{ #category : #accessing }
GEORelPosVelAccData >> alpFfF2 [
	^alpFfF at: 2
]

{ #category : #accessing }
GEORelPosVelAccData >> alpFfF3 [
	^alpFfF at: 3
]

{ #category : #accessing }
GEORelPosVelAccData >> alpFfF: col [ 
	alpFfF := col
]

{ #category : #accessing }
GEORelPosVelAccData >> alpOf [
	^self alpOfO length
]

{ #category : #accessing }
GEORelPosVelAccData >> alpOfO [
	alpOfO == nil ifTrue: [self alpOfO: (FullColumn zero: 3)].
	^alpOfO
]

{ #category : #accessing }
GEORelPosVelAccData >> alpOfO1 [
	^alpOfO at: 1
]

{ #category : #accessing }
GEORelPosVelAccData >> alpOfO2 [
	^alpOfO at: 2
]

{ #category : #accessing }
GEORelPosVelAccData >> alpOfO3 [
	^alpOfO at: 3
]

{ #category : #accessing }
GEORelPosVelAccData >> alpOfO: col [ 
	alpOfO := col
]

{ #category : #accessing }
GEORelPosVelAccData >> bryantFf1 [
	^aAFf bryantAngles at: 1
]

{ #category : #accessing }
GEORelPosVelAccData >> bryantFf2 [
	^aAFf bryantAngles at: 2
]

{ #category : #accessing }
GEORelPosVelAccData >> bryantFf3 [
	^aAFf bryantAngles at: 3
]

{ #category : #accessing }
GEORelPosVelAccData >> bryantOf1 [
	^aAOf bryantAngles at: 1
]

{ #category : #accessing }
GEORelPosVelAccData >> bryantOf2 [
	^aAOf bryantAngles at: 2
]

{ #category : #accessing }
GEORelPosVelAccData >> bryantOf3 [
	^aAOf bryantAngles at: 3
]

{ #category : #accessing }
GEORelPosVelAccData >> dataTypes [
	| answer |
	answer := OrderedCollection new.
	answer add: #time.
	answer add: #rFfF1.
	answer add: #rFfF2.
	answer add: #rFfF3.
	answer add: #rFf.
	answer add: #rOfO1.
	answer add: #rOfO2.
	answer add: #rOfO3.
	answer add: #rOf.
	answer add: #vFfF1.
	answer add: #vFfF2.
	answer add: #vFfF3.
	answer add: #vFf.
	answer add: #vFfRadial.
	answer add: #vOfO1.
	answer add: #vOfO2.
	answer add: #vOfO3.
	answer add: #vOf.
	answer add: #vOfRadial.
	answer add: #aFfF1.
	answer add: #aFfF2.
	answer add: #aFfF3.
	answer add: #aFf.
	answer add: #aOfO1.
	answer add: #aOfO2.
	answer add: #aOfO3.
	answer add: #aOf.
	answer add: #bryantFf1.
	answer add: #bryantFf2.
	answer add: #bryantFf3.
	answer add: #bryantOf1.
	answer add: #bryantOf2.
	answer add: #bryantOf3.
	answer add: #omeFfF1.
	answer add: #omeFfF2.
	answer add: #omeFfF3.
	answer add: #omeFf.
	answer add: #omeOfO1.
	answer add: #omeOfO2.
	answer add: #omeOfO3.
	answer add: #omeOf.
	answer add: #alpFfF1.
	answer add: #alpFfF2.
	answer add: #alpFfF3.
	answer add: #alpFf.
	answer add: #alpOfO1.
	answer add: #alpOfO2.
	answer add: #alpOfO3.
	answer add: #alpOf.
	^answer
]

{ #category : #'initialize-release' }
GEORelPosVelAccData >> initialize [
	"Do nothing."
]

{ #category : #accessing }
GEORelPosVelAccData >> omeFf [
	^omeFfF length
]

{ #category : #accessing }
GEORelPosVelAccData >> omeFfF [
	omeFfF == nil ifTrue: [self omeFfF: (FullColumn zero: 3)].
	^omeFfF
]

{ #category : #accessing }
GEORelPosVelAccData >> omeFfF1 [
	^omeFfF at: 1
]

{ #category : #accessing }
GEORelPosVelAccData >> omeFfF2 [
	^omeFfF at: 2
]

{ #category : #accessing }
GEORelPosVelAccData >> omeFfF3 [
	^omeFfF at: 3
]

{ #category : #accessing }
GEORelPosVelAccData >> omeFfF: col [ 
	omeFfF := col
]

{ #category : #accessing }
GEORelPosVelAccData >> omeOf [
	^omeOfO length
]

{ #category : #accessing }
GEORelPosVelAccData >> omeOfO [
	omeOfO == nil ifTrue: [self omeOfO: (FullColumn zero: 3)].
	^omeOfO
]

{ #category : #accessing }
GEORelPosVelAccData >> omeOfO1 [
	^omeOfO at: 1
]

{ #category : #accessing }
GEORelPosVelAccData >> omeOfO2 [
	^omeOfO at: 2
]

{ #category : #accessing }
GEORelPosVelAccData >> omeOfO3 [
	^omeOfO at: 3
]

{ #category : #accessing }
GEORelPosVelAccData >> omeOfO: col [ 
	omeOfO := col
]

{ #category : #accessing }
GEORelPosVelAccData >> rFf [
	^rFfF length
]

{ #category : #accessing }
GEORelPosVelAccData >> rFfF [
	rFfF == nil ifTrue: [self rFfF: (FullColumn zero: 3)].
	^rFfF
]

{ #category : #accessing }
GEORelPosVelAccData >> rFfF1 [
	^rFfF at: 1
]

{ #category : #accessing }
GEORelPosVelAccData >> rFfF2 [
	^rFfF at: 2
]

{ #category : #accessing }
GEORelPosVelAccData >> rFfF3 [
	^rFfF at: 3
]

{ #category : #accessing }
GEORelPosVelAccData >> rFfF: col [ 
	rFfF := col
]

{ #category : #accessing }
GEORelPosVelAccData >> rOf [
	^rOfO length
]

{ #category : #accessing }
GEORelPosVelAccData >> rOfO [
	rOfO == nil ifTrue: [self rOfO: (FullColumn zero: 3)].
	^rOfO
]

{ #category : #accessing }
GEORelPosVelAccData >> rOfO1 [
	^rOfO at: 1
]

{ #category : #accessing }
GEORelPosVelAccData >> rOfO2 [
	^rOfO at: 2
]

{ #category : #accessing }
GEORelPosVelAccData >> rOfO3 [
	^rOfO at: 3
]

{ #category : #accessing }
GEORelPosVelAccData >> rOfO: col [ 
	rOfO := col
]

{ #category : #accessing }
GEORelPosVelAccData >> time [
	^time
]

{ #category : #accessing }
GEORelPosVelAccData >> time: double [ 
	time := double
]

{ #category : #accessing }
GEORelPosVelAccData >> timetime [
	^time @ time
]

{ #category : #accessing }
GEORelPosVelAccData >> vFf [
	^vFfF length
]

{ #category : #accessing }
GEORelPosVelAccData >> vFfF [
	vFfF == nil ifTrue: [self vFfF: (FullColumn zero: 3)].
	^vFfF
]

{ #category : #accessing }
GEORelPosVelAccData >> vFfF1 [
	^vFfF at: 1
]

{ #category : #accessing }
GEORelPosVelAccData >> vFfF2 [
	^vFfF at: 2
]

{ #category : #accessing }
GEORelPosVelAccData >> vFfF3 [
	^vFfF at: 3
]

{ #category : #accessing }
GEORelPosVelAccData >> vFfF: col [ 
	vFfF := col
]

{ #category : #accessing }
GEORelPosVelAccData >> vFfRadial [
	| ur |
	^rFfF length > 0 
		ifTrue: 
			[ur := rFfF copy normalizeSelf.
			vFfF dot: ur]
		ifFalse: [vFfF length]
]

{ #category : #accessing }
GEORelPosVelAccData >> vOf [
	^vOfO length
]

{ #category : #accessing }
GEORelPosVelAccData >> vOfO [
	vOfO == nil ifTrue: [self vOfO: (FullColumn zero: 3)].
	^vOfO
]

{ #category : #accessing }
GEORelPosVelAccData >> vOfO1 [
	^vOfO at: 1
]

{ #category : #accessing }
GEORelPosVelAccData >> vOfO2 [
	^vOfO at: 2
]

{ #category : #accessing }
GEORelPosVelAccData >> vOfO3 [
	^vOfO at: 3
]

{ #category : #accessing }
GEORelPosVelAccData >> vOfO: col [ 
	vOfO := col
]

{ #category : #accessing }
GEORelPosVelAccData >> vOfRadial [
	| ur |
	^rOfO length > 0
		ifTrue: 
			[ur := rOfO copy normalizeSelf.
			vOfO dot: ur]
		ifFalse: [vOfO length]
]

{ #category : #'ops on self' }
GEORelPosVelAccData >> zeroSelf [
	rFfF := (FullColumn zero: 3).
	aAFf := (FullMatrix identity: 3).
	vFfF := (FullColumn zero: 3).
	omeFfF := (FullColumn zero: 3).
	aFfF := (FullColumn zero: 3).
	alpFfF := (FullColumn zero: 3).
	rOfO := (FullColumn zero: 3).
	aAOf := (FullMatrix identity: 3).
	vOfO := (FullColumn zero: 3).
	omeOfO := (FullColumn zero: 3).
	aOfO := (FullColumn zero: 3).
	alpOfO := (FullColumn zero: 3).
	time := 0.0d
]
