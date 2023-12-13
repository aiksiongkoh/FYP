Class {
	#name : #SpecialLinearAlgebra,
	#superclass : #Object,
	#category : #'StCAD-Math-StMathArraySpecial'
}

{ #category : #'VisualWorks metadata' }
SpecialLinearAlgebra class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
	)

]

{ #category : #accessing }
SpecialLinearAlgebra >> at: i and: j put: aNumber [ 
	"Special vectors and matrices are to be read only."

	self shouldNotImplement
]

{ #category : #accessing }
SpecialLinearAlgebra >> at: i put: aNumber [ 
	"Special vectors and matrices are to be read only."

	self shouldNotImplement
]

{ #category : #accessing }
SpecialLinearAlgebra >> numberOfElements [
	"Answer the number of elements in the full vector or matrix."

	self subclassResponsibility
]
