Class {
	#name : #ArcTan,
	#superclass : #FunctionX,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #accessing }
ArcTan class >> functionSymbol [
	^'arctan'
]

{ #category : #'VisualWorks metadata' }
ArcTan class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #evaluating }
ArcTan >> differentiateWRTx [
	^((x copy raisedTo: 2)
		plus: 1) reciprocal
]

{ #category : #evaluating }
ArcTan >> value [
	^x value arcTan
]
