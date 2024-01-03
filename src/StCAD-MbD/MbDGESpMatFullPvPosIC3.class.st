Class {
	#name : #MbDGESpMatFullPvPosIC3,
	#superclass : #GESpMatFullPv,
	#instVars : [
		'system',
		'pivotRowLimits',
		'pivotRowLimit'
	],
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #pivoting }
MbDGESpMatFullPvPosIC3 >> doPivoting: p [ 
	"Used by Gauss Elimination only."
	"Swap rows but keep columns in place."
	"The elements below the diagonal are removed column by column."

	| max pivotRow pivotCol rowi rowiValues nNonZeros count index jj aij mag redundantEqns jp aip |
	max := 0.
	pivotRow := p.
	pivotCol := p.
	p to: n do: [:j | (rowPositionsOfNonZerosInColumns at: (colOrder at: j)) setIndices].
	p > pivotRowLimit ifTrue: [pivotRowLimit := pivotRowLimits detect: [:limit | limit >= p]].
	p to: pivotRowLimit
		do: 
			[:i | 
			rowi := matrixA at: i.
			rowiValues := rowi valueArray.
			nNonZeros := rowi tally.
			count := 0.
			index := 1.
			[count < nNonZeros]
				whileTrue: 
					[jj := rowi basicAt: index.
					jj == nil
						ifFalse: 
							[count := count + 1.
							(rowPositionsOfNonZerosInColumns at: jj)
								add: i.
							aij := rowiValues at: index.
							mag := aij.
							mag < 0.0d ifTrue: [mag := 0.0d - mag].
							mag > max
								ifTrue: 
									[max := mag.
									pivotRow := i.
									pivotCol := positionsOfOriginalCols at: jj]].
					index := index + 1]].
	p == pivotRow
		ifFalse: 
			[matrixA swap: p with: pivotRow.
			rightHandSideB swap: p with: pivotRow.
			rowOrder swap: p with: pivotRow].
	p == pivotCol
		ifFalse: 
			[colOrder swap: p with: pivotCol.
			positionsOfOriginalCols at: (colOrder at: p)
				put: p.
			positionsOfOriginalCols at: (colOrder at: pivotCol)
				put: pivotCol].
	pivotValues at: p put: max.
	max < singularPivotTolerance
		ifTrue: 
			[pivotRowLimit := pivotRowLimits detect: [:limit | limit > pivotRowLimit]
						ifNone: 
							[redundantEqns := rowOrder copyFrom: p to: pivotRowLimit.
							SingularMatrixError signalWith: redundantEqns].
			^self doPivoting: p].
	jp := colOrder at: p.
	rowPositionsOfNonZerosInPivotColumn := rowPositionsOfNonZerosInColumns at: jp.
	pivotRowLimit + 1 to: m
		do: 
			[:i | 
			aip := matrixA at: i and: jp.
			aip == nil ifFalse: [rowPositionsOfNonZerosInPivotColumn add: i]].
	rowPositionsOfNonZerosInPivotColumn first == p ifTrue: [rowPositionsOfNonZerosInPivotColumn removeFirst].
	markowitzPivotColCount := rowPositionsOfNonZerosInPivotColumn size
]

{ #category : #accessing }
MbDGESpMatFullPvPosIC3 >> pivotRowLimits: array [ 
	pivotRowLimits := array
]

{ #category : #solution }
MbDGESpMatFullPvPosIC3 >> preSolve: aMatrix with: aVector saveOriginal: saveOriginal [ 
	super
		preSolve: aMatrix
		with: aVector
		saveOriginal: saveOriginal.
	pivotRowLimits := system isNil
				ifTrue: [Array with: m]
				ifFalse: [system pivotRowLimits].
	pivotRowLimit := 0
]

{ #category : #accessing }
MbDGESpMatFullPvPosIC3 >> system: object [ 
	system := object
]
