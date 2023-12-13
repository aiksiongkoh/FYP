Class {
	#name : #LeastSquaresFit,
	#superclass : #FunctionFromData,
	#instVars : [
		'xOffset'
	],
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #'VisualWorks metadata' }
LeastSquaresFit class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
LeastSquaresFit class >> with: var order: order xs: xxs ys: yys [ 
	^super new
		x: var
		order: order
		xs: xxs
		ys: yys
]
