Class {
	#name : #MbDVelCompIeqcJeqcO,
	#superclass : #MbDVelCompIeqcJecO,
	#instVars : [
		'pvIeJeOipEJ',
		'pvIeJeOipXdotJ',
		'pvIeJeOipEdotJ'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDVelCompIeqcJeqcO >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	pvIeJeOipEJ := frmJ pvOeOpE at: axis.
	pvIeJeOipEdotJ := frmJ pvOeOpEdot at: axis
]

{ #category : #'initialize-release' }
MbDVelCompIeqcJeqcO >> initialize [
	super initialize.
	pvIeJeOipEJ := FullRow new: 4.
	pvIeJeOipXdotJ := FullRow new: 3.
	pvIeJeOipEdotJ := FullRow new: 4
]

{ #category : #'initialize-release' }
MbDVelCompIeqcJeqcO >> initializeLocally [
	super initializeLocally.
	pvIeJeOipXdotJ := (FullRow zero: 3).
	pvIeJeOipXdotJ at: axis put: 1.0d
]

{ #category : #accessing }
MbDVelCompIeqcJeqcO >> pvaluepEJ [
	^pvIeJeOipEJ
]

{ #category : #accessing }
MbDVelCompIeqcJeqcO >> pvaluepEdotJ [
	^pvIeJeOipEdotJ
]

{ #category : #accessing }
MbDVelCompIeqcJeqcO >> pvaluepXdotJ [
	^pvIeJeOipXdotJ
]
