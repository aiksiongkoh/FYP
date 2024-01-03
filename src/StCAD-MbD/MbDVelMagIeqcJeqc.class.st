Class {
	#name : #MbDVelMagIeqcJeqc,
	#superclass : #MbDVelMagIeqcJec,
	#instVars : [
		'pvIeJepEJ',
		'pvIeJepXdotJ',
		'pvIeJepEdotJ'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDVelMagIeqcJeqc >> calcPostDynCorrectorIteration [
	| pvIeJeOpEJ pvIeJeOpEdotJ zeroRow |
	super calcPostDynCorrectorIteration.
	pvIeJeOpEJ := frmJ pvOeOpE.
	pvIeJeOpEdotJ := frmJ pvOeOpEdot.
	vIeJe = 0
		ifTrue: 
			["uvIeJeO := (StMFullColumn new: 3) zeroSelf."
			zeroRow := uvIeJeO transpose.
			pvIeJepEJ := zeroRow.
			pvIeJepXdotJ := zeroRow.
			pvIeJepEdotJ := zeroRow]
		ifFalse: 
			[pvIeJepEJ := uvIeJeO dot: pvIeJeOpEJ.
			pvIeJepXdotJ := uvIeJeO transpose.
			pvIeJepEdotJ := uvIeJeO dot: pvIeJeOpEdotJ]
]

{ #category : #'initialize-release' }
MbDVelMagIeqcJeqc >> initialize [
	super initialize.
	pvIeJepEJ := FullRow new: 4.
	pvIeJepXdotJ := FullRow new: 3.
	pvIeJepEdotJ := FullRow new: 4
]

{ #category : #accessing }
MbDVelMagIeqcJeqc >> pvaluepEJ [
	^pvIeJepEJ
]

{ #category : #accessing }
MbDVelMagIeqcJeqc >> pvaluepEdotJ [
	^pvIeJepEdotJ
]

{ #category : #accessing }
MbDVelMagIeqcJeqc >> pvaluepXdotJ [
	^pvIeJepXdotJ
]
