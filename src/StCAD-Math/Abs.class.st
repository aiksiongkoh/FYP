Class {
	#name : #Abs,
	#superclass : #FunctionX,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

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
