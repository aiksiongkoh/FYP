Class {
	#name : #MbDVelRadIeqcJeqc,
	#superclass : #MbDVelRadIeqcJec,
	#instVars : [
		'pvIeJepXJ',
		'pvIeJepEJ',
		'pvIeJepXdotJ',
		'pvIeJepEdotJ'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDVelRadIeqcJeqc >> calcPostDynCorrectorIteration [
	| prIeJeOpEJT pvIeJeOpEJT prIeJepXJ prIeJepEJ uIeJeOT prIeJeOpEJ |
	super calcPostDynCorrectorIteration.
	rIeJe = 0.0d ifTrue: [^self].
	prIeJeOpEJ := frmJ prOeOpE.
	prIeJeOpEJT := prIeJeOpEJ transpose.
	pvIeJeOpEJT := frmJ pvOeOpE transpose.
	uIeJeOT := uIeJeO transpose.
	prIeJepXJ := uIeJeOT.
	prIeJepEJ := uIeJeOT timesFullMatrix: prIeJeOpEJ.
	1 to: 3 do: [:i | pvIeJepXJ at: i put: (vIeJeO at: i)
				- (vIeJe * (prIeJepXJ at: i)) / rIeJe].
	1 to: 4 do: [:i | pvIeJepEJ at: i put: ((pvIeJeOpEJT at: i)
				dot: rIeJeO)
				+ ((prIeJeOpEJT at: i)
						dot: vIeJeO) - (vIeJe * (prIeJepEJ at: i)) / rIeJe].
	pvIeJepXdotJ := prIeJepXJ.
	pvIeJepEdotJ := prIeJepEJ
]

{ #category : #'initialize-release' }
MbDVelRadIeqcJeqc >> initialize [
	super initialize.
	pvIeJepXJ := FullRow new: 3.
	pvIeJepEJ := FullRow new: 4.
	pvIeJepXdotJ := FullRow new: 3.
	pvIeJepEdotJ := FullRow new: 4
]

{ #category : #accessing }
MbDVelRadIeqcJeqc >> pvaluepEJ [
	^pvIeJepEJ
]

{ #category : #accessing }
MbDVelRadIeqcJeqc >> pvaluepEdotJ [
	^pvIeJepEdotJ
]

{ #category : #accessing }
MbDVelRadIeqcJeqc >> pvaluepXJ [
	^pvIeJepXJ
]

{ #category : #accessing }
MbDVelRadIeqcJeqc >> pvaluepXdotJ [
	^pvIeJepXdotJ
]
