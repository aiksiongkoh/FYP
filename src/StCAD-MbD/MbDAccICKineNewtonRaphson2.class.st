Class {
	#name : #MbDAccICKineNewtonRaphson2,
	#superclass : #MbDAccNewtonRaphson2,
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'initialize-release' }
MbDAccICKineNewtonRaphson2 >> initializeGlobally [
	super initializeGlobally.
	iterMax := system iterMaxAccKine.
	dxTol := system errorTolAccKine
]

{ #category : #solving }
MbDAccICKineNewtonRaphson2 >> preRun [
	system logString: #'MbD: \Solving for quasi kinematic acceleration.'.
	super preRun
]
