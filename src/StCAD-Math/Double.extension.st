Extension { #name : #Double }

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> abs [
	"Answer a Number that is the absolute value (positive magnitude) of the receiver."

	^self < 0.0d
		ifTrue: [0.0d - self]
		ifFalse: [self]
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double classSide >> arcTan0to2piY: y overX: x [ 
	"(y/x) arcTan in the range 0 to 2*pi."
	"Double arcTan0to2piY: 1.0d overX: 1.0d."

	^x > 0
		ifTrue: [y >= 0
				ifTrue: ["First quadrant."
					(y / x) arcTan]
				ifFalse: ["Forth quadrant."
					2.0d * Double pi + (y / x) arcTan]]
		ifFalse: [x < 0
				ifTrue: ["Second and Third quadrants."
					Double pi + (y / x) arcTan]
				ifFalse: ["x = 0"
					y > 0
						ifTrue: [Double pi / 2.0d]
						ifFalse: [y < 0
								ifTrue: [1.5d * Double pi]
								ifFalse: [self error: '0/0 arcTan is not defined.']]]]
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double classSide >> arcTan0to2piY: y overX: x ifUndefined: aBlock [ 
	"(y/x) arcTan in the range 0 to 2*pi."

	"Double arcTan0to2piY: 1.0d overX: 1.0d."

	^x > 0 
		ifTrue: 
			[y >= 0 
				ifTrue: 
					["First quadrant."

					(y / x) arcTan]
				ifFalse: 
					["Forth quadrant."

					2.0d * Double pi + (y / x) arcTan]]
		ifFalse: 
			[x < 0 
				ifTrue: 
					["Second and Third quadrants."

					Double pi + (y / x) arcTan]
				ifFalse: 
					["x = 0"

					y > 0 
						ifTrue: [Double pi / 2.0d]
						ifFalse: [y < 0 ifTrue: [1.5d * Double pi] ifFalse: [aBlock value]]]]
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double classSide >> arcTanMpiTOpiY: y overX: x [ 
	"(y/x) arcTan in the range -pi to pi."
	"Double arcTanMpiTOpiY: 1.0d overX: 1.0d."

	^x > 0
		ifTrue: ["First and Fourth quadrants."
			(y / x) arcTan]
		ifFalse: [x < 0
				ifTrue: [y >= 0
						ifTrue: ["Second quadrant."
							(y / x) arcTan + Double pi]
						ifFalse: ["Third quadrant."
							(y / x) arcTan - Double pi]]
				ifFalse: ["x = 0"
					y = 0
						ifTrue: [self error: '0/0 arcTan is not defined.']
						ifFalse: [y sign * Double pi / 2.0d]]]
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> basicArcCos [
	"Answer the angle in radians.
	The receiver must be between -1.0 and 1.0
	The result will be between 0.0 and Pi"

	<primitive: 580>
	^self class
		raise: #domainErrorSignal
		receiver: self
		selector: #arcCos
		errorString: 'Receiver must be between 1.0 and -1.0'
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> basicArcSin [
	"Answer the angle in radians.
	The receiver must be between -1.0 and 1.0
	The result will be between -Pi/2 and Pi/2"

	<primitive: 579>
	^self class
		raise: #domainErrorSignal
		receiver: self
		selector: #arcSin
		errorString: 'Receiver must be between 1.0 and -1.0'
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> basicDivide: aNumber [ 
	"Answer a Double that is the exact result of dividing the receiver by the 
	argument, anInteger.  The primitive fails if it cannot coerce the argument 
	to a Double."

	<primitive: 570>
	^aNumber quotientFromDouble: self
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> basicTimes: aNumber [ 
	"Answer a Double that is the result of multiplying the receiver by the 
	argument, aNumber.  The primitive fails if it cannot coerce the argument
	to a Double"

	<primitive: 569>
	^aNumber productFromDouble: self
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> conditionEqual: aDouble or_ge: bDouble and_le: dDouble orEqual: eDouble [ 
	^self < bDouble 
		ifTrue: [aDouble]
		ifFalse: [self > dDouble ifTrue: [eDouble] ifFalse: [self]]
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> condition_ge: aDouble le: bDouble [ 
	^(self max: aDouble) min: bDouble
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> equal: aDouble tol: tol [ 
	^(self - aDouble) abs <= tol
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> equalAngle: aDouble tol: tol [ 
	^(self - aDouble) abs \\ Double twoPi <= tol
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> ge: aDouble le: bDouble [ 
	^aDouble <= self and: [self <= bDouble]
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> gt: aDouble lt: bDouble [

	^aDouble < self and: [self < bDouble]
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double classSide >> halfPi [
	^Pi / 2.0d
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> isDouble [
	^true
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> log [
	"Answer with base 10 logarithm."

	^self ln / 10.0d ln
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> log: aNumber [ 
	"Answer the log base aNumber of the receiver."

	^self ln / aNumber asDouble ln
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> modifiedArcCos [
	^self > 1.0d
		ifTrue: [0.0d]
		ifFalse: [self < -1.0d
				ifTrue: [Double pi]
				ifFalse: [self basicArcCos]]
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> modifiedArcSin [
	^self < 1.0d ifFalse: [Double pi / 2.0d]
		ifTrue: [self > -1.0d
				ifTrue: [self basicArcSin]
				ifFalse: [Double pi / -2.0d]]
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> modifiedDivide: object [ 
	| dum |
	object isDouble
		ifTrue: 
			[dum := object exponent.
			dum == -1023 ifTrue: [ArithmeticValue divisionByZeroSignal raise].
			^self exponent - dum > -1000
				ifTrue: [self basicDivide: object]
				ifFalse: [0.0d]]
		ifFalse: [^object quotientFromDouble: self]
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> modifiedTimes: object [ 
	object isDouble
		ifTrue: [^self exponent + object exponent > -1000
				ifTrue: [self basicTimes: object]
				ifFalse: [0.0d]]
		ifFalse: [^object productFromDouble: self]
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> negated [
	"Answer a Number that is the negation of the receiver."

	^0.0d - self
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> nextLargerNumber [

	"0.0d nextLargerNumber > 0.0d"

	"| dum | 
	dum := -1.0d. 
	dum nextLargerNumber > dum."

	"| dum | 
	dum := 1.0d. 
	dum nextLargerNumber > (dum + 
	StCAD.StMath.StMMachineAccuracy OfDouble)."

	^ self = 0.0 d
		  ifTrue: [ 
			  StCAD_Math_MachineAccuracy OfDouble "VW_TRANSLATION:StCAD.Math.MachineAccuracy:StCAD_Math_MachineAccuracy" ]
		  ifFalse: [ 
			  self
			  +
			  (StCAD_Math_MachineAccuracy OfDouble timesTwoPower: self exponent) ]
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> nextSmallerNumber [

	"| dum | 
	dum := 1.0d. 
	dum nextSmallerNumber < dum."

	"| dum | 
	dum := 1.1d. 
	dum nextSmallerNumber < (dum - StMMachineAccuracy 
	OfDouble)."

	^ self = 0.0 d
		  ifTrue: [ 
			  0.0 d - StCAD_Math_MachineAccuracy OfDouble "VW_TRANSLATION:StCAD.Math.MachineAccuracy:StCAD_Math_MachineAccuracy" ]
		  ifFalse: [ 
			  self
			  -
			  (StCAD_Math_MachineAccuracy OfDouble timesTwoPower: self exponent) ]
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> printForExport [
	| string |
	string := self printString.
	^string last == $d
		ifTrue: [string replaceAll: $d with: Character space]
		ifFalse: [string replaceAll: $d with: $e]
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> productFrom: aObject [ 
	^aObject times: self
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> reciprocal [
	^1.0d / self
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double classSide >> twoPi [
	^Pi * 2.0d
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Double >> yd: y [

	^ StCAD_Math_FullColumn with: self asDouble with: y asDouble "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn"
]
