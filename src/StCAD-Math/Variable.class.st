"
Abstract class
"
Class {
	#name : #Variable,
	#superclass : #Symbolic,
	#instVars : [
		'name',
		'value'
	],
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #'binary storage' }
Variable class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [ 
	"Remove the instance variable 'value dependents x name'."
	"Remove the instance variable 'name value'."

	oldVersion == nil
		ifTrue: 
			[| inst |
			inst := self basicNew.
			^
			[:oldObj | 
			| new |
			new := Array new: 2.
			new at: 1 put: (oldObj at: 4).
			new at: 2 put: (oldObj at: 1).
			oldObj become: new.
			oldObj changeClassToThatOf: inst]].
	^super binaryReaderBlockForVersion: oldVersion format: oldFormat
]

{ #category : #'binary storage' }
Variable class >> binaryRepresentationVersion [
	^30
]

{ #category : #'instance creation' }
Variable class >> name: symbol [ 
	^super new name: symbol
]

{ #category : #'VisualWorks metadata' }
Variable class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #comparing }
Variable >> = anObject [ 
	^self == anObject
]

{ #category : #copying }
Variable >> copy [
	"A Variable is unique."
	"Do nothing."
]

{ #category : #evaluating }
Variable >> expandUntil: set [ 
	"Do nothing."
]

{ #category : #accessing }
Variable >> name [
	^name
]

{ #category : #accessing }
Variable >> name: symbol [ 
	name := symbol asSymbol
]

{ #category : #evaluating }
Variable >> partialDifferentiateWRT: variable [ 
	^self == variable
		ifTrue: [Constant with: 1]
		ifFalse: [Constant with: 0]
]

{ #category : #printing }
Variable >> printOn: aStream [ 
	aStream print: self class.
	aStream nextPut: $'.
	aStream print: name.
	aStream nextPut: $'.
	aStream nextPut: $(.
	aStream print: value.
	aStream nextPut: $)
]

{ #category : #evaluating }
Variable >> simplifyUntil: set [ 
	"Do nothing."
]

{ #category : #changing }
Variable >> substitute: var1 with: var2 [ 
	^self == var1
		ifTrue: [var2]
		ifFalse: [self]
]

{ #category : #accessing }
Variable >> value [
	^value
]

{ #category : #accessing }
Variable >> value: arg [ 
	value := arg isReal
				ifTrue: [arg]
				ifFalse: [self error: 'Argument must be a constant.']
]

{ #category : #accessing }
Variable >> withUnits: argUnits [ 
	"Do nothing."
]
