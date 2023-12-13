Class {
	#name : #MbDReactionTorqueCompIpKe,
	#superclass : #MbDReactionComp,
	#instVars : [
		'aTiIpKe',
		'pTiIpKepXI',
		'pTiIpKepEI',
		'pTiIpKepXJ',
		'pTiIpKepEJ',
		'pTiIpKepEK',
		'pTiIpKeplam'
	],
	#category : #'StCAD-MbD-MbDReaction'
}

{ #category : #'VisualWorks metadata' }
MbDReactionTorqueCompIpKe class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #calc }
MbDReactionTorqueCompIpKe >> calcPostDynCorrectorIteration [
	| aAjOKe pAjOKepEK |
	aAjOKe := efrmK aAjOe: axis.
	pAjOKepEK := efrmK pAjOepE: axis.
	aTiIpKe := aAjOKe dot: joint aTIeJtO.
	pTiIpKepXI := aAjOKe dot: joint pTIeJtOpXI.
	pTiIpKepEI := aAjOKe dot: joint pTIeJtOpEI.
	pTiIpKepXJ := aAjOKe dot: joint pTIeJtOpXJ.
	pTiIpKepEJ := aAjOKe dot: joint pTIeJtOpEJ.
	pTiIpKepEK := pAjOKepEK dot: joint aTIeJtO.
	pTiIpKeplam := aAjOKe transpose timesSparseMatrix: joint pTIeJtOplam
]

{ #category : #accessing }
MbDReactionTorqueCompIpKe >> isJointTorque [
	^true
]

{ #category : #'input-output' }
MbDReactionTorqueCompIpKe >> postInput [
	| aAjOKe |
	aAjOKe := efrmK aAjOe: axis.
	aTiIpKe := aAjOKe dot: joint aTIeJtO
]

{ #category : #accessing }
MbDReactionTorqueCompIpKe >> pvaluepEI [
	^pTiIpKepEI
]

{ #category : #accessing }
MbDReactionTorqueCompIpKe >> pvaluepEJ [
	^pTiIpKepEJ
]

{ #category : #accessing }
MbDReactionTorqueCompIpKe >> pvaluepEK [
	^pTiIpKepEK
]

{ #category : #accessing }
MbDReactionTorqueCompIpKe >> pvaluepXI [
	^pTiIpKepXI
]

{ #category : #accessing }
MbDReactionTorqueCompIpKe >> pvaluepXJ [
	^pTiIpKepXJ
]

{ #category : #accessing }
MbDReactionTorqueCompIpKe >> pvaluepXK [
	^nil
]

{ #category : #accessing }
MbDReactionTorqueCompIpKe >> pvalueplam [
	^pTiIpKeplam
]

{ #category : #accessing }
MbDReactionTorqueCompIpKe >> value [
	^aTiIpKe
]
