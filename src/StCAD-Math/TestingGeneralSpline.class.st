Class {
	#name : #TestingGeneralSpline,
	#superclass : #GeneralSpline,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #calculation }
TestingGeneralSpline >> computeDerivatives [
	"See derivation in 9spline.doc."

	degree = 0 
		ifTrue: [self changeClassToThatOf: ZeroDegreeSpline basicNew]
		ifFalse: 
			[| n p np matrix bvector y1 hs zero hmax derivsVector hmaxpowers |
			n := xs size.
			p := degree.
			np := n * p.
			matrix := SparseMatrix new: np by: np.
			bvector := FullColumn new: np.
			y1 := ys at: 1.
			(y1 isKindOf: Array) 
				ifTrue: [zero := (y1 class new: y1 size) atAllPut: Double zero]
				ifFalse: [zero := y1 class zero].
			bvector atAllPut: zero.
			hs := FullColumn new: np - 1.
			hmax := 0.0d.
			1 to: n - 1
				do: 
					[:i | 
					| h |
					h := (xs at: i + 1) - (xs at: i).
					hmax := hmax max: h abs.
					hs at: i put: h].
			1 to: n - 1
				do: 
					[:i | 
					| offset hbar dum |
					offset := (i - 1) * p.
					hbar := (hs at: i) / hmax.
					2 to: p
						do: 
							[:j | 
							matrix 
								at: offset + j
								and: offset + j - 1
								put: 1.0d.
							matrix 
								at: offset + j
								and: offset + j - 1 + p
								put: -1.0d].
					dum := 1.0d.
					1 to: p
						do: 
							[:j | 
							dum := dum * hbar / j.
							j to: p
								do: 
									[:k | 
									matrix 
										at: offset + k - j + 1
										and: offset + k
										put: dum]].
					bvector at: offset + 1 put: (ys at: i + 1) - (ys at: i)].
			self isCyclic 
				ifTrue: 
					[0 to: p - 1
						do: 
							[:j | 
							matrix 
								at: np - j
								and: np - j
								put: 1.0d.
							matrix 
								at: np - j
								and: p - j
								put: -1.0d]]
				ifFalse: 
					["Zero out higher derivatives at node n and node 1 to get the p end equations."

					| count npass |
					count := 0.
					npass := 0.
					[count < p] whileTrue: 
							[count < p 
								ifTrue: 
									[matrix 
										at: np - count
										and: np - npass
										put: 1.0d.
									count := count + 1].
							count < p 
								ifTrue: 
									[matrix 
										at: np - count
										and: p - npass
										put: 1.0d.
									count := count + 1].
							npass := npass + 1]].
			derivsVector := GESpMatParPvMarkoFast new 
						solve: matrix
						with: bvector
						saveOriginal: false.
			derivs := FullMatrix new: n by: p.
			hmaxpowers := FullColumn new: p.
			1 to: p do: [:j | hmaxpowers at: j put: (hmax raisedTo: j)].
			1 to: n
				do: 
					[:i | 
					| derivsi |
					derivsi := derivs at: i.
					derivsi equalFullRow: derivsVector at: (i - 1) * p + 1.
					1 to: p do: [:j | derivsi at: j put: (derivsi at: j) / (hmaxpowers at: j)]]]
]

{ #category : #calculation }
TestingGeneralSpline >> computeDerivativesGood [
	"See derivation in 9spline.doc."

	degree = 0 
		ifTrue: [self changeClassToThatOf: ZeroDegreeSpline basicNew]
		ifFalse: 
			[| n p np matrix bvector y1 hs zero hmax derivsVector hmaxpowers |
			n := xs size.
			p := degree.
			np := n * p.
			matrix := SparseMatrix new: np by: np.
			bvector := FullColumn new: np.
			y1 := ys at: 1.
			(y1 isKindOf: Array) 
				ifTrue: [zero := (y1 class new: y1 size) atAllPut: Double zero]
				ifFalse: [zero := y1 class zero].
			bvector atAllPut: zero.
			hs := FullColumn new: np - 1.
			hmax := 0.0d.
			1 to: n - 1
				do: 
					[:i | 
					| h |
					h := (xs at: i + 1) - (xs at: i).
					hmax := hmax max: h abs.
					hs at: i put: h].
			1 to: n - 1
				do: 
					[:i | 
					| offset hbar dum |
					offset := (i - 1) * p.
					hbar := (hs at: i) / hmax.
					2 to: p
						do: 
							[:j | 
							matrix 
								at: offset + j
								and: offset + j - 1
								put: 1.0d.
							matrix 
								at: offset + j
								and: offset + j - 1 + p
								put: -1.0d].
					dum := 1.0d.
					1 to: p
						do: 
							[:j | 
							dum := dum * hbar / j.
							j to: p
								do: 
									[:k | 
									matrix 
										at: offset + k - j + 1
										and: offset + k
										put: dum]].
					bvector at: offset + 1 put: (ys at: i + 1) - (ys at: i)].
			self isCyclic 
				ifTrue: 
					[0 to: p - 1
						do: 
							[:j | 
							matrix 
								at: np - j
								and: np - j
								put: 1.0d.
							matrix 
								at: np - j
								and: p - j
								put: -1.0d]]
				ifFalse: 
					["Zero out higher derivatives at node n and node 1 to get the p end equations."

					| count npass |
					count := 0.
					npass := 0.
					[count < p] whileTrue: 
							[count < p 
								ifTrue: 
									[matrix 
										at: np - count
										and: np - npass
										put: 1.0d.
									count := count + 1].
							count < p 
								ifTrue: 
									[matrix 
										at: np - count
										and: p - npass
										put: 1.0d.
									count := count + 1].
							npass := npass + 1]].
			derivsVector := GESpMatParPvMarkoFast new 
						solve: matrix
						with: bvector
						saveOriginal: false.
			derivs := FullMatrix new: n by: p.
			hmaxpowers := FullColumn new: p.
			1 to: p do: [:j | hmaxpowers at: j put: (hmax raisedTo: p)].
			1 to: n
				do: 
					[:i | 
					| derivsi |
					derivsi := derivs at: i.
					derivsi equalFullRow: derivsVector at: (i - 1) * p + 1.
					1 to: p do: [:j | derivsi at: j put: (derivsi at: j) / (hmaxpowers at: j)]]]
]
