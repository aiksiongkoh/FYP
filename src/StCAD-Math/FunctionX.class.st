Class {
	#name : #FunctionX,
	#superclass : #Function,
	#instVars : [
		'x'
	],
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #comparing }
FunctionX >> = anObject [ 
	^super = anObject and: [x = anObject x]
]

{ #category : #'message handling' }
FunctionX >> argsPerform: selector withArguments: anArray [ 
	Processor yield.
	x perform: selector withArguments: anArray
]

{ #category : #accessing }
FunctionX >> arguments: array [ 
	array size == 1 ifFalse: [ArgumentNumberError raise].
	self x: (array at: 1)
]

{ #category : #'StCAD-UI' }
FunctionX >> cadStringOn: aStream [ 
	aStream nextPutAll: self class functionSymbol.
	aStream nextPut: $(.
	x cadStringOn: aStream.
	aStream nextPut: $)
]

{ #category : #evaluating }
FunctionX >> differentiateWRT: variable [ 
	| dfdx dxdvar |
	self == variable ifTrue: [^Constant with: 1].
	dfdx := self differentiateWRTx.
	dxdvar := x differentiateWRT: variable.
	^dfdx times: dxdvar
]

{ #category : #evaluating }
FunctionX >> differentiateWRTx [
	self subclassResponsibility
]

{ #category : #evaluating }
FunctionX >> expandUntil: set [ 
	| xx copy |
	^(set includes: self)
		ifTrue: [self]
		ifFalse: 
			[xx := x expandUntil: set.
			copy := self class with: xx.
			xx isConstant
				ifTrue: [Constant with: copy value]
				ifFalse: [copy]]
]

{ #category : #evaluating }
FunctionX >> partialDifferentiateWRT: variable [ 
	| dfdx dxdvar |
	self == variable ifTrue: [^Constant with: 1].
	dfdx := self differentiateWRTx.
	dxdvar := x partialDifferentiateWRT: variable.
	^dfdx times: dxdvar
]

{ #category : #copying }
FunctionX >> postCopy [
	x := x copy
]

{ #category : #printing }
FunctionX >> print_cArgumentOn: aStream [ 
	aStream print: x
]

{ #category : #accessing }
FunctionX >> setx: arg [ 
	x := arg
]

{ #category : #evaluating }
FunctionX >> simplifyUntil: set [ 
	| xx copy |
	^(set includes: self)
		ifTrue: [self]
		ifFalse: 
			[xx := x simplifyUntil: set.
			copy := self class with: xx.
			xx isConstant
				ifTrue: [Constant with: copy value]
				ifFalse: [copy]]
]

{ #category : #changing }
FunctionX >> substitute: var1 with: var2 [ 
	| xx |
	^self = var1
		ifTrue: [var2]
		ifFalse: 
			[xx := x substitute: var1 with: var2.
			self class with: xx]
]

{ #category : #accessing }
FunctionX >> x: arg [ 
	x := self conditionArgument: arg
]
