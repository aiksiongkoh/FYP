Class {
	#name : #MbDAccKineNewtonRaphson2,
	#superclass : #MbDAccNewtonRaphson2,
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'VisualWorks metadata' }
MbDAccKineNewtonRaphson2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'initialize-release' }
MbDAccKineNewtonRaphson2 >> initializeGlobally [
	super initializeGlobally.
	iterMax := system iterMaxAccKine.
	dxTol := system errorTolAccKine
]

{ #category : #solving }
MbDAccKineNewtonRaphson2 >> preRun [
	system logString: #'MbD: \Solving for kinematic acceleration.'.
	super preRun
]
