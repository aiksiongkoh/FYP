Class {
	#name : #DAEIntegrator,
	#superclass : #IntegratorInterface,
	#instVars : [
		'neqn',
		'ncon'
	],
	#category : #'StCAD-Math-StMathIntegrator'
}

{ #category : #'VisualWorks metadata' }
DAEIntegrator class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #run }
DAEIntegrator >> checkForDiscontinuity [
	system checkForDiscontinuity
]

{ #category : #run }
DAEIntegrator >> checkForOutputThrough: t [ 
	"Inclusive of t."

	| tlimit thereIsOutput yout ydotout yddotout |
	tlimit := t.
	thereIsOutput := false.
	direction * tend <= (direction * tlimit)
		ifTrue: 
			[integrator continue: false.
			tlimit := tend + (0.1d * direction * hout)].
	[direction * tout <= (direction * tlimit)]
		whileTrue: 
			[thereIsOutput := true.
			yout := integrator yDeriv: 0 at: tout.
			ydotout := integrator yDeriv: 1 at: tout.
			yddotout := integrator yDeriv: 2 at: tout.
			system time: tout.
			system y: yout.
			system ydot: ydotout.
			system yddot: yddotout.
			self preDAEOutput.
			system output.
			tout := tout + (direction * hout)].
	thereIsOutput
		ifTrue: 
			["Reset system to integrator time."
			system time: integrator t.
			system y: integrator y.
			system ydot: integrator ydot.
			self postDAEOutput]
]

{ #category : #run }
DAEIntegrator >> fillF: col [ 
	^system fillF: col
]

{ #category : #run }
DAEIntegrator >> fillY: aColumn [ 
	^system fillY: aColumn
]

{ #category : #run }
DAEIntegrator >> fillYdot: aColumn [ 
	^system fillYdot: aColumn
]

{ #category : #run }
DAEIntegrator >> fillpFpy: matrix [ 
	^system fillpFpy: matrix
]

{ #category : #run }
DAEIntegrator >> fillpFpydot: mat [ 
	^system fillpFpydot: mat
]

{ #category : #'initialize-release' }
DAEIntegrator >> initialize [
	super initialize.
	statistics := IdentityDictionary new.
	integrator := StartingBasicDAEIntegrator new.
	integrator system: self
]

{ #category : #'initialize-release' }
DAEIntegrator >> initializeGlobally [
	super initializeGlobally.
	neqn := system neqn
]

{ #category : #accessing }
DAEIntegrator >> iterMax [
	^system iterMax
]

{ #category : #accessing }
DAEIntegrator >> neqn [
	^neqn
]

{ #category : #run }
DAEIntegrator >> postDAECorrector [
	system postDAECorrector
]

{ #category : #run }
DAEIntegrator >> postDAECorrectorIteration [
	system postDAECorrectorIteration
]

{ #category : #run }
DAEIntegrator >> postDAEFirstStep [
	system postDAEFirstStep
]

{ #category : #run }
DAEIntegrator >> postDAEOutput [
	system postDAEOutput
]

{ #category : #run }
DAEIntegrator >> postDAEPredictor [
	system postDAEPredictor
]

{ #category : #run }
DAEIntegrator >> postDAEStep [
	system postDAEStep.
	integrator istep > 0 ifTrue: ["Noise make checking at the start unreliable."
		self checkForDiscontinuity].
	self checkForOutputThrough: integrator t
]

{ #category : #run }
DAEIntegrator >> postRun [
	system postDAEIntegrator
]

{ #category : #run }
DAEIntegrator >> preDAECorrector [
	system preDAECorrector
]

{ #category : #run }
DAEIntegrator >> preDAECorrectorIteration [
	system preDAECorrectorIteration
]

{ #category : #run }
DAEIntegrator >> preDAEFirstStep [
	system preDAEFirstStep
]

{ #category : #run }
DAEIntegrator >> preDAEOutput [
	system preDAEOutput
]

{ #category : #run }
DAEIntegrator >> preDAEPredictor [
	system preDAEPredictor
]

{ #category : #run }
DAEIntegrator >> preDAEStep [
	system preDAEStep
]

{ #category : #run }
DAEIntegrator >> preRun [
	system preDAEIntegrator
]

{ #category : #run }
DAEIntegrator >> reportStats [
	system useDAEStats: statistics
]

{ #category : #run }
DAEIntegrator >> suggestSmallerOrAcceptFirstStepSize: hnew [ 
	| hnew2 |
	hnew2 := system suggestSmallerOrAcceptFirstStepSize: hnew.
	hnew2 > hmax
		ifTrue: 
			[hnew2 := hmax.
			self logString: #'StM: \Step size is at user specified maximum.'].
	hnew2 < hmin
		ifTrue: 
			[self logString: #'StM: \Step size %1 < %2 user specified minimum.' withArguments: (Array with: hnew2 asFloat printString with: hmin asFloat printString).
			TooSmallStepSizeError raiseSignal].
	^hnew2
]

{ #category : #run }
DAEIntegrator >> suggestSmallerOrAcceptStepSize: hnew [ 
	| hnew2 |
	hnew2 := system suggestSmallerOrAcceptStepSize: hnew.
	hnew2 > hmax
		ifTrue: 
			[hnew2 := hmax.
			self logString: #'StM: \Step size is at user specified maximum.'].
	hnew2 < hmin
		ifTrue: 
			[self logString: #'StM: \Step size %1 < %2 user specified minimum.' withArguments: (Array with: hnew2 asFloat printString with: hmin asFloat printString).
			TooSmallStepSizeError raiseSignal].
	^hnew2
]

{ #category : #accessing }
DAEIntegrator >> t: aDouble [ 
	^system t: aDouble
]

{ #category : #accessing }
DAEIntegrator >> time: aDouble [ 
	^system time: aDouble
]

{ #category : #accessing }
DAEIntegrator >> tnew: aDouble [ 
	self halt: 'Check if used.'.
	^system tnew: aDouble
]

{ #category : #run }
DAEIntegrator >> updateForDAECorrector [
	system updateForDAECorrector
]

{ #category : #run }
DAEIntegrator >> useDAEStepStats: stats [ 
	system useDAEStepStats: stats
]

{ #category : #run }
DAEIntegrator >> useTrialStepStats: stats [ 
	system useDAETrialStepStats: stats
]

{ #category : #accessing }
DAEIntegrator >> y [
	^system y
]

{ #category : #accessing }
DAEIntegrator >> y: aColumn [ 
	^system y: aColumn
]

{ #category : #accessing }
DAEIntegrator >> ydot [
	^system ydot
]

{ #category : #accessing }
DAEIntegrator >> ydot: aColumn [ 
	^system ydot: aColumn
]
