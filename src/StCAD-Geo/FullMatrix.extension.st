Extension { #name : #FullMatrix }

{ #category : #'*StCAD-Geo-StCAD-Geo' }
FullMatrix >> bryantAngles [
	| answer sthe2y the1x the2y the3z cthe1x sthe1x y x |
	answer := GEOEulerAnglesxyz new.
	sthe2y := self at: 1 and: 3.
	sthe2y abs > 0.999999d
		ifTrue: 
			[sthe2y strictlyPositive
				ifTrue: 
					[the1x := Double arcTanMpiTOpiY: (self at: 2 and: 1)
								overX: (self at: 2 and: 2).
					the2y := Double pi / 2.0d.
					the3z := 0.0d.]
				ifFalse: 
					[the1x := Double arcTanMpiTOpiY: (self at: 3 and: 2)
								overX: (self at: 3 and: 1).
					the2y := Double pi / -2.0d.
					the3z := 0.0d.].]
		ifFalse: 
			[the1x := Double arcTanMpiTOpiY: (self at: 2 and: 3) negated
						overX: (self at: 3 and: 3).
			cthe1x := the1x cos.
			sthe1x := the1x sin.
			y := sthe2y.
			x := cthe1x abs > sthe1x abs
						ifTrue: [(self at: 3 and: 3) / cthe1x.]
						ifFalse: [(self at: 2 and: 3) / sthe1x negated.].
			the2y := Double arcTanMpiTOpiY: y overX: x.
			the3z := Double arcTanMpiTOpiY: (self at: 1 and: 2) negated
						overX: (self at: 1 and: 1).].
	answer at: 1 put: the1x.
	answer at: 2 put: the2y.
	answer at: 3 put: the3z.
	^answer.
]
