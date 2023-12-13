Class {
	#name : #VectorNewtonRaphson,
	#superclass : #NewtonRaphson,
	#instVars : [
		'matrixSolver'
	],
	#category : #'StCAD-Math-StMathNewtonRaphson'
}

{ #category : #'VisualWorks metadata' }
VectorNewtonRaphson class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #solving }
VectorNewtonRaphson >> basicSolveEquations [
"	self toDebugTxtShowContextFrom: 1 to: 100."
	dx := matrixSolver 
				solve: pypx
				with: y negated
				saveOriginal: false
]

{ #category : #solving }
VectorNewtonRaphson >> calcdxNorm [
	"Subclasses can modify calculation of dxNorm."

	dxNorm := dx rootMeanSquare
]

{ #category : #solving }
VectorNewtonRaphson >> calcyNorm [
	"Subclasses can modify calculation of yNorm."

	yNorm := 0.5d * y sumOfSquares
]

{ #category : #solving }
VectorNewtonRaphson >> dxEqualdxTimeslam [
	dx magnifySelf: lam.
	super dxEqualdxTimeslam
]

{ #category : #solving }
VectorNewtonRaphson >> fillPyPx [
	system fillJacobian: pypx
]

{ #category : #solving }
VectorNewtonRaphson >> fillY [
	system fillErrorVector: y
]

{ #category : #solving }
VectorNewtonRaphson >> handleSingularMatrix [
	self error: 'Singular matrix encountered.'
]

{ #category : #'initialize-release' }
VectorNewtonRaphson >> initializeGlobally [
	system fillVarVector: x
]

{ #category : #accessing }
VectorNewtonRaphson >> matrixSolver: matSolver [ 
	matrixSolver := matSolver
]

{ #category : #accessing }
VectorNewtonRaphson >> matrixSolverClass [
	^GEFullMatParPv
]

{ #category : #accessing }
VectorNewtonRaphson >> pypx: mat [ 
	pypx := mat
]

{ #category : #solving }
VectorNewtonRaphson >> solveEquations [
	[self basicSolveEquations] on: SingularMatrixError
		do: [:ex | self handleSingularMatrix]
]

{ #category : #accessing }
VectorNewtonRaphson >> x: col [ 
	x := col asFullColumn
]

{ #category : #solving }
VectorNewtonRaphson >> xEqualxoldPlusdx [
	x := xold plusFullColumn: dx
]

{ #category : #solving }
VectorNewtonRaphson >> xEqualxoldPlusdxTimeslam [
	x := xold plusFullColumn: dx times: lam
]

{ #category : #accessing }
VectorNewtonRaphson >> y: col [ 
	y := col asFullColumn
]
