Class {
	#name : #CroutFullMat,
	#superclass : #MatrixCroutDecomposition,
	#category : #'StCAD-Math-StMathMatrixSolver'
}

{ #category : #'back substitution' }
CroutFullMat >> backSubstituteIntoU [
	"U is upper triangular with ones in the diagonal."

	| rowi sum rhsZeroElement |
	answerX := rightHandSideB class new: n.
	rhsZeroElement := self rhsZeroElement.
	n
		to: 1
		by: -1
		do: 
			[:i | 
			rowi := matrixA at: i.
			sum := rhsZeroElement copy.
			i + 1 to: n do: [:j | sum := (rowi at: j)
							* (answerX at: j) + sum].
			answerX at: i put: (rightHandSideB at: i)
					- sum]
]

{ #category : #solution }
CroutFullMat >> formLij: p [ 
	| sum rowi |
	p to: m
		do: 
			[:i | 
			sum := 0.0d.
			rowi := matrixA at: i.
			1 to: p - 1 do: [:k | sum := (rowi at: k)
							* (matrixA at: k and: p) + sum].
			rowi at: p minusNumber: sum]
]

{ #category : #solution }
CroutFullMat >> formUij: p [ 
	| rowp lpp sum upj |
	rowp := matrixA at: p.
	lpp := rowp at: p.
	p + 1 to: n
		do: 
			[:j | 
			sum := 0.0d.
			1 to: p - 1 do: [:k | sum := (rowp at: k)
							* (matrixA at: k and: j) + sum].
			upj := (rowp at: j)
						- sum / lpp.
			rowp at: j put: upj]
]

{ #category : #'forward substitution' }
CroutFullMat >> forwardSubstituteIntoLD [
	"LD is lower triangular with nonzero and arbitrary diagonals."

	| vectorc rowi sum rhsZeroElement |
	vectorc := rightHandSideB class new: n.
	rhsZeroElement := self rhsZeroElement.
	1 to: n
		do: 
			[:i | 
			rowi := matrixA at: i.
			sum := rhsZeroElement copy.
			1 to: i - 1 do: [:j | sum := (rowi at: j)
							* (vectorc at: j) + sum].
			vectorc at: i put: (rightHandSideB at: i)
					- sum / (rowi at: i)].
	^rightHandSideB := vectorc
]

{ #category : #solution }
CroutFullMat >> inverse: aMatrix [ 
	"ForAndBackSub be optimized for the identity matrix."

	| matrixAinverse |
	self decompose: aMatrix.
	rightHandSideB := FullColumn new: m.
	matrixAinverse := FullMatrix new: m by: n.
	1 to: n
		do: 
			[:j | 
			rightHandSideB zeroSelf.
			rightHandSideB at: j put: 1.0d.
			self forAndBackSubNoSave: rightHandSideB.
			matrixAinverse at: 1 and: j putFullColumn: answerX].
	^matrixAinverse
]
