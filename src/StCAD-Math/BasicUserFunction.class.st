Class {
	#name : #BasicUserFunction,
	#superclass : #UserFunction,
	#instVars : [
		'funcText',
		'myUnit',
		'units'
	],
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #'VisualWorks metadata' }
BasicUserFunction class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
BasicUserFunction class >> with: string myUnit: argUnit units: argUnits [ 
	^(super new)
		funcText: string
		myUnit: argUnit
		units: argUnits; yourself
]

{ #category : #'instance creation' }
BasicUserFunction class >> with: string units: argUnits [ 
	^(super new) funcText: string units: argUnits; yourself
]

{ #category : #accessing }
BasicUserFunction >> funcText [
	^funcText
]

{ #category : #accessing }
BasicUserFunction >> funcText: string [ 
	funcText := string
]

{ #category : #accessing }
BasicUserFunction >> funcText: string myUnit: argUnit units: argUnits [ 
	funcText := string.
	myUnit := argUnit.
	units := argUnits
]

{ #category : #accessing }
BasicUserFunction >> funcText: string units: argUnits [ 
	funcText := string.
	units := argUnits
]

{ #category : #'ops on self' }
BasicUserFunction >> magnifySelf: aDouble [ 
	| aStream |
	aStream := (String new: funcText size + 100) writeStream.
	aStream
		nextPutAll: aDouble printString;
		nextPut: $*;
		nextPut: $(;
		nextPutAll: funcText;
		nextPut: $).
	funcText := aStream contents asText
]

{ #category : #accessing }
BasicUserFunction >> myUnit [
	^myUnit
]

{ #category : #copying }
BasicUserFunction >> postCopy [
	funcText := funcText copy.
	units := units copy
]

{ #category : #accessing }
BasicUserFunction >> units [
	^units
]

{ #category : #accessing }
BasicUserFunction >> units: argUnits [ 
	units := argUnits
]
