Class {
	#name : #Tan,
	#superclass : #FunctionX,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #accessing }
Tan class >> functionSymbol [
	^'tan'
]

{ #category : #'VisualWorks metadata' }
Tan class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

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
