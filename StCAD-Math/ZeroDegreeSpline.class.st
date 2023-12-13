Class {
	#name : #ZeroDegreeSpline,
	#superclass : #GeneralSpline,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #'VisualWorks metadata' }
ZeroDegreeSpline class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #evaluating }
ZeroDegreeSpline >> y: xx [ 
	"y(x) := yi + dydxi*hi + d2ydx2i*hi^2/2! + d3ydx3i*hi^3/3! +"

	self calcIndexAndDeltaFor: xx.
	^ys at: index
]
