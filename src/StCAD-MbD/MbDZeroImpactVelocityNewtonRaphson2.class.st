Class {
	#name : #MbDZeroImpactVelocityNewtonRaphson2,
	#superclass : #MbDScalarNewtonRaphson2,
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'VisualWorks metadata' }
MbDZeroImpactVelocityNewtonRaphson2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #solving }
MbDZeroImpactVelocityNewtonRaphson2 >> fillPyPx [
	pypx := system impactVelocityDerivative: 1 at: x
]

{ #category : #solving }
MbDZeroImpactVelocityNewtonRaphson2 >> fillY [
	y := system impactVelocityAt: x
]

{ #category : #solving }
MbDZeroImpactVelocityNewtonRaphson2 >> incrementIterNo [
	iterNo >= iterMax
		ifTrue: 
			[system logString: #'MbD: \Solver cannot locate maximum compression in collision after %1 iterations.' withArgument: iterNo printString.
			SimulationStoppingError raiseSignal].
	iterNo := iterNo + 1
]

{ #category : #'initialize-release' }
MbDZeroImpactVelocityNewtonRaphson2 >> initializeGlobally [
	x := system impulseStart
]

{ #category : #solving }
MbDZeroImpactVelocityNewtonRaphson2 >> passRootToSystem [
	system impulseStart: x
]

{ #category : #solving }
MbDZeroImpactVelocityNewtonRaphson2 >> preRun [
	| impulseGuess |
	impulseGuess := system interpolator firstPastTimeNode.
	system impulseStart: impulseGuess
]
