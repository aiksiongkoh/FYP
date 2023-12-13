Class {
	#name : #GEFullMatParPv,
	#superclass : #GEFullMat,
	#category : #'StCAD-Math-StMathMatrixSolver'
}

{ #category : #testing }
GEFullMatParPv class >> isAbstractClass [
	^false
]

{ #category : #'VisualWorks metadata' }
GEFullMatParPv class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #pivoting }
GEFullMatParPv >> doPivoting: p [ 
	"Use scalings. Do row pivoting."

	| app max rowPivot aip mag |
	app := (matrixA at: p) at: p.
	max := app * (rowScalings at: p).
	max < 0 ifTrue: [max := 0.0d - max].
	rowPivot := p.
	p + 1 to: m
		do: 
			[:i | 
			aip := (matrixA at: i) at: p.
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
			rightHandSideB swap: p with: rowPivot.
			rowScalings swap: p with: rowPivot.
			rowOrder swap: p with: rowPivot].
	pivotValues at: p put: max.
	max < singularPivotTolerance ifTrue: [SingularMatrixError raiseSignal]
]

{ #category : #solution }
GEFullMatParPv >> postSolve [
	"Do nothing."
]

{ #category : #solution }
GEFullMatParPv >> preSolve: aMatrix with: aVector saveOriginal: saveOriginal [ 
	super
		preSolve: aMatrix
		with: aVector
		saveOriginal: saveOriginal.
	(rowScalings == nil or: [rowScalings size ~= m])
		ifTrue: [self findScalingsForRows: 1 to: m]
]
