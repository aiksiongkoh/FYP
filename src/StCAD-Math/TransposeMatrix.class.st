Class {
	#name : #TransposeMatrix,
	#superclass : #SpecialMatrix,
	#instVars : [
		'originalMatrix'
	],
	#category : #'StCAD-Math-StMathArraySpecial'
}

{ #category : #'VisualWorks metadata' }
TransposeMatrix class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #accessing }
TransposeMatrix >> numberOfElements [
	"Answer the number of elements in the full vector or matrix."

	^originalMatrix numberOfElements
]
