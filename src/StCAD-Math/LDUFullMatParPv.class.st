Class {
	#name : #LDUFullMatParPv,
	#superclass : #LDUFullMat,
	#category : #'StCAD-Math-StMathMatrixSolver'
}

{ #category : #pivoting }
LDUFullMatParPv >> doPivoting: p [ 
	"Use scalings. Do row pivoting."

	| app max rowPivot aip mag |
	app := (matrixA at: p)
				at: p.
	max := app * (rowScalings at: p).
	max < 0 ifTrue: [max := 0.0d - max].
	rowPivot := p.
	p + 1 to: m
		do: 
			[:i | 
			aip := (matrixA at: i)
						at: p.
			aip = 0
				ifFalse: 
					[mag := aip * (rowScalings at: i).
					mag < 0 ifTrue: [mag := 0.0d - mag].
					mag > max
						ifTrue: 
							[max := mag.
							rowPivot := i]]].
	p == rowPivot
		ifFalse: 
			[matrixA swap: p with: rowPivot.
			rowScalings swap: p with: rowPivot.
			rowOrder swap: p with: rowPivot].
	pivotValues at: p put: max.
	max < singularPivotTolerance ifTrue: [SingularMatrixError raiseSignal]
]

{ #category : #'forward elimination' }
LDUFullMatParPv >> forwardEliminateWithPivot: p [ 
	"Save factors in lower triangle for LU decomposition."

	| rowp app rowi aip factor |
	rowp := matrixA at: p.
	app := rowp at: p.
	p + 1 to: m
		do: 
			[:i | 
			rowi := matrixA at: i.
			aip := rowi at: p.
			factor := aip / app.
			rowi at: p put: factor.
			factor = 0 ifFalse: [p + 1 to: n do: [:j | rowi at: j minusNumber: factor * (rowp at: j)]]]
]
