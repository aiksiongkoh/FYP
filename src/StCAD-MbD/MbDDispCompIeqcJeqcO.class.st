Class {
	#name : #MbDDispCompIeqcJeqcO,
	#superclass : #MbDDispCompIeqcJecO,
	#instVars : [
		'priIeJeOpXJ',
		'priIeJeOpEJ',
		'ppriIeJeOpEJpEJ'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDDispCompIeqcJeqcO >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	priIeJeOpEJ := frmJ priOeOpE: axis
]

{ #category : #'initialize-release' }
MbDDispCompIeqcJeqcO >> initializeGlobally [
	super initializeGlobally.
	priIeJeOpXJ := (FullRow zero: 3).
	priIeJeOpXJ at: axis put: 1.0d.
	ppriIeJeOpEJpEJ := frmJ ppriOeOpEpE: axis
]

{ #category : #accessing }
MbDDispCompIeqcJeqcO >> ppriIeJeOpEJpEJ [
	^ppriIeJeOpEJpEJ
]

{ #category : #accessing }
MbDDispCompIeqcJeqcO >> ppvaluepEJpEJ [
	^ppriIeJeOpEJpEJ
]

{ #category : #accessing }
MbDDispCompIeqcJeqcO >> priIeJeOpEJ [
	^priIeJeOpEJ
]

{ #category : #accessing }
MbDDispCompIeqcJeqcO >> pvaluepEJ [
	^priIeJeOpEJ
]

{ #category : #accessing }
MbDDispCompIeqcJeqcO >> pvaluepXJ [
	^priIeJeOpXJ
]
