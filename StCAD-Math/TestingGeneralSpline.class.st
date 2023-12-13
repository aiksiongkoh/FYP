Class {
	#name : #TestingGeneralSpline,
	#superclass : #GeneralSpline,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #examples }
TestingGeneralSpline class >> example2 [
	"self example2"

	"Closed curve. Best to use odd order."

	| x order xs ys |
	x := IndependentVariable new.
	order := 4.
	xs := MathArray 
				newWithElements: #(0.0d 1.0d 2.0d 3.0d 4.0d 5.0d 6.0d 7.0d 8.0d 9.0d 10.0d 11.0d 12.0d 13.0d 14.0d 15.0d).
	ys := MathArray 
				newWithElements: #(0.0d 1.0d 2.0d 3.0d 4.0d 5.0d 6.0d 7.0d 7.0d 6.0d 5.0d 4.0d 3.0d 2.0d 1.0d 0.0d).
	^self 
		with: x
		order: order
		xs: xs
		ys: ys
]

{ #category : #examples }
TestingGeneralSpline class >> example4 [
	"self example4"

	"Open antisymmetric curve. Even order maintains the antisymmetry beyond the first and last points."

	"Beware of wiggles in between nodes. Even order seems to be particularly bad!"

	| x order xs ys |
	x := IndependentVariable new.
	order := 4.
	xs := MathArray 
				newWithElements: #(-0.5d -0.4d -0.3d -0.2d -0.1d 0.0d 0.1d 0.2d 0.3d 0.4d 0.5d).
	ys := MathArray 
				newWithElements: #(-23200d -12800d -8700d -5800d -2900d 0d 2900d 5800d 8700d 12800d 23200d).
	^self 
		with: x
		order: order
		xs: xs
		ys: ys
]

{ #category : #'VisualWorks metadata' }
TestingGeneralSpline class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

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
