Class {
	#name : #MbDDragPosICNewtonRaphson2,
	#superclass : #MbDPosICNewtonRaphson2,
	#instVars : [
		'dragPart'
	],
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'VisualWorks metadata' }
MbDDragPosICNewtonRaphson2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDDragPosICNewtonRaphson2 >> dragPart [
	^dragPart
]

{ #category : #accessing }
MbDDragPosICNewtonRaphson2 >> dragPart: anObject [
	dragPart := anObject
]

{ #category : #'initialize-release' }
MbDDragPosICNewtonRaphson2 >> initialize [
	super initialize.
	dxTol := 1.0d-6
]

{ #category : #'initialize-release' }
MbDDragPosICNewtonRaphson2 >> initializeGlobally [
	super initializeGlobally.
	system partsJointsMotionsDo: 
			[:item | 
			item fillqsu: qsuOld.
			dragPart == item 
				ifTrue: [item fillqsuWeightsBig: qsuWeights]
				ifFalse: [item fillqsuWeightsSmall: qsuWeights].
			item fillqsulam: x]
]

{ #category : #solving }
MbDDragPosICNewtonRaphson2 >> isConverged [
	^(dxNorms at: iterNo) < dxTol
]
