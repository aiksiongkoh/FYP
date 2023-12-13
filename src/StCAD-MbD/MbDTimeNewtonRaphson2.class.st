Class {
	#name : #MbDTimeNewtonRaphson2,
	#superclass : #MbDScalarNewtonRaphson2,
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'VisualWorks metadata' }
MbDTimeNewtonRaphson2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #solving }
MbDTimeNewtonRaphson2 >> incrementIterNo [
	iterNo >= iterMax
		ifTrue: 
			[system logString: #'MbD: \Solver cannot locate contact discontinuity after %1 iterations.' withArgument: iterNo printString.
			SimulationStoppingError raiseSignal].
	iterNo := iterNo + 1
]

{ #category : #'initialize-release' }
MbDTimeNewtonRaphson2 >> initializeGlobally [
	x := system tstart
]

{ #category : #solving }
MbDTimeNewtonRaphson2 >> passRootToSystem [
	system tstart: x
]

{ #category : #solving }
MbDTimeNewtonRaphson2 >> preRun [
	| tguess |
	tguess := system interpolator firstPastTimeNode.
	system tstart: tguess
]
