Class {
	#name : #VectorNewtonRaphson2,
	#superclass : #VectorNewtonRaphson,
	#instVars : [
		'n'
	],
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'class initialization' }
VectorNewtonRaphson2 class >> initSignals [
	NotKinematicError notifierString: #'MbD: System is not pure kinematic.'; nameClass: self message: #notKinematicError
]

{ #category : #'class initialization' }
VectorNewtonRaphson2 class >> initialize [
	"MbDVectorNewtonRaphson2 initialize."

	self initSignals
]

{ #category : #'VisualWorks metadata' }
VectorNewtonRaphson2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.Math'
	)

]

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
