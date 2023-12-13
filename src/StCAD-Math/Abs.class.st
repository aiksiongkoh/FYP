Class {
	#name : #Abs,
	#superclass : #FunctionX,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #accessing }
Abs class >> functionSymbol [
	^'abs'
]

{ #category : #'VisualWorks metadata' }
Abs class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #evaluating }
Abs >> differentiateWRTx [
	^Step
		with: x copy
		x1: 0.0d
		y1: -1.0d
		y2: 1.0d
]

{ #category : #printing }
Abs >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'abs'
]

{ #category : #evaluating }
Abs >> value [
	^x value abs
]
