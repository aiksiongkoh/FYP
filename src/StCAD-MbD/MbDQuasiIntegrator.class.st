Class {
	#name : #MbDQuasiIntegrator,
	#superclass : #IntegratorInterface,
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'VisualWorks metadata' }
MbDQuasiIntegrator class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #run }
MbDQuasiIntegrator >> checkForDiscontinuity [
	"Check for discontinuity in (tpast,t] or [t,tpast) if integrating 
	backward."

	| t tprevious tstartNew discontinuityTypes |
	t := integrator t.
	tprevious := integrator tprevious.
	tstartNew := (direction * t) nextLargerNumber / direction.
	system partsJointsMotionsForcesTorquesDo: [:item | tstartNew := item checkForDynDiscontinuityBetween: tprevious and: tstartNew].
	direction * tstartNew > (direction * t)
		ifTrue: ["No discontinuity in step"
			^self]
		ifFalse: 
			[self checkForOutputThrough: tstartNew.
			self interpolateAt: tstartNew.
			system tstartPastsAddFirst: tstart.
			system tstart: tstartNew.
			system toutFirst: tout.
			discontinuityTypes := OrderedCollection new.
			system partsJointsMotionsForcesTorquesDo: [:item | item discontinuityAt: tstartNew addTypeTo: discontinuityTypes].
			DiscontinuityError signalWith: discontinuityTypes]
]

{ #category : #run }
MbDQuasiIntegrator >> checkForOutputThrough1: t [ 
	"Kinematic analysis is done at every tout."

	tend <= t ifTrue: [integrator continue: false].
	(tout - t) abs < 1.0d-12
		ifTrue: 
			[system output.
			tout := tout + hout]
]

{ #category : #run }
MbDQuasiIntegrator >> checkForOutputThrough2: t [ 
	"Kinematic analysis is done at every tout."

	tend - (0.1d * hout) <= t ifTrue: [integrator continue: false].
	(tout - t) abs < 1.0d-12
		ifTrue: 
			[system output.
			tout := tout + hout]
]

{ #category : #run }
MbDQuasiIntegrator >> checkForOutputThrough: t [ 
	"Kinematic analysis is done at every tout."

	direction * t <= (direction * (tend + (0.1d * direction * hout)))
		ifTrue: [(tout - t) abs < 1.0d-12
				ifTrue: 
					[system output.
					tout := tout + (direction * hout)]]
		ifFalse: [integrator continue: false]
]

{ #category : #run }
MbDQuasiIntegrator >> incrementTime: aDouble [ 
	system partsJointsMotionsForcesTorquesDo: [:item | item storeDynState].
	system time: aDouble
]

{ #category : #'initialize-release' }
MbDQuasiIntegrator >> initialize [
	super initialize.
	integrator := MbDBasicQuasiIntegrator new.
	integrator system: self
]

{ #category : #run }
MbDQuasiIntegrator >> interpolateAt: tArg [ 
	"Interpolate for system state at tArg and leave system in that state."

	system time: tArg.
	self runInitialConditionTypeSolution
]

{ #category : #run }
MbDQuasiIntegrator >> postFirstStep [
	system partsJointsMotionsForcesTorquesDo: [:item | item postDynFirstStep].
	integrator istep > 0 ifTrue: ["Noise make checking at the start unreliable."
		self checkForDiscontinuity].
	self checkForOutputThrough: integrator t
]

{ #category : #run }
MbDQuasiIntegrator >> postRun [
	system partsJointsMotionsForcesTorquesDo: [:item | item postDyn]
]

{ #category : #run }
MbDQuasiIntegrator >> postStep [
	system partsJointsMotionsForcesTorquesDo: [:item | item postDynStep].
	integrator istep > 0 ifTrue: ["Noise make checking at the start unreliable."
		self checkForDiscontinuity].
	self checkForOutputThrough: integrator t
]

{ #category : #run }
MbDQuasiIntegrator >> preFirstStep [
	system partsJointsMotionsForcesTorquesDo: [:item | item preDynFirstStep]
]

{ #category : #run }
MbDQuasiIntegrator >> preRun [
	system partsJointsMotionsForcesTorquesDo: [:item | item preDyn]
]

{ #category : #run }
MbDQuasiIntegrator >> preStep [
	system partsJointsMotionsForcesTorquesDo: [:item | item preDynStep]
]

{ #category : #run }
MbDQuasiIntegrator >> reportStats [
	"Do nothing."
]

{ #category : #run }
MbDQuasiIntegrator >> run [
	
	[
	[[super run] on: SingularMatrixError
		do: 
			[:ex | 
			self logString: #'MbD: \Solver has encountered a singular matrix.'.
			self 
				logString: #'MbD: \Check to see if a massless or a very low mass part is under constrained.'.
			self 
				logString: #'MbD: \Check to see if the system is in a locked position.'.
			self 
				logString: #'MbD: \Check to see if the error tolerance is too demanding.'.
			self 
				logString: #'MbD: \Check to see if a curve-curve is about to have multiple contact points.'.
			SimulationStoppingError raiseSignal]] 
			on: TooSmallStepSizeError
			do: 
				[:ex | 
				self 
					logString: #'MbD: \Step size is prevented from going below the user specified minimum.'.
				self 
					logString: #'MbD: \Check to see if the system is in a locked position.'.
				self 
					logString: #'MbD: \Check to see if a curve-curve is about to have multiple contact points.'.
				self 
					logString: #'MbD: \If they are not, lower the permitted minimum step size.'.
				SimulationStoppingError raiseSignal]] 
			on: TooManyTriesError
			do: 
				[:ex | 
				self 
					logString: #'MbD: \Check to see if the error tolerance is too demanding.'.
				SimulationStoppingError raiseSignal]
]

{ #category : #run }
MbDQuasiIntegrator >> runInitialConditionTypeSolution [
	self subclassResponsibility
]

{ #category : #run }
MbDQuasiIntegrator >> suggestSmallerOrAcceptFirstStepSize: hnew [ 
	| hnew2 |
	hnew2 := hnew.
	system partsJointsMotionsForcesTorquesDo: [:item | hnew2 := item suggestSmallerOrAcceptDynFirstStepSize: hnew2].
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
MbDQuasiIntegrator >> suggestSmallerOrAcceptStepSize: hnew [ 
	| hnew2 |
	hnew2 := hnew.
	system partsJointsMotionsForcesTorquesDo: [:item | hnew2 := item suggestSmallerOrAcceptDynStepSize: hnew2].
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
MbDQuasiIntegrator >> useQuasiStepStats: stats [ 
	"Do nothing for now."
]

{ #category : #run }
MbDQuasiIntegrator >> useTrialStepStats: stats [ 
	system useDynTrialStepStats: stats
]
