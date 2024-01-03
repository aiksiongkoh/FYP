Class {
	#name : #LDUFullMat,
	#superclass : #MatrixLDU,
	#category : #'StCAD-Math-StMathMatrixSolver'
}

{ #category : #'back substitution' }
LDUFullMat >> backSubstituteIntoDU [
	"DU is upper triangular with nonzero and arbitrary diagonals."

	| rowi sum |
	answerX := rightHandSideB class new: n.
	answerX at: n put: (rightHandSideB at: m)
			/ (matrixA at: m and: n).
	n - 1
		to: 1
		by: -1
		do: 
			[:i | 
			rowi := matrixA at: i.
			sum := (answerX at: n)
						* (rowi at: n).
			i + 1 to: n - 1 do: [:j | sum := sum + ((answerX at: j)
								* (rowi at: j))].
			answerX at: i put: (rightHandSideB at: i)
					- sum / (rowi at: i)]
]

{ #category : #'forward substitution' }
LDUFullMat >> forwardSubstituteIntoL [
	"L is lower triangular with nonzero and ones in diagonal."

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
					- sum].
	^rightHandSideB := vectorc
]

{ #category : #solution }
LDUFullMat >> inverse: aMatrix saveOriginal: saveOriginal [ 
	"ForAndBackSub be optimized for the identity matrix."

	| matrixAinverse |
	self decompose: aMatrix saveOriginal: saveOriginal.
	rightHandSideB := FullColumn new: m.
	matrixAinverse := FullMatrix new: m by: n.
	1 to: n
		do: 
			[:j | 
			rightHandSideB zeroSelf.
			rightHandSideB at: j put: 1.0d.
			self forAndBackSub: rightHandSideB saveOriginal: saveOriginal.
			matrixAinverse
				at: 1
				and: j
				putFullColumn: answerX].
	^matrixAinverse
]
