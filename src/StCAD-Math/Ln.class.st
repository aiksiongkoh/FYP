Class {
	#name : #Ln,
	#superclass : #FunctionX,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #accessing }
Ln class >> functionSymbol [
	^'ln'
]

{ #category : #'VisualWorks metadata' }
Ln class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

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
