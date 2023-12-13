Class {
	#name : #MbDSystemSolver2,
	#superclass : #MbDSolver,
	#instVars : [
		'system',
		'parts',
		'jointsMotions',
		'forcesTorques',
		'sensors',
		'variables',
		'icTypeSolver',
		'setsOfRedundantConstraints',
		'errorTolPosKine',
		'errorTolAccKine',
		'iterMaxPosKine',
		'iterMaxAccKine',
		'basicIntegrator',
		'tstartPasts',
		'tstart',
		'hmin',
		'hmax',
		'tend',
		'toutFirst',
		'hout',
		'direction',
		'corAbsTol',
		'corRelTol',
		'intAbsTol',
		'intRelTol',
		'iterMaxDyn',
		'orderMax',
		'translationLimit',
		'rotationLimit'
	],
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'VisualWorks metadata' }
MbDSystemSolver2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDSystemSolver2 >> allConstraints [
	^system allConstraints
]

{ #category : #accessing }
MbDSystemSolver2 >> allRedundantConstraints [
	^system allRedundantConstraints
]

{ #category : #accessing }
MbDSystemSolver2 >> contactEndFrames [
	^system contactEndFrames
]

{ #category : #accessing }
MbDSystemSolver2 >> corAbsTol: double [ 
	corAbsTol := double
]

{ #category : #accessing }
MbDSystemSolver2 >> corRelTol: double [ 
	corRelTol := double
]

{ #category : #accessing }
MbDSystemSolver2 >> correctorAbsoluteTolerance [
	^corAbsTol == nil
		ifTrue: [1.0d-6]
		ifFalse: [corAbsTol]
]

{ #category : #accessing }
MbDSystemSolver2 >> correctorRelativeTolerance [
	^corRelTol == nil
		ifTrue: [1.0d-6]
		ifFalse: [corRelTol]
]

{ #category : #run }
MbDSystemSolver2 >> discontinuityBlock [
	^
	[:ex | 
	"daeIntegrator should have found the transition point"

	"It has told system to change to the new topology."

	| discontinuityTypes |
	discontinuityTypes := ex parameter.
	(discontinuityTypes includes: #REBOUND) 
		ifTrue: 
			[self runAllIC.
			ex restart]
		ifFalse: 
			[(discontinuityTypes 
				contains: [:type | #(#LIFTOFF #BROKENJOINT) includes: type]) 
					ifTrue: 
						[self runAllIC.
						ex restart]
					ifFalse: 
						[(discontinuityTypes 
							contains: [:type | #(#TOUCHDOWN #PIECEWISEFORCE #PIECEWISEMOTION) includes: type]) 
								ifTrue: 
									[self runAllIC.
									ex restart]
								ifFalse: [self error: 'An unknown discontinuity has been found.']]]]
]

{ #category : #accessing }
MbDSystemSolver2 >> displacementConstraints [
	^system displacementConstraints
]

{ #category : #accessing }
MbDSystemSolver2 >> endTime [
	^tend
]

{ #category : #accessing }
MbDSystemSolver2 >> errorTol [
	^intRelTol == nil
		ifTrue: [1.0d-6]
		ifFalse: [intRelTol]
]

{ #category : #accessing }
MbDSystemSolver2 >> errorTol: double [ 
	errorTolPosKine := double.
	errorTolAccKine := double.
	corAbsTol := double.
	corRelTol := double.
	intAbsTol := double.
	intRelTol := double
]

{ #category : #accessing }
MbDSystemSolver2 >> errorTolAccKine [
	^errorTolAccKine == nil
		ifTrue: [1.0d-6]
		ifFalse: [errorTolAccKine]
]

{ #category : #accessing }
MbDSystemSolver2 >> errorTolAccKine: double [ 
	errorTolAccKine := double
]

{ #category : #accessing }
MbDSystemSolver2 >> errorTolPosKine [
	^errorTolPosKine == nil
		ifTrue: [1.0d-6]
		ifFalse: [errorTolPosKine]
]

{ #category : #accessing }
MbDSystemSolver2 >> errorTolPosKine: double [ 
	errorTolPosKine := double
]

{ #category : #accessing }
MbDSystemSolver2 >> essentialConstraints2 [
	^system essentialConstraints2
]

{ #category : #accessing }
MbDSystemSolver2 >> firstOutputTime [
	^toutFirst
]

{ #category : #run }
MbDSystemSolver2 >> followPart: aPart [ 
	self initializeLocally.
	self initializeGlobally.
	icTypeSolver := MbDDragPosICNewtonRaphson2 new.
	icTypeSolver dragPart: aPart.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : #accessing }
MbDSystemSolver2 >> gSubC [
	^system gSubC
]

{ #category : #accessing }
MbDSystemSolver2 >> hmax [
	^hmax == nil
		ifTrue: [1.0d]
		ifFalse: [hmax]
]

{ #category : #accessing }
MbDSystemSolver2 >> hmax: double [ 
	hmax := double
]

{ #category : #accessing }
MbDSystemSolver2 >> hmin [
	^hmin == nil
		ifTrue: [1.0d-9]
		ifFalse: [hmin]
]

{ #category : #accessing }
MbDSystemSolver2 >> hmin: double [ 
	hmin := double
]

{ #category : #accessing }
MbDSystemSolver2 >> hout [
	^hout == nil
		ifTrue: [direction * 0.1d]
		ifFalse: [hout]
]

{ #category : #accessing }
MbDSystemSolver2 >> hout: double [ 
	hout := double
]

{ #category : #'initialize-release' }
MbDSystemSolver2 >> initialize [
	tstartPasts := OrderedCollection new
]

{ #category : #'initialize-release' }
MbDSystemSolver2 >> initializeGlobally [
	parts := system parts.
	jointsMotions := system jointsMotions.
	forcesTorques := system forcesTorques.
	sensors := system sensors.
	variables := system variables
]

{ #category : #'initialize-release' }
MbDSystemSolver2 >> initializeLocally [
	"Prepare for a new set of sets of redundant constraints."

	setsOfRedundantConstraints := OrderedCollection new.
	direction := tstart < tend
				ifTrue: [1.0d]
				ifFalse: [-1.0d].
	toutFirst == nil ifTrue: [toutFirst := tstart + (direction * hout)]
]

{ #category : #accessing }
MbDSystemSolver2 >> intAbsTol: double [ 
	intAbsTol := double
]

{ #category : #accessing }
MbDSystemSolver2 >> intRelTol: double [ 
	intRelTol := double
]

{ #category : #accessing }
MbDSystemSolver2 >> integrationAbsoluteTolerance [
	^intAbsTol == nil
		ifTrue: [1.0d-6]
		ifFalse: [intAbsTol]
]

{ #category : #accessing }
MbDSystemSolver2 >> integrationRelativeTolerance [
	^intRelTol == nil
		ifTrue: [1.0d-6]
		ifFalse: [intRelTol]
]

{ #category : #accessing }
MbDSystemSolver2 >> istep [
	^basicIntegrator istep
]

{ #category : #accessing }
MbDSystemSolver2 >> iterMaxAccKine [
	^iterMaxAccKine == nil
		ifTrue: [25]
		ifFalse: [iterMaxAccKine]
]

{ #category : #accessing }
MbDSystemSolver2 >> iterMaxAccKine: integer [ 
	iterMaxAccKine := integer
]

{ #category : #accessing }
MbDSystemSolver2 >> iterMaxDyn [
	^iterMaxDyn == nil
		ifTrue: [4]
		ifFalse: [iterMaxDyn]
]

{ #category : #accessing }
MbDSystemSolver2 >> iterMaxDyn: integer [ 
	iterMaxDyn := integer
]

{ #category : #accessing }
MbDSystemSolver2 >> iterMaxPosKine [
	^iterMaxPosKine == nil
		ifTrue: [25]
		ifFalse: [iterMaxPosKine]
]

{ #category : #accessing }
MbDSystemSolver2 >> iterMaxPosKine: integer [ 
	iterMaxPosKine := integer
]

{ #category : #accessing }
MbDSystemSolver2 >> jointsMotions [
	^jointsMotions
]

{ #category : #output }
MbDSystemSolver2 >> logString: string [ 
	system logString: string
]

{ #category : #output }
MbDSystemSolver2 >> logString: string withArgument: string1 [ 
	system logString: string withArgument: string1
]

{ #category : #output }
MbDSystemSolver2 >> logString: string withArguments: arrayOfStrings [ 
	system logString: string withArguments: arrayOfStrings
]

{ #category : #accessing }
MbDSystemSolver2 >> maxStepSize [
	^hmax == nil
		ifTrue: [1.0d]
		ifFalse: [hmax]
]

{ #category : #accessing }
MbDSystemSolver2 >> minStepSize [
	^hmin == nil
		ifTrue: [1.0d-9]
		ifFalse: [hmin]
]

{ #category : #run }
MbDSystemSolver2 >> needToRedoPosIC [
	| allRedunCons newSet |
	allRedunCons := self allRedundantConstraints.
	newSet := (allRedunCons collect: [:i | i constraint name]) 
				asSortedCollection.
	newSet isEmpty ifTrue: [^false].
	(setsOfRedundantConstraints includes: newSet) 
		ifTrue: 
			["Same set of redundant constraints found."

			setsOfRedundantConstraints add: newSet.
			^false].
	setsOfRedundantConstraints size >= 2 
		ifTrue: 
			[((setsOfRedundantConstraints collect: [:set | set size]) 
				includes: newSet size) 
					ifTrue: 
						["Equal number of redundant constraints found."

						setsOfRedundantConstraints add: newSet.
						^false]].
	setsOfRedundantConstraints add: newSet.
	allRedunCons do: [:i | i activateConstraint].
	^true
]

{ #category : #accessing }
MbDSystemSolver2 >> neqn [
	"Let MbDDAEIntegrator subclasses calculate with assignEquationNumbers."

	^nil
]

{ #category : #accessing }
MbDSystemSolver2 >> opBDF [
	^basicIntegrator opBDF
]

{ #category : #accessing }
MbDSystemSolver2 >> orderMax [
	^orderMax == nil
		ifTrue: [5]
		ifFalse: [orderMax]
]

{ #category : #accessing }
MbDSystemSolver2 >> orderMax: integer [ 
	orderMax := integer
]

{ #category : #output }
MbDSystemSolver2 >> output [
	system outputFor: #DYNAMIC
]

{ #category : #accessing }
MbDSystemSolver2 >> outputStepSize [
	^hout == nil
		ifTrue: [direction * 0.1d]
		ifFalse: [hout]
]

{ #category : #accessing }
MbDSystemSolver2 >> parJoiMotForTorSenVarDo: aBlock [ 
	parts do: aBlock.
	jointsMotions do: aBlock.
	forcesTorques do: aBlock.
	sensors do: aBlock.
	variables do: aBlock
]

{ #category : #accessing }
MbDSystemSolver2 >> parts [
	^parts
]

{ #category : #accessing }
MbDSystemSolver2 >> partsJointsMotionsDo: aBlock [ 
	parts do: aBlock.
	jointsMotions do: aBlock
]

{ #category : #accessing }
MbDSystemSolver2 >> partsJointsMotionsForcesTorquesDo: aBlock [ 
	parts do: aBlock.
	jointsMotions do: aBlock.
	forcesTorques do: aBlock
]

{ #category : #accessing }
MbDSystemSolver2 >> partsJointsMotionsForcesTorquesSensorsDo: aBlock [ 
	parts do: aBlock.
	jointsMotions do: aBlock.
	forcesTorques do: aBlock.
	sensors do: aBlock
]

{ #category : #accessing }
MbDSystemSolver2 >> perpendicularConstraints2 [
	^system perpendicularConstraints2
]

{ #category : #run }
MbDSystemSolver2 >> preCollision [
	"There should only be one MbDInCollisionCVCVJoint"

	| aMbDInCollisionCVCVJoint |
	aMbDInCollisionCVCVJoint := jointsMotions 
				detect: [:a | a isMemberOf: MbDInCollisionCVCVJoint].
	jointsMotions 
		do: [:a | a == aMbDInCollisionCVCVJoint ifFalse: [a becomeSeparatedCVCVJoint]]
]

{ #category : #accessing }
MbDSystemSolver2 >> rotationLimit [
	^rotationLimit == nil
		ifTrue: [0.5d]
		ifFalse: [rotationLimit]
]

{ #category : #accessing }
MbDSystemSolver2 >> rotationLimit: double [ 
	rotationLimit := double
]

{ #category : #run }
MbDSystemSolver2 >> runAccIC [
	icTypeSolver := MbDAccICNewtonRaphson2 new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : #run }
MbDSystemSolver2 >> runAccICKine [
	icTypeSolver := MbDAccICKineNewtonRaphson2 new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : #run }
MbDSystemSolver2 >> runAccKine [
	icTypeSolver := MbDAccKineNewtonRaphson2 new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : #run }
MbDSystemSolver2 >> runAllIC [
	"Redundant constraint removal is best when the system is assembled."

	| cDiscontinuity |
	
	[self initializeLocally.
	self initializeGlobally.
	self runPosIC.
	"	self runPerturbedPosIC."
	[self needToRedoPosIC] whileTrue: [self runPosIC].
	self runVelIC.
	self runAccIC.
	cDiscontinuity := system cDiscontinuityAtIC.
	cDiscontinuity isEmpty not] 
			whileTrue: 
				[(cDiscontinuity includes: #REBOUND) 
					ifTrue: 
						[self preCollision.
						self runCollisionDerivativeIC.
						self runBasicCollision]]
]

{ #category : #run }
MbDSystemSolver2 >> runBasicCollision [
	
	["Use a new StMDAEIntegrator each time to wipe out past history."

	"A specialized integrator for collision may be better."

	basicIntegrator := MbDCollisionIntegrator new.
	basicIntegrator system: self.
	basicIntegrator run.
	basicIntegrator := nil.
	ObjectMemory garbageCollect] 
			on: DiscontinuityError
			do: 
				[:ex | 
				"basicIntegrator should have found end of collision."

				"It has told system to change to the new topology."

				| discontinuityTypes |
				discontinuityTypes := ex parameter.
				(discontinuityTypes 
					contains: [:type | #(#LIFTOFF #TOUCHDOWN) includes: type]) 
						ifTrue: 
							[basicIntegrator := nil.
							ObjectMemory garbageCollect.
							ex return]
						ifFalse: 
							[self logString: #'MbD: \Unknown discontinuity found in collision.'.
							SimulationStoppingError raiseSignal]]
]

{ #category : #run }
MbDSystemSolver2 >> runBasicDynamic [
	
	[basicIntegrator := MbDDynIntegrator new.
	basicIntegrator system: self.
	basicIntegrator run] 
			on: DiscontinuityError
			do: self discontinuityBlock
]

{ #category : #run }
MbDSystemSolver2 >> runBasicKinematic [
	
	[basicIntegrator := MbDKineIntegrator new.
	basicIntegrator system: self.
	basicIntegrator run] 
			on: NotKinematicError
			do: [:ex | self runQuasiKinematic]
]

{ #category : #run }
MbDSystemSolver2 >> runBasicTransient [
	system logString: #'MbD: \Starting transient simulation.'.
	
	[
	[basicIntegrator := MbDKineIntegrator new.
	basicIntegrator system: self.
	basicIntegrator run] 
			on: NotKinematicError
			do: 
				[:ex | 
				basicIntegrator := MbDDynIntegrator new.
				basicIntegrator system: self.
				basicIntegrator run]] 
			on: DiscontinuityError
			do: self discontinuityBlock
]

{ #category : #run }
MbDSystemSolver2 >> runBasicTransient1 [
	| discontinuityTypes |
	system logString: #'MbD: \Starting transient simulation.'.
	[
	[basicIntegrator := MbDKineIntegrator new.	"	basicIntegrator := MbDDynIntegrator new."
	basicIntegrator system: self.
	basicIntegrator run]
		on: NotKinematicError
		do: 
			[:ex | 
			basicIntegrator := MbDDynIntegrator new.
			basicIntegrator system: self.
			basicIntegrator run]]
		on: DiscontinuityError
		do: 
			[:ex | 
			"daeIntegrator should have found the transition point"
			"It has told system to change to the new topology."
			discontinuityTypes := ex parameter.
			(discontinuityTypes includes: #REBOUND)
				ifTrue: 
					[self runPosICVelICCollisionDerivativeIC.
					self runBasicCollision.
					self runPosICVelICAccIC.
					ex restart]
				ifFalse: [(discontinuityTypes contains: [:type | #(#LIFTOFF #BROKENJOINT) includes: type])
						ifTrue: 
							[self runPosICTwiceVelICAccIC.
							ex restart]
						ifFalse: [(discontinuityTypes contains: [:type | #(#TOUCHDOWN #PIECEWISEFORCE #PIECEWISEMOTION) includes: type])
								ifTrue: 
									[self runPosICTwiceVelICAccICCheckDiscontinuity.
									ex restart]
								ifFalse: [self error: 'An unknown discontinuity has been found.']]]]
]

{ #category : #run }
MbDSystemSolver2 >> runCollisionDerivativeIC [
	icTypeSolver := MbDCollisionDerivativeICNewtonRaphson2 new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : #run }
MbDSystemSolver2 >> runPerturbedPosIC [
	icTypeSolver := MbDPerturbedPosICNewtonRaphson2 new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : #run }
MbDSystemSolver2 >> runPosIC [
	icTypeSolver := MbDPosICNewtonRaphson2 new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : #run }
MbDSystemSolver2 >> runPosICKine [
	icTypeSolver := MbDPosICKineNewtonRaphson2 new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : #run }
MbDSystemSolver2 >> runPosICTwiceVelICAccIC [
	"Redundant constraint removal is best when the system is assembled."

	self initializeLocally.
	self initializeGlobally.
"self runPosIC."
	self runPerturbedPosIC.
	[self needToRedoPosIC]
		whileTrue: [self runPosIC].
	self runVelIC.
	self runAccIC
]

{ #category : #run }
MbDSystemSolver2 >> runPosICTwiceVelICAccICCheckDiscontinuity [
	
	[self runPosICTwiceVelICAccIC.
	system hasDiscontinuityAtIC]
		whileTrue: [system partsJointsMotionsDo: [:item | item preICRestart]]
]

{ #category : #run }
MbDSystemSolver2 >> runPosICVelICAccIC [
	"Redundant constraint removal is best when the system is assembled."

	self initializeLocally.
	self initializeGlobally.
	self runPosIC.
	self runVelIC.
	self runAccIC
]

{ #category : #run }
MbDSystemSolver2 >> runPosICVelICCollisionDerivativeIC [
	"Redundant constraint removal is best when the system is assembled."

	self initializeLocally.
	self initializeGlobally.
	self runPosIC.
	self runVelIC.
	self runCollisionDerivativeIC
]

{ #category : #run }
MbDSystemSolver2 >> runPosKine [
	icTypeSolver := MbDPosKineNewtonRaphson2 new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : #run }
MbDSystemSolver2 >> runQuasiKinematic [
	
	[basicIntegrator := MbD_ICKineIntegrator new.
	basicIntegrator system: self.
	basicIntegrator run] 
			on: DiscontinuityError
			do: self discontinuityBlock
]

{ #category : #run }
MbDSystemSolver2 >> runQuasiStatic [
	
	[basicIntegrator := MbDQuasiStaticIntegrator new.
	basicIntegrator system: self.
	basicIntegrator run] 
			on: DiscontinuityError
			do: self discontinuityBlock
]

{ #category : #run }
MbDSystemSolver2 >> runQuasiStatic1 [
	| discontinuityTypes |
	system logString: #'MbD: \Starting quasi static analysis.'.
	[
	[basicIntegrator := MbDKineIntegrator new.
	basicIntegrator system: self.
	basicIntegrator run]
		on: NotKinematicError
		do: 
			[:ex | 
			basicIntegrator := MbDQuasiStaticIntegrator new.
			basicIntegrator system: self.
			basicIntegrator run]]
		on: DiscontinuityError
		do: 
			[:ex | 
			"daeIntegrator should have found the transition point"
			"It has told system to change to the new topology."
			discontinuityTypes := ex parameter.
			(discontinuityTypes includes: #REBOUND)
				ifTrue: 
					[self runPosICVelICCollisionDerivativeIC.
					self runBasicCollision.
					self runPosICVelICAccIC.
					ex restart]
				ifFalse: [(discontinuityTypes contains: [:type | #(#LIFTOFF #BROKENJOINT) includes: type])
						ifTrue: 
							[self runPosICTwiceVelICAccIC.
							ex restart]
						ifFalse: [(discontinuityTypes contains: [:type | #(#TOUCHDOWN #PIECEWISEFORCE #PIECEWISEMOTION) includes: type])
								ifTrue: 
									[self runPosICTwiceVelICAccICCheckDiscontinuity.
									ex restart]
								ifFalse: [self error: 'An unknown discontinuity has been found.']]]]
]

{ #category : #run }
MbDSystemSolver2 >> runStaticIC [
	icTypeSolver := MbDStaticICNewtonRaphson2 new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : #run }
MbDSystemSolver2 >> runVelIC [
	icTypeSolver := MbDVelICSolver2 new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : #run }
MbDSystemSolver2 >> runVelICKine [
	icTypeSolver := MbDVelICKineSolver2 new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : #run }
MbDSystemSolver2 >> runVelKine [
	icTypeSolver := MbDVelKineSolver2 new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : #accessing }
MbDSystemSolver2 >> startTime [
	^tstart == nil
		ifTrue: [0.0d]
		ifFalse: [tstart]
]

{ #category : #accessing }
MbDSystemSolver2 >> system: object [ 
	system := object
]

{ #category : #accessing }
MbDSystemSolver2 >> tend [
	^tend == nil
		ifTrue: [1.0d]
		ifFalse: [tend]
]

{ #category : #accessing }
MbDSystemSolver2 >> tend: double [ 
	tend := double
]

{ #category : #accessing }
MbDSystemSolver2 >> time [
	^basicIntegrator time
]

{ #category : #accessing }
MbDSystemSolver2 >> time: aDouble [ 
	^system mbdTimeValue: aDouble
]

{ #category : #accessing }
MbDSystemSolver2 >> toutFirst: tout [ 
	toutFirst := tout
]

{ #category : #accessing }
MbDSystemSolver2 >> translationLimit [
	^translationLimit == nil
		ifTrue: [1.0d10]
		ifFalse: [translationLimit]
]

{ #category : #accessing }
MbDSystemSolver2 >> translationLimit: double [ 
	translationLimit := double
]

{ #category : #accessing }
MbDSystemSolver2 >> tstart [
	^tstart == nil
		ifTrue: [0.0d]
		ifFalse: [tstart]
]

{ #category : #accessing }
MbDSystemSolver2 >> tstart: double [ 
	tstart := double
]

{ #category : #accessing }
MbDSystemSolver2 >> tstartPasts [
	^tstartPasts
]

{ #category : #accessing }
MbDSystemSolver2 >> tstartPastsAddFirst: tstartPast [ 
	tstartPasts addFirst: tstartPast
]

{ #category : #accessing }
MbDSystemSolver2 >> uHolders [
	^system uHolders
]

{ #category : #run }
MbDSystemSolver2 >> useCollisionTrialStepStats: stats [ 
	system useCollisionTrialStepStats: stats
]

{ #category : #run }
MbDSystemSolver2 >> useDynTrialStepStats: stats [ 
	system useDynTrialStepStats: stats
]

{ #category : #run }
MbDSystemSolver2 >> useKineTrialStepStats: stats [ 
	system useKineTrialStepStats: stats
]
