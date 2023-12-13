"
PiecewiseFunction.
The piecewise functions must reference the same x so that everything is consistent. Otherwise the value returned will not be correct when the x's are changed independently.

Instance Variables:

x	<StMArgumentHolder>	The holder is used in functions so that change is argument is reflected in functions.
functions	<OrderedCollection>	func1, func2, .., funcn.
transitions	<OrderedCollection>	-inf < x1 < x2 < x3 ...< inf.

When 
	(x1 <= keyFunction < x2) 
then 
	function := functions at: 2.

To get 
	(x1 <= keyFunction <= x2), 
use 
	(x1 <= keyFunction < x2+) 
where
	x2+ :=  x2 * (1.0d + machinePrecision).

"
Class {
	#name : #PiecewiseFunction,
	#superclass : #FunctionXcParameter,
	#instVars : [
		'functions',
		'transitions'
	],
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #'VisualWorks metadata' }
PiecewiseFunction class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
PiecewiseFunction class >> with: var functions: funcs transitions: trans [ 
	^super new
		x: var
		functions: funcs
		transitions: trans
]

{ #category : #comparing }
PiecewiseFunction >> = anObject [ 
	^super = anObject and: [functions = anObject functions and: [transitions = anObject transitions]]
]

{ #category : #'message handling' }
PiecewiseFunction >> argsPerform: selector withArguments: anArray [ 
	super argsPerform: selector withArguments: anArray.
	functions do: [:function | function perform: selector withArguments: anArray].
	transitions do: [:transition | transition perform: selector withArguments: anArray]
]

{ #category : #evaluating }
PiecewiseFunction >> differentiateWRT: variable [ 
	| derivs |
	derivs := functions collect: [:function | function differentiateWRT: variable].
	^PiecewiseFunction
		with: x copy
		functions: derivs
		transitions: transitions
]

{ #category : #evaluating }
PiecewiseFunction >> expandUntil: set [ 
	| xx newfunctions newtransitions copy |
	^(set includes: self)
		ifTrue: [self]
		ifFalse: 
			[xx := x expandUntil: set.
			newfunctions := functions collect: [:function | function expandUntil: set].
			newtransitions := transitions collect: [:transition | transition expandUntil: set].
			copy := self class
						with: xx
						functions: newfunctions
						transitions: newtransitions.
			xx isConstant
				ifTrue: [Constant with: copy value]
				ifFalse: [copy]]
]

{ #category : #accessing }
PiecewiseFunction >> functions [
	^functions
]

{ #category : #evaluating }
PiecewiseFunction >> partialDifferentiateWRT: variable [ 
	| derivs answer |
	derivs := functions collect: [:function | function partialDifferentiateWRT: variable].
	answer := PiecewiseFunction
				with: x copy
				functions: derivs
				transitions: transitions.
	^answer
]

{ #category : #copying }
PiecewiseFunction >> postCopy [
	super postCopy.
	functions := functions collect: [:function | function copy].
	transitions := transitions collect: [:transition | transition copy]
]

{ #category : #evaluating }
PiecewiseFunction >> simplifyUntil: set [ 
	| xx newfunctions newtransitions copy |
	^(set includes: self)
		ifTrue: [self]
		ifFalse: 
			[xx := x simplifyUntil: set.
			newfunctions := functions collect: [:function | function simplifyUntil: set].
			newtransitions := transitions collect: [:transition | transition simplifyUntil: set].
			copy := self class
						with: xx
						functions: newfunctions
						transitions: newtransitions.
			xx isConstant
				ifTrue: [Constant with: copy value]
				ifFalse: [copy]]
]

{ #category : #changing }
PiecewiseFunction >> substitute: var1 with: var2 [ 
	| xx newFunctions newTransitions |
	^self = var1
		ifTrue: [var2]
		ifFalse: 
			[xx := x substitute: var1 with: var2.
			newFunctions := functions collect: [:function | function substitute: var1 with: var2].
			newTransitions := transitions collect: [:transition | transition substitute: var1 with: var2].
			self class
				with: xx
				functions: newFunctions
				transitions: newTransitions]
]

{ #category : #accessing }
PiecewiseFunction >> transitions [
	^transitions
]

{ #category : #evaluating }
PiecewiseFunction >> value [
	| nTransitions xvalue |
	nTransitions := transitions size.
	xvalue := x value.
	1 to: nTransitions do: [:i | xvalue < (transitions at: i) value ifTrue: [^(functions at: i) value]].
	^(functions at: nTransitions + 1) value
]

{ #category : #accessing }
PiecewiseFunction >> x: arg [ 
	| xold |
	xold := x.
	super x: arg.
	functions := functions collect: [:function | function substitute: xold with: x].
	transitions := transitions collect: [:transition | transition substitute: xold with: x]
]

{ #category : #'initialize-release' }
PiecewiseFunction >> x: var functions: funcs transitions: trans [ 
	x := self conditionArgument: var.
	functions := funcs collect: [:func | self conditionArgument: func].
	transitions := trans collect: [:tran | self conditionArgument: tran]
]
