Class {
	#name : #IntegratorInterface,
	#superclass : #Integrator,
	#instVars : [
		'tout',
		'hout',
		'hmin',
		'hmax',
		'tstart',
		'tend',
		'integrator'
	],
	#category : #'StCAD-Math-StMathIntegrator'
}

{ #category : #accessing }
IntegratorInterface >> changeTime: aDouble [ 
	system time: aDouble
]

{ #category : #run }
IntegratorInterface >> checkForDiscontinuity [
	self subclassResponsibility
]

{ #category : #run }
IntegratorInterface >> checkForOutputThrough: t [ 
	self subclassResponsibility
]

{ #category : #run }
IntegratorInterface >> correctorAbsoluteTolerance [
	^system correctorAbsoluteTolerance
]

{ #category : #run }
IntegratorInterface >> correctorRelativeTolerance [
	^system correctorRelativeTolerance
]

{ #category : #accessing }
IntegratorInterface >> hmax [
	^hmax
]

{ #category : #accessing }
IntegratorInterface >> hmax: aDouble [ 
	hmax := aDouble
]

{ #category : #accessing }
IntegratorInterface >> hmin [
	^hmin
]

{ #category : #accessing }
IntegratorInterface >> hmin: aDouble [ 
	hmin := aDouble
]

{ #category : #accessing }
IntegratorInterface >> hout [
	^hout
]

{ #category : #accessing }
IntegratorInterface >> hout: aDouble [ 
	hout := aDouble
]

{ #category : #run }
IntegratorInterface >> incrementTime: aDouble [ 
	system time: aDouble
]

{ #category : #'initialize-release' }
IntegratorInterface >> initializeGlobally [
	tstart := system startTime.
	self hout: system outputStepSize.
	hmax := system maxStepSize.
	hmin := system minStepSize.
	tout := system firstOutputTime.
	tend := system endTime.
	direction := tstart < tend
				ifTrue: [1.0d]
				ifFalse: [-1.0d]
]

{ #category : #run }
IntegratorInterface >> integrationAbsoluteTolerance [
	^system integrationAbsoluteTolerance
]

{ #category : #run }
IntegratorInterface >> integrationRelativeTolerance [
	^system integrationRelativeTolerance
]

{ #category : #run }
IntegratorInterface >> interpolateAt: tArg [ 
	"Interpolate for system state at tArg and leave system in that state."

	| yout ydotout yddotout |
	yout := integrator yDeriv: 0 at: tArg.
	ydotout := integrator yDeriv: 1 at: tArg.
	yddotout := integrator yDeriv: 2 at: tArg.
	system time: tArg.
	system y: yout.
	system ydot: ydotout.
	system yddot: yddotout.
	system simUpdateAll
]

{ #category : #accessing }
IntegratorInterface >> istep [
	^integrator istep
]

{ #category : #accessing }
IntegratorInterface >> opBDF [
	^integrator opBDF
]

{ #category : #accessing }
IntegratorInterface >> orderMax [
	^system orderMax
]

{ #category : #run }
IntegratorInterface >> postFirstStep [
	system postFirstStep.
	integrator istep > 0 ifTrue: ["Noise make checking at the start unreliable."
		self checkForDiscontinuity].
	self checkForOutputThrough: integrator t
]

{ #category : #run }
IntegratorInterface >> postRun [
	"system postRun"

	self subclassResponsibility
]

{ #category : #run }
IntegratorInterface >> postStep [
	system postStep.
	integrator istep > 0 ifTrue: ["Noise make checking at the start unreliable."
		self checkForDiscontinuity].
	self checkForOutputThrough: integrator t
]

{ #category : #run }
IntegratorInterface >> preRun [
	"system preRun"

	self subclassResponsibility
]

{ #category : #run }
IntegratorInterface >> reportStats [
	self subclassResponsibility
]

{ #category : #run }
IntegratorInterface >> run [
	self preRun.
	self initializeLocally.
	self initializeGlobally.
	(hout > MachineAccuracy OfDoubleTimesFour and: [direction * tout < (direction * (tend + (0.1d * direction * hout)))])
		ifTrue: [integrator run].
	self finalize.
	self reportStats.
	self postRun
]

{ #category : #run }
IntegratorInterface >> suggestSmallerOrAcceptFirstStepSize: hnew [ 
	self subclassResponsibility
]

{ #category : #run }
IntegratorInterface >> suggestSmallerOrAcceptStepSize: hnew [ 
	self subclassResponsibility
]

{ #category : #accessing }
IntegratorInterface >> time [
	^integrator t
]

{ #category : #accessing }
IntegratorInterface >> tout [
	^tout
]

{ #category : #accessing }
IntegratorInterface >> tstart [
	^tstart
]
