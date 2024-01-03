Class {
	#name : #MbDReactionForceCompIeKe,
	#superclass : #MbDReactionComp,
	#instVars : [
		'aFiIeKe',
		'pFiIeKepXI',
		'pFiIeKepEI',
		'pFiIeKepXJ',
		'pFiIeKepEJ',
		'pFiIeKepEK',
		'pFiIeKeplam'
	],
	#category : #'StCAD-MbD-MbDReaction'
}

{ #category : #calc }
MbDReactionForceCompIeKe >> calcPostDynCorrectorIteration [
	| aAjOKe pAjOKepEK |
	aAjOKe := efrmK aAjOe: axis.
	pAjOKepEK := efrmK pAjOepE: axis.
	aFiIeKe := aAjOKe dot: joint aFIeJtO.
	pFiIeKepXI := aAjOKe dot: joint pFIeJtOpXI.
	pFiIeKepEI := aAjOKe dot: joint pFIeJtOpEI.
	pFiIeKepXJ := aAjOKe dot: joint pFIeJtOpXJ.
	pFiIeKepEJ := aAjOKe dot: joint pFIeJtOpEJ.
	pFiIeKepEK := pAjOKepEK dot: joint aFIeJtO.
	pFiIeKeplam := aAjOKe transpose timesSparseMatrix: joint pFIeJtOplam
]

{ #category : #accessing }
MbDReactionForceCompIeKe >> isJointForce [
	^true
]

{ #category : #'input-output' }
MbDReactionForceCompIeKe >> postInput [
	| aAjOKe |
	aAjOKe := efrmK aAjOe: axis.
	aFiIeKe := aAjOKe dot: joint aFIeJtO
]

{ #category : #accessing }
MbDReactionForceCompIeKe >> pvaluepEI [
	^pFiIeKepEI
]

{ #category : #accessing }
MbDReactionForceCompIeKe >> pvaluepEJ [
	^pFiIeKepEJ
]

{ #category : #accessing }
MbDReactionForceCompIeKe >> pvaluepEK [
	^pFiIeKepEK
]

{ #category : #accessing }
MbDReactionForceCompIeKe >> pvaluepXI [
	^pFiIeKepXI
]

{ #category : #accessing }
MbDReactionForceCompIeKe >> pvaluepXJ [
	^pFiIeKepXJ
]

{ #category : #accessing }
MbDReactionForceCompIeKe >> pvaluepXK [
	^nil
]

{ #category : #accessing }
MbDReactionForceCompIeKe >> pvalueplam [
	^pFiIeKeplam
]

{ #category : #accessing }
MbDReactionForceCompIeKe >> value [
	^aFiIeKe
]
