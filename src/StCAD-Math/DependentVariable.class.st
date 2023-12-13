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

{ #category : #'binary storage' }
DependentVariable class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [ 
	"Remove the instance variable 'value dependents x name'."
	"Remove the instance variable 'name value x'."

	oldVersion == nil
		ifTrue: 
			[| inst |
			inst := self basicNew.
			^
			[:oldObj | 
			| new |
			new := Array new: 3.
			new at: 1 put: (oldObj at: 4).
			new at: 2 put: (oldObj at: 1).
			new at: 3 put: (oldObj at: 3).
			oldObj become: new.
			oldObj changeClassToThatOf: inst]].
	^super binaryReaderBlockForVersion: oldVersion format: oldFormat
]

{ #category : #'VisualWorks metadata' }
DependentVariable class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

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
