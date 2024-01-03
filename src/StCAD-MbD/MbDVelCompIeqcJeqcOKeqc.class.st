Class {
	#name : #MbDVelCompIeqcJeqcOKeqc,
	#superclass : #MbDVelCompIeqcJecOKeqc,
	#instVars : [
		'pviIeJeOKepEJ',
		'pviIeJeOKepXdotJ',
		'pviIeJeOKepEdotJ'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDVelCompIeqcJeqcOKeqc >> calcPostDynCorrectorIteration [
	| pvIeJeOpEJ pvIeJeOpEdotJ |
	super calcPostDynCorrectorIteration.
	pvIeJeOpEJ := frmJ pvOeOpE.
	pvIeJeOpEdotJ := frmJ pvOeOpEdot.
	pviIeJeOKepEJ := aAjOKe dot: pvIeJeOpEJ.
	pviIeJeOKepXdotJ := aAjOKe transpose.
	pviIeJeOKepEdotJ := aAjOKe dot: pvIeJeOpEdotJ
]

{ #category : #'initialize-release' }
MbDVelCompIeqcJeqcOKeqc >> initialize [
	super initialize.
	pviIeJeOKepEJ := FullRow new: 4.
	pviIeJeOKepXdotJ := FullRow new: 3.
	pviIeJeOKepEdotJ := FullRow new: 4
]

{ #category : #accessing }
MbDVelCompIeqcJeqcOKeqc >> pvaluepEJ [
	^pviIeJeOKepEJ
]

{ #category : #accessing }
MbDVelCompIeqcJeqcOKeqc >> pvaluepEdotJ [
	^pviIeJeOKepEdotJ
]

{ #category : #accessing }
MbDVelCompIeqcJeqcOKeqc >> pvaluepXdotJ [
	^pviIeJeOKepXdotJ
]
