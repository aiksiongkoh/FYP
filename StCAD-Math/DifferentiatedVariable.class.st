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

{ #category : #'binary storage' }
DifferentiatedVariable class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [ 
	"Remove the instance variable 'value dependents x name wrts'."
	"Remove the instance variable 'name value x wrts'."

	oldVersion == nil
		ifTrue: 
			[| inst |
			inst := self basicNew.
			^
			[:oldObj | 
			| new |
			new := Array new: 4.
			new at: 1 put: (oldObj at: 4).
			new at: 2 put: (oldObj at: 1).
			new at: 3 put: (oldObj at: 3).
			new at: 4 put: (oldObj at: 5).
			oldObj become: new.
			oldObj changeClassToThatOf: inst]].
	^super binaryReaderBlockForVersion: oldVersion format: oldFormat
]

{ #category : #'VisualWorks metadata' }
DifferentiatedVariable class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
DifferentiatedVariable class >> with: var wrts: derivs [ 
	^super new x: var wrts: derivs
]

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
