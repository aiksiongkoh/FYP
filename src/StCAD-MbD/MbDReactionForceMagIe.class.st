Class {
	#name : #MbDReactionForceMagIe,
	#superclass : #MbDReactionMag,
	#instVars : [
		'aFIe',
		'pFIepXI',
		'pFIepEI',
		'pFIepXJ',
		'pFIepEJ',
		'pFIeplam'
	],
	#category : #'StCAD-MbD-MbDReaction'
}

{ #category : #calc }
MbDReactionForceMagIe >> calcPostDynCorrectorIteration [
	| aFIeJtO uFIeJtO |
	aFIeJtO := joint aFIeJtO.
	aFIe := aFIeJtO length.
	aFIe = 0.0d
		ifTrue: 
			[pFIepXI := FullRow new: 3.
			pFIepEI := FullRow new: 4.
			pFIepXJ := FullRow new: 3.
			pFIepEJ := FullRow new: 4.
			pFIeplam := SparseRow new]
		ifFalse: 
			[uFIeJtO := aFIeJtO times: 1.0d / aFIe.
			pFIepXI := uFIeJtO dot: joint pFIeJtOpXI.
			pFIepEI := uFIeJtO dot: joint pFIeJtOpEI.
			pFIepXJ := uFIeJtO dot: joint pFIeJtOpXJ.
			pFIepEJ := uFIeJtO dot: joint pFIeJtOpEJ.
			pFIeplam := uFIeJtO transpose timesSparseMatrix: joint pFIeJtOplam]
]

{ #category : #accessing }
MbDReactionForceMagIe >> isJointForce [
	^true
]

{ #category : #'input-output' }
MbDReactionForceMagIe >> postInput [
	aFIe := joint aFIeJtO length
]

{ #category : #accessing }
MbDReactionForceMagIe >> pvaluepEI [
	^pFIepEI
]

{ #category : #accessing }
MbDReactionForceMagIe >> pvaluepEJ [
	^pFIepEJ
]

{ #category : #accessing }
MbDReactionForceMagIe >> pvaluepXI [
	^pFIepXI
]

{ #category : #accessing }
MbDReactionForceMagIe >> pvaluepXJ [
	^pFIepXJ
]

{ #category : #accessing }
MbDReactionForceMagIe >> pvalueplam [
	^pFIeplam
]

{ #category : #accessing }
MbDReactionForceMagIe >> value [
	^aFIe
]
