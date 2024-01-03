Class {
	#name : #MbDOmeMagIeqcJec,
	#superclass : #MbDOmeMagIecJec,
	#instVars : [
		'pomeIeJepEI',
		'pomeIeJepEIdot'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDOmeMagIeqcJec >> calcPostDynCorrectorIteration [
	| zeroColumn pomeIeJeOpEI pomeIeJeOpEIdot |
	super calcPostDynCorrectorIteration.
	pomeIeJeOpEI := frmI pomeOeOpE negated.
	pomeIeJeOpEIdot := frmI pomeOeOpEdot negated.
	omeIeJe = 0
		ifTrue: 
			["uomeIeJeO := (StMFullColumn new: 3) zeroSelf."
			zeroColumn := uomeIeJeO.
			pomeIeJepEI := zeroColumn.
			pomeIeJepEIdot := zeroColumn]
		ifFalse: 
			[pomeIeJepEI := pomeIeJeOpEI transposeTimesFullColumn: uomeIeJeO.
			pomeIeJepEIdot := pomeIeJeOpEIdot transposeTimesFullColumn: uomeIeJeO]
]

{ #category : #accessing }
MbDOmeMagIeqcJec >> pvaluepEI [
	^pomeIeJepEI
]

{ #category : #accessing }
MbDOmeMagIeqcJec >> pvaluepEIdot [
	^pomeIeJepEIdot
]
