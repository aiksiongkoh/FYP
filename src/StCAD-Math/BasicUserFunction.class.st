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
