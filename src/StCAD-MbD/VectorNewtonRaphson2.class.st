Class {
	#name : #VectorNewtonRaphson2,
	#superclass : #VectorNewtonRaphson,
	#instVars : [
		'n'
	],
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #solving }
VectorNewtonRaphson2 >> fillPyPx [
	self subclassResponsibility
]

{ #category : #solving }
VectorNewtonRaphson2 >> fillY [
	self subclassResponsibility
]

{ #category : #solving }
VectorNewtonRaphson2 >> isConverged [
	^(dxNorms at: iterNo) < dxTol or: [self isConvergedToNumericalLimit]
]

{ #category : #solving }
VectorNewtonRaphson2 >> run [
	self preRun.
	self initializeLocally.
	self initializeGlobally.
	self iterate.
	self postRun.
	^x
]
