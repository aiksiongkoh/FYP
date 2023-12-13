Class {
	#name : #MatrixGaussElimination,
	#superclass : #MatrixSolver,
	#category : #'StCAD-Math-StMathMatrixSolver'
}

{ #category : #'VisualWorks metadata' }
MatrixGaussElimination class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'back substitution' }
MatrixGaussElimination >> backSubstituteIntoDU [
	"DU is upper triangular with nonzero and arbitrary diagonals."

	self subclassResponsibility
]

{ #category : #solution }
MatrixGaussElimination >> basicSolve: aMatrix with: aVector saveOriginal: saveOriginal [ 
	self
		preSolve: aMatrix
		with: aVector
		saveOriginal: saveOriginal.
	1 to: m
		do: 
			[:p | 
			self doPivoting: p.
			self forwardEliminateWithPivot: p].
	self backSubstituteIntoDU.
	self postSolve.
	^answerX
]

{ #category : #'forward elimination' }
MatrixGaussElimination >> forwardEliminateWithPivot: p [ 
	self subclassResponsibility
]
