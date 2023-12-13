Class {
	#name : #GEFullMatFullPv,
	#superclass : #GEFullMat,
	#category : #'StCAD-Math-StMathMatrixSolver'
}

{ #category : #testing }
GEFullMatFullPv class >> isAbstractClass [
	^false
]

{ #category : #'VisualWorks metadata' }
GEFullMatFullPv class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #solution }
GEFullMatFullPv >> applyColOrderOnAnswerX [
	| answer |
	answer := answerX class new: n.
	1 to: n do: [:i | answer at: (colOrder at: i) put: (answerX at: i)].
	answerX := answer
]

{ #category : #pivoting }
GEFullMatFullPv >> doPivoting: p [ 
	"Do full pivoting."

	| max pivotRow pivotCol rowi aij mag |
	max := 0.
	pivotRow := p.
	pivotCol := p.
	p to: m
		do: 
			[:i | 
			rowi := matrixA at: i.
			p to: n
				do: 
					[:j | 
					aij := rowi at: j.
					aij = 0
						ifFalse: 
							[mag := aij.
							mag < 0 ifTrue: [mag := 0.0d - mag].
							mag > max
								ifTrue: 
									[max := mag.
									pivotRow := i.
									pivotCol := j]]]].
	p == pivotRow
		ifFalse: 
			[matrixA swap: p with: pivotRow.
			rightHandSideB swap: p with: pivotRow.
			rowOrder swap: p with: pivotRow].
	p == pivotCol
		ifFalse: 
			[matrixA do: [:row | row swap: p with: pivotCol].
			colOrder swap: p with: pivotCol].
	pivotValues at: p put: max.
	max < singularPivotTolerance ifTrue: [SingularMatrixError raiseSignal]
]

{ #category : #solution }
GEFullMatFullPv >> postSolve [
	self applyColOrderOnAnswerX.
	super postSolve
]
