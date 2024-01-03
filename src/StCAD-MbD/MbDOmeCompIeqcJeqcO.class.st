Class {
	#name : #MbDOmeCompIeqcJeqcO,
	#superclass : #MbDOmeCompIeqcJecO,
	#instVars : [
		'pomeIeJeOipEJ',
		'pomeIeJeOipEdotJ'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDOmeCompIeqcJeqcO >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	pomeIeJeOipEJ := frmJ pomeOeOpE at: axis.
	pomeIeJeOipEdotJ := frmJ pomeOeOpEdot at: axis
]

{ #category : #'initialize-release' }
MbDOmeCompIeqcJeqcO >> initialize [
	super initialize.
	pomeIeJeOipEJ := FullRow new: 4.
	pomeIeJeOipEdotJ := FullRow new: 4
]

{ #category : #accessing }
MbDOmeCompIeqcJeqcO >> pvaluepEJ [
	^pomeIeJeOipEJ
]

{ #category : #accessing }
MbDOmeCompIeqcJeqcO >> pvaluepEdotJ [
	^pomeIeJeOipEdotJ
]
