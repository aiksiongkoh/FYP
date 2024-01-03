Class {
	#name : #Tan,
	#superclass : #FunctionX,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #evaluating }
Tan >> differentiateWRTx [
	^Power with: (Cos with: x copy)
		raisedTo: (Constant with: -2)
]

{ #category : #printing }
Tan >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'tan'
]

{ #category : #evaluating }
Tan >> value [
	^x value tan
]
