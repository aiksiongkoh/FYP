Class {
	#name : #GEOEulerAngleszyx,
	#superclass : #GEOEulerAngles,
	#type : #variable,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'instance creation' }
GEOEulerAngleszyx class >> fromA: aA [ 
	| answer msthe2y the1z the2y the3x cthe1z sthe1z y x |
	answer := self new.
	msthe2y := aA at: 3 and: 1.
	msthe2y abs > 0.999999d
		ifTrue: [msthe2y strictlyPositive
				ifTrue: 
					[the1z := Double arcTanMpiTOpiY: (aA at: 1 and: 2) negated overX: (aA at: 2 and: 2).
					the2y := Double pi / -2.0d.
					the3x := 0.0d]
				ifFalse: 
					[the1z := Double arcTanMpiTOpiY: (aA at: 1 and: 2) negated overX: (aA at: 2 and: 2).
					the2y := Double pi / 2.0d.
					the3x := 0.0d]]
		ifFalse: 
			[the1z := Double arcTanMpiTOpiY: (aA at: 2 and: 1)
						overX: (aA at: 1 and: 1).
			cthe1z := the1z cos.
			sthe1z := the1z sin.
			y := msthe2y negated.
			x := cthe1z abs > sthe1z abs
						ifTrue: [(aA at: 1 and: 1)
								/ cthe1z]
						ifFalse: [(aA at: 2 and: 1)
								/ sthe1z].
			the2y := Double arcTanMpiTOpiY: y overX: x.
			the3x := Double arcTanMpiTOpiY: (aA at: 3 and: 2)
						overX: (aA at: 3 and: 3)].
	answer at: 1 put: the1z.
	answer at: 2 put: the2y.
	answer at: 3 put: the3x.
	^answer
]

{ #category : #'VisualWorks metadata' }
GEOEulerAngleszyx class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #calc }
GEOEulerAngleszyx >> calc [
	| aA1 aA2 aA3 |
	aA1 := self rotatez: (self at: 1).
	aA2 := self rotatey: (self at: 2).
	aA3 := self rotatex: (self at: 3).
	aA := aA1 timesFullMatrix: (aA2 timesFullMatrix: aA3)
]
