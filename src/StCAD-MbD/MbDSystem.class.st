"
GENERALIZE TO MAKE EASIER CODING.
SPECIALIZE FOR CRITICAL CODE ONLY. Use Profiler.
OODS should be input and output neutral. Use internal variables only. AdamsSystem will handle input and output formating.
Create Constraint
			AbsConstraint	function of time
			EulerParConstraint
			ConstraintPP	function of time


Remove OutStream from System. Put it in AdamsSystem.

NEXT: Torsional damper, motion constraints, SparseMatrix solver.
part
Let InertiaMatrix solve eigenvalue eigenvector problem.
Flexible beam as multibody.
Create class of FunctionFormula, subclass of Block. Have methods to return derivative.
Revolute, universal joints can inherit from spherical joint.
Check for joint marker on the same part.
theta0 and thetaInit are redundant in TorsionalSpring.
Make Request collection for better control.
Iteration counter.
Vector >> Row and Column.
Check on convergence rate to see if Jacobian is correct.
Use 'CompliantElements' collection for springs, dampers, bushings, etc.
Watch out for springs compressed to zero length or compressed rIJ flip directions.
'updateInSimulation' is used too frequently. Introduce more specific methods.
Constants should be initialized only once. Use ""initConstants"".
Allow omega to be used for easier input.
Output positions, velocities, accelerations, forces and torques, constraints forces and torques.
Joint: gear, pulley, screw, rack and pinion.
Motion: absolute marker position as function of time. relative marker position ... absolute marker rotation ... relative marker rotation ...
Force: Friction, bushing
Part: massless, slender, gyrostat, beam, variable mass
Check zI and zJ are perpendicular in universal joint, parallel in revolute, planar, translational, cylindrical joint.
Provide diagnostics for over constraint systems.
Combine MbD, FEM, CFD.
"
Class {
	#name : #MbDSystem,
	#superclass : #MbDItem,
	#instVars : [
		'admSystem',
		'namedItems',
		'mbdTime',
		'parts',
		'jointsMotions',
		'forcesTorques',
		'sensors',
		'variables',
		'hasChanged',
		'mbdSystemSolver'
	],
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #'VisualWorks metadata' }
MbDSystem class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDSystem >> admSystem [
	^admSystem
]

{ #category : #accessing }
MbDSystem >> admSystem: admSys [ 
	admSystem := admSys
]

{ #category : #accessing }
MbDSystem >> allConstraints [
	| allConstraints |
	allConstraints := OrderedCollection new.
	self partsJointsMotionsDo: [:item | item fillConstraints: allConstraints].
	^allConstraints
]

{ #category : #accessing }
MbDSystem >> allRedundantConstraints [
	| allRedundantConstraints |
	allRedundantConstraints := OrderedCollection new.
	self partsJointsMotionsDo: [:item | item fillRedundantConstraints: allRedundantConstraints].
	^allRedundantConstraints
]

{ #category : #dynamic }
MbDSystem >> bePerturbed: delta fillqsulam: col [ 
	self partsJointsMotionsDo: [:item | item bePerturbed: delta fillqsulam: col]
]

{ #category : #accessing }
MbDSystem >> cDiscontinuityAtIC [
	| cDiscontinuity |
	cDiscontinuity := OrderedCollection new.
	self partsJointsMotionsForcesTorquesDo: 
			[:item | 
			item discontinuityAtICAddTo: cDiscontinuity].
	^cDiscontinuity
]

{ #category : #accessing }
MbDSystem >> classMbDMarker [
	^MbDEndFrameqc
]

{ #category : #accessing }
MbDSystem >> contactEndFrames [
	| contactEndFrames |
	contactEndFrames := OrderedCollection new.
	jointsMotions do: [:joint | joint fillContactEndFrames: contactEndFrames].
	^contactEndFrames
]

{ #category : #accessing }
MbDSystem >> correctorAbsoluteTolerance [
	^admSystem correctorAbsoluteTolerance
]

{ #category : #accessing }
MbDSystem >> correctorRelativeTolerance [
	^admSystem correctorRelativeTolerance
]

{ #category : #debug }
MbDSystem >> debugFindConstraint_iG: i [ 
	jointsMotions do: 
			[:joint | 
			joint constraints 
				do: [:con | (con isRedundant not and: [con iG = i]) ifTrue: [^con]]]
]

{ #category : #accessing }
MbDSystem >> displacementConstraints [
	| dispConstraints |
	dispConstraints := OrderedCollection new.
	jointsMotions do: [:joint | joint fillDispConstraints: dispConstraints].
	^dispConstraints
]

{ #category : #dynamic }
MbDSystem >> endTime [
	^admSystem endTime
]

{ #category : #dynamic }
MbDSystem >> errorTolAccKine [
	^admSystem errorTolAccKine
]

{ #category : #dynamic }
MbDSystem >> errorTolPosKine [
	^admSystem errorTolPosKine
]

{ #category : #accessing }
MbDSystem >> essentialConstraints2 [
	| essenConstraints |
	essenConstraints := OrderedCollection new.
	self partsJointsMotionsDo: [:item | item fillEssenConstraints: essenConstraints].
	^essenConstraints
]

{ #category : #static }
MbDSystem >> fillStaticWeights: col [ 
	"self fillqsuWeights: col."
	"col magnifySelf: 1.0d-9 / TheMbDSystem gSubC"

	col atAllPut: 0.001d
]

{ #category : #dynamic }
MbDSystem >> fillqsulam: col [ 
	self partsJointsMotionsDo: [:item | item fillqsulam: col]
]

{ #category : #accessing }
MbDSystem >> find: aSymbol [ 
	^namedItems at: aSymbol
		ifAbsent: 
			[self logString: #'MbD: \The MbD item named (%1) is not found.' withArgument: aSymbol.
			SimulationStoppingError raiseSignal]
]

{ #category : #run }
MbDSystem >> followPart: aGEOPart [ 
	admSystem preMbDrun.
	
	[self initializeLocally.
	self initializeGlobally.
	self hasChanged] 
			whileTrue.
	self partsJointsMotionsForcesTorquesDo: [:item | item postInput].
	mbdSystemSolver followPart: aGEOPart mbdObject.
	admSystem outputFor: #'INITIAL CONDITIONS'.
	admSystem postMbDrun
]

{ #category : #accessing }
MbDSystem >> forcesTorques [
	^forcesTorques
]

{ #category : #accessing }
MbDSystem >> gSubC [
	"F := ma / gSubC."

	^admSystem gSubC
]

{ #category : #'input-output' }
MbDSystem >> getString: symbol [ 
	^admSystem getString: symbol
]

{ #category : #accessing }
MbDSystem >> hasChanged [
	^hasChanged
]

{ #category : #accessing }
MbDSystem >> hasChanged: boolean [ 
	hasChanged := boolean
]

{ #category : #dynamic }
MbDSystem >> hasDiscontinuityAtIC [
	| discontinuityTypes |
	discontinuityTypes := OrderedCollection new.
	self partsJointsMotionsForcesTorquesDo: [:item | item discontinuityAtICAddTo: discontinuityTypes].
	^discontinuityTypes isEmpty not
]

{ #category : #dynamic }
MbDSystem >> initStepSize [
	^self admSystem HINIT
]

{ #category : #'initialize-release' }
MbDSystem >> initialize [
	TheMbDSystem := self.
	namedItems := IdentityDictionary new.
	mbdTime := MbDTime new.
	parts := OrderedCollection new.
	jointsMotions := OrderedCollection new.
	forcesTorques := OrderedCollection new.
	sensors := OrderedCollection new.
	variables := OrderedCollection new.
	mbdSystemSolver := MbDSystemSolver2 new.
	mbdSystemSolver system: self
]

{ #category : #'initialize-release' }
MbDSystem >> initializeGlobally [
	self partsJointsMotionsForcesTorquesDo: [:item | item initializeGlobally].
	mbdSystemSolver initializeGlobally
]

{ #category : #'initialize-release' }
MbDSystem >> initializeLocally [
	hasChanged := false.
	self mbdTimeValue: mbdSystemSolver startTime.
	self partsJointsMotionsForcesTorquesDo: [:item | item initializeLocally].
	mbdSystemSolver initializeLocally
]

{ #category : #accessing }
MbDSystem >> integrationAbsoluteTolerance [
	^admSystem integrationAbsoluteTolerance
]

{ #category : #accessing }
MbDSystem >> integrationRelativeTolerance [
	^admSystem integrationRelativeTolerance
]

{ #category : #dynamic }
MbDSystem >> iterMaxAccKine [
	^admSystem iterMaxAccKine
]

{ #category : #dynamic }
MbDSystem >> iterMaxDyn [
	^admSystem iterMaxDyn
]

{ #category : #dynamic }
MbDSystem >> iterMaxPosKine [
	^admSystem iterMaxPosKine
]

{ #category : #accessing }
MbDSystem >> jointsMotions [
	^jointsMotions
]

{ #category : #'input-output' }
MbDSystem >> logContactForce: double [ 
	admSystem logContactForce: double
]

{ #category : #'input-output' }
MbDSystem >> logImpactVelocity: double [ 
	admSystem logImpactVelocity: double
]

{ #category : #'input-output' }
MbDSystem >> logSeparationDistance: double [ 
	admSystem logSeparationDistance: double
]

{ #category : #'input-output' }
MbDSystem >> logString: string [ 
	admSystem logString: string
]

{ #category : #'input-output' }
MbDSystem >> logString: string withArgument: string1 [ 
	admSystem logString: string withArgument: string1
]

{ #category : #'input-output' }
MbDSystem >> logString: string withArguments: arrayOfStrings [ 
	self admSystem logString: string withArguments: arrayOfStrings
]

{ #category : #dynamic }
MbDSystem >> maxStepSize [
	^admSystem maxStepSize
]

{ #category : #accessing }
MbDSystem >> maximumMass [
	| max |
	max := 0.0d.
	parts do: [:part | max := max max: part m].
	^max
]

{ #category : #accessing }
MbDSystem >> maximumMomentOfInertia [
	| max |
	max := 0.0d.
	parts do: [:part | part aJ do: [:aJii | max := max max: aJii]].
	^max
]

{ #category : #accessing }
MbDSystem >> mbdSystemSolver [
	^mbdSystemSolver
]

{ #category : #accessing }
MbDSystem >> mbdTime [
	^mbdTime
]

{ #category : #accessing }
MbDSystem >> mbdTimeValue [
	^mbdTime value
]

{ #category : #dynamic }
MbDSystem >> mbdTimeValue: double [ 
	mbdTime value = double ifFalse: [mbdTime value: double]
]

{ #category : #dynamic }
MbDSystem >> minStepSize [
	^admSystem minStepSize
]

{ #category : #accessing }
MbDSystem >> namedItems [
	^namedItems
]

{ #category : #dynamic }
MbDSystem >> orderMax [
	^admSystem orderMax
]

{ #category : #dynamic }
MbDSystem >> outputFor: analysisType [ 
	admSystem outputFor: analysisType
]

{ #category : #accessing }
MbDSystem >> outputStepSize [
	^mbdSystemSolver hout
]

{ #category : #accessing }
MbDSystem >> parts [
	^parts
]

{ #category : #accessing }
MbDSystem >> partsJointsMotionsDo: aBlock [ 
	parts do: aBlock.
	jointsMotions do: aBlock
]

{ #category : #accessing }
MbDSystem >> partsJointsMotionsForcesTorquesDo: aBlock [ 
	parts do: aBlock.
	jointsMotions do: aBlock.
	forcesTorques do: aBlock
]

{ #category : #accessing }
MbDSystem >> pastStartTimes [
	^mbdSystemSolver tstartPasts
]

{ #category : #accessing }
MbDSystem >> perpendicularConstraints2 [
	| perpenConstraints |
	perpenConstraints := OrderedCollection new.
	jointsMotions do: [:joint | joint fillPerpenConstraints: perpenConstraints].
	^perpenConstraints
]

{ #category : #dynamic }
MbDSystem >> rotationLimit [
	^mbdSystemSolver rotationLimit
]

{ #category : #run }
MbDSystem >> runDYNAMIC [
	admSystem preMbDrun.
	
	[self initializeLocally.
	self initializeGlobally.
	self hasChanged] 
			whileTrue.
	self partsJointsMotionsForcesTorquesDo: [:item | item postInput].
	admSystem outputFor: #INPUT.
	mbdSystemSolver runAllIC.
	admSystem outputFor: #'INITIAL CONDITIONS'.
	mbdSystemSolver runBasicDynamic.
	admSystem postMbDrun
]

{ #category : #run }
MbDSystem >> runKINEMATIC [
	admSystem preMbDrun.
	
	[self initializeLocally.
	self initializeGlobally.
	self hasChanged] 
			whileTrue.
	self partsJointsMotionsForcesTorquesDo: [:item | item postInput].
	admSystem outputFor: #INPUT.
	mbdSystemSolver runAllIC.
	admSystem outputFor: #'INITIAL CONDITIONS'.
	mbdSystemSolver runBasicKinematic.
	admSystem postMbDrun
]

{ #category : #run }
MbDSystem >> runQuasiKinematic [
	admSystem preMbDrun.
	
	[self initializeLocally.
	self initializeGlobally.
	self hasChanged] 
			whileTrue.
	self partsJointsMotionsForcesTorquesDo: [:item | item postInput].
	admSystem outputFor: #INPUT.
	mbdSystemSolver runAllIC.
	admSystem outputFor: #'INITIAL CONDITIONS'.
	mbdSystemSolver runQuasiKinematic.
	admSystem postMbDrun
]

{ #category : #run }
MbDSystem >> runSTATICS [
	admSystem preMbDrun.
	
	[self initializeLocally.
	self initializeGlobally.
	self hasChanged] 
			whileTrue.
	self partsJointsMotionsForcesTorquesDo: [:item | item postInput].
	admSystem outputFor: #INPUT.
	mbdSystemSolver runAllIC.
	mbdSystemSolver runStaticIC.
	admSystem outputFor: #STATIC.
	mbdSystemSolver runQuasiStatic.
	admSystem postMbDrun
]

{ #category : #run }
MbDSystem >> runSTATICS1 [
	admSystem preMbDrun.
	
	[self initializeLocally.
	self initializeGlobally.
	self hasChanged] whileTrue.
	self partsJointsMotionsForcesTorquesDo: [:item | item postInput].
	admSystem outputFor: #INPUT.
	mbdSystemSolver runPosICTwiceVelICAccIC.	"
	admSystem outputFor: #'INITIAL CONDITIONS'."
	mbdSystemSolver runStaticIC.
	admSystem outputFor: #STATIC.
	mbdSystemSolver runQuasiStatic.
	admSystem postMbDrun
]

{ #category : #run }
MbDSystem >> runTRANSIENT [
	admSystem preMbDrun.
	
	[self initializeLocally.
	self initializeGlobally.
	self hasChanged] 
			whileTrue.
	self partsJointsMotionsForcesTorquesDo: [:item | item postInput].
	admSystem outputFor: #INPUT.
	mbdSystemSolver runAllIC.
	admSystem outputFor: #'INITIAL CONDITIONS'.
	mbdSystemSolver runBasicTransient.
	admSystem postMbDrun
]

{ #category : #run }
MbDSystem >> runTRANSIENT1 [
	admSystem preMbDrun.
	
	[self initializeLocally.
	self initializeGlobally.
	self hasChanged] whileTrue.
	self partsJointsMotionsForcesTorquesDo: [:item | item postInput].
	admSystem outputFor: #INPUT.
	mbdSystemSolver runPosICTwiceVelICAccICCheckDiscontinuity.
	admSystem outputFor: #'INITIAL CONDITIONS'.
	mbdSystemSolver runBasicTransient.
	admSystem postMbDrun
]

{ #category : #accessing }
MbDSystem >> sensors [
	^sensors
]

{ #category : #dynamic }
MbDSystem >> simCompleted [
	self admSystem closeOutputs
]

{ #category : #dynamic }
MbDSystem >> startTime [
	^mbdTime value
]

{ #category : #dynamic }
MbDSystem >> translationLimit [
	^mbdSystemSolver translationLimit
]

{ #category : #accessing }
MbDSystem >> uHolders [
	| uHolders |
	uHolders := OrderedCollection new.
	jointsMotions do: [:joint | joint filluHolders: uHolders].
	^uHolders
]

{ #category : #dynamic }
MbDSystem >> useCollisionTrialStepStats: stats [ 
	admSystem useCollisionTrialStepStats: stats
]

{ #category : #dynamic }
MbDSystem >> useDynTrialStepStats: stats [ 
	admSystem useDynTrialStepStats: stats
]

{ #category : #dynamic }
MbDSystem >> useKineTrialStepStats: stats [ 
	admSystem useKineTrialStepStats: stats
]

{ #category : #accessing }
MbDSystem >> variables [
	^variables
]
