Class {
	#name : #ArcTan,
	#superclass : #FunctionX,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #evaluating }
ArcTan >> differentiateWRTx [
	^((x copy raisedTo: 2)
		plus: 1) reciprocal
]

{ #category : #evaluating }
ArcTan >> value [
	^x value arcTan
]
