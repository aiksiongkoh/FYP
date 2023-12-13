Class {
	#name : #VerySparseVector,
	#superclass : #SpecialLinearAlgebra,
	#instVars : [
		'fullsize'
	],
	#category : #'StCAD-Math-StMathArraySpecial'
}

{ #category : #'VisualWorks metadata' }
VerySparseVector class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #accessing }
VerySparseVector >> numberOfElements [
	"Answer the number of elements in the full vector or matrix."

	^fullsize
]
