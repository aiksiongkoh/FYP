Class {
	#name : #GESpMatParPvPrecise,
	#superclass : #GESpMatParPv,
	#category : #'StCAD-Math-StMathMatrixSolver'
}

{ #category : #pivoting }
GESpMatParPvPrecise >> doPivoting: p [ 
	"Search from bottom to top."
	"Use scaling vector and partial pivoting with actual swapping of rows."
	"Check for singular pivot."
	"Criterion is largest pivot in column."

	| max rowPivot aip mag lookForFirstNonZeroInPivotCol i |
	rowPositionsOfNonZerosInPivotColumn setIndices.
	lookForFirstNonZeroInPivotCol := true.
	i := m.
	[lookForFirstNonZeroInPivotCol]
		whileTrue: 
			[aip := (matrixA at: i)
						at: p.
			aip == nil
				ifTrue: [i > p ifFalse: [SingularMatrixError raiseSignal]]
				ifFalse: 
					[markowitzPivotColCount := 0.
					mag := aip * (rowScalings at: i).
					mag < 0 ifTrue: [mag := 0.0d - mag].
					max := mag.
					rowPivot := i.
					lookForFirstNonZeroInPivotCol := false].
			i := i - 1].
	[i >= p]
		whileTrue: 
			[aip := (matrixA at: i)
						at: p.
			aip == nil
				ifFalse: 
					[markowitzPivotColCount := markowitzPivotColCount + 1.
					mag := aip * (rowScalings at: i).
					mag < 0 ifTrue: [mag := 0.0d - mag].
					mag > max
						ifTrue: 
							[max := mag.
							rowPositionsOfNonZerosInPivotColumn add: rowPivot.
							rowPivot := i]
						ifFalse: [rowPositionsOfNonZerosInPivotColumn add: i]].
			i := i - 1].
	p == rowPivot
		ifFalse: 
			[matrixA swap: p with: rowPivot.
			rightHandSideB swap: p with: rowPivot.
			rowScalings swap: p with: rowPivot.
			rowOrder swap: p with: rowPivot.
			aip == nil ifFalse: [rowPositionsOfNonZerosInPivotColumn at: markowitzPivotColCount put: rowPivot]].
	pivotValues at: p put: max.
	max < singularPivotTolerance ifTrue: [SingularMatrixError raiseSignal]
]

{ #category : #solution }
GESpMatParPvPrecise >> preSolve: aMatrix with: aVector saveOriginal: saveOriginal [ 
	"A conditioned copy of aMatrix is solved."

	| rowi maxRowElement |
	(m == aMatrix nrow and: [n == aMatrix ncol]) 
		ifFalse: 
			[m := aMatrix nrow.
			n := aMatrix ncol.
			matrixA := SparseMatrix new: m.
			rowScalings := FullColumn new: m.
			pivotValues := FullColumn new: m.
			rowOrder := MathArray new: m.
			privateIndicesOfNonZerosInPivotRow := OrderedCollection new.
			rowPositionsOfNonZerosInPivotColumn := OrderedCollection new].
	rightHandSideB := saveOriginal ifTrue: [aVector copy] ifFalse: [aVector].
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
