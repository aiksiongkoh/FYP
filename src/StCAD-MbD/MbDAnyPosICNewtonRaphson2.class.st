Class {
	#name : #MbDAnyPosICNewtonRaphson2,
	#superclass : #MbDPosNewtonRaphson2,
	#instVars : [
		'nqsu',
		'qsuOld',
		'qsuWeights',
		'nSingularMatrixError'
	],
	#category : #'StCAD-MbD-My Classes'
}

{ #category : #'initialize-release' }
MbDAnyPosICNewtonRaphson2 >> assignEquationNumbers [
	" *** This method was defined by StCAD.StMbD.MbDSystemNewtonRaphson2 as a subclass responsibility.
	Replace its body with a proper implementation. *** "

	self error: 'Subclass responsibility stub not reimplemented'
]

{ #category : #'initialize-release' }
MbDAnyPosICNewtonRaphson2 >> createVectorsAndMatrices [
	qsuOld := FullColumn new: nqsu.
	qsuWeights := DiagonalMatrix new: nqsu.
	super createVectorsAndMatrices
]

{ #category : #solving }
MbDAnyPosICNewtonRaphson2 >> fillPyPx [
	pypx zeroSelf.
	pypx 
		at: 1
		and: 1
		minusDiagonalMatrix: qsuWeights.
	system partsJointsMotionsDo: [:item | item fillPosICJacob: pypx]
]

{ #category : #solving }
MbDAnyPosICNewtonRaphson2 >> fillY [
	| newMinusOld |
	newMinusOld := qsuOld negated.
	newMinusOld equalSelfPlusFullColumn: x at: 1.
	y zeroSelf.
	y at: 1 minusFullColumn: (qsuWeights timesFullColumn: newMinusOld).
	system partsJointsMotionsDo: [:item | item fillPosICError: y]
]

{ #category : #'initialize-release' }
MbDAnyPosICNewtonRaphson2 >> initialize [
	super initialize.
	nSingularMatrixError := 0
]

{ #category : #'initialize-release' }
MbDAnyPosICNewtonRaphson2 >> initializeGlobally [
	super initializeGlobally.
	system partsJointsMotionsDo: 
			[:item | 
			item fillqsu: qsuOld.
			item fillqsuWeights: qsuWeights.
			item fillqsulam: x]
]

{ #category : #solving }
MbDAnyPosICNewtonRaphson2 >> passRootToSystem [
	system partsJointsMotionsDo: [:item | item setqsulam: x]
]
