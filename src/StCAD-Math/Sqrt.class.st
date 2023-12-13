Class {
	#name : #Sqrt,
	#superclass : #FunctionX,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #accessing }
Sqrt class >> functionSymbol [
	^'sqrt'
]

{ #category : #'VisualWorks metadata' }
Sqrt class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

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
