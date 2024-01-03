Class {
	#name : #Ln,
	#superclass : #FunctionX,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #evaluating }
Ln >> differentiateWRTx [
	^Power with: x copy raisedTo: (Constant with: -1)
]

{ #category : #printing }
Ln >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'ln'
]

{ #category : #evaluating }
Ln >> value [
	^x value ln
]
