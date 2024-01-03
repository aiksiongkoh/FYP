Class {
	#name : #LDUSpMat,
	#superclass : #MatrixLDU,
	#instVars : [
		'matrixL',
		'matrixD',
		'matrixU',
		'markowitzPivotRowCount',
		'markowitzPivotColCount',
		'privateIndicesOfNonZerosInPivotRow',
		'rowPositionsOfNonZerosInPivotColumn'
	],
	#category : #'StCAD-Math-StMathMatrixSolver'
}

{ #category : #'back substitution' }
LDUSpMat >> backSubstituteIntoDU [
	"aD is a diagonal matrix."
	"aU is upper triangular with the ones in the diagonal omitted."

	| rowi rowiValues count index sum j duij rhsZeroElement |
	1 to: m do: [:i | rightHandSideB at: i put: (rightHandSideB at: i)
				/ (matrixD at: i)].
	answerX := rightHandSideB class new: n.
	answerX at: n put: (rightHandSideB at: n).
	rhsZeroElement := self rhsZeroElement.
	n - 1
		to: 1
		by: -1
		do: 
			[:i | 
			rowi := matrixU at: i.
			rowiValues := rowi valueArray.
			markowitzPivotRowCount := rowi tally.
			count := 0.
			index := 1.
			sum := rhsZeroElement copy.
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
					- sum]
]

{ #category : #'forward elimination' }
LDUSpMat >> forwardEliminateWithPivot: p [ 
	| rowp app rowi aip factor jIndex j apj i rowpValues rowUp |
	rowp := matrixA at: p.
	rowpValues := rowp valueArray.
	app := rowp at: p.
	self privateIndicesOfNonZerosInPivotRow: rowp withoutKey: p.
	1 to: markowitzPivotColCount
		do: 
			[:idum | 
			i := rowPositionsOfNonZerosInPivotColumn at: idum.
			rowi := matrixA at: i.
			aip := rowi removeKey: p.
			factor := aip / app.
			matrixL
				at: i
				and: p
				put: factor.
			1 to: markowitzPivotRowCount
				do: 
					[:index | 
					jIndex := privateIndicesOfNonZerosInPivotRow at: index.
					j := rowp basicAt: jIndex.
					apj := rowpValues at: jIndex.
					rowi at: j minusNumber: factor * apj]].
	matrixD at: p put: app.
	rowUp := matrixU at: p.
	1 to: markowitzPivotRowCount
		do: 
			[:index | 
			jIndex := privateIndicesOfNonZerosInPivotRow at: index.
			j := rowp basicAt: jIndex.
			apj := rowpValues at: jIndex.
			rowUp at: j put: apj / app]
]

{ #category : #'forward substitution' }
LDUSpMat >> forwardSubstituteIntoL [
	"aL is lower triangular with the ones in the diagonal omitted."

	| vectorc rowi rowiValues count index sum j duij rhsZeroElement |
	vectorc := rightHandSideB class new: n.
	vectorc at: 1 put: (rightHandSideB at: 1).
	rhsZeroElement := self rhsZeroElement.
	2 to: n
		do: 
			[:i | 
			rowi := matrixL at: i.
			rowiValues := rowi valueArray.
			markowitzPivotRowCount := rowi tally.
			count := 0.
			index := 1.
			sum := rhsZeroElement copy.
			[count < markowitzPivotRowCount]
				whileTrue: 
					[j := rowi basicAt: index.
					j == nil
						ifFalse: 
							[duij := rowiValues basicAt: index.
							count := count + 1.
							sum := sum + ((vectorc at: j)
											* duij)].
					index := index + 1].
			vectorc at: i put: (rightHandSideB at: i)
					- sum].
	^rightHandSideB := vectorc
]

{ #category : #solution }
LDUSpMat >> preSolve: aMatrix saveOriginal: saveOriginal [ 
	"A conditioned copy of aMatrix is solved."

	| rowi maxRowElement |
	(m == aMatrix nrow and: [n == aMatrix ncol]) 
		ifFalse: 
			[m := aMatrix nrow.
			n := aMatrix ncol.
			matrixA := SparseMatrix new: m.
			matrixL := SparseMatrix new: m by: n.
			matrixD := DiagonalMatrix new: m.
			matrixU := SparseMatrix new: m by: n.
			rowScalings := FullColumn new: m.
			pivotValues := FullColumn new: m.
			rowOrder := MathArray new: m.
			privateIndicesOfNonZerosInPivotRow := OrderedCollection new.
			rowPositionsOfNonZerosInPivotColumn := OrderedCollection new].
	1 to: m
		do: 
			[:i | 
			rowi := (aMatrix at: i) asSparseRow.
			maxRowElement := rowi maxElement.
			maxRowElement > 0 ifFalse: [SingularMatrixError raiseSignal].
			rowScalings at: i put: 1.0d / maxRowElement.
			matrixA at: i
				put: (rowi conditionedWithTol: singularPivotTolerance * maxRowElement).
			rowOrder at: i put: i]
]

{ #category : #'forward elimination' }
LDUSpMat >> privateIndicesOfNonZerosInPivotRow: pivotRow withoutKey: discardKey [ 
	"pivotRow is aStMSparseRow."

	| count index key |
	count := 0.
	index := 1.
	markowitzPivotRowCount := pivotRow tally - 1.
	privateIndicesOfNonZerosInPivotRow setIndices.
	[count < markowitzPivotRowCount]
		whileTrue: 
			[key := pivotRow basicAt: index.
			key == nil ifFalse: [key == discardKey
					ifFalse: 
						[count := count + 1.
						privateIndicesOfNonZerosInPivotRow add: index]].
			index := index + 1]
]
