Class {
	#name : #SpecialMatrix,
	#superclass : #SpecialLinearAlgebra,
	#category : #'StCAD-Math-StMathArraySpecial'
}

{ #category : #accessing }
SpecialMatrix >> numberOfElements [
	"Answer the number of elements in the full vector or matrix."

	^self nrow * self ncol
]
