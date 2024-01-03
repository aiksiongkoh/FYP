Class {
	#name : #Sqrt,
	#superclass : #FunctionX,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #evaluating }
Sqrt >> differentiateWRTx [
	^Product with: (Constant with: 0.5d)
		times: (Power with: x copy raisedTo: (Constant with: -0.5d))
]

{ #category : #printing }
Sqrt >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'sqrt'
]

{ #category : #evaluating }
Sqrt >> value [
	^x value sqrt
]
