Class {
	#name : #MbDMinDistIeJeNewtonRaphson2,
	#superclass : #VectorNewtonRaphson2,
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'VisualWorks metadata' }
MbDMinDistIeJeNewtonRaphson2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #solving }
MbDMinDistIeJeNewtonRaphson2 >> askSystemToUpdate [
	system postLocalSepDistIteration
]

{ #category : #solving }
MbDMinDistIeJeNewtonRaphson2 >> fillPyPx [
	pypx := system pprIeJepsps
]

{ #category : #solving }
MbDMinDistIeJeNewtonRaphson2 >> fillY [
	y := system prIeJeps
]

{ #category : #solving }
MbDMinDistIeJeNewtonRaphson2 >> incrementIterNo [
	iterNo := iterNo + 1.
	iterNo > iterMax ifTrue: [MaximumIterationError raiseSignal]
]

{ #category : #'initialize-release' }
MbDMinDistIeJeNewtonRaphson2 >> initializeGlobally [
	x := system s.
	matrixSolver := self matrixSolverClass new
]

{ #category : #'initialize-release' }
MbDMinDistIeJeNewtonRaphson2 >> initializeLocally [
	super initializeLocally.
	dxTol := 1.0d-9
]

{ #category : #solving }
MbDMinDistIeJeNewtonRaphson2 >> isConverged [
	^dxNorm < dxTol or: [yNorm < yNormTol or: [iterNo = iterMax]]
]

{ #category : #solving }
MbDMinDistIeJeNewtonRaphson2 >> passRootToSystem [
	system s: x
]

{ #category : #solving }
MbDMinDistIeJeNewtonRaphson2 >> postRun [
	"Do nothing."
]

{ #category : #solving }
MbDMinDistIeJeNewtonRaphson2 >> preRun [
	system preLocalSepDist
]

{ #category : #solving }
MbDMinDistIeJeNewtonRaphson2 >> run [
	self runWithBackTracking
]

{ #category : #solving }
MbDMinDistIeJeNewtonRaphson2 >> runWithBackTracking [
	self preRun.
	self initializeLocally.
	self initializeGlobally.
	self iterateWithBackTracking.
	self finalize.
	self postRun.
	^x
]
