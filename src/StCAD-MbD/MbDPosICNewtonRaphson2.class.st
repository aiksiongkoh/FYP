Class {
	#name : #MbDPosICNewtonRaphson2,
	#superclass : #MbDAnyPosICNewtonRaphson2,
	#instVars : [
		'pivotRowLimits'
	],
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'initialize-release' }
MbDPosICNewtonRaphson2 >> assignEquationNumbers [
	"Equation order is q,s,u,lambar,lam."

	| parts contactEndFrames uHolders essentialConstraints displacementConstraints perpendicularConstraints eqnNo lastEssenConEqnNo lastDispConEqnNo |
	parts := system parts.
	contactEndFrames := system contactEndFrames.
	uHolders := system uHolders.
	essentialConstraints := system essentialConstraints2.
	displacementConstraints := system displacementConstraints.
	perpendicularConstraints := system perpendicularConstraints2.
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
	essentialConstraints
		do: 
			[:con | 
			con iG: eqnNo.
			eqnNo := eqnNo + 1].
	lastEssenConEqnNo := eqnNo - 1.
	displacementConstraints
		do: 
			[:con | 
			con iG: eqnNo.
			eqnNo := eqnNo + 1].
	lastDispConEqnNo := eqnNo - 1.
	perpendicularConstraints
		do: 
			[:con | 
			con iG: eqnNo.
			eqnNo := eqnNo + 1].
	n := eqnNo - 1.
	pivotRowLimits := Array
				with: lastEssenConEqnNo
				with: lastDispConEqnNo
				with: n
]

{ #category : #solving }
MbDPosICNewtonRaphson2 >> handleSingularMatrix [
	nSingularMatrixError := nSingularMatrixError + 1.
	nSingularMatrixError = 1 
		ifTrue: 
			[self lookForRedundantConstraints.
			matrixSolver := self matrixSolverClass new]
		ifFalse: 
			[(matrixSolver isMemberOf: GESpMatParPvMarkoFast) 
				ifTrue: 
					[matrixSolver := GESpMatParPvPrecise new.
					self solveEquations]
				ifFalse: 
					[(matrixSolver isMemberOf: GESpMatParPvPrecise) 
						ifTrue: 
							[self lookForRedundantConstraints.
							matrixSolver := self matrixSolverClass new]
						ifFalse: [self halt: 'Check this.']]]
]

{ #category : #solving }
MbDPosICNewtonRaphson2 >> isConverged [
	^self isConvergedToNumericalLimit
]

{ #category : #solving }
MbDPosICNewtonRaphson2 >> lookForRedundantConstraints [
	| posICsolver |
	system logString: #'MbD: \Checking for redundant constraints.'.
"	self toDebugTxtShowContextFrom: 1 to: 100."
	posICsolver := MbDGESpMatFullPvPosIC3 new.
	posICsolver system: self.
	ObjectMemory garbageCollect.
	dx := posICsolver 
				solve: pypx
				with: y negated
				saveOriginal: false.
	ObjectMemory garbageCollect
]

{ #category : #solving }
MbDPosICNewtonRaphson2 >> lookForRedundantConstraints1 [
	| posICsolver |
	system logString: #'MbD: \Checking for redundant constraints.'.
	posICsolver := MbDGESpMatFullPvPosIC3 new.
	posICsolver system: self.
	ObjectMemory garbageCollect.
	dx := posICsolver
				solve: pypx
				with: y negated
				saveOriginal: false.
	ObjectMemory garbageCollect
]
