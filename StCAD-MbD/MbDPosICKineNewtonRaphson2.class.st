Class {
	#name : #MbDPosICKineNewtonRaphson2,
	#superclass : #MbDAnyPosICNewtonRaphson2,
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'VisualWorks metadata' }
MbDPosICKineNewtonRaphson2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'initialize-release' }
MbDPosICKineNewtonRaphson2 >> assignEquationNumbers [
	"Equation order is q,s,u."

	| parts contactEndFrames uHolders constraints eqnNo |
	parts := system parts.
	contactEndFrames := system contactEndFrames.
	uHolders := system uHolders.
	constraints := system allConstraints.
	eqnNo := 1.
	parts do: 
			[:part | 
			part iqX: eqnNo.
			eqnNo := eqnNo + 3.
			part iqE: eqnNo.
			eqnNo := eqnNo + 4].
	contactEndFrames do: 
			[:endFrm | 
			endFrm is: eqnNo.
			eqnNo := eqnNo + endFrm sSize].
	uHolders do: 
			[:uHolder | 
			uHolder iu: eqnNo.
			eqnNo := eqnNo + 1].
	nqsu := eqnNo - 1.
	constraints do: 
			[:con | 
			con iG: eqnNo.
			eqnNo := eqnNo + 1].
	n := eqnNo - 1
]

{ #category : #'initialize-release' }
MbDPosICKineNewtonRaphson2 >> initializeGlobally [
	super initializeGlobally.
	iterMax := system iterMaxPosKine.
	dxTol := system errorTolPosKine
]

{ #category : #solving }
MbDPosICKineNewtonRaphson2 >> isConverged [
	^(dxNorms at: iterNo) < dxTol or: [self isConvergedToNumericalLimit]
]

{ #category : #solving }
MbDPosICKineNewtonRaphson2 >> logSingularMatrixMessage [
	system 
		logString: #'MbD: \Quasi kinematic solver has encountered a singular matrix.'
]

{ #category : #solving }
MbDPosICKineNewtonRaphson2 >> preRun [
	system logString: #'MbD: \Solving for quasi kinematic position.'.
	super preRun
]
