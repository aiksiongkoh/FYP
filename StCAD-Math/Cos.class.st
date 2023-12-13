Class {
	#name : #Cos,
	#superclass : #FunctionX,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #accessing }
Cos class >> functionSymbol [
	^'cos'
]

{ #category : #'VisualWorks metadata' }
Cos class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

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
