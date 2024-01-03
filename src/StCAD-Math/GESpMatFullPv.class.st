"
Full Pivoting.

Instance Variables:

positionsOfOriginalCols	<StMArray>	given an original column number as index, answer the current column position.
rowPositionsOfNonZerosInColumns	<StMArray of OrderedCollection>	
"
Class {
	#name : #GESpMatFullPv,
	#superclass : #GESpMat,
	#instVars : [
		'positionsOfOriginalCols',
		'rowPositionsOfNonZerosInColumns'
	],
	#category : #'StCAD-Math-StMathMatrixSolver'
}

{ #category : #'back substitution' }
GESpMatFullPv >> backSubstituteIntoDU [
	"Use colOrder to get DU in upper triangular with nonzero diagonals."
	"Formula given by Eqn. 9.26 and 9.27 in Chapra's text 2nd Edition."

	| jn rowi rowiValues count index diagonalFound jj duij j sum duii ji rhsZeroElement |
	answerX := rightHandSideB class new: n.
	jn := colOrder at: n.
	answerX at: jn put: (rightHandSideB at: m)
			/ (matrixA at: m and: jn).
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
					[jj := rowi basicAt: index.
					jj == nil
						ifFalse: 
							[duij := rowiValues basicAt: index.
							j := positionsOfOriginalCols at: jj.
							j > i
								ifTrue: 
									[count := count + 1.
									sum := sum + ((answerX at: jj)
													* duij)]
								ifFalse: 
									[diagonalFound := true.
									duii := duij]].
					index := index + 1].
			[count < markowitzPivotRowCount]
				whileTrue: 
					[jj := rowi basicAt: index.
					jj == nil
						ifFalse: 
							[duij := rowiValues basicAt: index.
							count := count + 1.
							sum := sum + ((answerX at: jj)
											* duij)].
					index := index + 1].
			ji := colOrder at: i.
			answerX at: ji put: (rightHandSideB at: i)
					- sum / duii]
]

{ #category : #pivoting }
GESpMatFullPv >> doPivoting: p [ 
	"Used by Gauss Elimination only."
	"Do full pivoting."
	"Swap rows but keep columns in place."
	"The elements below the diagonal are removed column by column."

	| max pivotRow pivotCol rowi rowiValues nNonZeros count index jj aij mag jp |
	max := 0.0d.
	pivotRow := p.
	pivotCol := p.
	p to: n do: [:j | (rowPositionsOfNonZerosInColumns at: (colOrder at: j)) setIndices].
	p to: m do: [:i | 
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
							(rowPositionsOfNonZerosInColumns at: jj) add: i.
							aij := rowiValues at: index.
							mag := aij.
							mag < 0 ifTrue: [mag := 0.0d - mag].
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
	max < singularPivotTolerance ifTrue: [SingularMatrixError raiseSignal].
	jp := colOrder at: p.
	rowPositionsOfNonZerosInPivotColumn := rowPositionsOfNonZerosInColumns at: jp.
	rowPositionsOfNonZerosInPivotColumn first == p ifTrue: [rowPositionsOfNonZerosInPivotColumn removeFirst].
	markowitzPivotColCount := rowPositionsOfNonZerosInPivotColumn size
]

{ #category : #'forward elimination' }
GESpMatFullPv >> forwardEliminateWithPivot: p [ 
	"
	app is pivot. 
	i > p , j > p 
	aip is eliminated. 
	apj can cause fill-in. 
	Columns are in place. 
	"
	"rightHandSideB may be multidimensional."

	| jp rowp app bp rowi aip jIndex jj apj rowpValues i |
	jp := colOrder at: p.
	rowp := matrixA at: p.
	rowpValues := rowp valueArray.
	app := rowp at: jp.
	bp := rightHandSideB at: p.
	self privateIndicesOfNonZerosInPivotRow: rowp withoutKey: jp.
	1 to: markowitzPivotColCount
		do: 
			[:idum | 
			i := rowPositionsOfNonZerosInPivotColumn at: idum.
			rowi := matrixA at: i.
			aip := rowi removeKey: jp.
			aip == nil
				ifFalse: 
					[| factor |
					factor := aip / app.
					1 to: markowitzPivotRowCount
						do: 
							[:index | 
							jIndex := privateIndicesOfNonZerosInPivotRow at: index.
							jj := rowp basicAt: jIndex.
							apj := rowpValues at: jIndex.
							rowi at: jj minusNumber: factor * apj].
					rightHandSideB at: i put: (rightHandSideB at: i)
							- (bp * factor)]]
]

{ #category : #solution }
GESpMatFullPv >> postSolve [
	"Do nothing because column pivoting is done in-place."
	"Column pivoting is recorded but not carried out."
]

{ #category : #solution }
GESpMatFullPv >> preSolve: aMatrix with: aVector saveOriginal: saveOriginal [ 
	"A conditioned copy of aMatrix is solved."

	| rowi maxRowElement |
	(m == aMatrix nrow and: [n == aMatrix ncol]) 
		ifFalse: 
			[m := aMatrix nrow.
			n := aMatrix ncol.
			matrixA := SparseMatrix new: m.
			pivotValues := FullColumn new: m.
			rowOrder := MathArray new: m.
			colOrder := MathArray new: m.
			positionsOfOriginalCols := MathArray new: m.
			privateIndicesOfNonZerosInPivotRow := OrderedCollection new.
			rowPositionsOfNonZerosInColumns := MathArray new: n.
			1 to: n
				do: [:j | rowPositionsOfNonZerosInColumns at: j put: OrderedCollection new]].
	rightHandSideB := saveOriginal ifTrue: [aVector copy] ifFalse: [aVector].
	1 to: m
		do: 
			[:i | 
			rowi := (aMatrix at: i) asSparseRow.
			maxRowElement := rowi maxElement.
			maxRowElement > 0 ifFalse: [SingularMatrixError raiseSignal].
			matrixA at: i
				put: (rowi conditionedWithTol: singularPivotTolerance * maxRowElement).
			rowOrder at: i put: i.
			colOrder at: i put: i.
			positionsOfOriginalCols at: i put: i]
]
