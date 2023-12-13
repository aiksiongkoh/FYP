Class {
	#name : #MathTime,
	#superclass : #IndependentVariable,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #'VisualWorks metadata' }
MathTime class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'initialize-release' }
MathTime >> initialize [
	super initialize.
	name := #t
]
