Class {
	#name : #MbDPerturbedPosICNewtonRaphson2,
	#superclass : #MbDPosICNewtonRaphson2,
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'initialize-release' }
MbDPerturbedPosICNewtonRaphson2 >> initializeGlobally [
	| delta |
	super initializeGlobally.
	delta := 0.01d.
	system partsJointsMotionsDo: [:item | item bePerturbed: delta fillqsulam: x].
	system partsJointsMotionsDo: [:item | item postPosICIteration]
]
