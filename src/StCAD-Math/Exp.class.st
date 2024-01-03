Class {
	#name : #Exp,
	#superclass : #FunctionX,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #evaluating }
Exp >> differentiateWRTx [
	^Exp with: x copy
]

{ #category : #printing }
Exp >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'exp'
]

{ #category : #evaluating }
Exp >> value [
	^x value exp
]
