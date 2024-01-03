Class {
	#name : #'Function_cArg',
	#superclass : #Function,
	#instVars : [
		'terms'
	],
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #comparing }
Function_cArg >> = anObject [ 
	^super = anObject and: [terms = anObject terms]
]

{ #category : #accessing }
Function_cArg >> addTerm: term [ 
	terms add: term.
	^term
]

{ #category : #accessing }
Function_cArg >> addTerms: collection [ 
	terms addAll: collection.
	^collection
]

{ #category : #'message handling' }
Function_cArg >> argsPerform: selector withArguments: anArray [ 
	terms do: [:term | term perform: selector withArguments: anArray]
]

{ #category : #'initialize-release' }
Function_cArg >> initialize [
	super initialize.
	terms := OrderedCollection new
]

{ #category : #copying }
Function_cArg >> postCopy [
	terms := terms
				collect: 
					[:term | 
					| newTerm |
					newTerm := term copy.
					newTerm]
]

{ #category : #printing }
Function_cArg >> printOn1: aStream [ 
	aStream print: self class.
	aStream nextPutAll: '('.
	terms isNil ifFalse: [terms do: [:term | term printOn: aStream]
			separatedBy: [aStream space]].
	aStream nextPut: $)
]

{ #category : #printing }
Function_cArg >> printOn: aStream [ 
	aStream print: self class.
	aStream nextPutAll: '('.
	terms isNil ifFalse: [terms do: [:term | term printOn: aStream]
			separatedBy: [aStream space]].
	aStream nextPut: $)
]

{ #category : #changing }
Function_cArg >> substitute: var1 with1: var2 [ 
	terms := terms collect: [:term | term == var1
					ifTrue: [var2]
					ifFalse: [term substitute: var1 with: var2]]
]

{ #category : #changing }
Function_cArg >> substitute: var1 with: var2 [ 
	^self class new terms: (terms collect: [:term | term substitute: var1 with: var2])
]

{ #category : #accessing }
Function_cArg >> terms [
	^terms
]

{ #category : #accessing }
Function_cArg >> terms: collection [ 
	terms := collection
]
