Class {
	#name : #DiagonalMatrix,
	#superclass : #MathArray,
	#type : #variable,
	#category : #'StCAD-Math-StMathArray'
}

{ #category : #'VisualWorks metadata' }
DiagonalMatrix class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #accessing }
DiagonalMatrix >> at: i and: j [ 
	^i == j
		ifTrue: [self at: i]
		ifFalse: [self elementClass zero]
]

{ #category : #accessing }
DiagonalMatrix >> at: i and: j put: anObject [ 
	^i == j
		ifTrue: [self at: i put: anObject]
		ifFalse: [self error: 'Not yet implemented.']
]

{ #category : #accessing }
DiagonalMatrix >> at: i1 putDiagonalMatrix: aDiagonalMatrix [ 
	| iOffset |
	iOffset := i1 - 1.
	1 to: aDiagonalMatrix nrow do: [:ii | self at: iOffset + ii put: (aDiagonalMatrix at: ii)]
]

{ #category : #accessing }
DiagonalMatrix >> ncol [
	^self nrow
]

{ #category : #accessing }
DiagonalMatrix >> nrow [
	"Answer the number of indexable fields in the receiver. This value is the 
	same as the largest legal subscript. Primitive is specified here to override 
	SequenceableCollection size."

	<primitive: 62>
	^self basicSize
]

{ #category : #'basic ops' }
DiagonalMatrix >> times: aNumber [ 
	| nrow answer |
	nrow := self nrow.
	answer := self class new: nrow.
	1 to: nrow do: [:i | answer at: i put: (self at: i)
				* aNumber].
	^answer
]

{ #category : #'basic ops' }
DiagonalMatrix >> timesFullColumn: aFullColumn [ 
	"a*b = a(i,j)b(j) sum j."

	| nrow answer |
	nrow := self nrow.
	answer := aFullColumn class new: nrow.
	1 to: nrow do: [:i | answer at: i put: (self at: i)
				* (aFullColumn at: i)].
	^answer
]

{ #category : #'basic ops' }
DiagonalMatrix >> timesFullMatrix: aFullMatrix [ 
	"a*b = a(i,i)b(i,j) no sum."

	| nrow answer |
	nrow := self nrow.
	answer := aFullMatrix class new: nrow.
	1 to: nrow do: [:i | answer at: i put: ((aFullMatrix at: i)
				times: (self at: i))].
	^answer
]
