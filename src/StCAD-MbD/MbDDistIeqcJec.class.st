Class {
	#name : #MbDDistIeqcJec,
	#superclass : #MbDDistIecJec,
	#instVars : [
		'prIeJepXI',
		'prIeJepEI',
		'pprIeJepXIpXI',
		'pprIeJepXIpEI',
		'pprIeJepEIpEI',
		'mprIeJeOpEIT'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDDistIeqcJec >> calcPrivate [
	| mprIeJeOpEI mpprIeJeOpEIpEI pprIeJepXIipXI prIeJepXIi element pprIeJepXIipEI mprIeJeOipEI pprIeJepEIipEI prIeJepEIi mpprIeJeOpEIipEI mprIeJeOpEIiT muIeJeOT |
	super calcPrivate.
	rIeJe = 0.0d ifTrue: [^self].
	mprIeJeOpEI := frmI prOeOpE.
	mprIeJeOpEIT := mprIeJeOpEI transpose.
	mpprIeJeOpEIpEI := frmI pprOeOpEpE.
	muIeJeOT := muIeJeO transpose.
	prIeJepXI := muIeJeOT.
	prIeJepEI := muIeJeOT timesFullMatrix: mprIeJeOpEI.
	1 to: 3 do: [:i | 
			pprIeJepXIipXI := pprIeJepXIpXI at: i.
			prIeJepXIi := prIeJepXI at: i.
			1 to: 3 do: [:j | 
					element := i == j
								ifTrue: [1.0d]
								ifFalse: [0.0d].
					element := element - (prIeJepXIi * (prIeJepXI at: j)).
					pprIeJepXIipXI at: j put: element / rIeJe]].
	pprIeJepXIpEI := FullMatrix new: 3 by: 4.
	1 to: 3 do: [:i | 
			pprIeJepXIipEI := pprIeJepXIpEI at: i.
			prIeJepXIi := prIeJepXI at: i.
			mprIeJeOipEI := mprIeJeOpEI at: i.
			1 to: 4 do: [:j | 
					element := (mprIeJeOipEI at: j) - (prIeJepXIi * (prIeJepEI at: j)).
					pprIeJepXIipEI at: j put: element / rIeJe]].
	pprIeJepEIpEI := FullMatrix new: 4 by: 4.
	1 to: 4 do: [:i | 
			pprIeJepEIipEI := pprIeJepEIpEI at: i.
			prIeJepEIi := prIeJepEI at: i.
			mpprIeJeOpEIipEI := mpprIeJeOpEIpEI at: i.
			mprIeJeOpEIiT := mprIeJeOpEIT at: i.
			1 to: 4 do: [:j | 
					element := (mprIeJeOpEIiT dot: (mprIeJeOpEIT at: j)) 
								- ((mpprIeJeOpEIipEI at: j) dot: rIeJeO) - (prIeJepEIi * (prIeJepEI at: j)).
					pprIeJepEIipEI at: j put: element / rIeJe]]
]

{ #category : #'initialize-release' }
MbDDistIeqcJec >> initialize [
	super initialize.
	prIeJepXI := FullRow new: 3.
	prIeJepEI := FullRow new: 4.
	pprIeJepXIpXI := FullMatrix new: 3 by: 3.
	pprIeJepXIpEI := FullMatrix new: 3 by: 4.
	pprIeJepEIpEI := FullMatrix new: 4 by: 4
]

{ #category : #accessing }
MbDDistIeqcJec >> ppvaluepEIpEI [
	^pprIeJepEIpEI
]

{ #category : #accessing }
MbDDistIeqcJec >> ppvaluepXIpEI [
	^pprIeJepXIpEI
]

{ #category : #accessing }
MbDDistIeqcJec >> ppvaluepXIpXI [
	^pprIeJepXIpXI
]

{ #category : #accessing }
MbDDistIeqcJec >> prIeJepEI [
	^prIeJepEI
]

{ #category : #accessing }
MbDDistIeqcJec >> prIeJepXI [
	^prIeJepXI
]

{ #category : #accessing }
MbDDistIeqcJec >> puIeJeOpEI [
	| answer m1OverrIeJe m1OverrIeJeSq answeri rIeJeOi aij mprIeJeOpEI mprIeJeOpEIi |
	answer := FullMatrix new: 3 by: 4.
	mprIeJeOpEI := frmI prOeOpE.
	m1OverrIeJe := -1.0d / rIeJe.
	m1OverrIeJeSq := m1OverrIeJe / rIeJe.
	1 to: 3 do: [:i | 
			answeri := answer at: i.
			mprIeJeOpEIi := mprIeJeOpEI at: i.
			rIeJeOi := rIeJeO at: i.
			1 to: 4 do: [:j | 
					aij := (mprIeJeOpEIi at: j) * m1OverrIeJe + (rIeJeOi * (prIeJepEI at: j) * m1OverrIeJeSq).
					answeri at: j put: aij]].
	^answer
]

{ #category : #accessing }
MbDDistIeqcJec >> puIeJeOpXI [
	| answer m1OverrIeJe m1OverrIeJeSq answeri rIeJeOi aij |
	answer := FullMatrix new: 3 by: 3.
	m1OverrIeJe := -1.0d / rIeJe.
	m1OverrIeJeSq := m1OverrIeJe / rIeJe.
	1 to: 3 do: [:i | 
			answeri := answer at: i.
			rIeJeOi := rIeJeO at: i.
			1 to: 3 do: [:j | 
					aij := rIeJeOi * (prIeJepXI at: j) * m1OverrIeJeSq.
					answeri at: j put: aij].
			answeri at: i plusNumber: m1OverrIeJe].
	^answer
]

{ #category : #accessing }
MbDDistIeqcJec >> pvaluepEI [
	^prIeJepEI
]

{ #category : #accessing }
MbDDistIeqcJec >> pvaluepXI [
	^prIeJepXI
]
