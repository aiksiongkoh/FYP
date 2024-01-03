Class {
	#name : #MbDQuasiIntegrator,
	#superclass : #IntegratorInterface,
	#category : #'StCAD-MbD-MbDSolver'
}

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
