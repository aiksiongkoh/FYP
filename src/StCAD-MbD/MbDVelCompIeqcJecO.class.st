Class {
	#name : #MbDVelCompIeqcJecO,
	#superclass : #MbDVelCompIecJecO,
	#instVars : [
		'pvIeJeOipEI',
		'pvIeJeOipXdotI',
		'pvIeJeOipEdotI'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDVelCompIeqcJecO >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	pvIeJeOipEI := (frmI pvOeOpE at: axis) negated.
	pvIeJeOipEdotI := (frmI pvOeOpEdot at: axis) negated
]

{ #category : #'initialize-release' }
MbDVelCompIeqcJecO >> initialize [
	super initialize.
	pvIeJeOipEI := FullRow new: 4.
	pvIeJeOipXdotI := FullRow new: 3.
	pvIeJeOipEdotI := FullRow new: 4
]

{ #category : #'initialize-release' }
MbDVelCompIeqcJecO >> initializeLocally [
	pvIeJeOipXdotI := (FullRow zero: 3).
	pvIeJeOipXdotI at: axis put: -1.0d
]

{ #category : #accessing }
MbDVelCompIeqcJecO >> pvaluepEI [
	^pvIeJeOipEI
]

{ #category : #accessing }
MbDVelCompIeqcJecO >> pvaluepEdotI [
	^pvIeJeOipEdotI
]

{ #category : #accessing }
MbDVelCompIeqcJecO >> pvaluepXdotI [
	^pvIeJeOipXdotI
]
