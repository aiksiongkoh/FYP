"
General like Array. Elements can store anything. This class encapsulate StM methods without affecting the base class Array.
"
Class {
	#name : #MathArray,
	#superclass : #Array,
	#type : #variable,
	#category : #'StCAD-Math-StMathArray'
}

{ #category : #examples }
MathArray class >> aaaa [
	"self halt. StMArray aaaa."

	| vector copy |
"	vector := StMFullColumn newWithElements: #(1.0d 2.0d 3.0d 4.0d)."
	vector := #($a 2.0d 'aaaa' 4.0d).
	copy := vector copy.
	copy at: 1 put: 11111.
	^copy = vector
]

{ #category : #examples }
MathArray class >> example0 [
	"self halt. self example0."

	| n vector |
	n := 10.
	vector := FullColumn new: n.
	vector size = n ifFalse: [self error: 'Check this.'].
	vector nrow = n ifFalse: [self error: 'Check this.'].
	vector ncol = 1 ifFalse: [self error: 'Check this.'].
	vector numberOfElements = n ifFalse: [self error: 'Check this.'].
	1 to: n do: [:i | vector at: i put: i asDouble].
	vector maxElement = n asDouble ifFalse: [self error: 'Check this.'].
	vector minAndMaxValues = (Array with: 1 with: n) ifFalse: [self error: 'Check this.'].
	vector sumOfElements = (vector inject: 0.0d into: [:sum :element | sum + element]) ifFalse: [self error: 'Check this.'].
	vector sumOfSquares = (vector inject: 0.0d into: [:ssq :element | ssq + (element * element)]) ifFalse: [self error: 'Check this.'].
	vector sumOfSquares = (vector sumOfElementsRaisedTo: 2) ifFalse: [self error: 'Check this.'].
	vector rootMeanSquare = (vector sumOfSquares / n) sqrt ifFalse: [self error: 'Check this.'].
	vector length = (vector normL: 2) ifFalse: [self error: 'Check this.']
]

{ #category : #examples }
MathArray class >> example0a [
	"self halt. self example0a."

	| vector vector2 vector3 |
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d 4.0d).
	vector2 := FullColumn new: 4.
	vector2 at: 1 put: 1.0d.
	vector2 at: 2 put: 2.0d.
	vector2 at: 3 put: 3.0d.
	vector2 at: 4 put: 4.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector3 := vector copy.
	vector2 = vector3 ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf isZero ifFalse: [self error: 'Check this.'].
	(vector3 magnifySelf: 0.0d) isZero ifFalse: [self error: 'Check this.'].
	vector2 at: 1 putFullColumn: vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalFullColumn: vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalFullColumn: vector at: 1.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 at: 1 plusFullColumn: vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfPlusFullColumn: vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfPlusFullColumn: vector at: 1.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 at: 1 minusFullColumn: vector.
	vector2 = vector negated ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfMinusFullColumn: vector.
	vector2 = vector negated ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfMinusFullColumn: vector at: 1.
	vector2 = vector negated ifFalse: [self error: 'Check this.']
]

{ #category : #examples }
MathArray class >> example1 [
	"self halt. self example1."

	| vector vector2 vector3 |
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d 4.0d).
	vector2 := FullColumn new: 4.
	vector2 at: 1 put: 1.0d.
	vector2 at: 2 put: 2.0d.
	vector2 at: 3 put: 3.0d.
	vector2 at: 4 put: 4.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector3 := vector copy.
	vector2 = vector3 ifFalse: [self error: 'Check this.'].
	vector2 at: 1 putFullColumn: vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 at: 1 putFullColumn: vector times: 1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalFullColumn: vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 equalFullColumn: vector times: 1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 at: 1 plusFullColumn: vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 at: 1 plusFullColumn: vector times: 1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfPlusFullColumn: vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 equalSelfPlusFullColumn: vector times: 1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfTimes: 1.0d plusFullVector: vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 equalSelfTimes: 1.0d plusFullVector: vector times: 1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 equalSelfTimes: 2.0d plusFullVector: vector times: -1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 at: 1 minusFullColumn: vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 at: 1 minusFullColumn: vector times: -1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfMinusFullColumn: vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 equalSelfMinusFullColumn: vector times: -1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfTimes: 1.0d minusFullVector: vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 equalSelfTimes: 1.0d minusFullVector: vector times: 1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 equalSelfTimes: 2.0d minusFullVector: vector times: -1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.']
]

{ #category : #examples2 }
MathArray class >> example10 [
	"self halt. self example10."
	"#(0.5d 1.0d 1.5d 2.0d 1.0d 2.0d 3.0d 4.0d 5.0d)"

	| vector vector2 dum |
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d 4.0d).
	vector2 := FullColumn newWithElements: #(1.0d 2.0d 3.0d 4.0d 5.0d).
	dum := FullColumn new: 9.
	dum at: 1 putFullColumn: vector.
	dum at: 5 putFullColumn: vector2.
	dum at: 1 putFullColumn: vector times: 1.0d / 2.0d.
	dum at: 5 putFullColumn: vector2.
	dum at: 1 plusFullColumn: vector times: 1.0d / 2.0d.
	dum at: 5 plusFullColumn: vector.
	dum at: 1 minusFullColumn: vector times: 1.0d / 2.0d.
	dum at: 5 minusFullColumn: vector.
	^dum
]

{ #category : #examples2 }
MathArray class >> example11 [
	"self halt. self example11."
	"#(2.0d 3.0d 4.0d)"

	| vector vector2 dum |
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d 4.0d).
	vector2 := FullColumn newWithElements: #(1.0d 2.0d 3.0d 4.0d 5.0d).
	dum := FullColumn new: 3.
	dum equalFullColumn: vector at: 2.
	dum equalSelfPlusFullColumn: vector2 at: 2.
	dum equalSelfMinusFullColumn: vector2 at: 2.
	^dum
]

{ #category : #examples2 }
MathArray class >> example11b [
	"self halt. self example11b."
	"#(22.0d 32.0d 42.0d)"

	| matrix dum |
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d 14.0d) #(21.0d 22.0d 23.0d 24.0d) #(31.0d 32.0d 33.0d 34.0d) #(41.0d 42.0d 43.0d 44.0d)).
	dum := FullColumn new: 3.
	dum equalFullMatrix: matrix at: 2 and: 2.
	dum equalSelfPlusFullMatrix: matrix at: 2 and: 2.
	dum equalSelfMinusFullMatrix: matrix at: 2 and: 2.
	^dum
]

{ #category : #examples2 }
MathArray class >> example11d [
	"self halt. self example11d."
	"#(22.0d 23.0d 24.0d)"

	| matrix dum |
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d 14.0d) #(21.0d 22.0d 23.0d 24.0d) #(31.0d 32.0d 33.0d 34.0d) #(41.0d 42.0d 43.0d 44.0d)).
	dum := FullColumn new: 3.
	dum equalFullMatrix: matrix transpose at: 2 and: 2.
	dum equalSelfPlusFullMatrix: matrix transpose at: 2 and: 2.
	dum equalSelfMinusFullMatrix: matrix transpose at: 2 and: 2.
	^dum
]

{ #category : #examples2 }
MathArray class >> example12 [
	"self halt. self example12."
	"StMFullMatrix(StMFullRow(-1.0d 0.5d nil nil nil) StMFullRow(-2.0d 1.0d nil nil nil) StMFullRow(-3.0d 
	1.5d nil nil nil) StMFullRow(-4.0d 2.0d nil nil nil) StMFullRow(-1.0d -2.0d -3.0d -4.0d nil))"

	| vector dum |
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d 4.0d).
	dum := FullMatrix new: 5 by: 5.
	dum at: 1 and: 1 putFullColumn: vector.
	dum at: 1 and: 2 putFullColumn: (vector times: 1.0d / 2.0d).
	dum at: 1 and: 1 putFullColumn: vector negated.
	dum at: 5 and: 1 putFullRow: vector transpose.
	dum at: 5 and: 1 putFullRow: (vector transpose times: 1.0d / 2.0d).
	dum at: 5 and: 1 putFullRow: vector transpose negated.
	dum at: 1 and: 1 plusFullColumn: vector.
	dum at: 1 and: 1 plusFullColumn: (vector times: 1.0d / 2.0d).
	dum at: 1 and: 1 plusFullColumn: vector negated.
	dum at: 5 and: 1 plusFullRow: vector transpose.
	dum at: 5 and: 1 plusFullRow: (vector transpose times: 1.0d / 2.0d).
	dum at: 5 and: 1 plusFullRow: vector transpose negated.
	dum at: 1 and: 1 minusFullColumn: vector.
	dum at: 1 and: 1 minusFullColumn: (vector times: 1.0d / 2.0d).
	dum at: 1 and: 1 minusFullColumn: vector negated.
	dum at: 5 and: 1 minusFullRow: vector transpose.
	dum at: 5 and: 1 minusFullRow: (vector transpose times: 1.0d / 2.0d).
	dum at: 5 and: 1 minusFullRow: vector transpose negated.
	^dum
]

{ #category : #examples2 }
MathArray class >> example12a [
	"self halt. self example12a."

	| matrix dum |
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d 14.0d) #(21.0d 22.0d 23.0d 24.0d) #(31.0d 32.0d 33.0d 34.0d) #(41.0d 42.0d 43.0d 44.0d)).
	dum := FullMatrix new: 8 by: 8.
	dum at: 1 and: 1 putFullMatrix: matrix.
	dum at: 5 and: 5 putFullMatrix: (matrix times: 1.0d / 2.0d).
	dum at: 1 and: 1 putFullMatrix: matrix negated.
	dum at: 5 and: 1 putFullMatrix: matrix transpose.
	dum at: 5 and: 1 putFullMatrix: (matrix transpose times: 1.0d / 2.0d).
	dum at: 5 and: 1 putFullMatrix: matrix transpose negated.
	dum at: 1 and: 1 plusFullMatrix: matrix.
	dum at: 1 and: 1 plusFullMatrix: (matrix times: 1.0d / 2.0d).
	dum at: 1 and: 1 plusFullMatrix: matrix negated.
	dum at: 5 and: 1 plusFullMatrix: matrix transpose.
	dum at: 5 and: 1 plusFullMatrix: (matrix transpose times: 1.0d / 2.0d).
	dum at: 5 and: 1 plusFullMatrix: matrix transpose negated.
	dum at: 1 and: 1 minusFullMatrix: matrix.
	dum at: 1 and: 1 minusFullMatrix: (matrix times: 1.0d / 2.0d).
	dum at: 1 and: 1 minusFullMatrix: matrix negated.
	dum at: 5 and: 1 minusFullMatrix: matrix transpose.
	dum at: 5 and: 1 minusFullMatrix: (matrix transpose times: 1.0d / 2.0d).
	dum at: 5 and: 1 minusFullMatrix: matrix transpose negated.
	^dum
]

{ #category : #examples2 }
MathArray class >> example13 [
	"self halt. self example13."

	| matrix dum |
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d 14.0d) #(21.0d 22.0d 23.0d 24.0d) #(31.0d 32.0d 33.0d 34.0d) #(41.0d 42.0d 43.0d 44.0d)).
	dum := FullMatrix new: 3 by: 3.
	dum equalFullMatrix: matrix at: 1 and: 1.
	dum equalFullMatrix: (matrix times: 1.0d / 2.0d) at: 1 and: 2.
	dum equalFullMatrix: matrix negated at: 1 and: 1.
	dum equalFullMatrix: matrix transpose at: 2 and: 1.
	dum equalSelfPlusFullMatrix: matrix at: 1 and: 1.
	dum equalSelfPlusFullMatrix: (matrix times: 1.0d / 2.0d) at: 1 and: 1.
	dum equalSelfPlusFullMatrix: matrix negated at: 1 and: 1.
	dum equalSelfPlusFullMatrix: matrix transpose at: 2 and: 1.
	dum equalSelfMinusFullMatrix: matrix at: 2 and: 1.
	dum equalSelfMinusFullMatrix: (matrix times: 1.0d / 2.0d) at: 1 and: 1.
	dum equalSelfMinusFullMatrix: matrix negated at: 1 and: 1.
	dum equalSelfMinusFullMatrix: matrix transpose at: 2 and: 1.
	^dum
]

{ #category : #examples }
MathArray class >> example2 [
	"self halt. self example2."

	| vector vector2 |
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d 4.0d).
	vector2 := vector times: 1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 := vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 := vector2 plusFullColumn: vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 := vector2 plusFullColumn: vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 := vector2 plusFullColumn: vector times: 1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 := vector2 times: 0.0d plusFullColumn: vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 := vector2 times: 1.0d plusFullColumn: vector times: -1.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 := vector2 minusFullColumn: vector.
	vector2 = vector negated ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 := vector2 minusFullColumn: vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 := vector2 minusFullColumn: vector times: -1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 := vector2 times: 2.0d minusFullColumn: vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 := vector2 times: 1.0d minusFullColumn: vector times: 1.0d.
	vector2 isZero ifFalse: [self error: 'Check this.']
]

{ #category : #examples }
MathArray class >> example2a [
	"self halt. self example2a."
	"StMFullColumn(-5.5d -3.5d -1.5d 0.5d)"

	| fullCol fullCol2 dum |
	fullCol := FullColumn newWithElements: #(1.0d 2.0d 3.0d 4.0d).
	fullCol2 := FullColumn newWithElements: #(4.0d 3.0d 2.0d 1.0d).
	dum := (FullColumn zero: 4).
	dum := (fullCol times: 0.5d)
				minusFullColumn: dum.
	dum := (fullCol2 times: 0.5d)
				minusFullColumn: dum.
	dum := fullCol2 negated minusFullColumn: dum.
	^dum
]

{ #category : #examples }
MathArray class >> example2b [
	"self halt. self example2b."
	"StMFullColumn(-5.5d -3.5d -1.5d 0.5d)"

	| fullCol fullCol2 dum |
	fullCol := FullColumn newWithElements: #(1.0d 2.0d 3.0d 4.0d).
	fullCol2 := FullColumn newWithElements: #(4.0d 3.0d 2.0d 1.0d).
	dum := (FullColumn zero: 4).
	dum equalSelfPlusFullColumn: fullCol.
	dum equalSelfMinusFullColumn: fullCol.
	dum equalSelfPlusFullColumn: fullCol2 times: 2.0d.
	dum equalSelfMinusFullColumn: fullCol2 times: 2.0d.
	^dum
]

{ #category : #examples }
MathArray class >> example3 [
	"self halt. self example3."
	"84.720732530713d"

	| matrix matrix2 dum |
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d)).
	matrix2 := FullMatrix new: 3 by: 3.
	1 to: matrix2 nrow do: [:i | 1 to: matrix2 ncol do: [:j | matrix2 at: i and: j put: (matrix at: i and: j)]].
	matrix2 magnifySelf: 1.5d.
	dum := 0.0d.
	dum := matrix2 rootMeanSquare + dum.
	dum := matrix2 maxElement + dum.
	^dum
]

{ #category : #examples3 }
MathArray class >> example31 [
	"self halt. self example31"
	"2 -1 3"

	| aA b |
	aA := SparseMatrix new: 3 by: 3.
	aA at: 1 and: 1 put: 2.0d.
	aA at: 1 and: 2 put: -5.0d.
	aA at: 1 and: 3 put: 1.0d.
	aA at: 2 and: 1 put: -1.0d.
	aA at: 2 and: 2 put: 3.0d.
	aA at: 2 and: 3 put: -1.0d.
	aA at: 3 and: 1 put: 3.0d.
	aA at: 3 and: 2 put: -4.0d.
	aA at: 3 and: 3 put: 2.0d.
	b := FullColumn new: 3.
	b at: 1 put: 12.0d.
	b at: 2 put: -8.0d.
	b at: 3 put: 16.0d
]

{ #category : #examples }
MathArray class >> example4 [
	"self halt. self example4."
	"#(#(181.5d 198.0d 214.5d) #(346.5d 363.0d 379.5d) #(511.5d 528.0d 544.5d))"

	| matrix matrix2 dum |
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d)).
	matrix2 := FullMatrix newWithElements: #(#(110.0d 120.0d 130.0d) #(210.0d 220.0d 230.0d) #(310.0d 320.0d 330.0d)).
	dum := FullMatrix newWithElements: #(#(0.0d 0.0d 0.0d) #(0.0d 0.0d 0.0d) #(0.0d 0.0d 0.0d)).
	dum := ((matrix times: 1.0d/ 2.0d) plusFullMatrix: (matrix2 times: 1.0d/ 2.0d)) plusFullMatrix: dum.
	dum := ((matrix times: 1.0d/ 2.0d) plusFullMatrix: matrix2) plusFullMatrix: dum.
	dum := ((matrix times: 1.0d/ 2.0d) plusFullMatrix: matrix2 negated) plusFullMatrix: dum.
	dum := (matrix plusFullMatrix: (matrix2 times: 1.0d/ 2.0d)) plusFullMatrix: dum.
	dum := (matrix plusFullMatrix: matrix2) plusFullMatrix: dum.
	dum := (matrix plusFullMatrix: matrix2 negated) plusFullMatrix: dum.
	dum := (matrix negated plusFullMatrix: (matrix2 times: 1.0d/ 2.0d)) plusFullMatrix: dum.
	dum := (matrix negated plusFullMatrix: matrix2) plusFullMatrix: dum.
	dum := (matrix negated plusFullMatrix: matrix2 negated) plusFullMatrix: dum.
	^dum
]

{ #category : #examples }
MathArray class >> example4a [
	"self halt. self example4a."
	"#(#(-148.5d -162.0d -175.5d) #(-283.5d -297.0d -310.5d) #(-418.5d -432.0d -445.5d))"

	| matrix matrix2 dum |
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d)).
	matrix2 := FullMatrix newWithElements: #(#(110.0d 120.0d 130.0d) #(210.0d 220.0d 230.0d) #(310.0d 320.0d 330.0d)).
	dum := FullMatrix newWithElements: #(#(0.0d 0.0d 0.0d) #(0.0d 0.0d 0.0d) #(0.0d 0.0d 0.0d)).
	dum := ((matrix times: 1.0d/ 2.0d) minusFullMatrix: (matrix2 times: 1.0d/ 2.0d)) plusFullMatrix: dum.
	dum := ((matrix times: 1.0d/ 2.0d) minusFullMatrix: matrix2) plusFullMatrix: dum.
	dum := ((matrix times: 1.0d/ 2.0d) minusFullMatrix: matrix2 negated) plusFullMatrix: dum.
	dum := (matrix minusFullMatrix: (matrix2 times: 1.0d/ 2.0d)) plusFullMatrix: dum.
	dum := (matrix minusFullMatrix: matrix2) plusFullMatrix: dum.
	dum := (matrix minusFullMatrix: matrix2 negated) plusFullMatrix: dum.
	dum := (matrix negated minusFullMatrix: (matrix2 times: 1.0d/ 2.0d)) plusFullMatrix: dum.
	dum := (matrix negated minusFullMatrix: matrix2) plusFullMatrix: dum.
	dum := (matrix negated minusFullMatrix: matrix2 negated) plusFullMatrix: dum.
	^dum
]

{ #category : #examples }
MathArray class >> example5 [
	"self halt. self example5."
	" StMFullMatrix(StMFullRow(227.33333333333d 254.0d 280.66666666667d) StMFullRow(428.0d 454.66666666667d 481.33333333333d) StMFullRow(628.66666666667d 655.33333333333d 682.0d))"

	| matrix matrix2 matrix3 dum |
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d)).
	matrix2 := FullMatrix newWithElements: #(#(110.0d 120.0d 130.0d) #(210.0d 220.0d 230.0d) #(310.0d 320.0d 330.0d)).
	matrix3 := matrix transpose.
	dum := FullMatrix newWithElements: #(#(0.0d 0.0d 0.0d) #(0.0d 0.0d 0.0d) #(0.0d 0.0d 0.0d)).
	dum := ((matrix3 times: 1.0d / 3.0d) plusFullMatrix: (matrix2 times: 1.0d / 3.0d)) plusFullMatrix: dum.
	dum := (matrix2 plusFullMatrix: matrix3) plusFullMatrix: dum.
	dum := ((matrix3 times: 1.0d / 3.0d) minusFullMatrix: (matrix2 times: 1.0d / 3.0d)) plusFullMatrix: dum.
	dum := (matrix2 minusFullMatrix: matrix3) plusFullMatrix: dum.
	^dum
]

{ #category : #examples }
MathArray class >> example6 [
	"self halt. self example6."

	| vector matrix answer1 |
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d).
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d) #(41.0d 42.0d 43.0d)).
	answer1 := matrix timesFullColumn: vector.
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d).
	matrix := FullMatrix newWithElements: #(#(11.0d) #(21.0d) #(31.0d) #(41.0d)).
	answer1 := matrix timesFullRow: vector transpose.
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d 4.0d).
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d) #(41.0d 42.0d 43.0d)).
	answer1 := matrix transpose timesFullColumn: vector.
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d).
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d)).
	answer1 := matrix transpose timesFullRow: vector transpose.
	^answer1
]

{ #category : #examples }
MathArray class >> example7 [
	"self halt. self example7."

	| vector vector2 answer1 |
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d).
	vector2 := FullColumn newWithElements: #(1 2 3 4).
	answer1 := vector2 timesFullColumn: vector.
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d).
	vector2 := FullColumn newWithElements: #(1 2 3 4).
	answer1 := vector2 timesFullRow: vector transpose.
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d 4.0d).
	vector2 := FullColumn newWithElements: #(1 2 3 4).
	answer1 := vector2 transpose timesFullColumn: vector.
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d).
	vector2 := FullColumn newWithElements: #(1 2 3 4).
	answer1 := vector2 transpose timesFullRow: vector transpose.
	^answer1
]

{ #category : #examples }
MathArray class >> example8 [
	"self halt. self example8."

	| matrix matrix2 answer1 |
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d) #(41.0d 42.0d 43.0d)).
	matrix2 := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d)).
	answer1 := matrix timesFullMatrix: matrix2.
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d) #(41.0d 42.0d 43.0d)).
	matrix2 := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d) #(41.0d 42.0d 43.0d)).
	answer1 := matrix timesFullMatrix: matrix2 transpose.
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d) #(41.0d 42.0d 43.0d)).
	matrix2 := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d) #(41.0d 42.0d 43.0d)).
	answer1 := matrix transpose timesFullMatrix: matrix2.
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d)).
	matrix2 := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d) #(41.0d 42.0d 43.0d)).
	answer1 := matrix transpose timesFullMatrix: matrix2 transpose.
	^answer1
]

{ #category : #examples }
MathArray class >> example9 [
	"self halt. self example9."

	| vector matrix answer1 answer2 |
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d).
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d)).
	answer1 := vector timesFullMatrix: matrix.
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d).
	matrix := FullMatrix newWithElements: #(#(11.0d) #(21.0d) #(31.0d) #(41.0d)).
	answer1 := vector timesFullMatrix: matrix transpose.
	answer2 := vector timesTransposeFullMatrix: matrix.
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d 4.0d).
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d) #(41.0d 42.0d 43.0d)).
	answer1 := vector transpose timesFullMatrix: matrix.
	answer2 := vector transposeTimesFullMatrix: matrix.
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d).
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d)).
	answer1 := vector transpose timesFullMatrix: matrix transpose.
	^answer1
]

{ #category : #'instance creation' }
MathArray class >> newWithElements: aArray [ 
	| answer |
	answer := aArray shallowCopy.
	(answer isKindOf: MathArray)
		ifFalse: [answer := answer changeClassToThatOf: (self new: 0)].
	(answer at: 1) isReal
		ifTrue: [1 to: answer size do: [:i | answer at: i put: (aArray at: i) asDouble]]
		ifFalse: [1 to: answer size do: [:i | answer at: i put: (self newWithElements: (aArray at: i))]].
	^answer
]

{ #category : #accessing }
MathArray class >> veryShortName [
	^self shortName
]

{ #category : #'VisualWorks metadata' }
MathArray class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
MathArray class >> zero: n [ 
	^(self new: n) zeroSelf
]

{ #category : #'instance creation' }
MathArray class >> zero: n unitAt: i [ 
	"StMFullColumn zero: 3 unitAt: 1"

	| answer |
	answer := self zero: n.
	answer at: i put: 1.0d.
	^answer
]

{ #category : #'basic ops' }
MathArray >> * aNumber [ 
	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				* aNumber].
	^answer
]

{ #category : #'basic ops' }
MathArray >> + array [ 
	"No checking for speed. Assumes correct dimensions and type."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				+ (array at: i)].
	^answer
]

{ #category : #'basic ops' }
MathArray >> - array [ 
	"No checking for speed. Assumes correct dimensions and type."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				- (array at: i)].
	^answer
]

{ #category : #'basic ops' }
MathArray >> / aNumber [ 
	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				/ aNumber].
	^answer
]

{ #category : #testing }
MathArray >> < aStMArray [ 
	1 to: self size
		do: [:i | (self at: i) < (aStMArray at: i) ifFalse: [^false]].
	^true
]

{ #category : #testing }
MathArray >> <= aStMArray [ 
	1 to: self size
		do: [:i | (self at: i) <= (aStMArray at: i) ifFalse: [^false]].
	^true
]

{ #category : #testing }
MathArray >> = aObject [ 
	^self == aObject or: 
			[self class == aObject class and: 
					[self basicSize == aObject basicSize and: 
							[1 to: self size do: [:i | (self at: i) = (aObject at: i) ifFalse: [^false]].
							true]]]
]

{ #category : #testing }
MathArray >> > aStMArray [ 
	1 to: self size
		do: [:i | (self at: i) > (aStMArray at: i) ifFalse: [^false]].
	^true
]

{ #category : #testing }
MathArray >> >= aStMArray [ 
	1 to: self size
		do: [:i | (self at: i) >= (aStMArray at: i) ifFalse: [^false]].
	^true
]

{ #category : #norms }
MathArray >> addTo: cNumber [ 
	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isReal 
		ifTrue: [cNumber addAll: self]
		ifFalse: [1 to: self size do: [:i | (self at: i) addTo: cNumber]]
]

{ #category : #'basic ops' }
MathArray >> arrangeElementsAccordingTo: arrayOfOriginalPositions [ 
	| n answer elementi |
	n := self size.
	answer := self class new: n.
	1 to: n
		do: 
			[:i | 
			elementi := self at: (arrayOfOriginalPositions at: i).
			answer at: i put: elementi].
	^answer
]

{ #category : #converting }
MathArray >> asFullColumn [
	^self shallowCopy changeClassToThatOf: (FullColumn new: 0)
]

{ #category : #converting }
MathArray >> asFullMatrix [
	self subclassResponsibility
]

{ #category : #converting }
MathArray >> asFullRow [
	self subclassResponsibility
]

{ #category : #converting }
MathArray >> asSparseColumn [
	self subclassResponsibility
]

{ #category : #converting }
MathArray >> asSparseMatrix [
	self subclassResponsibility
]

{ #category : #converting }
MathArray >> asSparseRow [
	self subclassResponsibility
]

{ #category : #'ops on self' }
MathArray >> at: i times: aNumber [ 
	self at: i put: ((self at: i)
			times: aNumber)
]

{ #category : #'ops on self' }
MathArray >> conditionSelf [
	"Answer a self with insignificant elements set to zeros."

	| tol |
	tol := self maxElement * MachineAccuracy OfDouble.
	self conditionSelfWithTol: tol
]

{ #category : #'ops on self' }
MathArray >> conditionSelfVectorWithTol: tol [ 
	| element |
	1 to: self size
		do: 
			[:i | 
			element := self at: i.
			element < 0.0d ifTrue: [element := 0.0d - element].
			element < tol ifTrue: [self at: i put: 0.0d]]
]

{ #category : #'ops on self' }
MathArray >> conditionSelfWithTol: tol [ 
	(self at: 1) isReal
		ifTrue: [self conditionSelfVectorWithTol: tol]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					conditionSelfWithTol: tol]]
]

{ #category : #'basic ops' }
MathArray >> conditioned [
	"Answer a fresh vector with insignificant elements set to zeros."

	^self copy conditionSelf
]

{ #category : #'basic ops' }
MathArray >> conditionedWithTol: tol [ 
	"Answer a fresh vector with insignificant elements set to zeros."

	^self copy conditionSelfWithTol: tol
]

{ #category : #'basic ops' }
MathArray >> differentiateWRT: aVar [ 
	^self collect: [:item | item differentiateWRT: aVar]
]

{ #category : #'basic ops' }
MathArray >> dot1: stmArray [ 
	"Either receiver or argument must be a one dimensional array."
	"Assume the same first dimensions."

	| array1D array answer |
	(self at: 1) isReal
		ifTrue: 
			[array1D := self.
			array := stmArray]
		ifFalse: [(stmArray at: 1) isReal
				ifTrue: 
					[array1D := stmArray.
					array := self]
				ifFalse: [self error: 'Dot product requires either receiver or argument to be one dimensional.']].
	answer := (array at: 1)
				* (array1D at: 1).
	answer isReal
		ifTrue: [2 to: array1D size do: [:i | answer := answer + ((array at: i)
								* (array1D at: i))]]
		ifFalse: [2 to: array1D size do: [:i | answer equalSelfPlus: (array at: i)
						* (array1D at: i)]].
	^answer
]

{ #category : #'basic ops' }
MathArray >> dot: stmArray [ 
	"Either receiver or argument must be a one dimensional array."

	"Assume the same first dimensions."

	| array1D array answer |
	self is1D 
		ifTrue: 
			[array1D := self.
			array := stmArray]
		ifFalse: 
			[stmArray is1D 
				ifTrue: 
					[array1D := stmArray.
					array := self]
				ifFalse: 
					[self 
						error: 'Dot product requires either receiver or argument to be one dimensional.']].
	answer := (array at: 1) * (array1D at: 1).
	answer isSequenceable 
		ifTrue: 
			[2 to: array1D size
				do: [:i | answer equalSelfPlus: (array at: i) * (array1D at: i)]]
		ifFalse: 
			[2 to: array1D size
				do: [:i | answer := answer + ((array at: i) * (array1D at: i))]].
	^answer
]

{ #category : #accessing }
MathArray >> elementClass [
	"Vector and Matrix are intended to store numbers of the same class."

	^Double
]

{ #category : #'basic ops' }
MathArray >> elementTimesElementOf: stmArray [ 
	"Element by element multiplication."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				* (stmArray at: i)].
	^answer
]

{ #category : #'ops on self' }
MathArray >> equal: stmArray [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isReal
		ifTrue: [1 to: self size do: [:i | self at: i put: (stmArray at: i)]]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					equal: (stmArray at: i)]]
]

{ #category : #'ops on self' }
MathArray >> equal: stmArray at: ii1 [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isReal
		ifTrue: 
			[| iiOffset |
			iiOffset := ii1 - 1.
			1 to: self size do: [:i | self at: i put: (stmArray at: iiOffset + i)]]
		ifFalse: 
			[| iiOffset |
			iiOffset := ii1 - 1.
			1 to: self size do: [:i | (self at: i)
					equal: (stmArray at: iiOffset + i)]]
]

{ #category : #'ops on self' }
MathArray >> equal: stmArray at: ii1 and: jj1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self nrow do: [:i | (self at: i)
			equal: (stmArray at: iiOffset + i)
			at: jj1]
]

{ #category : #'ops on self' }
MathArray >> equal: stmArray times: number [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isReal
		ifTrue: [1 to: self size do: [:i | self at: i put: (stmArray at: i)
						* number]]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					equal: (stmArray at: i)
					times: number]]
]

{ #category : #'ops on self' }
MathArray >> equalSelfMinus: stmArray [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isReal
		ifTrue: [1 to: self size do: [:i | self at: i put: (self at: i)
						- (stmArray at: i)]]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					equalSelfMinus: (stmArray at: i)]]
]

{ #category : #'ops on self' }
MathArray >> equalSelfMinus: stmArray at: ii1 [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isReal
		ifTrue: 
			[| iiOffset |
			iiOffset := ii1 - 1.
			1 to: self size do: [:i | self at: i put: (self at: i)
						- (stmArray at: iiOffset + i)]]
		ifFalse: 
			[| iiOffset |
			iiOffset := ii1 - 1.
			1 to: self size do: [:i | (self at: i)
					equalSelfMinus: (stmArray at: iiOffset + i)]]
]

{ #category : #'ops on self' }
MathArray >> equalSelfMinus: stmArray at: ii1 and: jj1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self nrow do: [:i | (self at: i)
			equalSelfMinus: (stmArray at: iiOffset + i)
			at: jj1]
]

{ #category : #'ops on self' }
MathArray >> equalSelfMinus: stmArray times: number [ 
	"Assume self and stmArray are same type and dimensions."

	self equalSelfPlus: stmArray times: number negated
]

{ #category : #'ops on self' }
MathArray >> equalSelfPlus: stmArray [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isReal
		ifTrue: [1 to: self size do: [:i | self at: i put: (self at: i)
						+ (stmArray at: i)]]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					equalSelfPlus: (stmArray at: i)]]
]

{ #category : #'ops on self' }
MathArray >> equalSelfPlus: stmArray at: ii1 [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isReal
		ifTrue: 
			[| iiOffset |
			iiOffset := ii1 - 1.
			1 to: self size do: [:i | self at: i put: (self at: i)
						+ (stmArray at: iiOffset + i)]]
		ifFalse: 
			[| iiOffset |
			iiOffset := ii1 - 1.
			1 to: self size do: [:i | (self at: i)
					equalSelfPlus: (stmArray at: iiOffset + i)]]
]

{ #category : #'ops on self' }
MathArray >> equalSelfPlus: stmArray at: ii1 and: jj1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self nrow do: [:i | (self at: i)
			equalSelfPlus: (stmArray at: iiOffset + i)
			at: jj1]
]

{ #category : #'ops on self' }
MathArray >> equalSelfPlus: stmArray times: number [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isReal
		ifTrue: [1 to: self size do: [:i | self at: i put: (self at: i)
						+ ((stmArray at: i)
								* number)]]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					equalSelfPlus: (stmArray at: i)
					times: number]]
]

{ #category : #'ops on self' }
MathArray >> equalSelfTimes: alpha minus: stmArray times: beta [ 
	self
		equalSelfTimes: alpha
		plus: stmArray
		times: beta negated
]

{ #category : #'ops on self' }
MathArray >> equalSelfTimes: alpha plus: stmArray times: beta [ 
	"Assume self and stmArray are same type and dimensions."
	"alpha and beta are numbers."

	(self at: 1) isReal
		ifTrue: [1 to: self size do: [:i | self at: i put: (self at: i)
						* alpha + ((stmArray at: i)
							* beta)]]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					equalSelfTimes: alpha
					plus: (stmArray at: i)
					times: beta]]
]

{ #category : #testing }
MathArray >> is1D [
	"^first isSequenceable not"

	| first |
	first := self at: 1.
	^first isReal or: [first isSymbolic]
]

{ #category : #testing }
MathArray >> isZero [
	1 to: self size do: [:i | (self at: i) isZero ifFalse: [^false]].
	^true
]

{ #category : #norms }
MathArray >> length [
	"Euclidean norm."
	"Square root of the sum of squares."

	^self sumOfSquares sqrt
]

{ #category : #'ops on self' }
MathArray >> magnifySelf: aNumber [ 
	"Magnify every number in the receiver by aNumber."

	aNumber = 1 ifTrue: [^self].
	(self at: 1) isReal
		ifTrue: [self magnifySelfVector: aNumber]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					magnifySelf: aNumber]]
]

{ #category : #'ops on self' }
MathArray >> magnifySelfVector: aNumber [ 
	"Magnify every number in the receiver by aNumber."

	aNumber = 1 ifTrue: [^self].
	1 to: self size do: [:i | self at: i put: (self at: i)
				* aNumber]
]

{ #category : #'basic ops' }
MathArray >> max: array [ 
	| answer |
	answer := self shallowCopy.
	1 to: self size do: [:i | answer at: i put: ((self at: i)
				max: (array at: i))].
	^answer
]

{ #category : #norms }
MathArray >> maxElement [
	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isReal
		ifTrue: [self maxElementOfVector]
		ifFalse: 
			[| answer |
			answer := selfAt1 maxElement.
			2 to: self size
				do: 
					[:i | 
					| element |
					element := (self at: i) maxElement.
					answer < element ifTrue: [answer := element]].
			answer]
]

{ #category : #norms }
MathArray >> maxElementOfVector [
	| selfAt1 answer |
	selfAt1 := self at: 1.
	selfAt1 < 0.0d ifTrue: [selfAt1 := 0.0d - selfAt1].
	answer := selfAt1.
	2 to: self size
		do: 
			[:i | 
			| selfAti |
			selfAti := self at: i.
			selfAti < 0.0d ifTrue: [selfAti := 0.0d - selfAti].
			answer < selfAti ifTrue: [answer := selfAti]].
	^answer
]

{ #category : #'basic ops' }
MathArray >> min: array [ 
	| answer |
	answer := self shallowCopy.
	1 to: self size do: [:i | answer at: i put: ((self at: i)
				min: (array at: i))].
	^answer
]

{ #category : #norms }
MathArray >> minAndMaxValues [
	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isReal
		ifTrue: [self minAndMaxValuesOfVector]
		ifFalse: 
			[| rowMinAndMaxValues min max |
			rowMinAndMaxValues := selfAt1 minAndMaxValues.
			min := rowMinAndMaxValues at: 1.
			max := rowMinAndMaxValues at: 2.
			2 to: self size
				do: 
					[:i | 
					| rowMin rowMax |
					rowMinAndMaxValues := (self at: i) minAndMaxValues.
					rowMin := rowMinAndMaxValues at: 1.
					rowMax := rowMinAndMaxValues at: 2.
					min < rowMin ifFalse: [min := rowMin].
					max > rowMax ifFalse: [max := rowMax]].
			Array with: min with: max]
]

{ #category : #norms }
MathArray >> minAndMaxValuesOfVector [
	"Answer array of min value and max value."

	| min max |
	min := self at: 1.
	max := min.
	2 to: self size
		do: 
			[:i | 
			| selfAti |
			selfAti := self at: i.
			min < selfAti ifFalse: [min := selfAti].
			max > selfAti ifFalse: [max := selfAti]].
	^Array with: min with: max
]

{ #category : #accessing }
MathArray >> minValue [

	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isReal
		ifTrue: [self minValueOfVector]
		ifFalse: 
			[| answer |
			answer := selfAt1 minValue.
			2 to: self size
				do: 
					[:i |
					| element |
					element := (self at: i) minValue.
					answer > element ifTrue: [answer := element]].
			answer]
]

{ #category : #accessing }
MathArray >> minValueOfVector [

	| answer |
	answer := self at: 1.
	2 to: self size
		do: 
			[:i |
			| selfAti |
			selfAti := self at: i.
			answer > selfAti ifTrue: [answer := selfAti]].
	^answer
]

{ #category : #'basic ops' }
MathArray >> minus: stmArray times: aNumber [ 
	^self plus: stmArray times: aNumber negated
]

{ #category : #'basic ops' }
MathArray >> minusNumber: aNumber [ 
	"Minus aNumber from each element."

	^self plusNumber: aNumber negated
]

{ #category : #'ops on self' }
MathArray >> mostNegativeSelf [
	(self at: 1) isSequenceable
		ifTrue: [1 to: self size do: [:i | (self at: i) mostNegativeSelf]]
		ifFalse: [self mostNegativeSelfOfVector]
]

{ #category : #'ops on self' }
MathArray >> mostNegativeSelfOfVector [
	| largestNegative |
	largestNegative := MachineAccuracy OfLargestDouble negated.
	1 to: self size do: [:i | self at: i put: largestNegative]
]

{ #category : #'ops on self' }
MathArray >> mostPositiveSelf [
	(self at: 1) isSequenceable
		ifTrue: [1 to: self size do: [:i | (self at: i) mostPositiveSelf]]
		ifFalse: [self mostPositiveSelfOfVector]
]

{ #category : #'ops on self' }
MathArray >> mostPositiveSelfOfVector [
	| largest |
	largest := MachineAccuracy OfLargestDouble.
	1 to: self size do: [:i | self at: i put: largest]
]

{ #category : #'basic ops' }
MathArray >> moveElementsToPositionsSpecifiedBy: arrayOfNewPositions [ 
	| n answer newi |
	n := self size.
	answer := self class new: n.
	1 to: n
		do: 
			[:i | 
			newi := arrayOfNewPositions at: i.
			answer at: newi put: (self at: i)].
	^answer
]

{ #category : #'ops on self' }
MathArray >> negateSelf [
	"Negate every number in the array."

	self magnifySelf: -1.0d
]

{ #category : #'basic ops' }
MathArray >> negated [
	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i) negated].
	^answer
]

{ #category : #accessing }
MathArray >> numberClass [
	"Vector and Matrix are intended to store numbers of the same class."

	^Double
]

{ #category : #accessing }
MathArray >> numberOfElements [
	"Answer the number of elements in the full vector or matrix."

	self subclassResponsibility
]

{ #category : #accessing }
MathArray >> numberOfNonZeros [
	"Answer the number of non-zeros in the full vector or matrix."

	self subclassResponsibility
]

{ #category : #norms }
MathArray >> numberOfNumbers [
	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isReal 
		ifTrue: [self size]
		ifFalse: 
			[| sum |
			sum := selfAt1 numberOfNumbers.
			2 to: self size do: [:i | sum := sum + (self at: i) numberOfNumbers].
			sum]
]

{ #category : #accessing }
MathArray >> numberOfStorageLocations [
	"Answer the total number of numbers 'values' can hold."

	self subclassResponsibility
]

{ #category : #accessing }
MathArray >> numberOfStoredElements [
	"Answer the actual number of numbers 'values' is holding."

	self subclassResponsibility
]

{ #category : #accessing }
MathArray >> numberOfStoredNonZeros [
	"Vector or matrix must store all the non zeros."

	self numberOfNonZeros
]

{ #category : #accessing }
MathArray >> numberOfStoredZeros [
	"Answer the actual number of zeros 'values' is holding."

	self subclassResponsibility
]

{ #category : #accessing }
MathArray >> numberOfZeros [
	"Answer the number of zeros in the full vector or matrix."

	self subclassResponsibility
]

{ #category : #'basic ops' }
MathArray >> plus: stmArray times: aNumber [ 
	"No checking for speed. Assumes correct dimensions and type."

	| n answer |
	n := self size.
	answer := self class new: n.
	(self at: 1) isSequenceable
		ifTrue: [1 to: n do: [:i | answer at: i put: ((self at: i)
						plus: (stmArray at: i)
						times: aNumber)]]
		ifFalse: [1 to: n do: [:i | answer at: i put: (self at: i)
						+ ((stmArray at: i)
								* aNumber)]].
	^answer
]

{ #category : #'basic ops' }
MathArray >> plusNumber: aNumber [ 
	"Plus aNumber from each element."

	| n answer |
	n := self size.
	answer := self class new: n.
	(self at: 1) isSequenceable
		ifTrue: [1 to: n do: [:i | answer at: i put: ((self at: i)
						plusNumber: aNumber)]]
		ifFalse: [1 to: n do: [:i | answer at: i put: (self at: i)
						+ aNumber]].
	^answer
]

{ #category : #testing }
MathArray >> positive [
	1 to: self size do: [:i | (self at: i) positive ifFalse: [^false]].
	^true
]

{ #category : #copying }
MathArray >> postCopy [
	(self at: 1) isReal ifFalse: [1 to: self size do: [:i | self at: i put: (self at: i) copy]]
]

{ #category : #printing }
MathArray >> printOn: aStream [ 
	"Append to the argument, aStream, the elements of the Array 
	enclosed by parentheses."

	| tooMany |
	tooMany := aStream position + self maxPrint.
	aStream
		nextPutAll: self class veryShortName;
		nextPutAll: '('.
	self do: 
			[:element | 
			element isSequenceable ifTrue: [aStream cr].
			aStream position > tooMany 
				ifTrue: 
					[aStream nextPutAll: '...(more)...)'.
					^self].
			element printOn: aStream]
		separatedBy: [aStream space].
	aStream nextPut: $)
]

{ #category : #'basic ops' }
MathArray >> productFromDouble: aNumber [ 
	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				* aNumber].
	^answer
]

{ #category : #'basic ops' }
MathArray >> productFromInteger: aInteger [ 
	^self productFromDouble: aInteger asDouble
]

{ #category : #'basic ops' }
MathArray >> productFromSmallDouble: aNumber [ 
	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				* aNumber].
	^answer
]

{ #category : #norms }
MathArray >> rootMeanSquare [
	"(sumOfSquares / numberOfElements) sqrt"

	^(self sumOfSquares / self numberOfElements) sqrt
]

{ #category : #'basic ops' }
MathArray >> roundTo: aDouble [ 
	^self collect: [:arg | arg roundTo: aDouble]
]

{ #category : #'basic ops' }
MathArray >> rounded [
	^self collect: [:item | item rounded]
]

{ #category : #'ops on self' }
MathArray >> scaleSelfBy: aFullColumn [ 
	"Magnify every element in the receiver by corresponding element in aFullColumn."

	(self at: 1) isReal 
		ifTrue: [1 to: self size do: [:i | self at: i times: (aFullColumn at: i)]]
		ifFalse: 
			[1 to: self size do: [:i | (self at: i) magnifySelf: (aFullColumn at: i)]]
]

{ #category : #'basic ops' }
MathArray >> simplified [
	^self collect: [:item | item simplified]
]

{ #category : #accessing }
MathArray >> standardDeviation [
	"
	sigma := sqrt(sum((x - xbar)^2)/n)
	sigma := sqrt(sum((x^2 - 2*x*xbar + xbar^2))/n)
	sigma := sqrt((sum(x^2) - sum(2*x*xbar) + sum(xbar^2))/n)
	sigma := sqrt((sum(x^2) - 2*sum(x)*xbar + n*xbar^2)/n)
	sigma := sqrt((sum(x^2) - 2*sum(x)^2/n + n*sum(x)^2/n^2)/n)
	sigma := sqrt((sum(x^2) - sum(x)^2/n)/n)
	sigma := sqrt((n*sum(x^2) - sum(x)^2)/n^2)
	"

	| n cNumber sum ssq aNumber |
	n := self numberOfNumbers.
	cNumber := (SortedCollection new: n) sortBlock: [:x :y | x abs <= y abs].
	self addTo: cNumber.
	sum := ssq := 0.0d.
	1 to: n
		do: 
			[:i | 
			aNumber := cNumber at: i.
			sum := sum + aNumber.
			ssq := ssq + (aNumber * aNumber)].
	^((n * ssq - (sum * sum)) / (n * n)) sqrt
]

{ #category : #norms }
MathArray >> sumOfAbsElements [
	"Sum of all element abs values."

	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isReal
		ifTrue: [self sumOfAbsElementsOfVector]
		ifFalse: 
			[| sum |
			sum := selfAt1 sumOfAbsElements.
			2 to: self size do: [:i | sum := sum + (self at: i) sumOfAbsElements].
			sum]
]

{ #category : #norms }
MathArray >> sumOfAbsElementsOfVector [
	| sum selfAt1 |
	selfAt1 := self at: 1.
	sum := selfAt1 > 0.0d
				ifTrue: [selfAt1]
				ifFalse: [0.0d - selfAt1].
	2 to: self size
		do: 
			[:i | 
			| selfAti |
			selfAti := self at: i.
			sum := selfAti > 0.0d
						ifTrue: [sum + selfAti]
						ifFalse: [sum - selfAti]].
	^sum
]

{ #category : #norms }
MathArray >> sumOfElements [
	"Sum of all elements."

	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isReal
		ifTrue: [self sumOfElementsOfVector]
		ifFalse: 
			[| sum |
			sum := selfAt1 sumOfElements.
			2 to: self size do: [:i | sum := sum + (self at: i) sumOfElements].
			sum]
]

{ #category : #norms }
MathArray >> sumOfElementsOfVector [
	| sum |
	sum := self at: 1.
	2 to: self size do: [:i | sum := sum + (self at: i)].
	^sum
]

{ #category : #norms }
MathArray >> sumOfElementsOfVectorRaisedTo: number [ 
	"For each element abs it, raised it to the power of number."
	"Then sum them all."

	| selfAt1 sum |
	selfAt1 := self at: 1.
	selfAt1 < 0.0d ifTrue: [selfAt1 := 0.0d - selfAt1].
	sum := selfAt1 raisedTo: number.
	2 to: self size
		do: 
			[:i | 
			| selfAti |
			selfAti := self at: i.
			selfAti < 0.0d ifTrue: [selfAti := 0.0d - selfAti].
			sum := sum + (selfAti raisedTo: number)].
	^sum
]

{ #category : #norms }
MathArray >> sumOfElementsRaisedTo: number [ 
	"For each element abs it, raised it to the power of number."
	"Then sum them all."

	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isReal
		ifTrue: [self sumOfElementsOfVectorRaisedTo: number]
		ifFalse: 
			[| sum |
			sum := selfAt1 sumOfElementsRaisedTo: number.
			2 to: self size do: [:i | sum := sum + ((self at: i)
								sumOfElementsRaisedTo: number)].
			sum]
]

{ #category : #norms }
MathArray >> sumOfSquares [
	"Sum of squares of all elements."

	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isReal
		ifTrue: [self sumOfSquaresOfVector]
		ifFalse: 
			[| sum |
			sum := selfAt1 sumOfSquares.
			2 to: self size do: [:i | sum := sum + (self at: i) sumOfSquares].
			sum]
]

{ #category : #norms }
MathArray >> sumOfSquaresOfVector [
	"Sum of squares of all elements."

	| selfAt1 sum |
	selfAt1 := self at: 1.
	sum := selfAt1 * selfAt1.
	2 to: self size
		do: 
			[:i | 
			| selfAti |
			selfAti := self at: i.
			sum := sum + (selfAti * selfAti)].
	^sum
]

{ #category : #'basic ops' }
MathArray >> times: aNumber [ 
	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: ((self at: i)
				times: aNumber)].
	^answer
]

{ #category : #'basic ops' }
MathArray >> times: alpha minus: stmArray [ 
	"a*alpha - b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| n answer |
	n := self size.
	answer := self class new: n.
	(self at: 1) isSequenceable
		ifTrue: [1 to: n do: [:i | answer at: i put: ((self at: i)
						times: alpha minus: (stmArray at: i))]]
		ifFalse: [1 to: n do: [:i | answer at: i put: (self at: i)
						* alpha - (stmArray at: i)]].
	^answer
]

{ #category : #'basic ops' }
MathArray >> times: beta minus: stmArray times: alpha [ 
	^self
		times: beta
		plus: stmArray
		times: alpha negated
]

{ #category : #'basic ops' }
MathArray >> times: alpha plus: stmArray [ 
	"a*alpha + b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	^stmArray plus: self times: alpha
]

{ #category : #'basic ops' }
MathArray >> times: beta plus: stmArray times: alpha [ 
	"a*alpha + b*beta = b*beta + a*alpha."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| n answer |
	n := self size.
	answer := self class new: n.
	(self at: 1) isSequenceable
		ifTrue: [1 to: n do: [:i | answer at: i put: ((self at: i)
						times: beta
						plus: (stmArray at: i)
						times: alpha)]]
		ifFalse: [1 to: n do: [:i | answer at: i put: (self at: i)
						* beta + ((stmArray at: i)
							* alpha)]].
	^answer
]

{ #category : #'basic ops' }
MathArray >> transpose [
	"Answer the transpose of self."

	self subclassResponsibility
]

{ #category : #accessing }
MathArray >> u [
	^self at: 1
]

{ #category : #accessing }
MathArray >> u: object [ 
	^self at: 1 put: object
]

{ #category : #accessing }
MathArray >> v [
	^self at: 2
]

{ #category : #accessing }
MathArray >> v: object [ 
	^self at: 2 put: object
]

{ #category : #accessing }
MathArray >> w [
	^self at: 3
]

{ #category : #accessing }
MathArray >> x [
	^self at: 1
]

{ #category : #accessing }
MathArray >> x: object [ 
	^self at: 1 put: object
]

{ #category : #accessing }
MathArray >> xy [

	^self copyFrom: 1 to: 2
]

{ #category : #accessing }
MathArray >> y [
	^self at: 2
]

{ #category : #accessing }
MathArray >> y: object [ 
	^self at: 2 put: object
]

{ #category : #accessing }
MathArray >> z [
	^self at: 3
]

{ #category : #accessing }
MathArray >> z: object [ 
	^self at: 3 put: object
]

{ #category : #'basic ops' }
MathArray >> zeroCopy [
	^(self at: 1) isReal
		ifTrue: [self zeroCopyOfVector]
		ifFalse: 
			[| answer |
			answer := self shallowCopy.
			1 to: answer size do: [:i | answer at: i put: (answer at: i) zeroCopy].
			answer]
]

{ #category : #'basic ops' }
MathArray >> zeroCopyOfVector [
	| answer |
	answer := self shallowCopy.
	1 to: answer size do: [:i | answer at: i put: 0.0d].
	^answer
]

{ #category : #'ops on self' }
MathArray >> zeroSelf [
	"Zero all stored numbers in array."

	(self at: 1) isSequenceable
		ifTrue: [1 to: self size do: [:i | (self at: i) zeroSelf]]
		ifFalse: [self zeroSelfOfVector]
]

{ #category : #'ops on self' }
MathArray >> zeroSelfOfVector [
	"Zero all stored numbers in array."

	1 to: self size do: [:i | self at: i put: 0.0d]
]
