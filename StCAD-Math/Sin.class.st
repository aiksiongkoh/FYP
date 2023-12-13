Class {
	#name : #Sin,
	#superclass : #FunctionX,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #accessing }
Sin class >> functionSymbol [
	^'sin'
]

{ #category : #'VisualWorks metadata' }
Sin class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #evaluating }
Sin >> differentiateWRTx [
	^Cos with: x copy
]

{ #category : #printing }
Sin >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'sin'
]

{ #category : #evaluating }
Sin >> value [
	^x value sin
]
