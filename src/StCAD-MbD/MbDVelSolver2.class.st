Class {
	#name : #MbDVelSolver2,
	#superclass : #MbDSolver,
	#instVars : [
		'system',
		'n',
		'errorVector',
		'jacobian',
		'matrixSolver'
	],
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #run }
MbDVelSolver2 >> basicSolveEquations [
	^matrixSolver 
		solve: jacobian
		with: errorVector
		saveOriginal: true
]

{ #category : #run }
MbDVelSolver2 >> handleSingularMatrix [
	^(matrixSolver isMemberOf: GESpMatParPvMarkoFast) 
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

{ #category : #run }
MbDVelSolver2 >> logSingularMatrixMessage [
	system 
		logString: #'MbD: \Velocity solver has encountered a singular matrix.'
]

{ #category : #accessing }
MbDVelSolver2 >> matrixSolverClass [
	"It is not safe to use StMGESpMatParPvMarkoFast3 because unstable answer can result when the matrix is large. Since velocity calculation is not iterative, the time cost is low."

	^GESpMatParPvPrecise
]

{ #category : #run }
MbDVelSolver2 >> solveEquations [
	^[self basicSolveEquations] on: SingularMatrixError
		do: [:ex | ex return: self handleSingularMatrix]
]

{ #category : #accessing }
MbDVelSolver2 >> system: object [ 
	system := object
]
