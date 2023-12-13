Class {
	#name : #ExpressionXY,
	#superclass : #FunctionXY,
	#instVars : [
		'expression'
	],
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #'VisualWorks metadata' }
ExpressionXY class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
ExpressionXY class >> with: argx and: argy expression: func [ 
	^super new
		x: argx
		y: argy
		expression: func
]

{ #category : #comparing }
ExpressionXY >> = anObject [ 
	^super = anObject and: [expression = anObject expression]
]

{ #category : #'message handling' }
ExpressionXY >> argsPerform: selector withArguments: anArray [ 
	super argsPerform: selector withArguments: anArray.
	expression perform: selector withArguments: anArray
]

{ #category : #evaluating }
ExpressionXY >> differentiateWRT: variable [ 
	^expression differentiateWRT: variable
]

{ #category : #evaluating }
ExpressionXY >> expandUntil: set [ 
	^(set includes: self)
		ifTrue: [self]
		ifFalse: [expression expandUntil: set]
]

{ #category : #evaluating }
ExpressionXY >> partialDifferentiateWRT: variable [ 
	^expression partialDifferentiateWRT: variable
]

{ #category : #copying }
ExpressionXY >> postCopy [
	super postCopy.
	expression := expression copy
]

{ #category : #printing }
ExpressionXY >> printOn: aStream [ 
	aStream print: self class.
	aStream nextPut: $(.
	aStream print: expression.
	aStream nextPut: $)
]

{ #category : #evaluating }
ExpressionXY >> simplifyUntil: set [ 
	^(set includes: self)
		ifTrue: [self]
		ifFalse: [expression simplifyUntil: set]
]

{ #category : #changing }
ExpressionXY >> substitute: var1 with: var2 [ 
	| xx yy expr |
	^self = var1
		ifTrue: [var2]
		ifFalse: 
			[xx := x substitute: var1 with: var2.
			yy := y substitute: var1 with: var2.
			expr := expression substitute: var1 with: var2.
			self class
				with: xx
				and: yy
				expression: expr]
]

{ #category : #evaluating }
ExpressionXY >> value [
	^expression value
]

{ #category : #accessing }
ExpressionXY >> x: arg [ 
	| xold |
	xold := x.
	super x: arg.
	expression notNil ifTrue: [expression := expression substitute: xold with: x]
]

{ #category : #'initialize-release' }
ExpressionXY >> x: argx y: argy expression: func [ 
	x := self conditionArgument: argx.
	y := self conditionArgument: argy.
	expression := self conditionArgument: func
]

{ #category : #accessing }
ExpressionXY >> y: arg [ 
	| yold |
	yold := y.
	super y: arg.
	expression notNil ifTrue: [expression := expression substitute: yold with: y]
]
