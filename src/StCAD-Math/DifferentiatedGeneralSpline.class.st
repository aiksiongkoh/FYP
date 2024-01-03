Class {
	#name : #DifferentiatedGeneralSpline,
	#superclass : #GeneralSpline,
	#instVars : [
		'derivativeOrder'
	],
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #comparing }
DifferentiatedGeneralSpline >> = anObject [ 
	^super = anObject and: [derivativeOrder = anObject derivativeOrder]
]

{ #category : #accessing }
DifferentiatedGeneralSpline >> derivativeOrder [
	^derivativeOrder
]

{ #category : #evaluating }
DifferentiatedGeneralSpline >> differentiateWRTx [
	^DifferentiatedGeneralSpline with: self derivativeOrder: self derivativeOrder + 1
]

{ #category : #'instance creation' }
DifferentiatedGeneralSpline >> generalSpline: stmGeneralSpline derivativeOrder: integer [ 
	x := stmGeneralSpline x copy.
	xs := stmGeneralSpline xs.
	ys := stmGeneralSpline ys.
	derivs := stmGeneralSpline derivs.
	degree := stmGeneralSpline degree.
	derivativeOrder := integer asInteger
]

{ #category : #copying }
DifferentiatedGeneralSpline >> postCopy [
	super postCopy.
	derivativeOrder := derivativeOrder copy
]

{ #category : #changing }
DifferentiatedGeneralSpline >> substitute: var1 with: var2 [ 
	| answer |
	^self = var1
		ifTrue: [var2]
		ifFalse: 
			[answer := self shallowCopy.
			answer x: (x substitute: var1 with: var2).
			answer]
]

{ #category : #evaluating }
DifferentiatedGeneralSpline >> value [
	^self derivative: derivativeOrder at: x value
]
