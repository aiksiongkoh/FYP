Class {
	#name : #MbDOmeMagIeqcJeqc,
	#superclass : #MbDOmeMagIeqcJec,
	#instVars : [
		'pomeIeJepEJ',
		'pomeIeJepEJdot'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDOmeMagIeqcJeqc >> calcPostDynCorrectorIteration [
	| zeroColumn pomeIeJeOpEJ pomeIeJeOpEJdot |
	super calcPostDynCorrectorIteration.
	pomeIeJeOpEJ := frmJ pomeOeOpE.
	pomeIeJeOpEJdot := frmJ pomeOeOpEdot.
	omeIeJe = 0
		ifTrue: 
			["uomeIeJeO := (StMFullColumn new: 4) zeroSelf."
			zeroColumn := uomeIeJeO.
			pomeIeJepEJ := zeroColumn.
			pomeIeJepEJdot := zeroColumn]
		ifFalse: 
			[pomeIeJepEJ := pomeIeJeOpEJ transposeTimesFullColumn: uomeIeJeO.
			pomeIeJepEJdot := pomeIeJeOpEJdot transposeTimesFullColumn: uomeIeJeO]
]

{ #category : #accessing }
MbDOmeMagIeqcJeqc >> pvaluepEJ [
	^pomeIeJepEJ
]

{ #category : #accessing }
MbDOmeMagIeqcJeqc >> pvaluepEJdot [
	^pomeIeJepEJdot
]
