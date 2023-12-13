Class {
	#name : #'MbD_ICKineIntegrator',
	#superclass : #MbDQuasiIntegrator,
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'VisualWorks metadata' }
MbD_ICKineIntegrator class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

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
