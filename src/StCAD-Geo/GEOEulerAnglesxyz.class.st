Class {
	#name : #GEOEulerAnglesxyz,
	#superclass : #GEOEulerAngles,
	#type : #variable,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'instance creation' }
GEOEulerAnglesxyz class >> fromA: aA [ 
	| answer sthe2y the1x the2y the3z cthe1x sthe1x y x |
	answer := self new.
	sthe2y := aA at: 1 and: 3.
	sthe2y abs > 0.999999d
		ifTrue: [sthe2y strictlyPositive
				ifTrue: 
					[the1x := Double arcTanMpiTOpiY: (aA at: 3 and: 2)
								overX: (aA at: 2 and: 2).
					the2y := Double pi / 2.0d.
					the3z := 0.0d]
				ifFalse: 
					[the1x := Double arcTanMpiTOpiY: (aA at: 3 and: 2)
								overX: (aA at: 2 and: 2).
					the2y := Double pi / -2.0d.
					the3z := 0.0d]]
		ifFalse: 
			[the1x := Double arcTanMpiTOpiY: (aA at: 2 and: 3) negated overX: (aA at: 3 and: 3).
			cthe1x := the1x cos.
			sthe1x := the1x sin.
			y := sthe2y.
			x := cthe1x abs > sthe1x abs
						ifTrue: [(aA at: 3 and: 3)
								/ cthe1x]
						ifFalse: [(aA at: 2 and: 3)
								/ sthe1x negated].
			the2y := Double arcTanMpiTOpiY: y overX: x.
			the3z := Double arcTanMpiTOpiY: (aA at: 1 and: 2) negated overX: (aA at: 1 and: 1)].
	answer at: 1 put: the1x.
	answer at: 2 put: the2y.
	answer at: 3 put: the3z.
	^answer
]

{ #category : #'VisualWorks metadata' }
GEOEulerAnglesxyz class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #calc }
GEOEulerAnglesxyz >> calc [
	| aA1 aA2 aA3 |
	aA1 := self rotatex: (self at: 1).
	aA2 := self rotatey: (self at: 2).
	aA3 := self rotatez: (self at: 3).
	aA := aA1 timesFullMatrix: (aA2 timesFullMatrix: aA3)
]
