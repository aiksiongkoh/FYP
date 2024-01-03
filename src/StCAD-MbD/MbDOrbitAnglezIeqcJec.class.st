Class {
	#name : #MbDOrbitAnglezIeqcJec,
	#superclass : #MbDOrbitAnglezIecJec,
	#instVars : [
		'pthezpXI',
		'pthezpEI',
		'ppthezpXIpXI',
		'ppthezpXIpEI',
		'ppthezpEIpEI'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDOrbitAnglezIeqcJec >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	self calc_pthezpXI.
	self calc_pthezpEI.
	self calc_ppthezpXIpXI.
	self calc_ppthezpXIpEI.
	self calc_ppthezpEIpEI
]

{ #category : #calc }
MbDOrbitAnglezIeqcJec >> calc_ppthezpEIpEI [
	| pxpEI pypEI ppxpEIpEI ppypEIpEI ppthezpEIpEIi ppxpEIpEIi ppypEIpEIi pxpEIi pypEIi term1 term2 term3 pxpEIj pypEIj ppthezpEIpEIij |
	pxpEI := xIeJeIe pvaluepEI.
	pypEI := yIeJeIe pvaluepEI.
	ppxpEIpEI := xIeJeIe ppvaluepEIpEI.
	ppypEIpEI := yIeJeIe ppvaluepEIpEI.
	1 to: 4
		do: 
			[:i | 
			ppthezpEIpEIi := ppthezpEIpEI at: i.
			ppxpEIpEIi := ppxpEIpEI at: i.
			ppypEIpEIi := ppypEIpEI at: i.
			pxpEIi := pxpEI at: i.
			pypEIi := pypEI at: i.
			i to: 4
				do: 
					[:j | 
					pxpEIj := pxpEI at: j.
					pypEIj := pypEI at: j.
					term1 := (pxpEIi * pxpEIj - (pypEIi * pypEIj)) * twoCosSinOverSSqSq.
					term2 := (ppypEIpEIi at: j) * cosOverSSq 
								- ((ppxpEIpEIi at: j) * sinOverSSq).
					term3 := (pypEIi * pxpEIj + (pxpEIi * pypEIj)) * dSqOverSSqSq.
					ppthezpEIpEIij := term1 + term2 + term3.
					ppthezpEIpEIi at: j put: ppthezpEIpEIij.
					i < j 
						ifTrue: 
							[ppthezpEIpEI 
								at: j
								and: i
								put: ppthezpEIpEIij]]]
]

{ #category : #calc }
MbDOrbitAnglezIeqcJec >> calc_ppthezpXIpEI [
	| pxpXI pypXI pxpEI pypEI ppxpXIpEI ppypXIpEI ppthezpXIpEIi ppxpXIpEIi ppypXIpEIi pxpXIi pypXIi pxpEIj pypEIj term1 term2 term3 |
	pxpXI := xIeJeIe pvaluepXI.
	pypXI := yIeJeIe pvaluepXI.
	pxpEI := xIeJeIe pvaluepEI.
	pypEI := yIeJeIe pvaluepEI.
	ppxpXIpEI := xIeJeIe ppvaluepXIpEI.
	ppypXIpEI := yIeJeIe ppvaluepXIpEI.
	1 to: 3
		do: 
			[:i | 
			ppthezpXIpEIi := ppthezpXIpEI at: i.
			ppxpXIpEIi := ppxpXIpEI at: i.
			ppypXIpEIi := ppypXIpEI at: i.
			pxpXIi := pxpXI at: i.
			pypXIi := pypXI at: i.
			1 to: 4
				do: 
					[:j | 
					pxpEIj := pxpEI at: j.
					pypEIj := pypEI at: j.
					term1 := (pxpXIi * pxpEIj - (pypXIi * pypEIj)) * twoCosSinOverSSqSq.
					term2 := (ppypXIpEIi at: j) * cosOverSSq 
								- ((ppxpXIpEIi at: j) * sinOverSSq).
					term3 := (pypXIi * pxpEIj + (pxpXIi * pypEIj)) * dSqOverSSqSq.
					ppthezpXIpEIi at: j put: term1 + term2 + term3]]
]

{ #category : #calc }
MbDOrbitAnglezIeqcJec >> calc_ppthezpXIpXI [
	"
	ppxpXIpXI = 0
	ppypXIpXI = 0
	"

	| pxpXI pypXI ppthezpXIpXIi pxpXIi pypXIi pxpXIj pypXIj term1 term3 |
	pxpXI := xIeJeIe pvaluepXI.
	pypXI := yIeJeIe pvaluepXI.
	1 to: 3
		do: 
			[:i | 
			ppthezpXIpXIi := ppthezpXIpXI at: i.
			pxpXIi := pxpXI at: i.
			pypXIi := pypXI at: i.
			1 to: 3
				do: 
					[:j | 
					pxpXIj := pxpXI at: j.
					pypXIj := pypXI at: j.
					term1 := (pxpXIi * pxpXIj - (pypXIi * pypXIj)) * twoCosSinOverSSqSq.
					term3 := (pypXIi * pxpXIj + (pxpXIi * pypXIj)) * dSqOverSSqSq.
					ppthezpXIpXIi at: j put: term1 + term3]]
]

{ #category : #calc }
MbDOrbitAnglezIeqcJec >> calc_pthezpEI [
	| pxpEI pypEI |
	pxpEI := xIeJeIe pvaluepEI.
	pypEI := yIeJeIe pvaluepEI.
	1 to: 4
		do: 
			[:i | 
			pthezpEI at: i
				put: (pypEI at: i) * cosOverSSq - ((pxpEI at: i) * sinOverSSq)]
]

{ #category : #calc }
MbDOrbitAnglezIeqcJec >> calc_pthezpXI [
	| pxpXI pypXI |
	pxpXI := xIeJeIe pvaluepXI.
	pypXI := yIeJeIe pvaluepXI.
	1 to: 3
		do: 
			[:i | 
			pthezpXI at: i
				put: (pypXI at: i) * cosOverSSq - ((pxpXI at: i) * sinOverSSq)]
]

{ #category : #'initialize-release' }
MbDOrbitAnglezIeqcJec >> initialize [
	super initialize.
	pthezpXI := FullRow new: 3.
	pthezpEI := FullRow new: 4.
	ppthezpXIpXI := FullMatrix new: 3 by: 3.
	ppthezpXIpEI := FullMatrix new: 3 by: 4.
	ppthezpEIpEI := FullMatrix new: 4 by: 4
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJec >> ppthezpEIpEI [
	^ppthezpEIpEI
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJec >> ppthezpXIpEI [
	^ppthezpXIpEI
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJec >> ppthezpXIpXI [
	^ppthezpXIpXI
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJec >> ppvaluepEIpEI [
	^ppthezpEIpEI
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJec >> ppvaluepXIpEI [
	^ppthezpXIpEI
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJec >> ppvaluepXIpXI [
	^ppthezpXIpXI
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJec >> pthezpEI [
	^pthezpEI
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJec >> pthezpXI [
	^pthezpXI
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJec >> pvaluepEI [
	^pthezpEI
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJec >> pvaluepXI [
	^pthezpXI
]
