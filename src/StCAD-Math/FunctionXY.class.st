Class {
	#name : #FunctionXY,
	#superclass : #Function,
	#instVars : [
		'x',
		'y'
	],
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #comparing }
FunctionXY >> = anObject [ 
	^super = anObject and: [x = anObject x and: [y = anObject y]]
]

{ #category : #'message handling' }
FunctionXY >> argsPerform: selector withArguments: anArray [ 
	Processor yield.
	x perform: selector withArguments: anArray.
	y perform: selector withArguments: anArray
]

{ #category : #'StCAD-UI' }
FunctionXY >> cadStringOn: aStream [ 
	aStream nextPutAll: self class functionSymbol.
	aStream nextPut: $(.
	x cadStringOn: aStream.
	aStream nextPutAll: ', '.
	y cadStringOn: aStream.
	aStream nextPut: $)
]

{ #category : #evaluating }
FunctionXY >> differentiateWRT: variable [ 
	| dfdx dxdvar dfdy dydvar |
	self == variable ifTrue: [^Constant with: 1].
	dfdx := self differentiateWRTx.
	dxdvar := x differentiateWRT: variable.
	dfdy := self differentiateWRTy.
	dydvar := y differentiateWRT: variable.
	^(dfdx times: dxdvar)
		plus: (dfdy times: dydvar)
]

{ #category : #evaluating }
FunctionXY >> differentiateWRTx [
	self subclassResponsibility
]

{ #category : #evaluating }
FunctionXY >> differentiateWRTy [
	self subclassResponsibility
]

{ #category : #evaluating }
FunctionXY >> expandUntil: set [ 
	| xx yy copy |
	^(set includes: self)
		ifTrue: [self]
		ifFalse: 
			[xx := x expandUntil: set.
			yy := y expandUntil: set.
			copy := self class with: xx with: yy.
			(xx isConstant and: [yy isConstant])
				ifTrue: [Constant with: copy value]
				ifFalse: [copy]]
]

{ #category : #evaluating }
FunctionXY >> partialDifferentiateWRT: variable [ 
	| dfdx dxdvar dfdy dydvar |
	self == variable ifTrue: [^Constant with: 1].
	dfdx := self differentiateWRTx.
	dxdvar := x partialDifferentiateWRT: variable.
	dfdy := self differentiateWRTy.
	dydvar := y partialDifferentiateWRT: variable.
	^(dfdx times: dxdvar)
		plus: (dfdy times: dydvar)
]

{ #category : #copying }
FunctionXY >> postCopy [
	x := x copy.
	y := y copy
]

{ #category : #printing }
FunctionXY >> printOn: aStream [ 
	aStream print: self class.
	aStream nextPut: $(.
	aStream print: x.
	aStream space.
	aStream print: y.
	aStream nextPut: $)
]

{ #category : #evaluating }
FunctionXY >> simplifyUntil: set [ 
	| xx yy copy |
	^(set includes: self)
		ifTrue: [self]
		ifFalse: 
			[xx := x simplifyUntil: set.
			yy := y simplifyUntil: set.
			copy := self class with: xx with: yy.
			(xx isConstant and: [yy isConstant])
				ifTrue: [Constant with: copy value]
				ifFalse: [copy]]
]

{ #category : #changing }
FunctionXY >> substitute: var1 with: var2 [ 
	| xx yy |
	^self = var1
		ifTrue: [var2]
		ifFalse: 
			[xx := x substitute: var1 with: var2.
			yy := y substitute: var1 with: var2.
			self class with: xx with: yy]
]

{ #category : #accessing }
FunctionXY >> x: arg [ 
	x := self conditionArgument: arg
]

{ #category : #accessing }
FunctionXY >> x: argx y: argy [ 
	x := self conditionArgument: argx.
	y := self conditionArgument: argy
]

{ #category : #accessing }
FunctionXY >> y: arg [ 
	y := self conditionArgument: arg
]
