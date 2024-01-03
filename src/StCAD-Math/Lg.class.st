Class {
	#name : #Lg,
	#superclass : #FunctionX,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #evaluating }
Lg >> differentiateWRTx [
	^Product with: (Power with: x copy raisedTo: (Constant with: -1))
		times: (Constant with: 1.0d exp log)
]

{ #category : #printing }
Lg >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'lg'
]

{ #category : #evaluating }
Lg >> value [
	^x value log
]
