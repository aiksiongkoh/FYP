Class {
	#name : #Symbolic,
	#superclass : #Object,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #ops }
Symbolic >> * arg [ 
	| func |
	func := self conditionArgument: arg.
	^Product with: self copy times: func copy
]

{ #category : #ops }
Symbolic >> + arg [ 
	| func |
	func := self conditionArgument: arg.
	^Sum with: self copy plus: func copy
]

{ #category : #ops }
Symbolic >> - arg [ 
	| func |
	func := self conditionArgument: arg.
	^Sum with: self copy plus: func negated
]

{ #category : #ops }
Symbolic >> / arg [ 
	| func |
	func := self conditionArgument: arg.
	^Product with: self copy times: func reciprocal
]

{ #category : #comparing }
Symbolic >> = anObject [ 
	self subclassResponsibility
]

{ #category : #ops }
Symbolic >> abs [
	^Abs with: self copy
]

{ #category : #ops }
Symbolic >> arcTan [
	^ArcTan with: self copy
]

{ #category : #'message handling' }
Symbolic >> argsPerform: selector withArguments: anArray [ 
	self subclassResponsibility
]

{ #category : #changing }
Symbolic >> asFunctionOf: xarg [ 
	^ExpressionX with: xarg expression: self
]

{ #category : #changing }
Symbolic >> asFunctionOf: xarg and: yarg [ 
	^ExpressionXY
		with: xarg
		and: yarg
		expression: self
]

{ #category : #'StCAD-UI' }
Symbolic >> cadString [
	"Answer a math expression for the StCAD interface."

	| aStream |
	aStream := WriteStream on: (String new: 16).
	self cadStringOn: aStream.
	^aStream contents
]

{ #category : #'StCAD-UI' }
Symbolic >> cadStringOn: aStream [ 
	self printOn: aStream
]

{ #category : #ops }
Symbolic >> conditionArgument: arg [ 
	| answer |
	answer := arg isReal
				ifTrue: [Constant with: arg]
				ifFalse: [arg].
	^answer
]

{ #category : #ops }
Symbolic >> cos [
	^Cos with: self copy
]

{ #category : #evaluating }
Symbolic >> differentiateWRT: variable [ 
	self subclassResponsibility
]

{ #category : #'message handling' }
Symbolic >> doesNotUnderstand: aMessage [ 
	^self argsPerform: aMessage selector withArguments: aMessage arguments
]

{ #category : #ops }
Symbolic >> exp [
	^Exp with: self copy
]

{ #category : #'initialize-release' }
Symbolic >> initialize [
	"Do nothing"
]

{ #category : #testing }
Symbolic >> isConstant [
	^false
]

{ #category : #testing }
Symbolic >> isOne [
	^false
]

{ #category : #testing }
Symbolic >> isProduct [
	^false
]

{ #category : #testing }
Symbolic >> isSum [
	^false
]

{ #category : #testing }
Symbolic >> isSymbolic [
	^true
]

{ #category : #testing }
Symbolic >> isUserFunction [
	^false
]

{ #category : #testing }
Symbolic >> isZero [
	^false
]

{ #category : #ops }
Symbolic >> lg [
	^Lg with: self copy
]

{ #category : #ops }
Symbolic >> ln [
	^Ln with: self copy
]

{ #category : #ops }
Symbolic >> minus: arg [ 
	| func |
	func := self conditionArgument: arg.
	^Sum with: self copy plus: func negated
]

{ #category : #ops }
Symbolic >> negated [
	^Negative with: self copy
]

{ #category : #evaluating }
Symbolic >> partialDifferentiateWRT: variable [ 
	self subclassResponsibility
]

{ #category : #ops }
Symbolic >> plus: arg [ 
	| func |
	func := self conditionArgument: arg.
	^Sum with: self copy plus: func copy
]

{ #category : #copying }
Symbolic >> postCopy [
	self subclassResponsibility
]

{ #category : #printing }
Symbolic >> printOn: aStream [ 
	self subclassResponsibility
]

{ #category : #ops }
Symbolic >> raisedTo: arg [ 
	| exponent |
	exponent := self conditionArgument: arg.
	^Power with: self copy raisedTo: exponent copy
]

{ #category : #ops }
Symbolic >> reciprocal [
	^Power with: self copy raisedTo: -1
]

{ #category : #evaluating }
Symbolic >> simplified [
	| answer |
	answer := self expandUntil: Set new.
	^answer simplifyUntil: Set new
]

{ #category : #ops }
Symbolic >> sin [
	^Sin with: self copy
]

{ #category : #ops }
Symbolic >> sqrt [
	^Sqrt with: self copy
]

{ #category : #changing }
Symbolic >> substitute: var1 with: var2 [ 
	self subclassResponsibility
]

{ #category : #ops }
Symbolic >> tan [
	^Tan with: self copy
]

{ #category : #ops }
Symbolic >> times: arg [ 
	| func |
	func := self conditionArgument: arg.
	^Product with: self copy times: func copy
]

{ #category : #ops }
Symbolic >> timesFunction: aFunction [ 
	^self * aFunction
]

{ #category : #ops }
Symbolic >> timesProduct: aProduct [ 
	| answer |
	answer := aProduct copy.
	answer terms addFirst: self copy.
	^answer
]

{ #category : #ops }
Symbolic >> timesSum: aSum [ 
	| product |
	product := Product with: self.
	^product timesSum: aSum
]

{ #category : #evaluating }
Symbolic >> value [
	self subclassResponsibility
]
