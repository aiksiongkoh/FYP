"
Read documentation in the class side methods.

Instance Variables:

"
Class {
	#name : #Help,
	#superclass : #Object,
	#category : #'StCAD-Math-StMathHelp'
}

{ #category : #exampleSymbolicMath }
Help class >> exampleAbs [
	"self halt. self exampleAbs."

	| var func deriv |
	var := IndependentVariable new.
	func := Abs with: var.
	deriv := (func differentiateWRT: var) simplified asFunctionOf: var.
	var value: 1.0d.
	func value = 1.0d ifFalse: [self halt: 'Check this.'].
	deriv value = 1.0d ifFalse: [self halt: 'Check this.'].
	var value: -1.0d.
	func value = 1.0d ifFalse: [self halt: 'Check this.'].
	deriv value = -1.0d ifFalse: [self halt: 'Check this.'].
	(func x: 1.0d) value = 1.0d ifFalse: [self halt: 'Check this.'].
	(deriv x: 1.0d) value = 1.0d ifFalse: [self halt: 'Check this.'].
	(func x: -1.0d) value = 1.0d ifFalse: [self halt: 'Check this.'].
	(deriv x: -1.0d) value = -1.0d ifFalse: [self halt: 'Check this.'].
	func outputOn: 'dummy.txt' interval: (-1.0d to: 1.0d by: 0.1d).
	deriv outputOn: 'dummy2.txt' interval: (-1.0d to: 1.0d by: 0.1d)
]

{ #category : #exampleSymbolicMath }
Help class >> exampleArcTan [
	"self halt. self exampleArcTan."

	| var func deriv |
	var := IndependentVariable new.
	func := ArcTan with: var.
	deriv := (func differentiateWRT: var) simplified asFunctionOf: var.
	var value: 1.0d.
	func value = (Double pi / 4) ifFalse: [self halt: 'Check this.'].
	deriv value = (1.0d / (1.0d + var value squared)) ifFalse: [self halt: 'Check this.'].
	var value: -1.0d.
	func value = (Double pi / 4) negated ifFalse: [self halt: 'Check this.'].
	deriv value = (1.0d / (1.0d + var value squared)) ifFalse: [self halt: 'Check this.'].
	(func x: 1.0d) value = (Double pi / 4) ifFalse: [self halt: 'Check this.'].
	(deriv x: 1.0d) value = (1.0d / (1.0d + var value squared)) ifFalse: [self halt: 'Check this.'].
	(func x: -1.0d) value = (Double pi / 4) negated ifFalse: [self halt: 'Check this.'].
	(deriv x: -1.0d) value = (1.0d / (1.0d + var value squared)) ifFalse: [self halt: 'Check this.'].
	func outputOn: 'dummy.txt' interval: (-10.0d to: 10.0d by: 0.5d).
	deriv outputOn: 'dummy2.txt' interval: (-10.0d to: 10.0d by: 0.5d)
]

{ #category : #exampleDifferenceOperator }
Help class >> exampleBackwardDifferenceScalar [
	"self halt. self exampleBackwardDifferenceScalar."

	| bdf timeNodes series y ypast block |
	bdf := StableBackwardDifference new.
	bdf time: 5.0d.
	bdf order: 4.
	timeNodes := FullRow new: 4.
	timeNodes at: 1 put: 4.0d.
	timeNodes at: 2 put: 3.0d.
	timeNodes at: 3 put: 2.0d.
	timeNodes at: 4 put: 1.0d.
	bdf timeNodes: timeNodes.
	bdf calcOperatorMatrix.
	series := FullRow new: 5.
	series at: 1 put: 1.0d.
	series at: 2 put: 2.0d.
	series at: 3 put: 3.0d.
	series at: 4 put: 4.0d.
	series at: 5 put: 5.0d.
	Transcript cr.
	Transcript cr; show: 'Backward difference'.
	Transcript cr; show: 'vdot = '; show: (bdf valuedotWith: series) printString.
	Transcript cr; show: 'vddot = '; show: (bdf valueddotWith: series) printString.
	Transcript cr; show: 'vdddot = '; show: (bdf valuedddotWith: series) printString.
	Transcript cr; show: 'vddddot = '; show: (bdf valueddddotWith: series) printString.
	y := series at: 1.
	ypast := series copyFrom: 2 to: 5.
	block := [:string :ideriv | Transcript cr; show: string; show: (bdf
					derivative: ideriv
					present: y
					past: ypast) printString].
	block value: 'vdot = ' value: 1.
	block value: 'vddot = ' value: 2.
	block value: 'vdddot = ' value: 3.
	block value: 'vddddot = ' value: 4.
	block := [:string :ideriv | Transcript cr; show: string; show: (bdf
					derivative: ideriv
					at: 4.9d
					present: y
					past: ypast) printString].
	block value: 'vdot = ' value: 1.
	block value: 'vddot = ' value: 2.
	block value: 'vdddot = ' value: 3.
	block value: 'vddddot = ' value: 4
]

{ #category : #exampleDifferenceOperator }
Help class >> exampleBackwardDifferenceVector [
	"self halt. self exampleBackwardDifferenceVector."

	| bdf timeNodes series y ypast block |
	bdf := StableBackwardDifference new.
	bdf time: 5.0d.
	bdf order: 4.
	timeNodes := FullRow new: 4.
	timeNodes at: 1 put: 4.0d.
	timeNodes at: 2 put: 3.0d.
	timeNodes at: 3 put: 2.0d.
	timeNodes at: 4 put: 1.0d.
	bdf timeNodes: timeNodes.
	bdf calcOperatorMatrix.
	series := FullRow new: 5.
	series at: 1 put: (FullColumn with: 1.0d with: 1.0d).
	series at: 2 put: (FullColumn with: 2.0d with: 2.0d).
	series at: 3 put: (FullColumn with: 3.0d with: 3.0d).
	series at: 4 put: (FullColumn with: 4.0d with: 4.0d).
	series at: 5 put: (FullColumn with: 5.0d with: 5.0d).
	Transcript cr.
	Transcript cr; show: 'Backward difference'.
	Transcript cr; show: 'vdot = '; show: (bdf valuedotWith: series) printString.
	Transcript cr; show: 'vddot = '; show: (bdf valueddotWith: series) printString.
	Transcript cr; show: 'vdddot = '; show: (bdf valuedddotWith: series) printString.
	Transcript cr; show: 'vddddot = '; show: (bdf valueddddotWith: series) printString.
	y := series at: 1.
	ypast := series copyFrom: 2 to: 5.
	block := [:string :ideriv | Transcript cr; show: string; show: (bdf
					derivative: ideriv
					present: y
					past: ypast) printString].
	block value: 'vdot = ' value: 1.
	block value: 'vddot = ' value: 2.
	block value: 'vdddot = ' value: 3.
	block value: 'vddddot = ' value: 4.
	block := [:string :ideriv | Transcript cr; show: string; show: (bdf
					derivative: ideriv
					at: 4.9d
					present: y
					past: ypast) printString].
	block value: 'vdot = ' value: 1.
	block value: 'vddot = ' value: 2.
	block value: 'vdddot = ' value: 3.
	block value: 'vddddot = ' value: 4
]

{ #category : #exampleSymbolicMath }
Help class >> exampleCos [
	"self halt. self exampleCos."

	| var func deriv |
	var := IndependentVariable new.
	func := Cos with: var.
	deriv := (func differentiateWRT: var) simplified asFunctionOf: var.
	var value: 1.0d.
	func value = 1.0d cos ifFalse: [self halt: 'Check this.'].
	deriv value = -1.0d sin ifFalse: [self halt: 'Check this.'].
	var value: -1.0d.
	func value = -1.0d cos ifFalse: [self halt: 'Check this.'].
	deriv value = 1.0d sin ifFalse: [self halt: 'Check this.'].
	(func x: 1.0d) value = 1.0d cos ifFalse: [self halt: 'Check this.'].
	(deriv x: 1.0d) value = -1.0d sin ifFalse: [self halt: 'Check this.'].
	(func x: -1.0d) value = -1.0d cos ifFalse: [self halt: 'Check this.'].
	(deriv x: -1.0d) value = 1.0d sin ifFalse: [self halt: 'Check this.'].
	func outputOn: 'dummy.txt' interval: (-10.0d to: 10.0d by: 0.5d).
	deriv outputOn: 'dummy2.txt' interval: (-10.0d to: 10.0d by: 0.5d)
]

{ #category : #exampleSymbolicMath }
Help class >> exampleExp [
	"self halt. self exampleExp."

	| var func deriv |
	var := IndependentVariable new.
	func := Exp with: var.
	deriv := (func differentiateWRT: var) simplified asFunctionOf: var.
	var value: 1.0d.
	func value = 1.0d exp ifFalse: [self halt: 'Check this.'].
	deriv value = 1.0d exp ifFalse: [self halt: 'Check this.'].
	var value: -1.0d.
	func value = -1.0d exp ifFalse: [self halt: 'Check this.'].
	deriv value = -1.0d exp ifFalse: [self halt: 'Check this.'].
	(func x: 1.0d) value = 1.0d exp ifFalse: [self halt: 'Check this.'].
	(deriv x: 1.0d) value = 1.0d exp ifFalse: [self halt: 'Check this.'].
	(func x: -1.0d) value = -1.0d exp ifFalse: [self halt: 'Check this.'].
	(deriv x: -1.0d) value = -1.0d exp ifFalse: [self halt: 'Check this.'].
	func outputOn: 'dummy.txt' interval: (-1.0d to: 1.0d by: 0.1d).
	deriv outputOn: 'dummy2.txt' interval: (-1.0d to: 1.0d by: 0.1d)
]

{ #category : #exampleDifferenceOperator }
Help class >> exampleExtrapolatorScalar [
	"self halt. self exampleExtrapolatorScalar."

	| extrapol timeNodes series |
	extrapol := Extrapolator new.
	extrapol time: 5.0d.
	extrapol order: 3.
	timeNodes := FullRow new: 4.
	timeNodes at: 1 put: 4.0d.
	timeNodes at: 2 put: 3.0d.
	timeNodes at: 3 put: 2.0d.
	timeNodes at: 4 put: 1.0d.
	extrapol timeNodes: timeNodes.
	extrapol calcOperatorMatrix.
	series := FullRow new: 4.
	series at: 1 put: 1.0d.
	series at: 2 put: 2.0d.
	series at: 3 put: 3.0d.
	series at: 4 put: 4.0d.
	Transcript cr.
	Transcript cr; show: 'Extrapolator'.
	Transcript cr; show: 'v = '; show: (extrapol valueWith: series) printString.
	Transcript cr; show: 'vdot = '; show: (extrapol valuedotWith: series) printString.
	Transcript cr; show: 'vddot = '; show: (extrapol valueddotWith: series) printString.
	Transcript cr; show: 'vdddot = '; show: (extrapol valuedddotWith: series) printString
]

{ #category : #exampleDifferenceOperator }
Help class >> exampleExtrapolatorVector [
	"self halt. self exampleExtrapolatorVector."

	| extrapol timeNodes series |
	extrapol := Extrapolator new.
	extrapol time: 5.0d.
	extrapol order: 3.
	timeNodes := FullRow new: 4.
	timeNodes at: 1 put: 4.0d.
	timeNodes at: 2 put: 3.0d.
	timeNodes at: 3 put: 2.0d.
	timeNodes at: 4 put: 1.0d.
	extrapol timeNodes: timeNodes.
	extrapol calcOperatorMatrix.
	series := FullRow new: 4.
	series at: 1 put: (FullColumn with: 1.0d with: 1.0d).
	series at: 2 put: (FullColumn with: 2.0d with: 2.0d).
	series at: 3 put: (FullColumn with: 3.0d with: 3.0d).
	series at: 4 put: (FullColumn with: 4.0d with: 4.0d).
	Transcript cr.
	Transcript cr; show: 'Extrapolator'.
	Transcript cr; show: 'v = '; show: (extrapol valueWith: series) printString.
	Transcript cr; show: 'vdot = '; show: (extrapol valuedotWith: series) printString.
	Transcript cr; show: 'vddot = '; show: (extrapol valueddotWith: series) printString.
	Transcript cr; show: 'vdddot = '; show: (extrapol valuedddotWith: series) printString
]

{ #category : #exampleFullColumn }
Help class >> exampleFullColumn1 [
	"self halt. self exampleFullColumn1."

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

{ #category : #exampleFullColumn }
Help class >> exampleFullColumn2 [
	"self halt. self exampleFullColumn2."

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

{ #category : #exampleFullColumn }
Help class >> exampleFullColumn3 [
	"self halt. self exampleFullColumn3."

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
	vector2 equalSelfTimes: 1.0d plusFullColumn: vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 equalSelfTimes: 1.0d plusFullColumn: vector times: 1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 equalSelfTimes: 2.0d plusFullColumn: vector times: -1.0d.
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
	vector2 equalSelfTimes: 1.0d minusFullColumn: vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 equalSelfTimes: 1.0d minusFullColumn: vector times: -1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 equalSelfTimes: 2.0d minusFullColumn: vector times: 1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.']
]

{ #category : #exampleFullColumn }
Help class >> exampleFullColumn4 [
	"self halt. self exampleFullColumn4."

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

{ #category : #exampleFullColumn }
Help class >> exampleFullColumn4a [
	"self halt. self exampleFullColumn4a."

	| vector vector2 |
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d 4.0d).
	vector2 := vector * 1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 := vector * 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 := vector2 + vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 := vector2 + (vector * 0.0d).
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 := vector2 + (vector * 1.0d).
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 := vector2 * 0.0d + vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 := vector2 * 1.0d + (vector * -1.0d).
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 := vector2 - vector.
	vector2 = vector negated ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 := vector2 - (vector * 0.0d).
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 := vector2 - (vector * -1.0d).
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 := vector2 * 2.0d - vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 := vector2 * 1.0d - (vector * 1.0d).
	vector2 isZero ifFalse: [self error: 'Check this.']
]

{ #category : #exampleFullColumn }
Help class >> exampleFullColumn5 [
	"self halt. self exampleFullColumn5."

	| vector vector2 answer1 answer2 |
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d).
	vector2 := FullColumn newWithElements: #(1.0d 2.0d 3.0d 4.0d).
	answer1 := vector2 timesFullColumn: vector.
	answer1 := vector2 timesFullRow: vector transpose.
	answer2 := vector2 timesTransposeFullColumn: vector.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	answer1 := vector2 transpose timesFullColumn: vector2.
	answer2 := vector2 transposeTimesFullColumn: vector2.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	answer1 := vector2 transpose timesFullRow: vector transpose
]

{ #category : #exampleFullColumn }
Help class >> exampleFullColumn6 [
	"self halt. self exampleFullColumn6."

	| vector matrix answer1 answer2 |
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d).
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d)).
	answer1 := vector timesFullMatrix: matrix.
	answer2 := (matrix transpose timesFullRow: vector transpose) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	answer2 := (matrix transpose timesTransposeFullColumn: vector) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	answer1 := vector transpose timesFullMatrix: matrix transpose.
	answer2 := (matrix timesFullColumn: vector) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	answer2 := vector transpose timesTransposeFullMatrix: matrix.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	matrix := FullMatrix newWithElements: #(#(11.0d) #(21.0d) #(31.0d) #(41.0d)).
	answer1 := vector timesFullMatrix: matrix transpose.
	answer2 := vector timesTransposeFullMatrix: matrix.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d) #(41.0d 42.0d 43.0d)).
	answer1 := vector transpose timesFullMatrix: matrix.
	answer2 := vector transposeTimesFullMatrix: matrix.
	answer1 = answer2 ifFalse: [self halt: 'Check this.']
]

{ #category : #exampleFullMatrix }
Help class >> exampleFullMatrix1 [
	"self halt. self exampleFullMatrix1."

	| m n matrix |
	m := 5.
	n := 8.
	matrix := FullMatrix new: m by: n.
	matrix size = m ifFalse: [self error: 'Check this.'].
	matrix nrow = m ifFalse: [self error: 'Check this.'].
	matrix ncol = n ifFalse: [self error: 'Check this.'].
	matrix numberOfElements = (m * n) ifFalse: [self error: 'Check this.'].
	1 to: m do: [:i | 1 to: n do: [:j | matrix at: i and: j put: (i * 10 + j) asDouble]].
	matrix maxElement = (m * 10 + n) asDouble ifFalse: [self error: 'Check this.'].
	matrix minAndMaxValues = (Array with: 11 with: m * 10 + n) ifFalse: [self error: 'Check this.'].
	matrix sumOfElements = (matrix inject: 0.0d into: [:sum :row | sum + row sumOfElements]) ifFalse: [self error: 'Check this.'].
	matrix sumOfSquares = (matrix inject: 0.0d into: [:ssq :row | ssq + row sumOfSquares]) ifFalse: [self error: 'Check this.'].
	matrix sumOfSquares = (matrix sumOfElementsRaisedTo: 2) ifFalse: [self error: 'Check this.'].
	matrix rootMeanSquare = (matrix sumOfSquares / (m * n)) sqrt ifFalse: [self error: 'Check this.'].
	matrix length = matrix sumOfSquares sqrt ifFalse: [self error: 'Check this.'].
	matrix rowSumNorm = (matrix at: m) sumOfAbsElements ifFalse: [self error: 'Check this.']
]

{ #category : #exampleFullMatrix }
Help class >> exampleFullMatrix2 [
	"self halt. self exampleFullMatrix2."

	| m n matrix matrix2 |
	m := 4.
	n := 4.
	matrix := FullMatrix new: m by: n.
	1 to: m do: [:i | 1 to: n do: [:j | matrix at: i and: j put: (i * 10 + j) asDouble]].
	matrix2 := matrix copy.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf isZero ifFalse: [self error: 'Check this.'].
	matrix2 := matrix copy.
	(matrix2 magnifySelf: 0.0d) isZero ifFalse: [self error: 'Check this.'].
	matrix2 at: 1 and: 1 putFullMatrix: matrix.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 equalFullMatrix: matrix.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 equalFullMatrix: matrix at: 1 and: 1.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 at: 1 and: 1 plusFullMatrix: matrix.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 equalSelfPlusFullMatrix: matrix.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 equalSelfPlusFullMatrix: matrix at: 1 and: 1.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 at: 1 and: 1 minusFullMatrix: matrix.
	matrix2 = matrix negated ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 equalSelfMinusFullMatrix: matrix.
	matrix2 = matrix negated ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 equalSelfMinusFullMatrix: matrix at: 1 and: 1.
	matrix2 = matrix negated ifFalse: [self error: 'Check this.']
]

{ #category : #exampleFullMatrix }
Help class >> exampleFullMatrix2a [
	"self halt. self exampleFullMatrix2a."

	| m n matrix matrix2 |
	m := 4.
	n := 4.
	matrix := FullMatrix new: m by: n.
	1 to: m do: [:i | 1 to: n do: [:j | matrix at: i and: j put: (i * 10 + j) asDouble]].
	matrix2 := matrix copy.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf isZero ifFalse: [self error: 'Check this.'].
	matrix2 := matrix copy.
	(matrix2 magnifySelf: 0.0d) isZero ifFalse: [self error: 'Check this.'].
	matrix2 at: 1 and: 1 putFullMatrix: matrix.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 equal: matrix.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 equalFullMatrix: matrix at: 1 and: 1.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 at: 1 and: 1 plusFullMatrix: matrix.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 equalSelfPlus: matrix.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 equalSelfPlusFullMatrix: matrix at: 1 and: 1.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 at: 1 and: 1 minusFullMatrix: matrix.
	matrix2 = matrix negated ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 equalSelfMinus: matrix.
	matrix2 = matrix negated ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 equalSelfMinusFullMatrix: matrix at: 1 and: 1.
	matrix2 = matrix negated ifFalse: [self error: 'Check this.']
]

{ #category : #exampleFullMatrix }
Help class >> exampleFullMatrix3 [
	"self halt. self exampleFullMatrix3."

	| m n matrix matrix2 |
	m := 4.
	n := 4.
	matrix := FullMatrix new: m by: n.
	1 to: m do: [:i | 1 to: n do: [:j | matrix at: i and: j put: (i * 10 + j) asDouble]].
	matrix2 := matrix copy.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 at: 1 and: 1 putFullMatrix: matrix times: 0.0d.
	matrix2 isZero ifFalse: [self error: 'Check this.'].
	matrix2 at: 1 and: 1 putFullMatrix: matrix times: 1.0d.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 equalFullMatrix: matrix times: 0.0d.
	matrix2 isZero ifFalse: [self error: 'Check this.'].
	matrix2 equalFullMatrix: matrix times: 1.0d.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 at: 1 and: 1 plusFullMatrix: matrix times: 0.0d.
	matrix2 isZero ifFalse: [self error: 'Check this.'].
	matrix2 at: 1 and: 1 plusFullMatrix: matrix times: 1.0d.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 equalSelfPlusFullMatrix: matrix times: 0.0d.
	matrix2 isZero ifFalse: [self error: 'Check this.'].
	matrix2 equalSelfPlusFullMatrix: matrix times: 1.0d.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 equalSelfTimes: 1.0d plusFullMatrix: matrix times: 0.0d.
	matrix2 isZero ifFalse: [self error: 'Check this.'].
	matrix2 equalSelfTimes: 1.0d plusFullMatrix: matrix times: 1.0d.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 equalSelfTimes: 2.0d plusFullMatrix: matrix times: -1.0d.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 at: 1 and: 1 minusFullMatrix: matrix times: 0.0d.
	matrix2 isZero ifFalse: [self error: 'Check this.'].
	matrix2 at: 1 and: 1 minusFullMatrix: matrix times: -1.0d.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 equalSelfMinusFullMatrix: matrix times: 0.0d.
	matrix2 isZero ifFalse: [self error: 'Check this.'].
	matrix2 equalSelfMinusFullMatrix: matrix times: -1.0d.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 equalSelfTimes: 1.0d minusFullMatrix: matrix times: 0.0d.
	matrix2 isZero ifFalse: [self error: 'Check this.'].
	matrix2 equalSelfTimes: 1.0d minusFullMatrix: matrix times: -1.0d.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 equalSelfTimes: 2.0d minusFullMatrix: matrix times: 1.0d.
	matrix2 = matrix ifFalse: [self error: 'Check this.']
]

{ #category : #exampleFullMatrix }
Help class >> exampleFullMatrix3a [
	"self halt. self exampleFullMatrix3a."

	| m n matrix matrix2 |
	m := 4.
	n := 4.
	matrix := FullMatrix new: m by: n.
	1 to: m do: [:i | 1 to: n do: [:j | matrix at: i and: j put: (i * 10 + j) asDouble]].
	matrix2 := matrix copy.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 := matrix plusFullMatrix: matrix.
	matrix2 = (matrix times: 2.0d) ifFalse: [self error: 'Check this.'].
	matrix2 := matrix plusFullMatrix: matrix times: 1.0d.
	matrix2 = (matrix times: 2.0d) ifFalse: [self error: 'Check this.'].
	matrix2 := matrix times: 1.0d plusFullMatrix: matrix.
	matrix2 = (matrix times: 2.0d) ifFalse: [self error: 'Check this.'].
	matrix2 := matrix times: 1.0d plusFullMatrix: matrix times: 1.0d.
	matrix2 = (matrix times: 2.0d) ifFalse: [self error: 'Check this.'].
	matrix2 := matrix minusFullMatrix: matrix.
	matrix2 = (matrix times: 0.0d) ifFalse: [self error: 'Check this.'].
	matrix2 := matrix minusFullMatrix: matrix times: 1.0d.
	matrix2 = (matrix times: 0.0d) ifFalse: [self error: 'Check this.'].
	matrix2 := matrix times: 1.0d minusFullMatrix: matrix.
	matrix2 = (matrix times: 0.0d) ifFalse: [self error: 'Check this.'].
	matrix2 := matrix times: 1.0d minusFullMatrix: matrix times: 1.0d.
	matrix2 = (matrix times: 0.0d) ifFalse: [self error: 'Check this.']
]

{ #category : #exampleFullMatrix }
Help class >> exampleFullMatrix3b [
	"self halt. self exampleFullMatrix3b."

	| m n matrix matrix2 |
	m := 4.
	n := 4.
	matrix := FullMatrix new: m by: n.
	1 to: m do: [:i | 1 to: n do: [:j | matrix
				at: i
				and: j
				put: (i * 10 + j) asDouble]].
	matrix2 := matrix copy.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 := matrix + matrix.
	matrix2 = (matrix * 2.0d) ifFalse: [self error: 'Check this.'].
	matrix2 := matrix + (matrix * 1.0d).
	matrix2 = (matrix * 2.0d) ifFalse: [self error: 'Check this.'].
	matrix2 := matrix * 1.0d + matrix.
	matrix2 = (matrix * 2.0d) ifFalse: [self error: 'Check this.'].
	matrix2 := matrix * 1.0d + (matrix * 1.0d).
	matrix2 = (matrix * 2.0d) ifFalse: [self error: 'Check this.'].
	matrix2 := matrix - matrix.
	matrix2 = (matrix * 0.0d) ifFalse: [self error: 'Check this.'].
	matrix2 := matrix - (matrix * 1.0d).
	matrix2 = (matrix * 0.0d) ifFalse: [self error: 'Check this.'].
	matrix2 := matrix * 1.0d - matrix.
	matrix2 = (matrix * 0.0d) ifFalse: [self error: 'Check this.'].
	matrix2 := matrix * 1.0d - (matrix * 1.0d).
	matrix2 = (matrix * 0.0d) ifFalse: [self error: 'Check this.']
]

{ #category : #exampleFullMatrix }
Help class >> exampleFullMatrix4 [
	"self halt. self exampleFullMatrix4."

	| vector matrix answer1 answer2 |
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d).
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d) #(41.0d 42.0d 43.0d)).
	answer1 := matrix timesFullColumn: vector.
	answer2 := (vector transpose timesFullMatrix: matrix transpose) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	answer2 := (vector transpose timesTransposeFullMatrix: matrix) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d).
	matrix := FullMatrix newWithElements: #(#(11.0d) #(21.0d) #(31.0d) #(41.0d)).
	answer1 := matrix timesFullRow: vector transpose.
	answer2 := (vector timesFullMatrix: matrix transpose) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	answer2 := (vector timesTransposeFullMatrix: matrix) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d 4.0d).
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d) #(41.0d 42.0d 43.0d)).
	answer1 := matrix transpose timesFullColumn: vector.
	answer2 := (vector transpose timesFullMatrix: matrix) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	answer2 := (vector transposeTimesFullMatrix: matrix) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d).
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d)).
	answer1 := matrix transpose timesFullRow: vector transpose.
	answer2 := (vector timesFullMatrix: matrix) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.']
]

{ #category : #exampleFullMatrix }
Help class >> exampleFullMatrix5 [
	"self halt. self exampleFullMatrix5."

	| matrix matrix2 answer1 answer2 |
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d) #(41.0d 42.0d 43.0d)).
	matrix2 := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d)).
	answer1 := matrix timesFullMatrix: matrix2.
	answer2 := (matrix2 transpose timesFullMatrix: matrix transpose) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	answer2 := (matrix2 transpose timesTransposeFullMatrix: matrix) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	matrix2 := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d) #(41.0d 42.0d 43.0d)).
	answer1 := matrix timesFullMatrix: matrix2 transpose.
	answer2 := (matrix2 timesFullMatrix: matrix transpose) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	answer2 := matrix timesTransposeFullMatrix: matrix2.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	answer1 := matrix transpose timesFullMatrix: matrix2.
	answer2 := (matrix2 transpose timesFullMatrix: matrix) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	answer2 := matrix transposeTimesFullMatrix: matrix2.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	matrix := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d)).
	answer1 := matrix transpose timesFullMatrix: matrix2 transpose.
	answer2 := (matrix2 timesFullMatrix: matrix) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	answer2 := matrix transposeTimesFullMatrix: matrix2 transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.']
]

{ #category : #exampleFullMatrix }
Help class >> exampleFullMatrix6 [
	"self halt. self exampleFullMatrix6."

	| vector matrix |
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d 4.0d).
	matrix := FullMatrix new: 5 by: 5.
	matrix at: 1 and: 1 putFullColumn: vector.
	matrix at: 1 and: 2 putFullColumn: vector.
	(matrix fullColumn: 1) = (matrix fullColumn: 2) ifFalse: [self halt: 'Check this.'].
	matrix at: 1 and: 1 putFullRow: vector transpose.
	matrix at: 2 and: 1 putFullRow: vector transpose.
	(matrix row: 1) = (matrix row: 2) ifFalse: [self halt: 'Check this.'].
	matrix zeroSelf.
	matrix at: 1 and: 1 plusFullColumn: vector.
	matrix at: 1 and: 2 plusFullColumn: vector.
	(matrix fullColumn: 1) = (matrix fullColumn: 2) ifFalse: [self halt: 'Check this.'].
	matrix zeroSelf.
	matrix at: 1 and: 1 plusFullRow: vector transpose.
	matrix at: 2 and: 1 plusFullRow: vector transpose.
	(matrix row: 1) = (matrix row: 2) ifFalse: [self halt: 'Check this.'].
	matrix zeroSelf.
	matrix at: 1 and: 1 minusFullColumn: vector.
	matrix at: 1 and: 2 minusFullColumn: vector.
	(matrix fullColumn: 1) = (matrix fullColumn: 2) ifFalse: [self halt: 'Check this.'].
	matrix zeroSelf.
	matrix at: 1 and: 1 minusFullRow: vector transpose.
	matrix at: 2 and: 1 minusFullRow: vector transpose.
	(matrix row: 1) = (matrix row: 2) ifFalse: [self halt: 'Check this.']
]

{ #category : #exampleFullRow }
Help class >> exampleFullRow1 [
	"self halt. self exampleFullRow1."

	| n vector |
	n := 10.
	vector := FullRow new: n.
	vector size = n ifFalse: [self error: 'Check this.'].
	vector nrow = 1 ifFalse: [self error: 'Check this.'].
	vector ncol = n ifFalse: [self error: 'Check this.'].
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

{ #category : #exampleFullRow }
Help class >> exampleFullRow2 [
	"self halt. self exampleFullRow2."

	| vector vector2 vector3 |
	vector := FullRow newWithElements: #(1.0d 2.0d 3.0d 4.0d).
	vector2 := FullRow new: 4.
	vector2 at: 1 put: 1.0d.
	vector2 at: 2 put: 2.0d.
	vector2 at: 3 put: 3.0d.
	vector2 at: 4 put: 4.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector3 := vector copy.
	vector2 = vector3 ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf isZero ifFalse: [self error: 'Check this.'].
	(vector3 magnifySelf: 0.0d) isZero ifFalse: [self error: 'Check this.'].
	vector2 at: 1 putFullRow: vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalFullRow: vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalFullRow: vector at: 1.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 at: 1 plusFullRow: vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfPlusFullRow: vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfPlusFullRow: vector at: 1.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 at: 1 minusFullRow: vector.
	vector2 = vector negated ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfMinusFullRow: vector.
	vector2 = vector negated ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfMinusFullRow: vector at: 1.
	vector2 = vector negated ifFalse: [self error: 'Check this.']
]

{ #category : #exampleFullRow }
Help class >> exampleFullRow3 [
	"self halt. self exampleFullRow3."

	| vector vector2 vector3 |
	vector := FullRow newWithElements: #(1.0d 2.0d 3.0d 4.0d).
	vector2 := FullRow new: 4.
	vector2 at: 1 put: 1.0d.
	vector2 at: 2 put: 2.0d.
	vector2 at: 3 put: 3.0d.
	vector2 at: 4 put: 4.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector3 := vector copy.
	vector2 = vector3 ifFalse: [self error: 'Check this.'].
	vector2 at: 1 putFullRow: vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 at: 1 putFullRow: vector times: 1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalFullRow: vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 equalFullRow: vector times: 1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 at: 1 plusFullRow: vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 at: 1 plusFullRow: vector times: 1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfPlusFullRow: vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 equalSelfPlusFullRow: vector times: 1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfTimes: 1.0d plusFullRow: vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 equalSelfTimes: 1.0d plusFullRow: vector times: 1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 equalSelfTimes: 2.0d plusFullRow: vector times: -1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 at: 1 minusFullRow: vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 at: 1 minusFullRow: vector times: -1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfMinusFullRow: vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 equalSelfMinusFullRow: vector times: -1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfTimes: 1.0d minusFullRow: vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 equalSelfTimes: 1.0d minusFullRow: vector times: -1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 equalSelfTimes: 2.0d minusFullRow: vector times: 1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.']
]

{ #category : #exampleFullRow }
Help class >> exampleFullRow4 [
	"self halt. self exampleFullRow4."

	| vector vector2 |
	vector := FullRow newWithElements: #(1.0d 2.0d 3.0d 4.0d).
	vector2 := vector times: 1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 := vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 := vector2 plusFullRow: vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 := vector2 plusFullRow: vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 := vector2 plusFullRow: vector times: 1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 := vector2 times: 0.0d plusFullRow: vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 := vector2 times: 1.0d plusFullRow: vector times: -1.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 := vector2 minusFullRow: vector.
	vector2 = vector negated ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 := vector2 minusFullRow: vector times: 0.0d.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 := vector2 minusFullRow: vector times: -1.0d.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 := vector2 times: 2.0d minusFullRow: vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 := vector2 times: 1.0d minusFullRow: vector times: 1.0d.
	vector2 isZero ifFalse: [self error: 'Check this.']
]

{ #category : #exampleSymbolicMath }
Help class >> exampleGeneralSpline [
	"self halt. self exampleGeneralSpline."

	| var func deriv |
	var := IndependentVariable new.
	func := GeneralSpline
				with: var
				order: 3
				xs: #(1.0d 2.0d 3.0d 4.0d 5.0d 5.5d)
				ys: #(1.0d -1.0d -2.0d 1.0d 1.0d 1.5d).
	deriv := (func differentiateWRT: var) simplified asFunctionOf: var.
	var value: 1.0d.
	func value = 1.0d ifFalse: [self halt: 'Check this.'].
	deriv value.
	var value: 3.0d.
	func value = -2.0d ifFalse: [self halt: 'Check this.'].
	deriv value.
	(func x: 1.0d) value = 1.0d ifFalse: [self halt: 'Check this.'].
	(deriv x: 1.0d) value.
	(func x: 3.0d) value = -2.0d ifFalse: [self halt: 'Check this.'].
	(deriv x: 3.0d) value.
	func outputOn: 'dummy.txt' interval: (0.0d to: 6.0d by: 0.1d).
	deriv outputOn: 'dummy2.txt' interval: (0.0d to: 6.0d by: 0.1d)
]

{ #category : #exampleSymbolicMath }
Help class >> exampleGeneralSpline2 [
	"self halt. self exampleGeneralSpline2."

	| var func deriv |
	var := IndependentVariable new.
	func := GeneralSpline
				with: var
				order: 3
				xs: (MathArray newWithElements: #(1.0d 2.0d 3.0d 4.0d 5.0d 5.5d))
				ys: (MathArray newWithElements: #(#(1.0d -1.0d) #(2.0d -2.0d) #(2.5d -2.5d) #(3.0d -3.0d) #(2.0d -2.0d) #(1.0d -1.0d))).
	deriv := (func differentiateWRT: var) simplified asFunctionOf: var.
	var value: 1.0d.
	func value = (MathArray newWithElements: #(1.0d -1.0d)) ifFalse: [self halt: 'Check this.'].
	deriv value.
	var value: 3.0d.
	func value = (MathArray newWithElements: #(2.5d -2.5d)) ifFalse: [self halt: 'Check this.'].
	deriv value.
	(func x: 1.0d) value = (MathArray newWithElements: #(1.0d -1.0d)) ifFalse: [self halt: 'Check this.'].
	(deriv x: 1.0d) value.
	(func x: 3.0d) value = (MathArray newWithElements: #(2.5d -2.5d)) ifFalse: [self halt: 'Check this.'].
	(deriv x: 3.0d) value.
	func outputOn: 'dummy.txt' interval: (0.0d to: 6.0d by: 0.1d).
	deriv outputOn: 'dummy2.txt' interval: (0.0d to: 6.0d by: 0.1d)
]

{ #category : #exampleIntegrator }
Help class >> exampleIntegratorIndexThree [
	"DAE for a simple pendulum."
	"Ref: Numerical Solution Initial-Value Problems in Differential-Algebraic Equations by K.E. Brenan et 
	al. pp. 154, 1996."
	"x points right. y points up. gravity=1 is down. length=1. phi=0 when pendulum is straight down."
	"Pendulum is initially pointing right with initial velocity of 1 rad/s upwards."
	"self halt. self exampleIntegratorIndexThree."

	| solver t y1 y2 y3 y4 y5 ydot1 ydot2 ydot3 ydot4 ydot5 gravity length eqn1 eqn2 eqn3 eqn4 eqn5 filenameString |
	self raiseTranscript.
	Transcript cr; show: 'Index three DAE for a simple pendulum.'.
	solver := DifferentialAlgebraicEquationSolver new: 5.
	t := IndependentVariable name: #t.
	y1 := DependentVariable name: #x.
	y2 := DependentVariable name: #y.
	y3 := DependentVariable name: #xdot.
	y4 := DependentVariable name: #ydot.
	y5 := DependentVariable name: #lam.
	y1 x: t.
	y2 x: t.
	y3 x: t.
	y4 x: t.
	y5 x: t.
	ydot1 := (y1 differentiateWRT: t) simplified.
	ydot2 := (y2 differentiateWRT: t) simplified.
	ydot3 := (y3 differentiateWRT: t) simplified.
	ydot4 := (y4 differentiateWRT: t) simplified.
	ydot5 := (y5 differentiateWRT: t) simplified.
	gravity := Parameter name: #gravity.
	length := Parameter name: #length.
	gravity value: 1.0d.
	length value: 1.0d.
	t value: 0.0d.
	y1 value: 1.0d.
	y2 value: 0.0d.
	y3 value: 0.0d.
	y4 value: 1.0d.
	y5 value: 1.0d.
	ydot1 value: 0.0d.
	ydot2 value: 1.0d.
	ydot3 value: -1.0d.
	ydot4 value: -1.0d.
	ydot5 value: 0.0d.
	eqn1 := ydot1 - y3.
	eqn2 := ydot2 - y4.
	eqn3 := ydot3 + (y1 * y5).
	eqn4 := ydot4 + (y2 * y5) + gravity.
	eqn5 := (y1 raisedTo: 2)
				+ (y2 raisedTo: 2) - (length raisedTo: 2).
	solver t: t.
	solver yAt: 1 put: y1.
	solver yAt: 2 put: y2.
	solver yAt: 3 put: y3.
	solver yAt: 4 put: y4.
	solver yAt: 5 put: y5.
	solver ydotAt: 1 put: ydot1.
	solver ydotAt: 2 put: ydot2.
	solver ydotAt: 3 put: ydot3.
	solver ydotAt: 4 put: ydot4.
	solver ydotAt: 5 put: ydot5.
	solver aFAt: 1 put: eqn1.
	solver aFAt: 2 put: eqn2.
	solver aFAt: 3 put: eqn3.
	solver aFAt: 4 put: eqn4.
	solver aFAt: 5 put: eqn5.
	solver tstart: 0.0d.
	solver tend: 1.0d.
	solver hout: 0.01d.
	solver hmin: 1.0d-12.
	solver hmax: 1.0d.
	solver orderMax: 5.
	solver iterMax: 4.
	solver relativeTol: 1.0d-6.
	solver absoluteTol: 1.0d-6.
	solver run.
	filenameString := 'dummy2.txt'.
	Transcript cr; show: 'Tabulated data is in ' , filenameString.
	solver outputOnFile: filenameString
]

{ #category : #exampleIntegrator }
Help class >> exampleIntegratorIndexTwo [
	"DAE for a simple pendulum."
	"Ref: Numerical Solution Initial-Value Problems in Differential-Algebraic Equations by K.E. Brenan et 
	al. pp. 154, 1996."
	"x points right. y points up. gravity=1 is down. length=1. phi=0 when pendulum is straight down."
	"Pendulum is initially pointing right with initial velocity of 1 rad/s upwards."
	"let mudot = lam. This is an index two problem."
	"self halt. self exampleIntegratorIndexTwo."

	| solver t y1 y2 y3 y4 y5 ydot1 ydot2 ydot3 ydot4 ydot5 gravity length eqn1 eqn2 eqn3 eqn4 eqn5 filenameString |
	self raiseTranscript.
	Transcript cr; show: 'Index two DAE for a simple pendulum.'.
	solver := DifferentialAlgebraicEquationSolver new: 5.
	t := IndependentVariable name: #t.
	y1 := DependentVariable name: #x.
	y2 := DependentVariable name: #y.
	y3 := DependentVariable name: #xdot.
	y4 := DependentVariable name: #ydot.
	y5 := DependentVariable name: #mu.
	y1 x: t.
	y2 x: t.
	y3 x: t.
	y4 x: t.
	y5 x: t.
	ydot1 := (y1 differentiateWRT: t) simplified.
	ydot2 := (y2 differentiateWRT: t) simplified.
	ydot3 := (y3 differentiateWRT: t) simplified.
	ydot4 := (y4 differentiateWRT: t) simplified.
	ydot5 := (y5 differentiateWRT: t) simplified.
	gravity := Parameter name: #gravity.
	length := Parameter name: #length.
	gravity value: 1.0d.
	length value: 1.0d.
	t value: 0.0d.
	y1 value: 1.0d.
	y2 value: 0.0d.
	y3 value: 0.0d.
	y4 value: 1.0d.
	y5 value: 0.0d.
	ydot1 value: 0.0d.
	ydot2 value: 1.0d.
	ydot3 value: -1.0d.
	ydot4 value: -1.0d.
	ydot5 value: 1.0d.
	eqn1 := ydot1 - y3.
	eqn2 := ydot2 - y4.
	eqn3 := ydot3 + (y1 * ydot5).
	eqn4 := ydot4 + (y2 * ydot5) + gravity.
	eqn5 := (y1 raisedTo: 2)
				+ (y2 raisedTo: 2) - (length raisedTo: 2).
	solver t: t.
	solver yAt: 1 put: y1.
	solver yAt: 2 put: y2.
	solver yAt: 3 put: y3.
	solver yAt: 4 put: y4.
	solver yAt: 5 put: y5.
	solver ydotAt: 1 put: ydot1.
	solver ydotAt: 2 put: ydot2.
	solver ydotAt: 3 put: ydot3.
	solver ydotAt: 4 put: ydot4.
	solver ydotAt: 5 put: ydot5.
	solver aFAt: 1 put: eqn1.
	solver aFAt: 2 put: eqn2.
	solver aFAt: 3 put: eqn3.
	solver aFAt: 4 put: eqn4.
	solver aFAt: 5 put: eqn5.
	solver tstart: 0.0d.
	solver tend: 1.0d.
	solver hout: 0.01d.
	solver hmin: 1.0d-12.
	solver hmax: 1.0d.
	solver orderMax: 5.
	solver iterMax: 4.
	solver relativeTol: 1.0d-4.
	solver absoluteTol: 1.0d-4.
	solver run.
	filenameString := 'dummy.txt'.
	Transcript cr; show: 'Tabulated data is in ' , filenameString.
	solver outputOnFile: filenameString
]

{ #category : #exampleIntegrator }
Help class >> exampleIntegratorODE [
	"ODE for a simple pendulum."
	"Ref: Numerical Solution Initial-Value Problems in Differential-Algebraic Equations by K.E. Brenan et 
	al. pp. 151, 1996."
	"x points right. y points up. gravity=1 is down. length=1. phi=0 when pendulum is straight down."
	"Pendulum is initially pointing right with initial velocity of 1 rad/s upwards."
	"self halt. self exampleIntegratorODE."

	| solver t y1 y2 ydot1 ydot2 gravity length eqn1 eqn2 filenameString |
	self raiseTranscript.
	Transcript cr; show: 'ODE for a simple pendulum.'.
	solver := DifferentialAlgebraicEquationSolver new: 2.
	t := IndependentVariable name: #t.
	y1 := DependentVariable name: #phi.
	y2 := DependentVariable name: #phidot.
	y1 x: t.
	y2 x: t.
	ydot1 := (y1 differentiateWRT: t) simplified.
	ydot2 := (y2 differentiateWRT: t) simplified.
	gravity := Parameter name: #gravity.
	length := Parameter name: #length.
	gravity value: 1.0d.
	length value: 1.0d.
	t value: 0.0d.
	y1 value: Double pi / 2.0d.
	y2 value: 1.0d.
	ydot1 value: 1.0d.
	ydot2 value: -1.0d.
	eqn1 := ydot1 - y2.
	eqn2 := ydot2 + (gravity / length * y1 sin).
	solver t: t.
	solver yAt: 1 put: y1.
	solver yAt: 2 put: y2.
	solver ydotAt: 1 put: ydot1.
	solver ydotAt: 2 put: ydot2.
	solver aFAt: 1 put: eqn1.
	solver aFAt: 2 put: eqn2.
	solver tstart: 0.0d.
	solver tend: 1.0d.
	solver hout: 0.01d.
	solver hmin: 1.0d-12.
	solver hmax: 1.0d.
	solver orderMax: 5.
	solver iterMax: 4.
	solver relativeTol: 1.0d-4.
	solver absoluteTol: 1.0d-4.
	solver run.
	filenameString := 'dummy.txt'.
	Transcript cr; show: 'Tabulated data is in ' , filenameString.
	solver outputOnFile: filenameString
]

{ #category : #exampleIntegrator }
Help class >> exampleIntegratorODE1 [
	"ODE for a simple pendulum."
	"Ref: Numerical Solution Initial-Value Problems in Differential-Algebraic Equations by K.E. Brenan et 
	al. pp. 151, 1996."
	"x points right. y points up. gravity=1 is down. length=1. phi=0 when pendulum is straight down."
	"Pendulum is initially pointing right with initial velocity of 1 rad/s upwards."
	"self halt. self exampleIntegratorODE1."

	| solver t y1 y2 ydot1 ydot2 gravity length eqn1 eqn2 filenameString |
	self raiseTranscript.
	Transcript cr; show: 'ODE for a simple pendulum.'.
	solver := DifferentialAlgebraicEquationSolver new: 2.
	t := IndependentVariable name: #t.
	y1 := DependentVariable name: #phi.
	y2 := DependentVariable name: #phidot.
	y1 x: t.
	y2 x: t.
	ydot1 := (y1 differentiateWRT: t) simplified.
	ydot2 := (y2 differentiateWRT: t) simplified.
	gravity := Parameter name: #gravity.
	length := Parameter name: #length.
	gravity value: 1.0d.
	length value: 1.0d.
	t value: 0.0d.
	y1 value: Double pi / 2.0d.
	y2 value: 1.0d.
	ydot1 value: 1.0d.
	ydot2 value: -1.0d.
	eqn1 := ydot1 - y2.
	eqn2 := ydot2 + (gravity / length * y1 sin).
	solver t: t.
	solver yAt: 1 put: y1.
	solver yAt: 2 put: y2.
	solver ydotAt: 1 put: ydot1.
	solver ydotAt: 2 put: ydot2.
	solver aFAt: 1 put: eqn1.
	solver aFAt: 2 put: eqn2.
	solver tstart: 0.0d.
	solver tend: 10.0d.
	solver hout: 0.1d.
	solver hmin: 1.0d-12.
	solver hmax: 1.0d.
	solver orderMax: 5.
	solver iterMax: 4.
	solver relativeTol: 1.0d-6.
	solver absoluteTol: 1.0d-6.
	solver run.
	filenameString := 'dummy.txt'.
	Transcript cr; show: 'Tabulated data is in ' , filenameString.
	solver outputOnFile: filenameString
]

{ #category : #exampleSymbolicMath }
Help class >> exampleLeastSquaresFitPolynomial [
	"self halt. self exampleLeastSquaresFitPolynomial."

	| var func deriv |
	var := IndependentVariable new.
	func := LeastSquaresFitPolynomial
				with: var
				order: 2
				xs: (MathArray newWithElements: #(1.0d 2.0d 3.0d 4.0d 5.0d 5.5d))
				ys: (MathArray newWithElements: #(1.0d 4.0d 9.0d 16.0d 25.0d 30.25d)).
	deriv := (func differentiateWRT: var) simplified asFunctionOf: var.
	var value: 1.0d.
	func value = 1.0d ifFalse: [self halt: 'Check this.'].
	deriv value.
	var value: 3.0d.
	func value = 9.0d ifFalse: [self halt: 'Check this.'].
	deriv value.
	(func x: 1.0d) value = 1.0d ifFalse: [self halt: 'Check this.'].
	(deriv x: 1.0d) value.
	(func x: 3.0d) value = 9.0d ifFalse: [self halt: 'Check this.'].
	(deriv x: 3.0d) value.
	func outputOn: 'dummy.txt' interval: (0.0d to: 6.0d by: 0.1d).
	deriv outputOn: 'dummy2.txt' interval: (0.0d to: 6.0d by: 0.1d)
]

{ #category : #exampleSymbolicMath }
Help class >> exampleLg [
	"self halt. self exampleLg."

	| var func deriv |
	var := IndependentVariable new.
	func := Lg with: var.
	deriv := (func differentiateWRT: var) simplified asFunctionOf: var.
	var value: 1.0d.
	func value = 1.0d log ifFalse: [self halt: 'Check this.'].
	(deriv value - 10.0d ln reciprocal) abs < 1.0d-8 ifFalse: [self halt: 'Check this.'].
	func outputOn: 'dummy.txt' interval: (0.01d to: 100.0d by: 1.0d)
]

{ #category : #exampleSymbolicMath }
Help class >> exampleLn [
	"self halt. self exampleLn."

	| var func deriv |
	var := IndependentVariable new.
	func := Ln with: var.
	deriv := (func differentiateWRT: var) simplified asFunctionOf: var.
	var value: 1.0d.
	func value = 1.0d ln ifFalse: [self halt: 'Check this.'].
	deriv value = 1.0d reciprocal ifFalse: [self halt: 'Check this.'].
	func outputOn: 'dummy.txt' interval: (0.01d to: 100.0d by: 1.0d)
]

{ #category : #exampleMatrixSolver }
Help class >> exampleMatrixSolver1 [
	"This example tests the handling of a singular matrix."
	"self halt. self exampleMatrixSolver1."

	| aA b |
	aA := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d 14.0d) #(21.0d 22.0d 23.0d 24.0d) #(31.0d 32.0d 33.0d 34.0d) #(41.0d 42.0d 43.0d 44.0d)).
	b := FullColumn newWithElements: #(1.0d 2.0d 3.0d 4.0d).
	self testAllSolversWithMatrix: aA vector: b
]

{ #category : #exampleMatrixSolver }
Help class >> exampleMatrixSolver1a [
	"This example tests the handling of a singular matrix."
	"self halt. self exampleMatrixSolver1a."

	| aA b |
	aA := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d 14.0d) #(21.0d 22.0d 23.0d 24.0d) #(31.0d 32.0d 33.0d 34.0d) #(41.0d 42.0d 43.0d 44.0d)).
	b := FullMatrix newWithElements: #(#(1.0d 2.0d) #(2.0d 4.0d) #(3.0d 6.0d) #(4.0d 8.0d)).
	self testAllSolversWithMatrix: aA vector: b
]

{ #category : #exampleMatrixSolver }
Help class >> exampleMatrixSolver2 [
	"self halt. self exampleMatrixSolver2."

	| aA b |
	aA := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d 14.0d) #(21.0d 22.0d 23.0d 24.0d) #(31.0d 32.0d 34.0d 34.0d) #(41.0d 42.0d 43.0d 45.0d)).
	b := FullColumn newWithElements: #(1.0d 2.0d 3.0d 4.0d).
	self testAllSolversWithMatrix: aA vector: b
]

{ #category : #exampleMatrixSolver }
Help class >> exampleMatrixSolver2a [
	"self halt. self exampleMatrixSolver2a."

	| aA b |
	aA := FullMatrix newWithElements: #(#(11.0d 12.0d 13.0d 14.0d) #(21.0d 22.0d 23.0d 24.0d) #(31.0d 32.0d 34.0d 34.0d) #(41.0d 42.0d 43.0d 45.0d)).
	b := FullMatrix newWithElements: #(#(1.0d 2.0d) #(2.0d 4.0d) #(3.0d 6.0d) #(4.0d 8.0d)).
	self testAllSolversWithMatrix: aA vector: b
]

{ #category : #exampleMatrixSolver }
Help class >> exampleMatrixSolver3 [
	"self halt. self exampleMatrixSolver3."

	| aA b |
	aA := FullMatrix newWithElements: #(#(2.0d -5.0d 1.0d) #(-1.0d 3.0d -1.0d) #(3.0d -4.0d 2.0d)).
	b := FullColumn newWithElements: #(12.0d -8.0d 16.0d).
	self testAllSolversWithMatrix: aA vector: b
]

{ #category : #exampleMatrixSolver }
Help class >> exampleMatrixSolver4 [
	"self halt. self exampleMatrixSolver4."

	| aA b |
	aA := FullMatrix newWithElements: #(
	#(0.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d) 
	#(0.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d) 
	#(0.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d)).
	b := FullColumn newWithElements: #(1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d).
	self testAllSolversWithMatrix: aA vector: b
]

{ #category : #exampleMatrixSolver }
Help class >> exampleMatrixSolver5 [
	"self halt. self exampleMatrixSolver5."

	| aA b |
	aA := FullMatrix newWithElements: #(
	#(1.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d) 
	#(0.0d 1.0d 0.0d 1.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d) 
	#(0.0d 0.0d 1.0d 1.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d)).
	b := FullColumn newWithElements: #(1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d).
	self testAllSolversWithMatrix: aA vector: b
]

{ #category : #exampleMatrixSolver }
Help class >> exampleMatrixSolver6 [
	"self halt. self exampleMatrixSolver6."

	| aA b |
	aA := FullMatrix newWithElements: #(
	#(1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(0.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(0.0d 0.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(0.0d 0.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d 0.0d) 
	#(0.0d 0.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 0.0d) 
	#(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d) 
	).
	b := FullColumn newWithElements: #(1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d).
	self testAllSolversWithMatrix: aA vector: b
]

{ #category : #exampleMatrixSolver }
Help class >> exampleMatrixSolver7 [
	"self halt. self exampleMatrixSolver7."

	| aA b |
	aA := FullMatrix newWithElements: #(
	#(1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d) 
	).
	b := FullColumn newWithElements: #(1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d).
	self testAllSolversWithMatrix: aA vector: b
]

{ #category : #exampleMatrixSolver }
Help class >> exampleMatrixSolver8 [
	"self halt. self exampleMatrixSolver8."

	| aA b |
	aA := FullMatrix newWithElements: #(

	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	#(1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d) 
	).
	b := FullColumn newWithElements: #(1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d).
	self testAllSolversWithMatrix: aA vector: b
]

{ #category : #exampleNewtonRaphson }
Help class >> exampleNewtonRaphsonScalar [
	"self halt. self exampleNewtonRaphsonScalar."

	| solver var1 eqn1 |
	solver := NonlinearEquationSolver new: 1.
	var1 := IndependentVariable name: #var1.
	var1 value: 1.0d.
	eqn1 := Cos with: var1.
	solver varAt: 1 put: var1.
	solver eqnAt: 1 put: eqn1.
	solver run.
	Transcript cr.
	Transcript cr; show: 'var1 root = '; show: var1 value printString.
	Transcript cr; show: 'eqn1 at root = '; show: eqn1 value printString
]

{ #category : #exampleNewtonRaphson }
Help class >> exampleNewtonRaphsonScalar1 [
	"self halt. self exampleNewtonRaphsonScalar1."

	| solver var1 eqn1 |
	solver := NonlinearEquationSolver new: 1.
	var1 := IndependentVariable name: #var1.
	var1 value: 1.0d.
	eqn1 := Sum with: 2 plus: (Cos with: var1).
	solver varAt: 1 put: var1.
	solver eqnAt: 1 put: eqn1.
	solver run.
	Transcript cr.
	Transcript cr; show: 'var1 root = '; show: var1 value printString.
	Transcript cr; show: 'eqn1 at root = '; show: eqn1 value printString
]

{ #category : #exampleNewtonRaphson }
Help class >> exampleNewtonRaphsonScalar2 [
	"self halt. self exampleNewtonRaphsonScalar2."

	| solver var1 eqn1 |
	solver := NonlinearEquationSolver new: 1.
	var1 := IndependentVariable name: #var1.
	var1 value: 1.0d.
	eqn1 := Sum with: 2 plus: (Cos with: var1).
	solver varAt: 1 put: var1.
	solver eqnAt: 1 put: eqn1.
	solver runWithBackTracking.
	Transcript cr.
	Transcript cr; show: 'var1 root = '; show: var1 value printString.
	Transcript cr; show: 'eqn1 at root = '; show: eqn1 value printString
]

{ #category : #exampleNewtonRaphson }
Help class >> exampleNewtonRaphsonVector [
	"self halt. self exampleNewtonRaphsonVector."

	| solver var1 var2 eqn1 eqn2 |
	solver := NonlinearEquationSolver new: 2.
	var1 := IndependentVariable name: #var1.
	var2 := IndependentVariable name: #var2.
	var1 value: 1.0d.
	var2 value: 1.0d.
	eqn1 := Cos with: var1.
	eqn2 := Sin with: var2.
	solver varAt: 1 put: var1.
	solver varAt: 2 put: var2.
	solver eqnAt: 1 put: eqn1.
	solver eqnAt: 2 put: eqn2.
	solver run.
	Transcript cr.
	Transcript cr; show: 'var1 root = '; show: var1 value printString.
	Transcript cr; show: 'var2 root = '; show: var2 value printString.
	Transcript cr; show: 'eqn1 at root = '; show: eqn1 value printString.
	Transcript cr; show: 'eqn2 at root = '; show: eqn2 value printString
]

{ #category : #exampleNewtonRaphson }
Help class >> exampleNewtonRaphsonVector1 [
	"self halt. self exampleNewtonRaphsonVector1."

	| solver var1 var2 eqn1 eqn2 |
	solver := NonlinearEquationSolver new: 2.
	var1 := IndependentVariable name: #var1.
	var2 := IndependentVariable name: #var2.
	var1 value: 1.0d.
	var2 value: 1.0d.
	eqn1 := Sum with: 2 plus: (Cos with: var1).
	eqn2 := Sin with: var2.
	solver varAt: 1 put: var1.
	solver varAt: 2 put: var2.
	solver eqnAt: 1 put: eqn1.
	solver eqnAt: 2 put: eqn2.
	solver run.
	Transcript cr.
	Transcript cr; show: 'var1 root = '; show: var1 value printString.
	Transcript cr; show: 'var2 root = '; show: var2 value printString.
	Transcript cr; show: 'eqn1 at root = '; show: eqn1 value printString.
	Transcript cr; show: 'eqn2 at root = '; show: eqn2 value printString
]

{ #category : #exampleNewtonRaphson }
Help class >> exampleNewtonRaphsonVector2 [
	"self halt. self exampleNewtonRaphsonVector2."

	| solver var1 var2 eqn1 eqn2 |
	solver := NonlinearEquationSolver new: 2.
	var1 := IndependentVariable name: #var1.
	var2 := IndependentVariable name: #var2.
	var1 value: 1.0d.
	var2 value: 1.0d.
	eqn1 := Sum with: 2 plus: (Cos with: var1).
	eqn2 := Sin with: var2.
	solver varAt: 1 put: var1.
	solver varAt: 2 put: var2.
	solver eqnAt: 1 put: eqn1.
	solver eqnAt: 2 put: eqn2.
	solver runWithBackTracking.
	Transcript cr.
	Transcript cr; show: 'var1 root = '; show: var1 value printString.
	Transcript cr; show: 'var2 root = '; show: var2 value printString.
	Transcript cr; show: 'eqn1 at root = '; show: eqn1 value printString.
	Transcript cr; show: 'eqn2 at root = '; show: eqn2 value printString
]

{ #category : #exampleSymbolicMath }
Help class >> examplePolynomial [
	"self halt. self examplePolynomial."

	| var func deriv |
	var := IndependentVariable new.
	func := Polynomial with: var coeffs: #(1.0d -1.0d -2.0d 1.0d).
	deriv := (func differentiateWRT: var) simplified asFunctionOf: var.
	var value: 0.0d.
	func value = 1.0d ifFalse: [self halt: 'Check this.'].
	deriv value = -1.0d ifFalse: [self halt: 'Check this.'].
	var value: 3.0d.
	func value = (1.0d + (-1.0d * 3.0d) + (-2.0d * 3.0d * 3.0d) + (1.0d * 3.0d * 3.0d * 3.0d)) ifFalse: [self halt: 'Check this.'].
	deriv value = (-1.0d + (-2.0d * 2.0d * 3.0d) + (1.0d * 3.0d * 3.0d * 3.0d)) ifFalse: [self halt: 'Check this.'].
	func outputOn: 'dummy.txt' interval: (-1.0d to: 1.0d by: 0.01d).
	deriv outputOn: 'dummy2.txt' interval: (-1.0d to: 1.0d by: 0.01d)
]

{ #category : #exampleSymbolicMath }
Help class >> exampleSin [
	"self halt. self exampleSin."

	| var func deriv |
	var := IndependentVariable new.
	func := Sin with: var.
	deriv := (func differentiateWRT: var) simplified asFunctionOf: var.
	var value: 1.0d.
	func value = 1.0d sin ifFalse: [self halt: 'Check this.'].
	deriv value = 1.0d cos ifFalse: [self halt: 'Check this.'].
	var value: -1.0d.
	func value = -1.0d sin ifFalse: [self halt: 'Check this.'].
	deriv value = -1.0d cos ifFalse: [self halt: 'Check this.'].
	func outputOn: 'dummy.txt' interval: (-10.0d to: 10.0d by: 0.5d)
]

{ #category : #exampleSymbolicMath }
Help class >> exampleSmoothAbs [
	"self halt. self exampleSmoothAbs."

	| var func deriv |
	var := IndependentVariable new.
	func := SmoothAbs with: var epsilon: 0.1d.
	deriv := (func differentiateWRT: var) simplified asFunctionOf: var.
	var value: 1.0d.
	func value = 1.0d ifFalse: [self halt: 'Check this.'].
	deriv value = 1.0d ifFalse: [self halt: 'Check this.'].
	var value: -1.0d.
	func value = 1.0d ifFalse: [self halt: 'Check this.'].
	deriv value = -1.0d ifFalse: [self halt: 'Check this.'].
	func outputOn: 'dummy.txt' interval: (-1.0d to: 1.0d by: 0.01d).
	deriv outputOn: 'dummy2.txt' interval: (-1.0d to: 1.0d by: 0.01d)
]

{ #category : #exampleSymbolicMath }
Help class >> exampleSmoothCubicStep [
	"self halt. self exampleSmoothCubicStep."

	| var func deriv |
	var := IndependentVariable new.
	func := SmoothCubicStep
				with: var
				x1: 1.0d
				y1: -1.0d
				x2: 2.0d
				y2: 2.0d.
	deriv := (func differentiateWRT: var) simplified asFunctionOf: var.
	var value: 0.0d.
	func value = -1.0d ifFalse: [self halt: 'Check this.'].
	deriv value = 0.0d ifFalse: [self halt: 'Check this.'].
	var value: 3.0d.
	func value = 2.0d ifFalse: [self halt: 'Check this.'].
	deriv value = 0.0d ifFalse: [self halt: 'Check this.'].
	func outputOn: 'dummy.txt' interval: (-4.0d to: 4.0d by: 0.1d).
	deriv outputOn: 'dummy2.txt' interval: (-4.0d to: 4.0d by: 0.1d)
]

{ #category : #exampleSymbolicMath }
Help class >> exampleSmoothSineStep [
	"self halt. self exampleSmoothSineStep."

	| var func deriv |
	var := IndependentVariable new.
	func := SmoothSineStep
				with: var
				x1: 1.0d
				y1: -1.0d
				x2: 2.0d
				y2: 2.0d.
	deriv := (func differentiateWRT: var) simplified asFunctionOf: var.
	var value: 0.0d.
	func value = -1.0d ifFalse: [self halt: 'Check this.'].
	deriv value = 0.0d ifFalse: [self halt: 'Check this.'].
	var value: 1.5d.
	func value = 0.5d ifFalse: [self halt: 'Check this.'].
	var value: 3.0d.
	func value = 2.0d ifFalse: [self halt: 'Check this.'].
	deriv value = 0.0d ifFalse: [self halt: 'Check this.'].
	func outputOn: 'dummy.txt' interval: (-4.0d to: 4.0d by: 0.1d)
]

{ #category : #exampleSparseMatrix }
Help class >> exampleSparseMatrix1 [
	"self halt. self exampleSparseMatrix1."

	| m n matrix |
	m := 5.
	n := 8.
	matrix := SparseMatrix new: m by: n.
	matrix size = m ifFalse: [self error: 'Check this.'].
	matrix nrow = m ifFalse: [self error: 'Check this.'].
	matrix ncol = n ifFalse: [self error: 'Check this.'].
	matrix numberOfElements = (m * n) ifFalse: [self error: 'Check this.'].
	1 to: m do: [:i | 1 to: n do: [:j | matrix at: i and: j put: (i * 10 + j) asDouble]].
	matrix maxElement = (m * 10 + n) asDouble ifFalse: [self error: 'Check this.'].
	matrix minAndMaxValues = (Array with: 11 with: m * 10 + n) ifFalse: [self error: 'Check this.'].
	matrix sumOfElements = (matrix inject: 0.0d into: [:sum :row | sum + row sumOfElements]) ifFalse: [self error: 'Check this.'].
	matrix sumOfSquares = (matrix inject: 0.0d into: [:ssq :row | ssq + row sumOfSquares]) ifFalse: [self error: 'Check this.'].
	matrix sumOfSquares = (matrix sumOfElementsRaisedTo: 2) ifFalse: [self error: 'Check this.'].
	matrix rootMeanSquare = (matrix sumOfSquares / (m * n)) sqrt ifFalse: [self error: 'Check this.'].
	matrix length = matrix sumOfSquares sqrt ifFalse: [self error: 'Check this.'].
	matrix rowSumNorm = (matrix at: m) sumOfAbsElements ifFalse: [self error: 'Check this.']
]

{ #category : #exampleSparseMatrix }
Help class >> exampleSparseMatrix2 [
	"self halt. self exampleSparseMatrix2."

	| m n matrix matrix2 |
	m := 4.
	n := 4.
	matrix := SparseMatrix new: m by: n.
	1 to: m do: [:i | 1 to: n do: [:j | matrix at: i and: j put: (i * 10 + j) asDouble]].
	matrix2 := matrix copy.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf isZero ifFalse: [self error: 'Check this.'].
	matrix2 := matrix copy.
	(matrix2 magnifySelf: 0.0d) isZero ifFalse: [self error: 'Check this.'].
	matrix2 at: 1 and: 1 putFullMatrix: matrix asFullMatrix.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 at: 1 and: 1 plusFullMatrix: matrix asFullMatrix.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 at: 1 and: 1 minusFullMatrix: matrix asFullMatrix.
	matrix2 = matrix negated ifFalse: [self error: 'Check this.']
]

{ #category : #exampleSparseMatrix }
Help class >> exampleSparseMatrix3 [
	"self halt. self exampleSparseMatrix3."

	| m n matrix matrix2 |
	m := 4.
	n := 4.
	matrix := SparseMatrix new: m by: n.
	1 to: m do: [:i | 1 to: n do: [:j | matrix at: i and: j put: (i * 10 + j) asDouble]].
	matrix2 := matrix copy.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 at: 1 and: 1 putFullMatrix: matrix asFullMatrix times: 0.0d.
	matrix2 isZero ifFalse: [self error: 'Check this.'].
	matrix2 at: 1 and: 1 putFullMatrix: matrix asFullMatrix times: 1.0d.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 at: 1 and: 1 plusFullMatrix: matrix asFullMatrix times: 0.0d.
	matrix2 isZero ifFalse: [self error: 'Check this.'].
	matrix2 at: 1 and: 1 plusFullMatrix: matrix asFullMatrix times: 1.0d.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 zeroSelf.
	matrix2 at: 1 and: 1 minusFullMatrix: matrix asFullMatrix times: 0.0d.
	matrix2 isZero ifFalse: [self error: 'Check this.'].
	matrix2 at: 1 and: 1 minusFullMatrix: matrix asFullMatrix times: -1.0d.
	matrix2 = matrix ifFalse: [self error: 'Check this.']
]

{ #category : #exampleSparseMatrix }
Help class >> exampleSparseMatrix3a [
	"self halt. self exampleSparseMatrix3a."

	| m n matrix matrix2 |
	m := 4.
	n := 4.
	matrix := SparseMatrix new: m by: n.
	1 to: m do: [:i | 1 to: n do: [:j | matrix at: i and: j put: (i * 10 + j) asDouble]].
	matrix2 := matrix copy.
	matrix2 = matrix ifFalse: [self error: 'Check this.'].
	matrix2 := matrix plusSparseMatrix: matrix.
	matrix2 = (matrix times: 2.0d) ifFalse: [self error: 'Check this.'].
	matrix2 := matrix plusSparseMatrix: matrix times: 1.0d.
	matrix2 = (matrix times: 2.0d) ifFalse: [self error: 'Check this.'].
	matrix2 := matrix times: 1.0d plusSparseMatrix: matrix.
	matrix2 = (matrix times: 2.0d) ifFalse: [self error: 'Check this.'].
	matrix2 := matrix times: 1.0d plusSparseMatrix: matrix times: 1.0d.
	matrix2 = (matrix times: 2.0d) ifFalse: [self error: 'Check this.'].
	matrix2 := matrix minusSparseMatrix: matrix.
	matrix2 = (matrix times: 0.0d) ifFalse: [self error: 'Check this.'].
	matrix2 := matrix minusSparseMatrix: matrix times: 1.0d.
	matrix2 = (matrix times: 0.0d) ifFalse: [self error: 'Check this.'].
	matrix2 := matrix times: 1.0d minusSparseMatrix: matrix.
	matrix2 = (matrix times: 0.0d) ifFalse: [self error: 'Check this.'].
	matrix2 := matrix times: 1.0d minusSparseMatrix: matrix times: 1.0d.
	matrix2 = (matrix times: 0.0d) ifFalse: [self error: 'Check this.']
]

{ #category : #exampleSparseMatrix }
Help class >> exampleSparseMatrix4 [
	"self halt. self exampleSparseMatrix4."

	| vector matrix answer1 answer2 |
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d).
	matrix := SparseMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d) #(41.0d 42.0d 43.0d)).
	answer1 := matrix timesFullColumn: vector.
	answer2 := (vector transpose timesSparseMatrix: matrix transpose) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	answer2 := (vector transpose timesTransposeSparseMatrix: matrix) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d).
	matrix := SparseMatrix newWithElements: #(#(11.0d) #(21.0d) #(31.0d) #(41.0d)).
	answer1 := matrix timesFullRow: vector transpose.
	answer2 := (vector timesSparseMatrix: matrix transpose) transpose.
	answer1 = answer2 asFullMatrix ifFalse: [self halt: 'Check this.'].
	answer2 := (vector timesTransposeSparseMatrix: matrix) transpose.
	answer1 = answer2 asFullMatrix ifFalse: [self halt: 'Check this.'].
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d 4.0d).
	matrix := SparseMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d) #(41.0d 42.0d 43.0d)).
	answer1 := matrix transpose timesFullColumn: vector.
	answer2 := (vector transpose timesSparseMatrix: matrix) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	answer2 := (vector transposeTimesSparseMatrix: matrix) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d).
	matrix := SparseMatrix newWithElements: #(#(11.0d 12.0d 13.0d)).
	answer1 := matrix transpose timesFullRow: vector transpose.
	answer2 := (vector timesSparseMatrix: matrix) transpose.
	answer1 = answer2 asFullMatrix ifFalse: [self halt: 'Check this.']
]

{ #category : #exampleSparseMatrix }
Help class >> exampleSparseMatrix5 [
	"self halt. self exampleSparseMatrix5."

	| matrix matrix2 answer1 answer2 |
	matrix := SparseMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d) #(41.0d 42.0d 43.0d)).
	matrix2 := SparseMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d)).
	answer1 := matrix timesSparseMatrix: matrix2.
	answer2 := (matrix2 transpose timesSparseMatrix: matrix transpose) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	answer2 := (matrix2 transpose timesTransposeSparseMatrix: matrix) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	matrix2 := SparseMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d) #(41.0d 42.0d 43.0d)).
	answer1 := matrix timesSparseMatrix: matrix2 transpose.
	answer2 := (matrix2 timesSparseMatrix: matrix transpose) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	answer2 := matrix timesTransposeSparseMatrix: matrix2.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	answer1 := matrix transpose timesSparseMatrix: matrix2.
	answer2 := (matrix2 transpose timesSparseMatrix: matrix) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	answer2 := matrix transposeTimesSparseMatrix: matrix2.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	matrix := SparseMatrix newWithElements: #(#(11.0d 12.0d 13.0d) #(21.0d 22.0d 23.0d) #(31.0d 32.0d 33.0d)).
	answer1 := matrix transpose timesSparseMatrix: matrix2 transpose.
	answer2 := (matrix2 timesSparseMatrix: matrix) transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.'].
	answer2 := matrix transposeTimesSparseMatrix: matrix2 transpose.
	answer1 = answer2 ifFalse: [self halt: 'Check this.']
]

{ #category : #exampleSparseMatrix }
Help class >> exampleSparseMatrix6 [
	"self halt. self exampleSparseMatrix6."

	| vector matrix |
	vector := FullColumn newWithElements: #(1.0d 2.0d 3.0d 4.0d).
	matrix := SparseMatrix new: 5 by: 5.
	matrix at: 1 and: 1 putFullColumn: vector.
	matrix at: 1 and: 2 putFullColumn: vector.
	(matrix sparseColumn: 1) = (matrix sparseColumn: 2) ifFalse: [self halt: 'Check this.'].
	matrix at: 1 and: 1 putFullRow: vector transpose.
	matrix at: 2 and: 1 putFullRow: vector transpose.
	(matrix row: 1) = (matrix row: 2) ifFalse: [self halt: 'Check this.'].
	matrix zeroSelf.
	matrix at: 1 and: 1 plusFullColumn: vector.
	matrix at: 1 and: 2 plusFullColumn: vector.
	(matrix sparseColumn: 1) = (matrix sparseColumn: 2) ifFalse: [self halt: 'Check this.'].
	matrix zeroSelf.
	matrix at: 1 and: 1 plusFullRow: vector transpose.
	matrix at: 2 and: 1 plusFullRow: vector transpose.
	(matrix row: 1) = (matrix row: 2) ifFalse: [self halt: 'Check this.'].
	matrix zeroSelf.
	matrix at: 1 and: 1 minusFullColumn: vector.
	matrix at: 1 and: 2 minusFullColumn: vector.
	(matrix sparseColumn: 1) = (matrix sparseColumn: 2) ifFalse: [self halt: 'Check this.'].
	matrix zeroSelf.
	matrix at: 1 and: 1 minusFullRow: vector transpose.
	matrix at: 2 and: 1 minusFullRow: vector transpose.
	(matrix row: 1) = (matrix row: 2) ifFalse: [self halt: 'Check this.']
]

{ #category : #exampleSparseRow }
Help class >> exampleSparseRow1 [
	"self halt. self exampleSparseRow1."

	| n vector |
	n := 10. self halt.
	vector := SparseRow new: n.
"	vector size = n ifFalse: [self error: 'Check this.']."
	vector nrow = 1 ifFalse: [self error: 'Check this.'].
	vector ncol = n ifFalse: [self error: 'Check this.'].
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

{ #category : #exampleSymbolicMath }
Help class >> exampleSqrt [
	"self halt. self exampleSqrt."

	| var func deriv |
	var := IndependentVariable new.
	func := Sqrt with: var.
	deriv := (func differentiateWRT: var) simplified asFunctionOf: var.
	var value: 1.0d.
	func value = 1.0d sqrt ifFalse: [self halt: 'Check this.'].
	deriv value = (0.5d * 1.0d sqrt reciprocal) ifFalse: [self halt: 'Check this.'].
	func outputOn: 'dummy.txt' interval: (0.01d to: 100.0d by: 1.0d)
]

{ #category : #exampleDifferenceOperator }
Help class >> exampleStartingBDFScalar [
	"self halt. self exampleStartingBDFScalar."

	| bdf timeNodes y ypast ydotPast ydot block |
	bdf := StableStartingBDF new.
	bdf time: 5.0d.
	1 to: 4 do: [:i | bdf iStep: i].
	timeNodes := FullRow new: 4.
	timeNodes at: 1 put: 4.0d.
	timeNodes at: 2 put: 3.0d.
	timeNodes at: 3 put: 2.0d.
	timeNodes at: 4 put: 1.0d.
	bdf timeNodes: timeNodes.
	bdf calcOperatorMatrix.
	y := 0.0d.
	ypast := FullRow new: 4.
	ypast at: 1 put: 1.0d.
	ypast at: 2 put: 2.0d.
	ypast at: 3 put: 3.0d.
	ypast at: 4 put: 4.0d.
	ydot := -1.0d.
	ydotPast := FullRow new: 4.
	ydotPast at: 1 put: -1.0d.
	ydotPast at: 2 put: -1.0d.
	ydotPast at: 3 put: -1.0d.
	ydotPast at: 4 put: -1.0d.
	Transcript cr.
	Transcript cr; show: 'StartingBDF'.
	block := [:string :ideriv | Transcript cr; show: string; show: (bdf
					derivative: ideriv
					present: y
					past: ypast
					presentDerivative: ydot
					pastDerivative: ydotPast) printString].
	block value: 'vdot = ' value: 1.
	block value: 'vddot = ' value: 2.
	block value: 'vdddot = ' value: 3.
	block value: 'vddddot = ' value: 4
]

{ #category : #exampleDifferenceOperator }
Help class >> exampleStartingBDFVector [
	"self halt. self exampleStartingBDFVector."

	| bdf timeNodes y ypast ydotPast ydot block |
	bdf := StableStartingBDF new.
	bdf time: 5.0d.
	1 to: 4 do: [:i | bdf iStep: i].
	timeNodes := FullRow new: 4.
	timeNodes at: 1 put: 4.0d.
	timeNodes at: 2 put: 3.0d.
	timeNodes at: 3 put: 2.0d.
	timeNodes at: 4 put: 1.0d.
	bdf timeNodes: timeNodes.
	bdf calcOperatorMatrix.
	y := FullColumn with: 0.0d with: 0.0d.
	ypast := FullRow new: 4.
	ypast at: 1 put: (FullColumn with: 1.0d with: 1.0d).
	ypast at: 2 put: (FullColumn with: 2.0d with: 2.0d).
	ypast at: 3 put: (FullColumn with: 3.0d with: 3.0d).
	ypast at: 4 put: (FullColumn with: 4.0d with: 4.0d).
	ydot := FullColumn with: -1.0d with: -1.0d.
	ydotPast := FullRow new: 4.
	ydotPast at: 1 put: (FullColumn with: -1.0d with: -1.0d).
	ydotPast at: 2 put: (FullColumn with: -1.0d with: -1.0d).
	ydotPast at: 3 put: (FullColumn with: -1.0d with: -1.0d).
	ydotPast at: 4 put: (FullColumn with: -1.0d with: -1.0d).
	Transcript cr.
	Transcript cr; show: 'StartingBDF'.
	block := [:string :ideriv | Transcript cr; show: string; show: (bdf
					derivative: ideriv
					present: y
					past: ypast
					presentDerivative: ydot
					pastDerivative: ydotPast) printString].
	block value: 'vdot = ' value: 1.
	block value: 'vddot = ' value: 2.
	block value: 'vdddot = ' value: 3.
	block value: 'vddddot = ' value: 4
]

{ #category : #exampleSymbolicMath }
Help class >> exampleStep [
	"self halt. self exampleStep."

	| var func deriv |
	var := IndependentVariable new.
	func := Step
				with: var
				x1: 1.0d
				y1: -1.0d
				y2: 2.0d.
	deriv := (func differentiateWRT: var) simplified asFunctionOf: var.
	var value: 1.1d.
	func value = 2.0d ifFalse: [self halt: 'Check this.'].
	deriv value = 0.0d ifFalse: [self halt: 'Check this.'].
	var value: -1.0d.
	func value = -1.0d ifFalse: [self halt: 'Check this.'].
	deriv value = 0.0d ifFalse: [self halt: 'Check this.'].
	func outputOn: 'dummy.txt' interval: (-2.0d to: 2.0d by: 0.1d)
]

{ #category : #exampleSymbolicAssembly }
Help class >> exampleSymbolicAssembly [

	"StMathHelp exampleSymbolicAssembly"

	| aAbsoluteFrame aAssembly iPart jPart iRefPoint jRefPoint iEndFrame jEndFrame aKinematicIJ |
	aAbsoluteFrame := StCAD_MbD_AbsoluteFrame new. "VW_TRANSLATION:StCAD.MbD.AbsoluteFrame:StCAD_MbD_AbsoluteFrame"
	aAssembly := StCAD_MbD_Assembly new. "VW_TRANSLATION:StCAD.MbD.Assembly:StCAD_MbD_Assembly"
	aAbsoluteFrame addSub: aAssembly aRefFrame.
	iPart := StCAD_MbD_Part new. "VW_TRANSLATION:StCAD.MbD.Part:StCAD_MbD_Part"
	jPart := StCAD_MbD_Part new.
	aAssembly addAnyPart: iPart.
	aAssembly addAnyPart: jPart.
	iRefPoint := StCAD_MbD_RefPoint new. "VW_TRANSLATION:StCAD.MbD.RefPoint:StCAD_MbD_RefPoint"
	jRefPoint := StCAD_MbD_RefPoint new.
	iPart addRefGeo: iRefPoint.
	jPart addRefGeo: jRefPoint.
	iEndFrame := EndFrameqc new.
	jEndFrame := EndFrameqc new.
	iRefPoint addRefFrame: iEndFrame.
	jRefPoint addRefFrame: jEndFrame.
	aKinematicIJ := KinematicIJ aEndI: iEndFrame aEndJ: jEndFrame.
	aAbsoluteFrame beSymbolic.
	aKinematicIJ inspect
]

{ #category : #exampleSymbolicMath }
Help class >> exampleTan [
	"self halt. self exampleTan."

	| var func deriv |
	var := IndependentVariable new.
	func := Tan with: var.
	deriv := (func differentiateWRT: var) simplified asFunctionOf: var.
	var value: 1.0d.
	func value = 1.0d tan ifFalse: [self halt: 'Check this.'].
	deriv value = 1.0d cos squared reciprocal ifFalse: [self halt: 'Check this.'].
	var value: -1.0d.
	func value = -1.0d tan ifFalse: [self halt: 'Check this.'].
	deriv value = -1.0d cos squared reciprocal ifFalse: [self halt: 'Check this.'].
	func outputOn: 'dummy.txt' interval: (-5.0d to: 5.0d by: 0.1d)
]

{ #category : #documentation }
Help class >> readMe [
	"StMath is a set of math objects that I have derived from a motion simulation program. It is not 
	intended to be comprehensive, but I believe it is suitable for engineering type applications and I am 
	happy to contribute it to the general Smalltalk community. It has Linear Algebra, Newton-Raphson, 
	numerical solution of Ordinary Differential Equations (ODE) and Differential Algebraic Equations 
	(DAE), and some Symbolic Math with Symbolic Differentiation. The Symbolic Math works with the 
	Newton-Raphson and solution of ODE and DAE. 
	
	To learn to use StMath, run the examples in StMathHelp class methods. I will add more 
	documentation and capabilities based on feedback from users. 
	
	StMath was developed in VisualWorks 3.0 NT but it should run on all versions of VisualWorks. 
	Porting to other flavors of Smalltalk would require reimplementing StMSparseVector which is 
	dependent to VisualWorks IdentityDictionary. 
	
	Download from: 
	http://www.askoh.com/stcad
	
	Thanks for your interest. 
	
	Sincerely, 
	Aik-Siong Koh 
	askoh@alumni.princeton.edu 
	"

	^self commentOnly
]

{ #category : #exampleMatrixSolver }
Help class >> testAllSolversWithMatrix: aA vector: b [ 
	"
	| aA b | 
	aA := StMFullMatrix newWithElements: #(#(2.0d -5.0d 1.0d) #(-1.0d 3.0d -1.0d) #(3.0d -4.0d 2.0d)). 
	b := StMFullColumn newWithElements: #(12.0d -8.0d 16.0d). 
	self testAllSolversWithMatrix: aA vector: b. 
	"

	| fullA sparseA solverClassPrintString matA |
	ScheduledControllers scheduledControllers
		do: 
			[:controller | 
			| window |
			window := controller view.
			('VisualWorks*' match: window label)
				ifTrue: [window raise]].
	Transcript cr; cr; show: 'Testing all concrete subclasses of StMMatrixSolver3'.
	fullA := aA asFullMatrix.
	sparseA := aA asSparseMatrix.
	MatrixSolver
		allSubclassesDo: 
			[:solverClass | 
			solverClassPrintString := solverClass printString.
			solverClass isAbstractClass not
				ifTrue: 
					[matA := ('*FullMat*' match: solverClassPrintString)
								ifTrue: [fullA]
								ifFalse: [sparseA].
					self
						testSolverClass: solverClass
						matrix: matA
						vector: b]]
]

{ #category : #exampleMatrixSolver }
Help class >> testSolverClass: solverClass matrix: aA vector: b [ 
	"
	| solverClass aA b | 
	solverClass := StMLDUSpMatParPvPrecise3. 
	aA := StMSparseMatrix newWithElements: #(#(2.0d -5.0d 1.0d) #(-1.0d 3.0d -1.0d) #(3.0d -4.0d 2.0d)). 
	b := StMFullColumn newWithElements: #(12.0d -8.0d 16.0d). 
	self testSolverClass: solverClass matrix: aA vector: b. 
	"

	| solver x error |
	solver := solverClass new.
	x := [solver
				solve: aA
				with: b
				saveOriginal: true]
				on: SingularMatrixError do: [:ex | ex return].
	x isNil
		ifTrue: [Transcript cr; show: solverClass printString , ' found a singular matrix.']
		ifFalse: 
			[error := (x isKindOf: FullMatrix)
						ifTrue: [(aA timesFullMatrix: x)
								minusFullMatrix: b]
						ifFalse: [(aA timesFullColumn: x)
								minusFullColumn: b].
			error conditionSelfWithTol: MachineAccuracy OfDouble * 9.
			error isZero ifFalse: [self halt: 'Check this.'].
			Transcript cr; show: solverClass printString , ' solved ok. ' , solver millisecondsToRun printString , ' ms.'].
	Transcript flush
]

{ #category : #'VisualWorks metadata' }
Help class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
	)

]

{ #category : #readMe }
Help >> readMe [
	"Read documentation in the class side methods."

	self commentOnly
]
