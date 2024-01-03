Class {
	#name : #MinSepMaxPenIeJeNewtonRaphson2,
	#superclass : #VectorNewtonRaphson2,
	#instVars : [
		'aAIe3Je1',
		'lamConstraint',
		'sSizeI',
		'sSizeJ'
	],
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #solving }
MinSepMaxPenIeJeNewtonRaphson2 >> askSystemToUpdate [
	system endFramesCalc.
	system calcPostLocalSepDistIteration.
	aAIe3Je1 calcPostDynCorrectorIteration
]

{ #category : #solving }
MinSepMaxPenIeJeNewtonRaphson2 >> fillPyPx [
	pypx
		at: 1
		and: 1
		putFullMatrix: system ppvaluepsIpsI + (aAIe3Je1 ppvaluepsIpsI times: lamConstraint).
	pypx
		at: 1
		and: sSizeI + 1
		putFullMatrix: system ppvaluepsIpsJ + (aAIe3Je1 ppvaluepsIpsJ times: lamConstraint).
	pypx
		at: 1
		and: sSizeI + sSizeJ + 1
		putFullColumn: aAIe3Je1 pvaluepsI.
	pypx
		at: sSizeI + 1
		and: sSizeI + 1
		putFullMatrix: system ppvaluepsJpsJ + (aAIe3Je1 ppvaluepsJpsJ times: lamConstraint).
	pypx
		at: sSizeI + 1
		and: sSizeI + sSizeJ + 1
		putFullColumn: aAIe3Je1 pvaluepsJ.
	pypx
		at: sSizeI + sSizeJ + 1
		and: sSizeI + sSizeJ + 1
		put: 0.0d.
	pypx symLowerWithUpper
]

{ #category : #solving }
MinSepMaxPenIeJeNewtonRaphson2 >> fillY [
	y at: 1 putFullColumn: system pvaluepsI + (aAIe3Je1 pvaluepsI times: lamConstraint).
	y at: sSizeI + 1 putFullColumn: system pvaluepsJ + (aAIe3Je1 pvaluepsJ times: lamConstraint).
	y at: sSizeI + sSizeJ + 1 put: aAIe3Je1 value
]

{ #category : #solving }
MinSepMaxPenIeJeNewtonRaphson2 >> incrementIterNo [
	iterNo := iterNo + 1.
	iterNo > iterMax ifTrue: [MaximumIterationError raiseSignal]
]

{ #category : #'initialize-release' }
MinSepMaxPenIeJeNewtonRaphson2 >> initializeGlobally [
	| lamSize |
	aAIe3Je1 initializeGlobally.
	aAIe3Je1 calcPostDynCorrectorIteration.
	lamSize := 1.
	lamConstraint := 0.0d.
	n := sSizeI + sSizeJ + lamSize.
	x := FullColumn new: n.
	y := FullColumn new: n.
	pypx := FullMatrix new: n by: n.
	x at: 1 putFullColumn: system frmI s.
	x at: sSizeI + 1 putFullColumn: system frmJ s.
	x at: sSizeI + sSizeJ + 1 put: lamConstraint.
	matrixSolver := self matrixSolverClass new
]

{ #category : #'initialize-release' }
MinSepMaxPenIeJeNewtonRaphson2 >> initializeLocally [
	super initializeLocally.
	aAIe3Je1 initializeLocally.
	dxTol := 1.0d-9
]

{ #category : #solving }
MinSepMaxPenIeJeNewtonRaphson2 >> isConverged [
	^dxNorm < dxTol or: [yNorm < yNormTol or: [iterNo = iterMax]]
]

{ #category : #solving }
MinSepMaxPenIeJeNewtonRaphson2 >> passRootToSystem [
	system frmI s equalFullColumn: x at: 1.
	system frmJ s equalFullColumn: x at: sSizeI + 1.
	lamConstraint := x at: sSizeI + sSizeJ + 1
]

{ #category : #solving }
MinSepMaxPenIeJeNewtonRaphson2 >> postRun [
	"Do nothing."
]

{ #category : #solving }
MinSepMaxPenIeJeNewtonRaphson2 >> preRun [
	system endFramesCalc.
	system calcPostLocalSepDistIteration
]

{ #category : #solving }
MinSepMaxPenIeJeNewtonRaphson2 >> run [
	self runWithBackTracking
]

{ #category : #solving }
MinSepMaxPenIeJeNewtonRaphson2 >> runWithBackTracking [
	self preRun.
	self initializeLocally.
	self initializeGlobally.
	self iterateWithBackTracking.
	self finalize.
	self postRun.
	^x
]

{ #category : #accessing }
MinSepMaxPenIeJeNewtonRaphson2 >> system: rIeJe [ 
	| frmI frmJ |
	super system: rIeJe.
	frmI := rIeJe frmI.
	frmJ := rIeJe frmJ.
	aAIe3Je1 := MbDDirectionCosineIecJec
				withFrmI: frmI
				frmJ: frmJ
				axisI: 3
				axisJ: 1.
	sSizeI := frmI sSize.
	sSizeJ := frmJ sSize
]
