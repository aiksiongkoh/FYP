Class {
	#name : #MbDKineIntegrator,
	#superclass : #MbDQuasiIntegrator,
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'VisualWorks metadata' }
MbDKineIntegrator class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #run }
MbDKineIntegrator >> preRun [
	system logString: #'MbD: \Starting kinematic analysis.'.
	super preRun
]

{ #category : #run }
MbDKineIntegrator >> runInitialConditionTypeSolution [
	system runPosKine.
	system runVelKine.
	system runAccKine
]

{ #category : #run }
MbDKineIntegrator >> useTrialStepStats: stats [ 
	system useKineTrialStepStats: stats
]
