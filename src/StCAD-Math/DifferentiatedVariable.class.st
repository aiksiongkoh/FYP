"
x is the variable to be differentiated.
wrt := 'with respect to'.

Instance Variables:

wrt	<OrderedCollection>	stores the differential variables in order of differentiation use.
"
Class {
	#name : #DifferentiatedVariable,
	#superclass : #DependentVariable,
	#instVars : [
		'wrts'
	],
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #copying }
DifferentiatedVariable >> copy [
	^self shallowCopy postCopy
]

{ #category : #evaluating }
DifferentiatedVariable >> differentiateWRT: variable [ 
	| answer |
	answer := self copy.
	answer wrtsAdd: variable copy.
	^answer
]

{ #category : #evaluating }
DifferentiatedVariable >> differentiateWRTx [
	| xcopy answer |
	xcopy := x copy.
	answer := self class new.
	answer x: xcopy.
	wrts do: [:wrt | answer wrtsAdd: wrt].
	answer wrtsAdd: xcopy.
	^answer
]

{ #category : #'initialize-release' }
DifferentiatedVariable >> initialize [
	super initialize.
	wrts := OrderedCollection new
]

{ #category : #copying }
DifferentiatedVariable >> postCopy [
	x := x copy.
	wrts := wrts collect: [:a | a copy]
]

{ #category : #printing }
DifferentiatedVariable >> printOn: aStream [ 
	aStream nextPutAll: 'diff('.
	aStream print: x.
	wrts do: 
			[:wrt | 
			aStream nextPut: $,.
			aStream print: wrt].
	aStream nextPut: $)
]

{ #category : #changing }
DifferentiatedVariable >> substitute: var1 with: var2 [ 
	| xx wrts2 |
	^self = var1
		ifTrue: [var2]
		ifFalse: 
			[xx := x substitute: var1 with: var2.
			wrts2 := wrts collect: [:wrt | wrt substitute: var1 with: var2].
			self class with: xx wrts: wrts2]
]

{ #category : #accessing }
DifferentiatedVariable >> wrtsAdd: variable [ 
	wrts add: variable
]

{ #category : #accessing }
DifferentiatedVariable >> x: arg [ 
	| xold |
	xold := x.
	super x: arg.
	wrts := wrts collect: [:wrt | wrt substitute: xold with: x]
]

{ #category : #'initialize-release' }
DifferentiatedVariable >> x: var wrts: derivs [ 
	x := self conditionArgument: var.
	wrts := derivs collect: [:deriv | self conditionArgument: deriv]
]
