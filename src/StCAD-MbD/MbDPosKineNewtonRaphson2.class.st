Class {
	#name : #MbDPosKineNewtonRaphson2,
	#superclass : #MbDPosNewtonRaphson2,
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'initialize-release' }
MbDPosKineNewtonRaphson2 >> assignEquationNumbers [
	"Equation order is q,s,u."

	| parts contactEndFrames uHolders constraints varNo nvar eqnNo |
	parts := system parts.
	contactEndFrames := system contactEndFrames.
	uHolders := system uHolders.
	constraints := system allConstraints.
	varNo := 1.
	parts
		do: 
			[:part | 
			part iqX: varNo.
			varNo := varNo + 3.
			part iqE: varNo.
			varNo := varNo + 4].
	contactEndFrames
		do: 
			[:endFrm | 
			endFrm is: varNo.
			varNo := varNo + endFrm sSize].
	uHolders
		do: 
			[:uHolder | 
			uHolder iu: varNo.
			varNo := varNo + 1].
	nvar := varNo - 1.
	eqnNo := 1.
	constraints
		do: 
			[:con | 
			con iG: eqnNo.
			eqnNo := eqnNo + 1].
	n := eqnNo - 1.
	n == nvar
		ifFalse: 
			[system logString: #'MbD: \SYSTEM IS NOT PURE KINEMATIC.'.
			NotKinematicError raiseSignal]
]

{ #category : #solving }
MbDPosKineNewtonRaphson2 >> fillPyPx [
	pypx zeroSelf.
	system partsJointsMotionsDo: [:item | item fillPosKineJacob: pypx]
]

{ #category : #solving }
MbDPosKineNewtonRaphson2 >> fillY [
	y zeroSelf.
	system partsJointsMotionsDo: [:item | item fillPosKineError: y]
]

{ #category : #'initialize-release' }
MbDPosKineNewtonRaphson2 >> initializeGlobally [
	super initializeGlobally.
	system partsJointsMotionsDo: [:item | item fillqsu: x].
	iterMax := system iterMaxPosKine.
	dxTol := system errorTolPosKine
]

{ #category : #solving }
MbDPosKineNewtonRaphson2 >> logSingularMatrixMessage [
	system 
		logString: #'MbD: \Kinematic solver has encountered a singular matrix.'
]

{ #category : #solving }
MbDPosKineNewtonRaphson2 >> passRootToSystem [
	system partsJointsMotionsDo: [:item | item setqsu: x]
]

{ #category : #solving }
MbDPosKineNewtonRaphson2 >> preRun [
	system logString: #'MbD: \Solving for kinematic position.'.
	system partsJointsMotionsDo: [:item | item prePosKine]
]
