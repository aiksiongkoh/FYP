Class {
	#name : #MbDSystemNewtonRaphson2,
	#superclass : #VectorNewtonRaphson2,
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'VisualWorks metadata' }
MbDSystemNewtonRaphson2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'initialize-release' }
MbDSystemNewtonRaphson2 >> assignEquationNumbers [
	self subclassResponsibility
]

{ #category : #solving }
MbDSystemNewtonRaphson2 >> calcdxNorm [
	super calcdxNorm.
	system logString: #'MbD: \Convergence = %1.' withArgument: dxNorm printString
]

{ #category : #'initialize-release' }
MbDSystemNewtonRaphson2 >> createVectorsAndMatrices [
	x := FullColumn new: n.
	y := FullColumn new: n.
	pypx := SparseMatrix new: n by: n
]

{ #category : #solving }
MbDSystemNewtonRaphson2 >> handleSingularMatrix [
	(matrixSolver isMemberOf: GESpMatParPvMarkoFast) 
		ifTrue: 
			[matrixSolver := GESpMatParPvPrecise new.
			self solveEquations]
		ifFalse: 
			[(matrixSolver isMemberOf: GESpMatParPvPrecise) 
				ifTrue: 
					[self logSingularMatrixMessage.
					SimulationStoppingError raiseSignal]
				ifFalse: [self halt: 'Check this.']]
]

{ #category : #'initialize-release' }
MbDSystemNewtonRaphson2 >> initializeGlobally [
	self assignEquationNumbers.
	system 
		partsJointsMotionsForcesTorquesDo: [:item | item useEquationNumbers].
	self createVectorsAndMatrices.
	matrixSolver := self matrixSolverClass new
]

{ #category : #accessing }
MbDSystemNewtonRaphson2 >> matrixSolverClass [
	^GESpMatParPvMarkoFast
]
