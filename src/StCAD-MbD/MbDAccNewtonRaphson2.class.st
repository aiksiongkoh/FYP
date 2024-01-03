Class {
	#name : #MbDAccNewtonRaphson2,
	#superclass : #MbDSystemNewtonRaphson2,
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #solving }
MbDAccNewtonRaphson2 >> askSystemToUpdate [
	system partsJointsMotionsForcesTorquesDo: [:item | item postAccICIteration]
]

{ #category : #'initialize-release' }
MbDAccNewtonRaphson2 >> assignEquationNumbers [
	"Equation order is q,s,u,lamb,lam."

	| parts contactEndFrames uHolders constraints eqnNo |
	parts := system parts.
	contactEndFrames := system contactEndFrames.
	uHolders := system uHolders.
	constraints := system allConstraints.
	eqnNo := 1.
	parts
		do: 
			[:part | 
			part iqX: eqnNo.
			eqnNo := eqnNo + 3.
			part iqE: eqnNo.
			eqnNo := eqnNo + 4].
	contactEndFrames
		do: 
			[:endFrm | 
			endFrm is: eqnNo.
			eqnNo := eqnNo + endFrm sSize].
	uHolders
		do: 
			[:uHolder | 
			uHolder iu: eqnNo.
			eqnNo := eqnNo + 1].
	constraints
		do: 
			[:con | 
			con iG: eqnNo.
			eqnNo := eqnNo + 1].
	n := eqnNo - 1
]

{ #category : #solving }
MbDAccNewtonRaphson2 >> fillPyPx [
	pypx zeroSelf.
	system partsJointsMotionsForcesTorquesDo: [:item | item fillAccICIterJacob: pypx]
]

{ #category : #solving }
MbDAccNewtonRaphson2 >> fillY [
	y zeroSelf.
	system partsJointsMotionsForcesTorquesDo: [:item | item fillAccICIterError: y]
]

{ #category : #solving }
MbDAccNewtonRaphson2 >> incrementIterNo [
	iterNo >= iterMax
		ifTrue: 
			[system logString: #'MbD: \No convergence after %1 iterations. \A force function of joint reactions can cause this problem \if the function returns large values.' withArgument: iterNo printString.
			SimulationStoppingError raiseSignal].
	iterNo := iterNo + 1
]

{ #category : #'initialize-release' }
MbDAccNewtonRaphson2 >> initializeGlobally [
	super initializeGlobally.
	system partsJointsMotionsDo: [:item | item fillqsuddotlam: x]
]

{ #category : #solving }
MbDAccNewtonRaphson2 >> logSingularMatrixMessage [
	system 
		logString: #'MbD: \Some parts with zero masses or moment of inertias have infinite accelerations. \Add masses and inertias to or properly constrain those parts.'
]

{ #category : #solving }
MbDAccNewtonRaphson2 >> passRootToSystem [
	system partsJointsMotionsDo: [:item | item setqsuddotlam: x]
]

{ #category : #solving }
MbDAccNewtonRaphson2 >> postRun [
	system partsJointsMotionsForcesTorquesDo: [:item | item postAccIC]
]

{ #category : #solving }
MbDAccNewtonRaphson2 >> preRun [
	system partsJointsMotionsForcesTorquesDo: [:item | item preAccIC]
]
