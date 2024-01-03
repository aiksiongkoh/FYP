Class {
	#name : #MbDVelKineSolver2,
	#superclass : #MbDVelSolver2,
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'initialize-release' }
MbDVelKineSolver2 >> assignEquationNumbers [
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
	n == nvar ifFalse: [NotKinematicError raiseSignal]
]

{ #category : #run }
MbDVelKineSolver2 >> run [
	| qsudot |
	system logString: #'MbD: \Solving for kinematic velocity.'.
	system partsJointsMotionsDo: [:item | item preVelIC].
	self assignEquationNumbers.
	system partsJointsMotionsDo: [:item | item useEquationNumbers].
	errorVector := FullColumn new: n.
	jacobian := SparseMatrix new: n by: n.
	errorVector zeroSelf.
	system partsJointsMotionsDo: [:item | item fillVelICError: errorVector].
	jacobian zeroSelf.
	system partsJointsMotionsDo: [:item | item fillPosKineJacob: jacobian].
	matrixSolver := self matrixSolverClass new.
	qsudot := self solveEquations.
	system partsJointsMotionsDo: [:item | item setqsudot: qsudot].
	system partsJointsMotionsDo: [:item | item postVelIC]
]
