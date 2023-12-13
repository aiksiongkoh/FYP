Class {
	#name : #ExpressionX,
	#superclass : #FunctionX,
	#instVars : [
		'expression'
	],
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #'VisualWorks metadata' }
ExpressionX class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
ExpressionX class >> with: arg expression: func [ 
	^super new x: arg expression: func
]

{ #category : #comparing }
ExpressionX >> = anObject [ 
	^super = anObject and: [expression = anObject expression]
]

{ #category : #'message handling' }
ExpressionX >> argsPerform: selector withArguments: anArray [ 
	super argsPerform: selector withArguments: anArray.
	expression perform: selector withArguments: anArray
]

{ #category : #evaluating }
ExpressionX >> differentiateWRT: variable [ 
	^expression differentiateWRT: variable
]

{ #category : #evaluating }
ExpressionX >> expandUntil: set [ 
	^(set includes: self)
		ifTrue: [self]
		ifFalse: [expression expandUntil: set]
]

{ #category : #evaluating }
ExpressionX >> partialDifferentiateWRT: variable [ 
	^expression partialDifferentiateWRT: variable
]

{ #category : #copying }
ExpressionX >> postCopy [
	super postCopy.
	expression := expression copy
]

{ #category : #printing }
ExpressionX >> printOn: aStream [ 
	aStream print: self class.
	aStream nextPut: $(.
	aStream print: expression.
	aStream nextPut: $)
]

{ #category : #evaluating }
ExpressionX >> simplifyUntil: set [ 
	^(set includes: self)
		ifTrue: [self]
		ifFalse: [expression simplifyUntil: set]
]

{ #category : #changing }
ExpressionX >> substitute: var1 with: var2 [ 
	| xx expr |
	^self = var1
		ifTrue: [var2]
		ifFalse: 
			[xx := x substitute: var1 with: var2.
			expr := expression substitute: var1 with: var2.
			self class with: xx expression: expr]
]

{ #category : #evaluating }
ExpressionX >> value [
	^expression value
]

{ #category : #accessing }
ExpressionX >> x: arg [ 
	| xold |
	xold := x.
	super x: arg.
	expression notNil ifTrue: [expression := expression substitute: xold with: x]
]

{ #category : #'initialize-release' }
ExpressionX >> x: arg expression: func [ 
	"
	Future modification: 
	Check that func is a function of arg. 
	No need for self to be dependent of arg since self is dependent of func which is indirectly 
	dependent of of arg. 
	"

	x := self conditionArgument: arg.
	expression := self conditionArgument: func
]
