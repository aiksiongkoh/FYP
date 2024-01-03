Class {
	#name : #ScalarNewtonRaphson,
	#superclass : #NewtonRaphson,
	#category : #'StCAD-Math-StMathNewtonRaphson'
}

{ #category : #solving }
ScalarNewtonRaphson >> calcdxNorm [
	"Subclasses can modify calculation of dxNorm."

	dxNorm := dx abs
]

{ #category : #solving }
ScalarNewtonRaphson >> calcyNorm [
	"Subclasses can modify calculation of yNorm."

	yNorm := 0.5 * y * y
]

{ #category : #solving }
ScalarNewtonRaphson >> dxEqualdxTimeslam [
	dx := dx * lam.
	super dxEqualdxTimeslam
]

{ #category : #solving }
ScalarNewtonRaphson >> fillPyPx [
	pypx := system pypx
]

{ #category : #solving }
ScalarNewtonRaphson >> fillY [
	y := system y
]

{ #category : #'initialize-release' }
ScalarNewtonRaphson >> initializeGlobally [
	x := system x
]

{ #category : #solving }
ScalarNewtonRaphson >> solveEquations [
	dx := 0.0d - y / pypx
]

{ #category : #solving }
ScalarNewtonRaphson >> xEqualxoldPlusdx [
	x := xold + dx
]

{ #category : #solving }
ScalarNewtonRaphson >> xEqualxoldPlusdxTimeslam [
	x := xold + (dx * lam)
]
