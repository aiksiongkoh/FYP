Class {
	#name : #BasicIntegrator,
	#superclass : #Integrator,
	#instVars : [
		'istep',
		'iTry',
		'maxTry',
		'tpast',
		't',
		'tnew',
		'h',
		'hnew',
		'order',
		'orderNew',
		'orderMax',
		'opBDF',
		'continue'
	],
	#category : #'StCAD-Math-StMathIntegrator'
}

{ #category : #'VisualWorks metadata' }
BasicIntegrator class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #run }
BasicIntegrator >> calcOperatorMatrix [
	opBDF calcOperatorMatrix
]

{ #category : #accessing }
BasicIntegrator >> continue: boolean [ 
	continue := boolean
]

{ #category : #accessing }
BasicIntegrator >> iStep: integer [ 
	istep := integer.
	opBDF iStep: integer
]

{ #category : #run }
BasicIntegrator >> incrementTime [
	| istepNew |
	tpast addFirst: t.
	tpast size > (orderMax + 1) ifTrue: [tpast removeLast].
	istepNew := istep + 1.
	self iStep: istepNew.
	self order: orderNew.
	h := hnew.
	self tnew: t + (direction * h).
	self calcOperatorMatrix.
	system incrementTime: tnew
]

{ #category : #run }
BasicIntegrator >> incrementTry [
	iTry := iTry + 1
]

{ #category : #'initialize-release' }
BasicIntegrator >> initialize [
	super initialize.
	statistics := IdentityDictionary new.
	tpast := OrderedCollection new.
	opBDF := StableBackwardDifference new.
	opBDF timeNodes: tpast
]

{ #category : #'initialize-release' }
BasicIntegrator >> initializeGlobally [
	"Get info from system and prepare for start of simulation."
	"Integrator asks system for info. Not system setting integrator."

	self t: system tstart.
	self direction: system direction.
	self orderMax: system orderMax
]

{ #category : #'initialize-release' }
BasicIntegrator >> initializeLocally [
	continue := true
]

{ #category : #accessing }
BasicIntegrator >> istep [
	^istep
]

{ #category : #accessing }
BasicIntegrator >> opBDF [
	^opBDF
]

{ #category : #accessing }
BasicIntegrator >> order: integer [ 
	order := integer.
	opBDF order: integer
]

{ #category : #accessing }
BasicIntegrator >> orderMax: integer [ 
	integer == nil
		ifTrue: [orderMax := 5]
		ifFalse: [orderMax := integer asInteger]
]

{ #category : #run }
BasicIntegrator >> postFirstStep [
	t := tnew.
	system postFirstStep
]

{ #category : #run }
BasicIntegrator >> postRun [
	"Do nothing."
]

{ #category : #run }
BasicIntegrator >> postStep [
	t := tnew.
	system postStep
]

{ #category : #run }
BasicIntegrator >> preFirstStep [
	system preFirstStep
]

{ #category : #run }
BasicIntegrator >> preRun [
	"Do nothing."
]

{ #category : #run }
BasicIntegrator >> preStep [
	system preStep
]

{ #category : #run }
BasicIntegrator >> reportStats [
	"Do nothing."
]

{ #category : #run }
BasicIntegrator >> run [
	self preRun.
	self initializeLocally.
	self initializeGlobally.
	self firstStep.
	self subsequentSteps.
	self finalize.
	self reportStats.
	self postRun
]

{ #category : #run }
BasicIntegrator >> selectOrder [
	"Increase order consecutively with step."

	iTry == 1 ifTrue: [orderNew := istep + 1 min: orderMax]
]

{ #category : #run }
BasicIntegrator >> subsequentSteps [
	[continue]
		whileTrue: [self nextStep]
]

{ #category : #accessing }
BasicIntegrator >> t [
	^t
]

{ #category : #accessing }
BasicIntegrator >> t: double [ 
	t := double.
	self time: double
]

{ #category : #accessing }
BasicIntegrator >> time: double [ 
	opBDF time: double
]

{ #category : #accessing }
BasicIntegrator >> tnew: double [ 
	tnew := double.
	self time: double
]

{ #category : #accessing }
BasicIntegrator >> tprevious [
	^tpast at: 1
]
