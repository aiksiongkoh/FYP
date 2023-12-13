Extension { #name : #NurbsSurfaceInversion }

{ #category : #'*StCAD-Geo-initialize-release' }
NurbsSurfaceInversion >> initializeGlobally [
	| ccDeriv s |
	ccDeriv := system 
				ccDeriv: 2
				u: (x at: 1)
				v: (x at: 2).
	s := ccDeriv at: 1 and: 1.
	r := s minusFullColumn: rFpF.
	su := ccDeriv at: 2 and: 1.
	sv := ccDeriv at: 1 and: 2.
	suu := ccDeriv at: 3 and: 1.
	suv := ccDeriv at: 2 and: 2.
	svv := ccDeriv at: 1 and: 3.
	matrixSolver := self matrixSolverClass new
]
