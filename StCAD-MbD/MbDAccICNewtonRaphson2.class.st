Class {
	#name : #MbDAccICNewtonRaphson2,
	#superclass : #MbDAccNewtonRaphson2,
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'VisualWorks metadata' }
MbDAccICNewtonRaphson2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #solving }
MbDAccICNewtonRaphson2 >> isConverged [
	^self isConvergedToNumericalLimit
]

{ #category : #solving }
MbDAccICNewtonRaphson2 >> preRun [
	system logString: #'MbD: \Solving for acceleration initial conditions.'.
	super preRun
]
