Class {
	#name : #MbDOmeCompIeqcJecKeqc,
	#superclass : #MbDOmeCompIecJecKeqc,
	#instVars : [
		'pomeiIeJeKepEI',
		'pomeiIeJeKepEdotI'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDOmeCompIeqcJecKeqc >> calcPostDynCorrectorIteration [
	| mpomeIeJeOpEI mpomeIeJeOpEdotI mAjOKe |
	super calcPostDynCorrectorIteration.
	mpomeIeJeOpEI := frmI pomeOeOpE.
	mpomeIeJeOpEdotI := frmI pomeOeOpEdot.
	mAjOKe := aAjOKe negated.
	pomeiIeJeKepEI := mAjOKe dot: mpomeIeJeOpEI.
	pomeiIeJeKepEdotI := mAjOKe dot: mpomeIeJeOpEdotI
]

{ #category : #'initialize-release' }
MbDOmeCompIeqcJecKeqc >> initialize [
	super initialize.
	pomeiIeJeKepEI := FullRow new: 4.
	pomeiIeJeKepEdotI := FullRow new: 4
]

{ #category : #accessing }
MbDOmeCompIeqcJecKeqc >> pvaluepEI [
	^pomeiIeJeKepEI
]

{ #category : #accessing }
MbDOmeCompIeqcJecKeqc >> pvaluepEdotI [
	^pomeiIeJeKepEdotI
]
