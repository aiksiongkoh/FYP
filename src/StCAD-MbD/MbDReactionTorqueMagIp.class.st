Class {
	#name : #MbDReactionTorqueMagIp,
	#superclass : #MbDReactionMag,
	#instVars : [
		'aTIp',
		'pTIppXI',
		'pTIppEI',
		'pTIppXJ',
		'pTIppEJ',
		'pTIpplam'
	],
	#category : #'StCAD-MbD-MbDReaction'
}

{ #category : #calc }
MbDReactionTorqueMagIp >> calcPostDynCorrectorIteration [
	| aTIeJtO uTIeJtO |
	aTIeJtO := joint aTIeJtO.
	aTIp := aTIeJtO length.
	aTIp = 0.0d
		ifTrue: 
			[pTIppXI := FullRow new: 3.
			pTIppEI := FullRow new: 4.
			pTIppXJ := FullRow new: 3.
			pTIppEJ := FullRow new: 4.
			pTIpplam := SparseRow new]
		ifFalse: 
			[uTIeJtO := aTIeJtO times: 1.0d / aTIp.
			pTIppXI := uTIeJtO dot: joint pTIeJtOpXI.
			pTIppEI := uTIeJtO dot: joint pTIeJtOpEI.
			pTIppXJ := uTIeJtO dot: joint pTIeJtOpXJ.
			pTIppEJ := uTIeJtO dot: joint pTIeJtOpEJ.
			pTIpplam := uTIeJtO transpose timesSparseMatrix: joint pTIeJtOplam]
]

{ #category : #accessing }
MbDReactionTorqueMagIp >> isJointTorque [
	^true
]

{ #category : #'input-output' }
MbDReactionTorqueMagIp >> postInput [
	aTIp := joint aTIeJtO length
]

{ #category : #accessing }
MbDReactionTorqueMagIp >> pvaluepEI [
	^pTIppEI
]

{ #category : #accessing }
MbDReactionTorqueMagIp >> pvaluepEJ [
	^pTIppEJ
]

{ #category : #accessing }
MbDReactionTorqueMagIp >> pvaluepXI [
	^pTIppXI
]

{ #category : #accessing }
MbDReactionTorqueMagIp >> pvaluepXJ [
	^pTIppXJ
]

{ #category : #accessing }
MbDReactionTorqueMagIp >> pvalueplam [
	^pTIpplam
]

{ #category : #accessing }
MbDReactionTorqueMagIp >> value [
	^aTIp
]
