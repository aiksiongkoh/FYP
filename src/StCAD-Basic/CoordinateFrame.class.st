Class {
	#name : #CoordinateFrame,
	#superclass : #SupItem,
	#instVars : [
		'body',
		'rFfF',
		'aAFf',
		'rOfO',
		'aAOf'
	],
	#category : #'StCAD-Basic'
}

{ #category : #accessing }
CoordinateFrame >> aAFf [

	^aAFf
]

{ #category : #accessing }
CoordinateFrame >> aAFf: anObject [

	aAFf := anObject
]

{ #category : #accessing }
CoordinateFrame >> aAOf [
	^aAOf ifNil: 
			[aAOf := aSup ifNil: [aAFf] ifNotNil: [aSup aAOf timesFullMatrix: aAFf]]
]

{ #category : #accessing }
CoordinateFrame >> aAOf: aFullMatrix [

	aAOf := aFullMatrix
]

{ #category : #accessing }
CoordinateFrame >> body [

	^body
]

{ #category : #accessing }
CoordinateFrame >> body: anObject [

	body := anObject
]

{ #category : #testing }
CoordinateFrame >> isAxis: axisi coaxialWith: aFrame axis: axisj [

	| angleTol distTol axesParallel rfpf rfpfperpendicular originjIsOnAxisi |
	angleTol := 1.0d-6.
	distTol := 1.0d-9.
	axesParallel := ((self aAOf column: axisi)
				dot: (aFrame aAOf column: axisj)) abs
				equal: 1.0d
				tol: angleTol.
	rfpf := self rfpffromrOpO: aFrame rOfO.
	rfpfperpendicular := rfpf
				at: axisi put: 0.0d;
				yourself.
	originjIsOnAxisi := rfpfperpendicular length < distTol.
	^axesParallel & originjIsOnAxisi
]

{ #category : #accessing }
CoordinateFrame >> rFfF [

	^rFfF
]

{ #category : #accessing }
CoordinateFrame >> rFfF: col [

	rFfF := col.
	self changed
]

{ #category : #accessing }
CoordinateFrame >> rOfO [

	^rOfO
		ifNil: 
			[rOfO := aSup
						ifNil: [rFfF]
						ifNotNil: [aSup rOfO + (aSup aAOf timesFullColumn: rFfF)]]
]

{ #category : #accessing }
CoordinateFrame >> rOfO: anObject [

	^rOfO := anObject
]

{ #category : #accessing }
CoordinateFrame >> rfpffromrOpO: rOpO [

	^self aAOf transpose timesFullColumn: rOpO - self rOfO
]
