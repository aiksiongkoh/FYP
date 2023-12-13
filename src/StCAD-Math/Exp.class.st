Class {
	#name : #Exp,
	#superclass : #FunctionX,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #accessing }
Exp class >> functionSymbol [
	^'exp'
]

{ #category : #'VisualWorks metadata' }
Exp class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

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
