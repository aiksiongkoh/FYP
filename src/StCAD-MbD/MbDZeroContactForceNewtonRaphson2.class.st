Class {
	#name : #MbDZeroContactForceNewtonRaphson2,
	#superclass : #MbDTimeNewtonRaphson2,
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #solving }
MbDZeroContactForceNewtonRaphson2 >> fillPyPx [
	pypx := system contactForceDerivative: 1 at: x
]

{ #category : #solving }
MbDZeroContactForceNewtonRaphson2 >> fillY [
	y := system contactForceAt: x
]
