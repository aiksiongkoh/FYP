"
GENERALIZE TO MAKE EASIER CODING AND MAINTENANCE.
SPECIALIZE FOR CRITICAL CODE ONLY.
FUNDAMENTAL CLASSES: 
System controls Part, Joint, Force.
Part controls Marker, EulerConstraint, AbsConstraint.
Joint controls Constraint. Constraint controls KinematicIJ.
Force controls KinematicIJ.
initialize = smalltalk initialize.
localInitialize = initialize with user input and info belonging to object.
globalInitialize = initialize with all system info available.
Use MVC for graphical user interface only.

Let forces handle generalized forces, not part or frameEnd.
Let IntegratorDAE handle all integration parameters, not MbDItem.
	""parameters: g, m, aJ, q0, qdot0, s0, sdot0, u0, udot0, w0, wdot0, k, c, length0, kt, ct, 
	angle0, rIpImIp, aAIpIm, pd, scales.""
	""independent variables: t.""
	""level 1 dependent variables: p,q,s,u,w, mu (lam).""
	""level 2 dependent variables: pdot, qdot, ..., aAOIp, aB, aC, pAOIppE, ppAOIppEpE, 
	rOIeO, prOIeOpE, ppr...pEpE, aAOIe, pAOIepE, ppAOIepEpE.""
	""level 3 dependent variables: rIeJeO, rIeJeIe, aAIeJe, p...pqsuw, pp...pqsuwpqsuw, 
	vIeJeIe.""
	""level 4 dependent variables: aG, aF, aT.""
	""Parts take care of markers.""

"
Class {
	#name : #MbDItem,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#classVars : [
		'MbD'
	],
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #accessing }
MbDItem >> TheMbDSystem [
	^TheMbDSystem
]

{ #category : #accessing }
MbDItem >> bePerturbed: delta fillqsulam: col [ 
	"Default is do nothing."
]

{ #category : #calc }
MbDItem >> calcPostDynCorrectorIteration [
	"A commonly used subset of calculations."
	"It is equal or super set of calcPostPosICIteration."

	self subclassResponsibility
]

{ #category : #collision }
MbDItem >> checkForCollisionDiscontinuityBetween: impulsePrevious and: impulse [ 
	"Check for discontinuity in the last step defined by the interval (impulsePrevious,impulse]."
	"Default is assume no discontinuity and return impulse."

	^impulse
]

{ #category : #dynamic }
MbDItem >> checkForDynDiscontinuityBetween: tprevious and: t [ 
	"Check for discontinuity in the last step defined by the interval (tprevious,t]."
	"Default is assume no discontinuity and return t."

	^t
]

{ #category : #dynamic }
MbDItem >> discontinuityAt: tstartNew addTypeTo: collection [ 
	"Do all the transitions or mutations before restart here."
	"Default is do nothing."
]

{ #category : #accIC }
MbDItem >> discontinuityAtICAddTo: collection [ 
	"Every object is given chance to transform."
	"Default is do nothing."
]

{ #category : #accIC }
MbDItem >> fillAccICIterError: col [ 
	"Do nothing."
]

{ #category : #accIC }
MbDItem >> fillAccICIterJacob: mat [ 
	"Do nothing."
]

{ #category : #collision }
MbDItem >> fillCollisionDerivativeICError: col [ 
	"Do nothing."
]

{ #category : #collision }
MbDItem >> fillCollisionDerivativeICJacob: mat [ 
	"Do nothing."
]

{ #category : #collision }
MbDItem >> fillCollisionError: col [ 
	"Do nothing."
]

{ #category : #collision }
MbDItem >> fillCollisionpFpy: mat [ 
	"Do nothing."
	"Collision is pure ODE."
]

{ #category : #collision }
MbDItem >> fillCollisionpFpydot: mat [ 
	"Default is do nothing."
]

{ #category : #dynamic }
MbDItem >> fillDynError: col [ 
	"Do nothing."
]

{ #category : #posIC }
MbDItem >> fillPosICError: col [ 
	"Default is do nothing."
]

{ #category : #posIC }
MbDItem >> fillPosICJacob: mat [ 
	"Default is do nothing."
]

{ #category : #posIC }
MbDItem >> fillPosKineError: col [ 
	"Default is do nothing."
]

{ #category : #posIC }
MbDItem >> fillPosKineJacob: mat [ 
	"Default is do nothing."
]

{ #category : #static }
MbDItem >> fillStaticError: col [ 
	"Default is do nothing."
]

{ #category : #static }
MbDItem >> fillStaticJacob: mat [ 
	"Default is do nothing."
]

{ #category : #velIC }
MbDItem >> fillVelICError: col [ 
	"Default is do nothing."
]

{ #category : #velIC }
MbDItem >> fillVelICJacob: mat [ 
	"Default is do nothing."
]

{ #category : #dynamic }
MbDItem >> fillpFpy: mat [ 
	"Do nothing."
]

{ #category : #dynamic }
MbDItem >> fillpFpydot: mat [ 
	"Do nothing."
]

{ #category : #accessing }
MbDItem >> fillpqsumu: col [ 
	"Default is do nothing."
]

{ #category : #accessing }
MbDItem >> fillpqsumudot: col [ 
	"Default is do nothing."
]

{ #category : #accessing }
MbDItem >> fillqsu: col [ 
	"Default is do nothing."
]

{ #category : #accessing }
MbDItem >> fillqsuWeights: col [ 
	"Default is do nothing."
]

{ #category : #accessing }
MbDItem >> fillqsuWeightsSmall: col [ 
	"Default is do nothing."
]

{ #category : #accessing }
MbDItem >> fillqsuddotlam: col [ 
	"Default is do nothing."
]

{ #category : #accessing }
MbDItem >> fillqsudot: col [ 
	"Default is do nothing."
]

{ #category : #accessing }
MbDItem >> fillqsudotPlam: col [ 
	"Default is do nothing."
]

{ #category : #accessing }
MbDItem >> fillqsudotPlamDeriv: col [ 
	"Default is do nothing."
]

{ #category : #accessing }
MbDItem >> fillqsudotWeights: col [ 
	"Default is do nothing."
]

{ #category : #accessing }
MbDItem >> fillqsulam: col [ 
	"Default is do nothing."
]

{ #category : #'input-output' }
MbDItem >> getString: string [ 
	^TheMbDSystem getString: string
]

{ #category : #'initialize-release' }
MbDItem >> initialize [
	"Called once only."
	"Used immediately after instance creation."
	"Create the data structure for the instance."
	"Default is do nothing."
]

{ #category : #'initialize-release' }
MbDItem >> initializeGlobally [
	"Called once only."
	"Initialize all constant dependent instance variables using local and global objects."
	"Default is do nothing."
]

{ #category : #'initialize-release' }
MbDItem >> initializeLocally [
	"Called once only."
	"Assume that the independent instance variables are already set."
	"Initialize all constant dependent instance variables using local objects only."
	"Default is do nothing."
]

{ #category : #testing }
MbDItem >> isJointForce [
	^false
]

{ #category : #testing }
MbDItem >> isJointTorque [
	^false
]

{ #category : #testing }
MbDItem >> isKineIJ [
	^false
]

{ #category : #testing }
MbDItem >> isKinedotIJ [
	^false
]

{ #category : #'input-output' }
MbDItem >> logString: string [ 
	TheMbDSystem logString: string
]

{ #category : #'input-output' }
MbDItem >> logString: string withArgument: string1 [ 
	TheMbDSystem logString: string withArgument: string1
]

{ #category : #'input-output' }
MbDItem >> logString: string withArguments: arrayOfStrings [ 
	TheMbDSystem logString: string withArguments: arrayOfStrings
]

{ #category : #accessing }
MbDItem >> name [
	^name asString
]

{ #category : #accessing }
MbDItem >> name: symbol [ 
	name := symbol asSymbol
]

{ #category : #collision }
MbDItem >> normalImpulse: aDouble [ 
	"Default is do nothing."
]

{ #category : #accIC }
MbDItem >> postAccIC [
	"Assume positions and velocities are valid."
	"Called after solving for acceleration initial conditions."
	"Update all instance variables dependent on position, velocity and acceleration regardless 
	of whether they are relevant to accIC."
	"Do nothing."
]

{ #category : #accIC }
MbDItem >> postAccICIteration [
	"Called after each iteration in the accIC solution."
	"Update only instance variables dependent on pddot,qddot,sddot,uddot,lam 
	that are needed for the iteration stage."
	"Default is do nothing."
]

{ #category : #collision }
MbDItem >> postCollisionCorrector [
	"Called after the corrector stage in the collision solution."
	"Update instance variables not updated by postCollisionCorrectorIteration."
	"Default is do nothing."
]

{ #category : #collision }
MbDItem >> postCollisionCorrectorIteration [
	"Called after the predictor stage in the collision solution."
	"Update only instance variables dependent on qdot,sdot,udot, Plam 
	that are needed for the corrector stage."
	"Default is do nothing."
]

{ #category : #collision }
MbDItem >> postCollisionDerivativeIC [
	"Do nothing."
]

{ #category : #collision }
MbDItem >> postCollisionPredictor [
	"Called after the predictor stage in the collision solution."
	"Update only instance variables dependent on qdot,sdot,udot, Plam 
	that are needed for the corrector stage."
	"Default is do nothing."
]

{ #category : #collision }
MbDItem >> postCollisionStep [
	"Do nothing."
]

{ #category : #dynamic }
MbDItem >> postDyn [
	"Assume runDYNAMICS ended successfully."
	"Called once at the end of runDYNAMICS."
	"Update all instance variables dependent on p,q,s,u,mu,pdot,qdot,sdot,udot,mudot (lam) 
	regardless of whether they are needed."
	"This is a subset of update."
	"Default is do nothing."
]

{ #category : #dynamic }
MbDItem >> postDynCorrector [
	"Called after the corrector stage in the dynamic solution."
	"Update instance variables not updated by postDynCorrectorIteration."
	"Default is do nothing."
]

{ #category : #dynamic }
MbDItem >> postDynCorrectorIteration [
	"Called after the predictor stage in the dynamic solution."
	"Update only instance variables dependent on p,q,s,u,mu,pdot,qdot,sdot,udot,mudot (lam) 
	that are needed for the corrector stage."

	self calcPostDynCorrectorIteration
]

{ #category : #dynamic }
MbDItem >> postDynFirstStep [
	"Called after the end of the first step in the dynamic solution."

	self postDynStep
]

{ #category : #dynamic }
MbDItem >> postDynOutput [
	"Calculate all instance variables just after output."

	self calcPostDynCorrectorIteration
]

{ #category : #dynamic }
MbDItem >> postDynPredictor [
	"Called after the predictor stage in the dynamic solution."
	"Update only instance variables dependent on p,q,s,u,mu,pdot,qdot,sdot,udot,mudot (lam) 
	that are needed for the corrector stage."
	"Needless updating can be expensive here."
	"This is a subset of update."
	"Default is do nothing."
	"updateInSimulation is the interface to the old system."

	self calcPostDynCorrectorIteration
]

{ #category : #dynamic }
MbDItem >> postDynStep [
	"Called after the end of a complete step in the dynamic solution."
	"Update info before checking for discontinuities."
	"Default is do nothing."
]

{ #category : #'input-output' }
MbDItem >> postInput [
	"Called once after input."

	self calcPostDynCorrectorIteration
]

{ #category : #posIC }
MbDItem >> postPosIC [
	"Called once after solving for position initial conditions."
	"Update all instance variables dependent on position regardless of whether they are 
	relevant to posIC."
	"postPosICIteration should have done a lot."
	"Default is do nothing."
]

{ #category : #posIC }
MbDItem >> postPosICIteration [
	"Called after each iteration in the posIC solution."
	"Update only instance variables dependent on p,q,s,u,lam 
	that are needed for the iteration stage."
	"This is a subset of update."
	"Default is do nothing."

	self calcPostDynCorrectorIteration
]

{ #category : #static }
MbDItem >> postStatic [
	"Assume runSTATICS ended successfully."
	"Called once at the end of runSTATICS."
	"Update all instance variables dependent on p,q,s,u,mu,pdot,qdot,sdot,udot,mudot (lam) 
	regardless of whether they are needed."
	"Default is do nothing."
]

{ #category : #static }
MbDItem >> postStaticIteration [
	"Called after each iteration in the static solution."
	"Update only instance variables dependent on q,s,u,w,lam. 
	that are needed for the iteration stage."
	"This is a subset of update."

	self calcPostDynCorrectorIteration
]

{ #category : #velIC }
MbDItem >> postVelIC [
	"Assume positions are valid."
	"Called after solving for velocity initial conditions."
	"Update all instance variables dependent on position and velocity regardless of whether 
	they are relevant to velIC."
	"Default is do nothing."
]

{ #category : #accIC }
MbDItem >> preAccIC [
	"Assume positions and velocities are valid."
	"Called once before solving for acceleration initial conditions."
	"Update all variable dependent instance variables needed for accIC even if they have 
	been calculated in postPosIC and postVelIC."

	self calcPostDynCorrectorIteration
]

{ #category : #collision }
MbDItem >> preCollision [
	"Assume positions, velocities and accelerations are valid."
	"Called once before solving for collision solution."
	"Update all variable dependent instance variables needed for runDYNAMICS even if they 
	have been calculated in postPosIC, postVelIC and postAccIC."
	"Calculate p, pdot."
	"Default is do nothing."
]

{ #category : #collision }
MbDItem >> preCollisionCorrector [
	"Called before the corrector stage in the collision solution."
	"postCollisionPredictor should have done the updating needed."
	"Some checking for suitability of predicted values may be done here."
	"Default is do nothing."
]

{ #category : #collision }
MbDItem >> preCollisionCorrectorIteration [
	"Called before each corrector iteration in the collision solution."
	"postCollisionPredictor or postCollisionCorrectorIteration should have done the updating needed."
	"Some checking for suitability of predicted or corrected values may be done here."
	"Default is do nothing."
]

{ #category : #collision }
MbDItem >> preCollisionDerivativeIC [
	"Do nothing."
]

{ #category : #collision }
MbDItem >> preCollisionPredictor [
	"Assume past p,q,s,u,mu,pdot,qdot,sdot,udot,mudot (lam) are valid."
	"Called before the predictor stage in the collision solution."
	"Dependent instance variables should not be involved."
	"Default is do nothing."
]

{ #category : #collision }
MbDItem >> preCollisionStep [
	"Called before the start of a step in the collision solution."
	"Default is do nothing."
]

{ #category : #dynamic }
MbDItem >> preDyn [
	"Assume positions, velocities and accelerations are valid."
	"Called once before solving for dynamic solution."
	"Update all variable dependent instance variables needed for runDYNAMICS even if they 
	have been calculated in postPosIC, postVelIC and postAccIC."
	"Calculate p, pdot."
	"Default is do nothing."
]

{ #category : #dynamic }
MbDItem >> preDynCorrector [
	"Called before the corrector stage in the dynamic solution."
	"postDynPredictor should have done the updating needed."
	"Some checking for suitability of predicted values may be done here."
	"Default is do nothing."
]

{ #category : #dynamic }
MbDItem >> preDynCorrectorIteration [
	"Called before each corrector iteration in the dynamic solution."
	"postDynPredictor or postDynCorrectorIteration should have done the updating needed."
	"Some checking for suitability of predicted or corrected values may be done here."
	"Default is do nothing."
]

{ #category : #dynamic }
MbDItem >> preDynFirstStep [
	"Called before the start of the first step in the dynamic solution."

	self preDynStep
]

{ #category : #dynamic }
MbDItem >> preDynOutput [
	"Calculate all instance variables just before output."

	self calcPostDynCorrectorIteration
]

{ #category : #dynamic }
MbDItem >> preDynPredictor [
	"Assume past p,q,s,u,mu,pdot,qdot,sdot,udot,mudot (lam) are valid."
	"Called before the predictor stage in the dynamic solution."
	"Dependent instance variables should not be involved."
	"Default is do nothing."
]

{ #category : #dynamic }
MbDItem >> preDynStep [
	"Called before the start of a step in the dynamic solution."
	"Default is do nothing."
]

{ #category : #posIC }
MbDItem >> preICRestart [
	"Do all the transitions or mutations before restart here."
	"Default is do nothing."
]

{ #category : #posIC }
MbDItem >> prePosIC [
	"Called once before solving for position initial conditions."
	"Update all variable dependent instance variables needed for posIC."
	"This is a subset of update."
	"Default is do nothing."

	self calcPostDynCorrectorIteration
]

{ #category : #kine }
MbDItem >> prePosKine [
	self prePosIC
]

{ #category : #static }
MbDItem >> preStatic [
	"Called once before solving for static solution."
	"Velocities and accelerations are set to zeros."
	"Update all variable dependent on instance variables needed for runSTATICS even if they 
	have been calculated in postPosIC, postVelIC and postAccIC."
	"This is a subset of update."

	self calcPostDynCorrectorIteration
]

{ #category : #velIC }
MbDItem >> preVelIC [
	"Assume positions are valid."
	"Called once before solving for velocity initial conditions."
	"Update all variable dependent instance variables needed for velIC even if they have 
	been calculated in postPosIC."
	"Variables dependent on t are updated."

	self calcPostDynCorrectorIteration
]

{ #category : #accessing }
MbDItem >> registerName [
	| namedItems |
	((name isKindOf: String) and: [name isEmpty not]) 
		ifTrue: 
			[namedItems := TheMbDSystem namedItems.
			(namedItems at: name) isNil 
				ifTrue: [namedItems at: name put: self]
				ifFalse: 
					[self logString: #'MbD: \The name (%1) is defined more than once.'
						withArgument: name.
					SimulationStoppingError raiseSignal]]
		ifFalse: [self error: 'TheMbDSystem is trying to register an unnamed item.']
]

{ #category : #accessing }
MbDItem >> registerName1 [
	| namedItems |
	name == nil
		ifTrue: [self error: 'TheMbDSystem is trying to register an unnamed item.']
		ifFalse: 
			[namedItems := TheMbDSystem namedItems.
			(namedItems at: name) isNil
				ifTrue: [namedItems at: name put: self]
				ifFalse: 
					[self logString: #'MbD: \The name (%1) is defined more than once.' withArgument: name.
					SimulationStoppingError raiseSignal]]
]

{ #category : #posIC }
MbDItem >> removeRedundantConstraints: redundantEqns [ 
	"Default is do nothing."
]

{ #category : #accessing }
MbDItem >> setpqsumu: col [ 
	"Default is do nothing."
]

{ #category : #accessing }
MbDItem >> setpqsumuddot: col [ 
	"Default is do nothing."
]

{ #category : #accessing }
MbDItem >> setpqsumudot: col [ 
	"Default is do nothing."
]

{ #category : #accessing }
MbDItem >> setqsu: col [ 
	"Default is do nothing."
]

{ #category : #accessing }
MbDItem >> setqsuddotlam: col [ 
	"Default is do nothing."
]

{ #category : #accessing }
MbDItem >> setqsudot: col [ 
	"Default is do nothing."
]

{ #category : #accessing }
MbDItem >> setqsudotPlam: col [ 
	"Default is do nothing."
]

{ #category : #accessing }
MbDItem >> setqsudotPlamDeriv: col [ 
	"Default is do nothing."
]

{ #category : #accessing }
MbDItem >> setqsudotlam: col [ 
	"Default is do nothing."
]

{ #category : #accessing }
MbDItem >> setqsulam: col [ 
	"Default is do nothing."
]

{ #category : #dynamic }
MbDItem >> simUpdateAll [
	self calcPostDynCorrectorIteration
]

{ #category : #collision }
MbDItem >> storeCollisionState [
	"Store current state in time series."
	"Default is do nothing."
]

{ #category : #dynamic }
MbDItem >> storeDynState [
	"Store current state in time series."
	"Default is do nothing."
]

{ #category : #'initialize-release' }
MbDItem >> submitToSystem [
	"Commit an MbDItem to TheMbDSystem."

	self subclassResponsibility
]

{ #category : #dynamic }
MbDItem >> suggestSmallerOrAcceptCollisionFirstStepSize: hnew [ 
	"Default is return hnew."
	"Best to do nothing so as not to disrupt the starting algorithm."

	^hnew
]

{ #category : #dynamic }
MbDItem >> suggestSmallerOrAcceptCollisionStepSize: hnew [ 
	"Default is return hnew."
	"Best to do nothing so as not to disrupt the starting algorithm."

	^hnew
]

{ #category : #dynamic }
MbDItem >> suggestSmallerOrAcceptDynFirstStepSize: hnew [ 
	"Default is return hnew."
	"Best to do nothing so as not to disrupt the starting algorithm."

	^hnew
]

{ #category : #dynamic }
MbDItem >> suggestSmallerOrAcceptDynStepSize: hnew [ 
	"Default is return hnew."

	^hnew
]

{ #category : #'initialize-release' }
MbDItem >> useEquationNumbers [
	"Equation numbers have just been assigned to parts, endframes and constraints."
	"Derived variables can now use those numbers."
	"Default is do nothing."
]
