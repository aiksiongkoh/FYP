Class {
	#name : #MbDStaticICNewtonRaphson2,
	#superclass : #MbDSystemNewtonRaphson2,
	#instVars : [
		'nqsu',
		'qsuOld',
		'qsuWeights'
	],
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'VisualWorks metadata' }
MbDStaticICNewtonRaphson2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #solving }
MbDStaticICNewtonRaphson2 >> askSystemToUpdate [
	system partsJointsMotionsForcesTorquesDo: [:item | item postStaticIteration]
]

{ #category : #'initialize-release' }
MbDStaticICNewtonRaphson2 >> assignEquationNumbers [
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
	nqsu := eqnNo - 1.
	constraints
		do: 
			[:con | 
			con iG: eqnNo.
			eqnNo := eqnNo + 1].
	n := eqnNo - 1
]

{ #category : #'initialize-release' }
MbDStaticICNewtonRaphson2 >> createVectorsAndMatrices [
	qsuOld := FullColumn new: nqsu.
	qsuWeights := DiagonalMatrix new: nqsu.
	super createVectorsAndMatrices
]

{ #category : #solving }
MbDStaticICNewtonRaphson2 >> fillPyPx [
	pypx zeroSelf.
	pypx
		at: 1
		and: 1
		minusDiagonalMatrix: qsuWeights.
	system partsJointsMotionsForcesTorquesDo: [:item | item fillStaticJacob: pypx]
]

{ #category : #solving }
MbDStaticICNewtonRaphson2 >> fillY [
	| newMinusOld |
	newMinusOld := qsuOld negated.
	newMinusOld equalSelfPlusFullColumn: x at: 1.
	y zeroSelf.
	y at: 1 minusFullColumn: (qsuWeights timesFullColumn: newMinusOld).
	system partsJointsMotionsForcesTorquesDo: [:item | item fillStaticError: y]
]

{ #category : #solving }
MbDStaticICNewtonRaphson2 >> incrementIterNo [
	iterNo >= iterMax
		ifTrue: 
			[system logString: #'MbD: \No convergence after %1 iterations.' withArgument: iterNo printString.
			system logString: #'MbD: \A static solution cannot be found'.
			SimulationStoppingError raiseSignal].
	iterNo := iterNo + 1
]

{ #category : #'initialize-release' }
MbDStaticICNewtonRaphson2 >> initializeGlobally [
	super initializeGlobally.
	system partsJointsMotionsDo: 
			[:item | 
			item fillqsu: qsuOld.
			item fillqsulam: x].
	qsuWeights atAllPut: 1.0d-9.
	iterMax := system iterMaxAccKine.
	dxTol := system errorTolAccKine
]

{ #category : #solving }
MbDStaticICNewtonRaphson2 >> logSingularMatrixMessage [
	system logString: #'MbD: \A static solution cannot be found'
]

{ #category : #solving }
MbDStaticICNewtonRaphson2 >> passRootToSystem [
	system partsJointsMotionsDo: [:item | item setqsulam: x]
]

{ #category : #solving }
MbDStaticICNewtonRaphson2 >> postRun [
	system partsJointsMotionsForcesTorquesDo: [:item | item postStatic]
]

{ #category : #solving }
MbDStaticICNewtonRaphson2 >> preRun [
	system logString: #'MbD: \Iterating for static solution.'.
	system partsJointsMotionsForcesTorquesDo: [:item | item preStatic]
]
