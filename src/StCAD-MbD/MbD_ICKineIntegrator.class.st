Class {
	#name : #'MbD_ICKineIntegrator',
	#superclass : #MbDQuasiIntegrator,
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #run }
MbD_ICKineIntegrator >> preRun [
	system logString: #'MbD: \Starting quasi kinematic analysis.'.
	super preRun
]

{ #category : #run }
MbD_ICKineIntegrator >> runInitialConditionTypeSolution [
	system runPosICKine.
	system runVelICKine.
	system runAccICKine
]
