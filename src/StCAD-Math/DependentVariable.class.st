"
The dependent variable is an unknown function of its argument x.
"
Class {
	#name : #DependentVariable,
	#superclass : #Variable,
	#instVars : [
		'x'
	],
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #accessing }
DependentVariable >> aIndependentVariable [
	^x aIndependentVariable
]

{ #category : #evaluating }
DependentVariable >> differentiateWRT: variable [ 
	| dfdx dxdvar |
	self == variable ifTrue: [^Constant with: 1].
	dfdx := self differentiateWRTx.
	dxdvar := x differentiateWRT: variable.
	^dfdx times: dxdvar
]

{ #category : #evaluating }
DependentVariable >> differentiateWRTx [
	^DifferentiatedVariable with: self wrts: (OrderedCollection with: x copy)
]

{ #category : #printing }
DependentVariable >> printOn: aStream [ 
	aStream nextPutAll: name.
	aStream nextPut: $(.
	aStream print: x.
	aStream nextPut: $)
]

{ #category : #accessing }
DependentVariable >> x: arg [ 
	x := self conditionArgument: arg
]
