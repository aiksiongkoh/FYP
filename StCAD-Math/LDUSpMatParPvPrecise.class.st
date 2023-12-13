Class {
	#name : #LDUSpMatParPvPrecise,
	#superclass : #LDUSpMatParPv,
	#category : #'StCAD-Math-StMathMatrixSolver'
}

{ #category : #testing }
LDUSpMatParPvPrecise class >> isAbstractClass [
	^false
]

{ #category : #'VisualWorks metadata' }
LDUSpMatParPvPrecise class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #pivoting }
LDUSpMatParPvPrecise >> doPivoting: p [ 
	"Search from bottom to top."
	"Do scaling and partial pivoting with actual swapping of rows."
	"Check for singular pivot."

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
			rowScalings swap: p with: rowPivot.
			rowOrder swap: p with: rowPivot.
			matrixL swap: p with: rowPivot.
			aip == nil ifFalse: [rowPositionsOfNonZerosInPivotColumn at: markowitzPivotColCount put: rowPivot]].
	pivotValues at: p put: max.
	max < singularPivotTolerance ifTrue: [SingularMatrixError raiseSignal]
]
