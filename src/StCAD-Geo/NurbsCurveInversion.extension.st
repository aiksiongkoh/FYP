Extension { #name : #NurbsCurveInversion }

{ #category : #'*StCAD-Geo-initialize-release' }
NurbsCurveInversion >> initializeGlobally [
	| cDeriv s |
	cDeriv := system cDeriv: 2 u: x.
	s := cDeriv at: 1.
	r := s minusFullColumn: rFpF.
	su := cDeriv at: 2.
	suu := cDeriv at: 3
]
