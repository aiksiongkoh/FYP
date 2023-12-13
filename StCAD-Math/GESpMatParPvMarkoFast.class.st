Class {
	#name : #GESpMatParPvMarkoFast,
	#superclass : #GESpMatParPvMarko,
	#category : #'StCAD-Math-StMathMatrixSolver'
}

{ #category : #'VisualWorks metadata' }
GESpMatParPvMarkoFast class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #pivoting }
GESpMatParPvMarkoFast >> doPivoting: p [ 
	"Search from bottom to top."
	"Optimized for speed. No check for singular pivot."
	"Do partial pivoting."
	"criterion := mag / (2.0d raisedTo: rowiCount)."
	"Rows are explicitly scaled in preSolve:."
	"Pivot size are nieither checked nor stored."

	| lookForFirstNonZeroInPivotCol i rowi aip criterionMax rowPivot criterion max |
	rowPositionsOfNonZerosInPivotColumn setIndices.
	lookForFirstNonZeroInPivotCol := true.
	i := m.
	[lookForFirstNonZeroInPivotCol]
		whileTrue: 
			[rowi := matrixA at: i.
			aip := rowi at: p.
			aip == nil
				ifTrue: [i > p ifFalse: [SingularMatrixError raiseSignal]]
				ifFalse: 
					[markowitzPivotColCount := 0.
					aip < 0 ifTrue: [aip := 0.0d - aip].
					max := aip.
					criterionMax := aip / (2.0d raisedTo: rowi tally).
					rowPivot := i.
					lookForFirstNonZeroInPivotCol := false].
			i := i - 1].
	[i >= p]
		whileTrue: 
			[rowi := matrixA at: i.
			aip := rowi at: p.
			aip == nil
				ifFalse: 
					[markowitzPivotColCount := markowitzPivotColCount + 1.
					aip < 0 ifTrue: [aip := 0.0d - aip].
					criterion := aip / (2.0d raisedTo: rowi tally).
					criterion > criterionMax
						ifTrue: 
							[max := aip.
							criterionMax := criterion.
							rowPositionsOfNonZerosInPivotColumn add: rowPivot.
							rowPivot := i]
						ifFalse: [rowPositionsOfNonZerosInPivotColumn add: i]].
			i := i - 1].
	p == rowPivot
		ifFalse: 
			[matrixA swap: p with: rowPivot.
			rightHandSideB swap: p with: rowPivot.
			aip == nil ifFalse: [rowPositionsOfNonZerosInPivotColumn at: markowitzPivotColCount put: rowPivot]].
	max < singularPivotTolerance ifTrue: [SingularMatrixError raiseSignal]
]

{ #category : #solution }
GESpMatParPvMarkoFast >> preSolve: aMatrix with: aVector saveOriginal: saveOriginal [ 
	"Optimized for speed."

	| rowi maxRowElement scaling |
	(m == aMatrix nrow and: [n == aMatrix ncol]) 
		ifFalse: 
			[m := aMatrix nrow.
			n := aMatrix ncol.
			matrixA := SparseMatrix new: m.
			privateIndicesOfNonZerosInPivotRow := OrderedCollection new.
			rowPositionsOfNonZerosInPivotColumn := OrderedCollection new].
	rightHandSideB := saveOriginal ifTrue: [aVector copy] ifFalse: [aVector].
	1 to: m
		do: 
			[:i | 
			rowi := (aMatrix at: i) asSparseRow.
			maxRowElement := rowi maxElement.
			maxRowElement > 0 ifFalse: [SingularMatrixError raiseSignal].
			scaling := 1.0d / maxRowElement.
			matrixA at: i
				put: (rowi times: scaling conditionedWithTol: singularPivotTolerance).
			rightHandSideB at: i times: scaling]
]
