Class {
	#name : #TransposeMatrix,
	#superclass : #SpecialMatrix,
	#instVars : [
		'originalMatrix'
	],
	#category : #'StCAD-Math-StMathArraySpecial'
}

{ #category : #accessing }
TransposeMatrix >> numberOfElements [
	"Answer the number of elements in the full vector or matrix."

	^originalMatrix numberOfElements
]
