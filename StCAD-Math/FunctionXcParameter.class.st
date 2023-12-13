Class {
	#name : #FunctionXcParameter,
	#superclass : #FunctionX,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #'VisualWorks metadata' }
FunctionXcParameter class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #comparing }
FunctionXcParameter >> = anObject [ 
	^super = anObject and: [x = anObject x]
]

{ #category : #'message handling' }
FunctionXcParameter >> argsPerform: selector withArguments: anArray [ 
	Processor yield.
	x perform: selector withArguments: anArray
]

{ #category : #copying }
FunctionXcParameter >> postCopy [
	x := x copy
]

{ #category : #changing }
FunctionXcParameter >> substitute: var1 with: var2 [ 
	| xx |
	^self = var1
		ifTrue: [var2]
		ifFalse: 
			[xx := x substitute: var1 with: var2.
			self class with: xx]
]

{ #category : #accessing }
FunctionXcParameter >> x [
	^x
]

{ #category : #accessing }
FunctionXcParameter >> x: arg [ 
	x := self conditionArgument: arg
]
