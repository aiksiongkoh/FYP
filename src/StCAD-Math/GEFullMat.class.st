Class {
	#name : #GEFullMat,
	#superclass : #MatrixGaussElimination,
	#category : #'StCAD-Math-StMathMatrixSolver'
}

{ #category : #'VisualWorks metadata' }
GEFullMat class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'back substitution' }
GEFullMat >> backSubstituteIntoDU [
	"DU is upper triangular with nonzero and arbitrary diagonals."

	| rowi sum |
	answerX := rightHandSideB class new: n.
	answerX at: n put: (rightHandSideB at: m)
			/ (matrixA at: m and: n).
	n - 1
		to: 1
		by: -1
		do: 
			[:i | 
			rowi := matrixA at: i.
			sum := (answerX at: n)
						* (rowi at: n).
			i + 1 to: n - 1 do: [:j | sum := sum + ((answerX at: j)
								* (rowi at: j))].
			answerX at: i put: (rightHandSideB at: i)
					- sum / (rowi at: i)]
]

{ #category : #'forward elimination' }
GEFullMat >> forwardEliminateWithPivot: p [ 
	"Ignore elements below pivot. They should be zeros"
	"rightHandSideB may be multidimensional."

	| rowp app bp rowi aip factor |
	rowp := matrixA at: p.
	app := rowp at: p.
	bp := rightHandSideB at: p.
	p + 1 to: m
		do: 
			[:i | 
			rowi := matrixA at: i.
			aip := rowi at: p.
			aip = 0
				ifFalse: 
					[factor := aip / app.
					p + 1 to: n do: [:j | rowi at: j minusNumber: factor * (rowp at: j)].
					rightHandSideB at: i put: (rightHandSideB at: i)
							- (bp * factor)]]
]

{ #category : #solution }
GEFullMat >> postSolve [
	"Do nothing."
]

{ #category : #solution }
GEFullMat >> preSolve: aMatrix with: aVector saveOriginal: saveOriginal [ 
	saveOriginal 
		ifTrue: 
			[matrixA := aMatrix copy asFullMatrix.
			rightHandSideB := aVector copy]
		ifFalse: 
			[matrixA := aMatrix asFullMatrix.
			rightHandSideB := aVector].
	(m == matrixA nrow and: [n == matrixA ncol]) 
		ifFalse: 
			[m := matrixA nrow.
			n := matrixA ncol.
			pivotValues := FullColumn new: m.
			rowOrder := MathArray new: m.
			colOrder := MathArray new: n].
	m = n 
		ifTrue: 
			[1 to: m
				do: 
					[:i | 
					rowOrder at: i put: i.
					colOrder at: i put: i]]
		ifFalse: 
			[1 to: m do: [:i | rowOrder at: i put: i].
			1 to: n do: [:j | colOrder at: j put: j]]
]
