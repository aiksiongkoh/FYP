Class {
	#name : #MatrixDecomposition,
	#superclass : #MatrixSolver,
	#category : #'StCAD-Math-StMathMatrixSolver'
}

{ #category : #'VisualWorks metadata' }
MatrixDecomposition class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'back substitution' }
MatrixDecomposition >> applyRowOrderOnRightHandSideB [
	| answer |
	answer := rightHandSideB class new: m.
	1 to: m do: [:i | answer at: i put: (rightHandSideB at: (rowOrder at: i))].
	rightHandSideB := answer
]

{ #category : #'back substitution' }
MatrixDecomposition >> backSubstituteIntoDU [
	"aD is a diagonal matrix."
	"aU is upper triangular with the ones in the diagonal omitted."

	self subclassResponsibility
]

{ #category : #'back substitution' }
MatrixDecomposition >> backSubstituteIntoU [
	"U is upper triangular with ones in the diagonal."

	self subclassResponsibility
]

{ #category : #solution }
MatrixDecomposition >> basicSolve: aMatrix with: aVector saveOriginal: saveOriginal [ 
	self decompose: aMatrix saveOriginal: saveOriginal.
	^self forAndBackSub: aVector saveOriginal: saveOriginal
]

{ #category : #'forward substitution' }
MatrixDecomposition >> forwardSubstituteIntoL [
	"aL is lower triangular with the ones in the diagonal omitted."

	self subclassResponsibility
]

{ #category : #'forward substitution' }
MatrixDecomposition >> forwardSubstituteIntoLD [
	"LD is lower triangular with nonzero and arbitrary diagonals."

	self subclassResponsibility
]

{ #category : #solution }
MatrixDecomposition >> postSolve [
	"Do nothing."
]

{ #category : #solution }
MatrixDecomposition >> preSolve: aMatrix saveOriginal: saveOriginal [ 
	matrixA := saveOriginal 
				ifTrue: [aMatrix copy asFullMatrix]
				ifFalse: [aMatrix asFullMatrix].
	(m == matrixA nrow and: [n == matrixA ncol]) 
		ifFalse: 
			[m := matrixA nrow.
			n := matrixA ncol.
			pivotValues := FullColumn new: m.
			rowOrder := MathArray new: m.
			colOrder := MathArray new: n].
	m = n 
		ifTrue: 
			[1 to: m
				do: 
					[:i | 
					rowOrder at: i put: i.
					colOrder at: i put: i]]
		ifFalse: 
			[1 to: m do: [:i | rowOrder at: i put: i].
			1 to: n do: [:j | colOrder at: j put: j]].
	(rowScalings == nil or: [rowScalings size ~= m]) 
		ifTrue: [self findScalingsForRows: 1 to: m]
]
