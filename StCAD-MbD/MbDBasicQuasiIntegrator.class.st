Class {
	#name : #MbDBasicQuasiIntegrator,
	#superclass : #BasicIntegrator,
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'VisualWorks metadata' }
MbDBasicQuasiIntegrator class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #run }
MbDBasicQuasiIntegrator >> firstStep [
	istep := 0.
	self preFirstStep.
	iTry := 1.
	orderNew := 1.
	self selectFirstStepSize.
	self incrementTime.
	self runInitialConditionTypeSolution.
	self reportTrialStepStats.
	[self isRedoingFirstStep]
		whileTrue: 
			[self incrementTry.
			orderNew := 1.
			self selectFirstStepSize.
			self changeTime.
			self runInitialConditionTypeSolution.
			self reportTrialStepStats].
	self postFirstStep.
	self reportStepStats
]

{ #category : #run }
MbDBasicQuasiIntegrator >> isRedoingFirstStep [
	^false
]

{ #category : #run }
MbDBasicQuasiIntegrator >> isRedoingStep [
	^false
]

{ #category : #run }
MbDBasicQuasiIntegrator >> nextStep [
	self preStep.
	iTry := 1.
	self selectOrder.
	self selectStepSize.
	self incrementTime.
	self runInitialConditionTypeSolution.
	self reportTrialStepStats.
	[self isRedoingStep] whileTrue: 
			[self incrementTry.
			self selectOrder.
			self selectStepSize.
			self changeTime.
			self runInitialConditionTypeSolution.
			self reportTrialStepStats].
	self postStep.
	self reportStepStats
]

{ #category : #run }
MbDBasicQuasiIntegrator >> reportStepStats [
	system useQuasiStepStats: statistics
]

{ #category : #run }
MbDBasicQuasiIntegrator >> reportTrialStepStats [
	statistics at: #istep put: istep.
	statistics at: #t put: t.
	statistics at: #h put: direction * h.
	system useTrialStepStats: statistics
]

{ #category : #run }
MbDBasicQuasiIntegrator >> runInitialConditionTypeSolution [
	system runInitialConditionTypeSolution
]

{ #category : #run }
MbDBasicQuasiIntegrator >> selectFirstStepSize [
	iTry == 1
		ifTrue: [hnew := direction * (system tout - t)]
		ifFalse: [hnew := 0.25d * h].
	hnew := system suggestSmallerOrAcceptFirstStepSize: hnew
]

{ #category : #run }
MbDBasicQuasiIntegrator >> selectStepSize [
	iTry == 1
		ifTrue: [hnew := direction * (system tout - t)]
		ifFalse: [hnew := 0.25d * h].
	hnew := system suggestSmallerOrAcceptStepSize: hnew
]
