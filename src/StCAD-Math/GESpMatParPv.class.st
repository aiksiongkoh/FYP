Class {
	#name : #GESpMatParPv,
	#superclass : #GESpMat,
	#category : #'StCAD-Math-StMathMatrixSolver'
}

{ #category : #'back substitution' }
GESpMatParPv >> backSubstituteIntoDU [
	"DU is upper triangular with nonzero diagonals."

	| rowi rowiValues count index sum diagonalFound j duij duii rhsZeroElement |
	answerX := rightHandSideB class new: n.
	answerX at: n put: (rightHandSideB at: m)
			/ (matrixA at: m and: n).
	rhsZeroElement := self rhsZeroElement.
	n - 1
		to: 1
		by: -1
		do: 
			[:i | 
			rowi := matrixA at: i.
			rowiValues := rowi valueArray.
			markowitzPivotRowCount := rowi tally - 1.
			count := 0.
			index := 1.
			sum := rhsZeroElement copy.
			diagonalFound := false.
			[diagonalFound]
				whileFalse: 
					[j := rowi basicAt: index.
					j == nil
						ifFalse: 
							[duij := rowiValues basicAt: index.
							j > i
								ifTrue: 
									[count := count + 1.
									sum := sum + ((answerX at: j)
													* duij)]
								ifFalse: 
									[diagonalFound := true.
									duii := duij]].
					index := index + 1].
			[count < markowitzPivotRowCount]
				whileTrue: 
					[j := rowi basicAt: index.
					j == nil
						ifFalse: 
							[duij := rowiValues basicAt: index.
							count := count + 1.
							sum := sum + ((answerX at: j)
											* duij)].
					index := index + 1].
			answerX at: i put: (rightHandSideB at: i)
					- sum / duii]
]

{ #category : #'forward elimination' }
GESpMatParPv >> forwardEliminateWithPivot: p [ 
	"rightHandSideB may be multidimensional."

	| rowp app bp rowi aip factor jIndex j apj i rowpValues |
	rowp := matrixA at: p.
	rowpValues := rowp valueArray.
	app := rowp at: p.
	bp := rightHandSideB at: p.
	self privateIndicesOfNonZerosInPivotRow: rowp withoutKey: p.
	1 to: markowitzPivotColCount
		do: 
			[:idum | 
			i := rowPositionsOfNonZerosInPivotColumn at: idum.
			rowi := matrixA at: i.
			aip := rowi removeKey: p.
			factor := aip / app.
			1 to: markowitzPivotRowCount
				do: 
					[:index | 
					jIndex := privateIndicesOfNonZerosInPivotRow at: index.
					j := rowp basicAt: jIndex.
					apj := rowpValues at: jIndex.
					rowi at: j minusNumber: factor * apj].
			rightHandSideB at: i put: (rightHandSideB at: i)
					- (bp * factor)]
]

{ #category : #solution }
GESpMatParPv >> postSolve [
	"Do nothing."
]
