Class {
	#name : #MbDCollisionDerivativeICNewtonRaphson2,
	#superclass : #MbDSystemNewtonRaphson2,
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'VisualWorks metadata' }
MbDCollisionDerivativeICNewtonRaphson2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #solving }
MbDCollisionDerivativeICNewtonRaphson2 >> askSystemToUpdate [
	"Do nothing."
]

{ #category : #'initialize-release' }
MbDCollisionDerivativeICNewtonRaphson2 >> assignEquationNumbers [
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
MbDCollisionDerivativeICNewtonRaphson2 >> fillPyPx [
	pypx zeroSelf.
	system partsJointsMotionsDo: [:item | item fillCollisionDerivativeICJacob: pypx]
]

{ #category : #solving }
MbDCollisionDerivativeICNewtonRaphson2 >> fillY [
	y zeroSelf.
	system partsJointsMotionsDo: [:item | item fillCollisionDerivativeICError: y]
]

{ #category : #'initialize-release' }
MbDCollisionDerivativeICNewtonRaphson2 >> initializeGlobally [
	super initializeGlobally.
	x zeroSelf
]

{ #category : #solving }
MbDCollisionDerivativeICNewtonRaphson2 >> isConverged [
	"No friction case for now."
	"Hence system is linear."

	^true
]

{ #category : #solving }
MbDCollisionDerivativeICNewtonRaphson2 >> logSingularMatrixMessage [
	system 
		logString: #'MbD: \Collision derivative solver has encountered a singular matrix.'
]

{ #category : #solving }
MbDCollisionDerivativeICNewtonRaphson2 >> passRootToSystem [
	system partsJointsMotionsDo: [:item | item setqsudotPlamDeriv: x]
]

{ #category : #solving }
MbDCollisionDerivativeICNewtonRaphson2 >> postRun [
	system partsJointsMotionsDo: [:item | item postCollisionDerivativeIC]
]

{ #category : #solving }
MbDCollisionDerivativeICNewtonRaphson2 >> preRun [
	system logString: #'MbD: \Solving for collision derivative initial conditions.'.
	system partsJointsMotionsDo: [:item | item preCollisionDerivativeIC]
]
