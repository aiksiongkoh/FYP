Class {
	#name : #Cos,
	#superclass : #FunctionX,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #evaluating }
Cos >> differentiateWRTx [
	^Negative with: (Sin with: x copy)
]

{ #category : #printing }
Cos >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'cos'
]

{ #category : #evaluating }
Cos >> value [
	^x value cos
]
