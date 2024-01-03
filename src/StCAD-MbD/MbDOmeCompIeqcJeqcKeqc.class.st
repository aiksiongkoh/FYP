Class {
	#name : #MbDOmeCompIeqcJeqcKeqc,
	#superclass : #MbDOmeCompIeqcJecKeqc,
	#instVars : [
		'pomeiIeJeKepEJ',
		'pomeiIeJeKepEdotJ'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDOmeCompIeqcJeqcKeqc >> calcPostDynCorrectorIteration [
	| pomeIeJeOpEJ pomeIeJeOpEdotJ |
	super calcPostDynCorrectorIteration.
	pomeIeJeOpEJ := frmJ pomeOeOpE.
	pomeIeJeOpEdotJ := frmJ pomeOeOpEdot.
	pomeiIeJeKepEJ := aAjOKe dot: pomeIeJeOpEJ.
	pomeiIeJeKepEdotJ := aAjOKe dot: pomeIeJeOpEdotJ
]

{ #category : #'initialize-release' }
MbDOmeCompIeqcJeqcKeqc >> initialize [
	super initialize.
	pomeiIeJeKepEJ := FullRow new: 4.
	pomeiIeJeKepEdotJ := FullRow new: 4
]

{ #category : #accessing }
MbDOmeCompIeqcJeqcKeqc >> pvaluepEJ [
	^pomeiIeJeKepEJ
]

{ #category : #accessing }
MbDOmeCompIeqcJeqcKeqc >> pvaluepEdotJ [
	^pomeiIeJeKepEdotJ
]
