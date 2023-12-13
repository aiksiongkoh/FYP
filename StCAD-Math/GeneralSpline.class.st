"
StMGeneralSpline is a general spline of ys vs xs.
xs is a series of scalars.
ys is a series of vectors.
Note: even degree splines cannot be closed.

Instance Variables:
	degree	<SmallInteger>	degree of polynomial used.
	delta	<Double>	least positive value of (x - xs(i)).
	derivs	<StMFullMatrix>	each row is #(y dy/dx and higher derivatives) at xs(i).
	index	<SmallInteger>	same as i.


"
Class {
	#name : #GeneralSpline,
	#superclass : #FunctionFromData,
	#instVars : [
		'derivs',
		'degree',
		'index',
		'delta'
	],
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #examples }
GeneralSpline class >> example1 [
	"StMGeneralSpline example1"

	"Open curve. Best to use even order."

	| x order xs ys |
	x := IndependentVariable new.
	order := 3.
	xs := MathArray 
				newWithElements: #(0.0d 1.0d 2.0d 3.0d 4.0d 5.0d 6.0d 7.0d 8.0d 9.0d 10.0d 11.0d 12.0d 13.0d 14.0d 15.0d).
	ys := MathArray 
				newWithElements: #(0.0d 1.0d 2.0d 3.0d 4.0d 5.0d 6.0d 7.0d 8.0d 9.0d 10.0d 11.0d 12.0d 13.0d 14.0d 15.0d).
	^GeneralSpline 
		with: x
		order: order
		xs: xs
		ys: ys
]

{ #category : #examples }
GeneralSpline class >> example2 [
	"StMGeneralSpline example2"

	"Closed curve. Best to use odd order."

	| x order xs ys |
	x := IndependentVariable new.
	order := 3.
	xs := MathArray 
				newWithElements: #(0.0d 1.0d 2.0d 3.0d 4.0d 5.0d 6.0d 7.0d 8.0d 9.0d 10.0d 11.0d 12.0d 13.0d 14.0d 15.0d).
	ys := MathArray 
				newWithElements: #(0.0d 1.0d 2.0d 3.0d 4.0d 5.0d 6.0d 7.0d 7.0d 6.0d 5.0d 4.0d 3.0d 2.0d 1.0d 0.0d).
	^GeneralSpline 
		with: x
		order: order
		xs: xs
		ys: ys
]

{ #category : #examples }
GeneralSpline class >> example3 [
	"StMGeneralSpline example3"

	"Open antisymmetric curve. Even order maintains the antisymmetry beyond the first and last points."

	| x order xs ys |
	x := IndependentVariable new.
	order := 4.
	xs := MathArray 
				newWithElements: #(-5.0d -4.0d -3.0d -2.0d -1.0d 0.0d 1.0d 2.0d 3.0d 4.0d 5.0d).
	ys := MathArray 
				newWithElements: #(-6.0d -4.0d -3.0d -2.0d -1.0d 0.0d 1.0d 2.0d 3.0d 4.0d 6.0d).
	^GeneralSpline 
		with: x
		order: order
		xs: xs
		ys: ys
]

{ #category : #examples }
GeneralSpline class >> example4 [
	"StMGeneralSpline example4"

	"Open antisymmetric curve. Even order maintains the antisymmetry beyond the first and last points."

	"Beware of wiggles in between nodes. Even order seems to be particularly bad!"

	| x order xs ys |
	x := IndependentVariable new.
	order := 4.
	xs := MathArray 
				newWithElements: #(-0.5d -0.4d -0.3d -0.2d -0.1d 0.0d 0.1d 0.2d 0.3d 0.4d 0.5d).
	ys := MathArray 
				newWithElements: #(-23200d -12800d -8700d -5800d -2900d 0d 2900d 5800d 8700d 12800d 23200d).
	^GeneralSpline 
		with: x
		order: order
		xs: xs
		ys: ys
]

{ #category : #accessing }
GeneralSpline class >> functionSymbol [
	^'spline'
]

{ #category : #accessing }
GeneralSpline class >> functionTemplate [
	^self functionSymbol , '(x, degree, x1, y1, x2, y2, ...)'
]

{ #category : #'VisualWorks metadata' }
GeneralSpline class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
GeneralSpline class >> with: var order: order xs: xxs ys: yys [ 
	| ys answer |
	ys := (yys isKindOf: MathArray)
				ifTrue: [yys]
				ifFalse: 
					[answer := MathArray new: yys size.
					1 to: answer size do: [:i | answer at: i put: (yys at: i)].
					answer].
	^super new
		x: var
		order: order
		xs: xxs
		ys: ys
]

{ #category : #ops }
GeneralSpline >> * double [ 
	^GeneralSpline 
		with: self x
		order: self degree
		xs: self xs copy
		ys: (self ys collect: [:element | element * double])
]

{ #category : #ops }
GeneralSpline >> / double [ 
	^GeneralSpline
		with: self x
		order: self degree
		xs: self xs copy
		ys: (self ys collect: [:element | element / double])
]

{ #category : #comparing }
GeneralSpline >> = anObject [ 
	^super = anObject and: [derivs = anObject derivs and: [degree = anObject degree]]
]

{ #category : #accessing }
GeneralSpline >> arguments1: array [ 
	| n |
	self x: (array at: 1).
	self degree: (array at: 2) value.
	n := (array size - 2) / 2.
	xs := Array new: n.
	ys := Array new: n.
	1 to: n
		do: 
			[:i | 
			xs at: i put: (array at: 2 * i + 1) value.
			ys at: i put: (array at: 2 * i + 2) value].
	self xs: xs.
	self ys: ys
]

{ #category : #accessing }
GeneralSpline >> arguments: array [ 
	| n arg order xarray yarray |
	arg := array at: 1.
	order := (array at: 2) value.
	n := (array size - 2) / 2.
	xarray := Array new: n.
	yarray := Array new: n.
	1 to: n
		do: 
			[:i | 
			xarray at: i put: (array at: 2 * i + 1) value.
			yarray at: i put: (array at: 2 * i + 2) value].
	self 
		x: arg
		order: order
		xs: xarray
		ys: yarray
]

{ #category : #calculation }
GeneralSpline >> calcCyclicIndexAndDelta [
	| xFirst xLast |
	xFirst := xs first.
	xLast := xs last.
	xvalue := xvalue - xFirst \\ (xLast - xFirst) + xFirst.
	self calcIndexAndDelta
]

{ #category : #calculation }
GeneralSpline >> calcIndexAndDelta [
	(index < xs size and: [(xs at: index)
			<= xvalue & (xvalue < (xs at: index + 1))])
		ifFalse: [self searchIndexFrom: 1 to: xs size].
	delta := xvalue - (xs at: index)
]

{ #category : #calculation }
GeneralSpline >> calcIndexAndDeltaFor: xx [ 
	xvalue := xx.
	self isCyclic
		ifTrue: [self calcCyclicIndexAndDelta]
		ifFalse: [self calcNonCyclicIndexAndDelta]
]

{ #category : #calculation }
GeneralSpline >> calcNonCyclicIndexAndDelta [
	| xFirst xLast |
	xFirst := xs first.
	xLast := xs last.
	xvalue <= xFirst
		ifTrue: 
			[index := 1.
			delta := xvalue - xFirst]
		ifFalse: [xvalue >= xLast
				ifTrue: 
					[index := xs size.
					delta := xvalue - xLast]
				ifFalse: [self calcIndexAndDelta]]
]

{ #category : #calculation }
GeneralSpline >> computeDerivatives [
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
GeneralSpline >> computeDerivatives1 [
	"See derivation in 9spline.doc."

	| n p np matrix bvector y1 zero offset h dum jj ii derivsVector |
	degree = 0
		ifTrue: [self changeClassToThatOf: ZeroDegreeSpline basicNew]
		ifFalse: 
			[n := xs size.
			p := degree.
			np := n * p.
			matrix := SparseMatrix new: np by: np.
			bvector := FullColumn new: np.
			y1 := ys at: 1.
			(y1 isKindOf: Array)
				ifTrue: [zero := (y1 class new: y1 size)
								atAllPut: Double zero]
				ifFalse: [zero := y1 class zero].
			bvector atAllPut: zero.
			1 to: n - 1
				do: 
					[:i | 
					offset := i - 1 * p.
					h := (xs at: i + 1)
								- (xs at: i).
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
							dum := dum * h / j.
							j to: p do: [:k | matrix
									at: offset + k - j + 1
									and: offset + k
									put: dum]].
					bvector at: offset + 1 put: (ys at: i + 1)
							- (ys at: i)].
			offset := n - 1 * p.
			self isCyclic
				ifTrue: ["Filling in the boundary conditions."
					p odd
						ifTrue: 
							[1 to: p - 1
								do: 
									[:j | 
									jj := offset + j.
									matrix
										at: jj
										and: j
										put: 1.0d.
									matrix
										at: jj
										and: jj
										put: -1.0d].
							matrix
								at: np
								and: np
								put: 1.0d]
						ifFalse: 
							[1 to: p - 2
								do: 
									[:j | 
									jj := offset + j.
									matrix
										at: jj
										and: j
										put: 1.0d.
									matrix
										at: jj
										and: jj
										put: -1.0d].
							matrix
								at: np - 1
								and: p
								put: 1.0d.	"(pEven - 1) continuity at 1 and n is not 
							guaranteed."
							matrix
								at: np
								and: np
								put: 1.0d]]
				ifFalse: 
					["pEven derivative at 1 and n are zeros."
					ii := offset.
					p // 2 + 1 to: p - 1
						do: 
							[:j | 
							ii := ii + 1.
							matrix
								at: ii
								and: j
								put: 1.0d.
							ii := ii + 1.
							matrix
								at: ii
								and: offset + j
								put: 1.0d].
					p even ifTrue: [matrix
							at: np - 1
							and: p
							put: 1.0d].
					matrix
						at: np
						and: np
						put: 1.0d].
			derivsVector := GESpMatParPvMarko new
						solve: matrix
						with: bvector
						saveOriginal: false.
			derivs := FullMatrix new: n by: p.
			1 to: n do: [:i | (derivs at: i)
					equalFullRow: derivsVector at: i - 1 * p + 1]]
]

{ #category : #calculation }
GeneralSpline >> computeDerivativesgood [
	"See derivation in 9spline.doc."

	| n p np matrix bvector y1 zero offset h dum derivsVector count npass |
	degree = 0 
		ifTrue: [self changeClassToThatOf: ZeroDegreeSpline basicNew]
		ifFalse: 
			[n := xs size.
			p := degree.
			np := n * p.
			matrix := SparseMatrix new: np by: np.
			bvector := FullColumn new: np.
			y1 := ys at: 1.
			(y1 isKindOf: Array) 
				ifTrue: [zero := (y1 class new: y1 size) atAllPut: Double zero]
				ifFalse: [zero := y1 class zero].
			bvector atAllPut: zero.
			1 to: n - 1
				do: 
					[:i | 
					offset := (i - 1) * p.
					h := (xs at: i + 1) - (xs at: i).
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
							dum := dum * h / j.
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
			1 to: n
				do: [:i | (derivs at: i) equalFullRow: derivsVector at: (i - 1) * p + 1]]
]

{ #category : #evaluating }
GeneralSpline >> d2ydx2: xx [ 
	^self derivative: 2 at: xx
]

{ #category : #evaluating }
GeneralSpline >> d3ydx3: xx [ 
	^self derivative: 3 at: xx
]

{ #category : #accessing }
GeneralSpline >> degree [
	^degree
]

{ #category : #accessing }
GeneralSpline >> degree: integer [ 
	degree := integer.
	(degree even and: [self isCyclic])
		ifTrue: [self error: 'KOH001: Even degree cyclic spline is not possible.']
]

{ #category : #evaluating }
GeneralSpline >> derivative: n at1: xx [ 
	"dydx(x) := dydxi + d2ydx2i*hi + d3ydx3i*hi^2/2! +"
	"d2ydx2(x) := d2ydx2i + d3ydx3i*hi + d4ydx4i*hi^2/2! +"

	| derivsi d1 sum |
	self calcIndexAndDeltaFor: xx.
	derivsi := derivs at: index.
	d1 := derivsi at: 1.
	(d1 isKindOf: Array)
		ifTrue: [sum := (d1 class new: d1 size)
						atAllPut: Double zero]
		ifFalse: [sum := d1 class zero].
	degree
		to: n + 1
		by: -1
		do: [:j | sum := sum + (derivsi at: j) * delta / (j - n) asDouble].
	^(derivsi at: n)
		+ sum
]

{ #category : #evaluating }
GeneralSpline >> derivative: n at: xx [ 
	"dydx(x) := dydxi + d2ydx2i*hi + d3ydx3i*hi^2/2! +"

	"d2ydx2(x) := d2ydx2i + d3ydx3i*hi + d4ydx4i*hi^2/2! +"

	^n > degree 
		ifTrue: [0.0d]
		ifFalse: 
			[| derivsi d1 sum |
			self calcIndexAndDeltaFor: xx.
			derivsi := derivs at: index.
			d1 := derivsi at: 1.
			(d1 isKindOf: Array) 
				ifTrue: [sum := (d1 class new: d1 size) atAllPut: Double zero]
				ifFalse: [sum := d1 class zero].
			degree to: n + 1
				by: -1
				do: [:j | sum := (sum + (derivsi at: j)) * delta / (j - n) asDouble].
			(derivsi at: n) + sum]
]

{ #category : #accessing }
GeneralSpline >> derivs [
	^derivs
]

{ #category : #evaluating }
GeneralSpline >> differentiateWRTx [
	^DifferentiatedGeneralSpline with: self derivativeOrder: 1
]

{ #category : #evaluating }
GeneralSpline >> dydx: xx [ 
	^self derivative: 1 at: xx
]

{ #category : #'initialize-release' }
GeneralSpline >> initialize [
	super initialize.
	index := 1
]

{ #category : #testing }
GeneralSpline >> isCyclic [
	"Answer whether the receiver is cyclic, i.e., folds back on itself."

	^ys size > 3 and: [ys first = ys last]
]

{ #category : #copying }
GeneralSpline >> postCopy [
	super postCopy.
	derivs := derivs isSequenceable
				ifTrue: [derivs collect: [:item | item copy]]
				ifFalse: [derivs copy].
	degree := degree copy.
	index := index copy.
	delta := delta copy
]

{ #category : #evaluating }
GeneralSpline >> pppvaluepspsps: s [ 
	^Array with: (Array with: (Array with: (self d3ydx3: (s at: 1))))
]

{ #category : #evaluating }
GeneralSpline >> ppvaluepsps: s [ 
	^FullMatrix with: (FullRow with: (self d2ydx2: (s at: 1)))
]

{ #category : #evaluating }
GeneralSpline >> pvalueps: s [ 
	^(self dydx: (s at: 1)) asFullMatrix
]

{ #category : #calculation }
GeneralSpline >> searchIndexFrom: first to: last [ 
	"Assume xs(first) <= xvalue < xs(last)."

	| middle |
	first + 1 == last
		ifTrue: [index := first]
		ifFalse: 
			[middle := first + last // 2.
			xvalue < (xs at: middle)
				ifTrue: [self searchIndexFrom: first to: middle]
				ifFalse: [self searchIndexFrom: middle to: last]]
]

{ #category : #changing }
GeneralSpline >> substitute: var1 with: var2 [ 
	| xx |
	^self = var1
		ifTrue: [var2]
		ifFalse: 
			[xx := x substitute: var1 with: var2.
			self class
				with: xx
				order: degree
				xs: xs
				ys: ys]
]

{ #category : #accessing }
GeneralSpline >> value [
	^self y: x value
]

{ #category : #evaluating }
GeneralSpline >> value: s [ 
	^self y: (s at: 1)
]

{ #category : #'initialize-release' }
GeneralSpline >> x: arg order: order xs: xarray ys: yarray [ 
	x := self conditionArgument: arg.
	degree := order asInteger.
	xs := xarray.
	xs isIncreasing ifFalse: [self error: #'StM: x series must be in increasing order.'].
	ys := yarray.
"	(degree notNil and: [degree isZero not and: [degree even and: [self isCyclic]]])
		ifTrue: [self error: 'KOH001: Even degree cyclic spline is not possible.']."
	self computeDerivatives
]

{ #category : #accessing }
GeneralSpline >> xs [
	^xs
]

{ #category : #accessing }
GeneralSpline >> xs: array [ 
	array isIncreasing ifFalse: [self error: #'KOH: x series must be in increasing order.'].
	xs := array
]

{ #category : #evaluating }
GeneralSpline >> y: xx [ 
	"y(x) := yi + dydxi*hi + d2ydx2i*hi^2/2! + d3ydx3i*hi^3/3! +"

	| derivsi d1 sum |
	self calcIndexAndDeltaFor: xx.
	derivsi := derivs at: index.
	d1 := derivsi at: 1.
	(d1 isKindOf: Array)
		ifTrue: [sum := (d1 class new: d1 size) atAllPut: Double zero]
		ifFalse: [sum := d1 class zero].
	degree to: 1 by: -1 do: [:j | sum := sum + (derivsi at: j) * delta / j asDouble].
	^(ys at: index) + sum
]

{ #category : #accessing }
GeneralSpline >> ys [
	^ys
]

{ #category : #accessing }
GeneralSpline >> ys: array [ 
	ys := array.
	(degree notNil and: [degree even and: [self isCyclic]])
		ifTrue: [self error: 'KOH001: Even degree cyclic spline is not possible.']
]
