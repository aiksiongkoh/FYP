Class {
	#name : #MbDOrbitAnglezIeqcJeqc,
	#superclass : #MbDOrbitAnglezIeqcJec,
	#instVars : [
		'pthezpXJ',
		'pthezpEJ',
		'ppthezpXIpXJ',
		'ppthezpXIpEJ',
		'ppthezpEIpXJ',
		'ppthezpEIpEJ',
		'ppthezpXJpXJ',
		'ppthezpXJpEJ',
		'ppthezpEJpEJ'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDOrbitAnglezIeqcJeqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDOrbitAnglezIeqcJeqc class >> withFrmI: afrmI frmJ: afrmJ [ 
	^(afrmI isMemberOf: MbDEndFrameqc) & (afrmJ isMemberOf: MbDEndFrameqc) 
		ifTrue: [self new withFrmI: afrmI frmJ: afrmJ]
		ifFalse: [nil]
]

{ #category : #calc }
MbDOrbitAnglezIeqcJeqc >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	self calc_pthezpXJ.
	self calc_pthezpEJ.
	self calc_ppthezpXIpXJ.
	self calc_ppthezpXIpEJ.
	self calc_ppthezpEIpXJ.
	self calc_ppthezpEIpEJ.
	self calc_ppthezpXJpXJ.
	self calc_ppthezpXJpEJ.
	self calc_ppthezpEJpEJ
]

{ #category : #calc }
MbDOrbitAnglezIeqcJeqc >> calc_ppthezpEIpEJ [
	| pxpEI pypEI pxpEJ pypEJ ppxpEIpEJ ppypEIpEJ ppthezpEIpEJi ppxpEIpEJi ppypEIpEJi pxpEIi pypEIi pxpEJj pypEJj term1 term2 term3 |
	pxpEI := xIeJeIe pvaluepEI.
	pypEI := yIeJeIe pvaluepEI.
	pxpEJ := xIeJeIe pvaluepEJ.
	pypEJ := yIeJeIe pvaluepEJ.
	ppxpEIpEJ := xIeJeIe ppvaluepEIpEJ.
	ppypEIpEJ := yIeJeIe ppvaluepEIpEJ.
	1 to: 4
		do: 
			[:i | 
			ppthezpEIpEJi := ppthezpEIpEJ at: i.
			ppxpEIpEJi := ppxpEIpEJ at: i.
			ppypEIpEJi := ppypEIpEJ at: i.
			pxpEIi := pxpEI at: i.
			pypEIi := pypEI at: i.
			1 to: 4
				do: 
					[:j | 
					pxpEJj := pxpEJ at: j.
					pypEJj := pypEJ at: j.
					term1 := (pxpEIi * pxpEJj - (pypEIi * pypEJj)) * twoCosSinOverSSqSq.
					term2 := (ppypEIpEJi at: j) * cosOverSSq 
								- ((ppxpEIpEJi at: j) * sinOverSSq).
					term3 := (pypEIi * pxpEJj + (pxpEIi * pypEJj)) * dSqOverSSqSq.
					ppthezpEIpEJi at: j put: term1 + term2 + term3]]
]

{ #category : #calc }
MbDOrbitAnglezIeqcJeqc >> calc_ppthezpEIpXJ [
	| pxpEI pypEI pxpXJ pypXJ ppxpEIpXJ ppypEIpXJ ppthezpEIpXJi ppxpEIpXJi ppypEIpXJi pxpEIi pypEIi pxpXJj pypXJj term1 term2 term3 |
	pxpEI := xIeJeIe pvaluepEI.
	pypEI := yIeJeIe pvaluepEI.
	pxpXJ := xIeJeIe pvaluepXJ.
	pypXJ := yIeJeIe pvaluepXJ.
	ppxpEIpXJ := xIeJeIe ppvaluepEIpXJ.
	ppypEIpXJ := yIeJeIe ppvaluepEIpXJ.
	1 to: 4
		do: 
			[:i | 
			ppthezpEIpXJi := ppthezpEIpXJ at: i.
			ppxpEIpXJi := ppxpEIpXJ at: i.
			ppypEIpXJi := ppypEIpXJ at: i.
			pxpEIi := pxpEI at: i.
			pypEIi := pypEI at: i.
			1 to: 3
				do: 
					[:j | 
					pxpXJj := pxpXJ at: j.
					pypXJj := pypXJ at: j.
					term1 := (pxpEIi * pxpXJj - (pypEIi * pypXJj)) * twoCosSinOverSSqSq.
					term2 := (ppypEIpXJi at: j) * cosOverSSq 
								- ((ppxpEIpXJi at: j) * sinOverSSq).
					term3 := (pypEIi * pxpXJj + (pxpEIi * pypXJj)) * dSqOverSSqSq.
					ppthezpEIpXJi at: j put: term1 + term2 + term3]]
]

{ #category : #calc }
MbDOrbitAnglezIeqcJeqc >> calc_ppthezpEJpEJ [
	| pxpEJ pypEJ ppxpEJpEJ ppypEJpEJ ppthezpEJpEJi ppxpEJpEJi ppypEJpEJi pxpEJi pypEJi term1 term2 term3 pxpEJj pypEJj ppthezpEJpEJij |
	pxpEJ := xIeJeIe pvaluepEJ.
	pypEJ := yIeJeIe pvaluepEJ.
	ppxpEJpEJ := xIeJeIe ppvaluepEJpEJ.
	ppypEJpEJ := yIeJeIe ppvaluepEJpEJ.
	1 to: 4
		do: 
			[:i | 
			ppthezpEJpEJi := ppthezpEJpEJ at: i.
			ppxpEJpEJi := ppxpEJpEJ at: i.
			ppypEJpEJi := ppypEJpEJ at: i.
			pxpEJi := pxpEJ at: i.
			pypEJi := pypEJ at: i.
			i to: 4
				do: 
					[:j | 
					pxpEJj := pxpEJ at: j.
					pypEJj := pypEJ at: j.
					term1 := (pxpEJi * pxpEJj - (pypEJi * pypEJj)) * twoCosSinOverSSqSq.
					term2 := (ppypEJpEJi at: j) * cosOverSSq 
								- ((ppxpEJpEJi at: j) * sinOverSSq).
					term3 := (pypEJi * pxpEJj + (pxpEJi * pypEJj)) * dSqOverSSqSq.
					ppthezpEJpEJij := term1 + term2 + term3.
					ppthezpEJpEJi at: j put: ppthezpEJpEJij.
					i < j 
						ifTrue: 
							[ppthezpEJpEJ 
								at: j
								and: i
								put: ppthezpEJpEJij]]]
]

{ #category : #calc }
MbDOrbitAnglezIeqcJeqc >> calc_ppthezpXIpEJ [
	"
	ppxpXIpEJ = 0
	ppypXIpEJ = 0
	"

	| pxpXI pypXI pxpEJ pypEJ ppthezpXIpEJi pxpXIi pypXIi pxpEJj pypEJj term1 term3 |
	pxpXI := xIeJeIe pvaluepXI.
	pypXI := yIeJeIe pvaluepXI.
	pxpEJ := xIeJeIe pvaluepEJ.
	pypEJ := yIeJeIe pvaluepEJ.
	1 to: 3
		do: 
			[:i | 
			ppthezpXIpEJi := ppthezpXIpEJ at: i.
			pxpXIi := pxpXI at: i.
			pypXIi := pypXI at: i.
			1 to: 4
				do: 
					[:j | 
					pxpEJj := pxpEJ at: j.
					pypEJj := pypEJ at: j.
					term1 := (pxpXIi * pxpEJj - (pypXIi * pypEJj)) * twoCosSinOverSSqSq.
					term3 := (pypXIi * pxpEJj + (pxpXIi * pypEJj)) * dSqOverSSqSq.
					ppthezpXIpEJi at: j put: term1 + term3]]
]

{ #category : #calc }
MbDOrbitAnglezIeqcJeqc >> calc_ppthezpXIpXJ [
	"
	ppxpXIpXJ = 0
	ppypXIpXJ = 0
	"

	| pxpXI pypXI pxpXJ pypXJ ppthezpXIpXJi pxpXIi pypXIi pxpXJj pypXJj term1 term3 |
	pxpXI := xIeJeIe pvaluepXI.
	pypXI := yIeJeIe pvaluepXI.
	pxpXJ := xIeJeIe pvaluepXJ.
	pypXJ := yIeJeIe pvaluepXJ.
	1 to: 3
		do: 
			[:i | 
			ppthezpXIpXJi := ppthezpXIpXJ at: i.
			pxpXIi := pxpXI at: i.
			pypXIi := pypXI at: i.
			1 to: 3
				do: 
					[:j | 
					pxpXJj := pxpXJ at: j.
					pypXJj := pypXJ at: j.
					term1 := (pxpXIi * pxpXJj - (pypXIi * pypXJj)) * twoCosSinOverSSqSq.
					term3 := (pypXIi * pxpXJj + (pxpXIi * pypXJj)) * dSqOverSSqSq.
					ppthezpXIpXJi at: j put: term1 + term3]]
]

{ #category : #calc }
MbDOrbitAnglezIeqcJeqc >> calc_ppthezpXJpEJ [
	"
	ppxpXJpEJ = 0
	ppypXJpEJ = 0
	"

	| pxpXJ pypXJ pxpEJ pypEJ ppthezpXJpEJi pxpXJi pypXJi pxpEJj pypEJj term1 term3 |
	pxpXJ := xIeJeIe pvaluepXJ.
	pypXJ := yIeJeIe pvaluepXJ.
	pxpEJ := xIeJeIe pvaluepEJ.
	pypEJ := yIeJeIe pvaluepEJ.
	1 to: 3
		do: 
			[:i | 
			ppthezpXJpEJi := ppthezpXJpEJ at: i.
			pxpXJi := pxpXJ at: i.
			pypXJi := pypXJ at: i.
			1 to: 4
				do: 
					[:j | 
					pxpEJj := pxpEJ at: j.
					pypEJj := pypEJ at: j.
					term1 := (pxpXJi * pxpEJj - (pypXJi * pypEJj)) * twoCosSinOverSSqSq.
					term3 := (pypXJi * pxpEJj + (pxpXJi * pypEJj)) * dSqOverSSqSq.
					ppthezpXJpEJi at: j put: term1 + term3]]
]

{ #category : #calc }
MbDOrbitAnglezIeqcJeqc >> calc_ppthezpXJpXJ [
	"
	ppxpXJpXJ = 0
	ppypXJpXJ = 0
	"

	| pxpXJ pypXJ ppthezpXJpXJi pxpXJi pypXJi pxpXJj pypXJj term1 term3 |
	pxpXJ := xIeJeIe pvaluepXJ.
	pypXJ := yIeJeIe pvaluepXJ.
	1 to: 3
		do: 
			[:i | 
			ppthezpXJpXJi := ppthezpXJpXJ at: i.
			pxpXJi := pxpXJ at: i.
			pypXJi := pypXJ at: i.
			1 to: 3
				do: 
					[:j | 
					pxpXJj := pxpXJ at: j.
					pypXJj := pypXJ at: j.
					term1 := (pxpXJi * pxpXJj - (pypXJi * pypXJj)) * twoCosSinOverSSqSq.
					term3 := (pypXJi * pxpXJj + (pxpXJi * pypXJj)) * dSqOverSSqSq.
					ppthezpXJpXJi at: j put: term1 + term3]]
]

{ #category : #calc }
MbDOrbitAnglezIeqcJeqc >> calc_pthezpEJ [
	| pxpEJ pypEJ |
	pxpEJ := xIeJeIe pvaluepEJ.
	pypEJ := yIeJeIe pvaluepEJ.
	1 to: 4
		do: 
			[:i | 
			pthezpEJ at: i
				put: (pypEJ at: i) * cosOverSSq - ((pxpEJ at: i) * sinOverSSq)]
]

{ #category : #calc }
MbDOrbitAnglezIeqcJeqc >> calc_pthezpXJ [
	| pxpXJ pypXJ |
	pxpXJ := xIeJeIe pvaluepXJ.
	pypXJ := yIeJeIe pvaluepXJ.
	1 to: 3
		do: 
			[:i | 
			pthezpXJ at: i
				put: (pypXJ at: i) * cosOverSSq - ((pxpXJ at: i) * sinOverSSq)]
]

{ #category : #'initialize-release' }
MbDOrbitAnglezIeqcJeqc >> initialize [
	super initialize.
	pthezpXJ := FullRow new: 3.
	pthezpEJ := FullRow new: 4.
	ppthezpXIpXJ := FullMatrix new: 3 by: 3.
	ppthezpXIpEJ := FullMatrix new: 3 by: 4.
	ppthezpEIpXJ := FullMatrix new: 4 by: 3.
	ppthezpEIpEJ := FullMatrix new: 4 by: 4.
	ppthezpXJpXJ := FullMatrix new: 3 by: 3.
	ppthezpXJpEJ := FullMatrix new: 3 by: 4.
	ppthezpEJpEJ := FullMatrix new: 4 by: 4
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJeqc >> ppthezpEIpEJ [
	^ppthezpEIpEJ
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJeqc >> ppthezpEIpXJ [
	^ppthezpEIpXJ
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJeqc >> ppthezpEJpEJ [
	^ppthezpEJpEJ
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJeqc >> ppthezpXIpEJ [
	^ppthezpXIpEJ
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJeqc >> ppthezpXIpXJ [
	^ppthezpXIpXJ
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJeqc >> ppthezpXJpEJ [
	^ppthezpXJpEJ
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJeqc >> ppthezpXJpXJ [
	^ppthezpXJpXJ
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJeqc >> ppvaluepEIpEJ [
	^ppthezpEIpEJ
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJeqc >> ppvaluepEIpXJ [
	^ppthezpEIpXJ
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJeqc >> ppvaluepEJpEJ [
	^ppthezpEJpEJ
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJeqc >> ppvaluepXIpEJ [
	^ppthezpXIpEJ
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJeqc >> ppvaluepXIpXJ [
	^ppthezpXIpXJ
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJeqc >> ppvaluepXJpEJ [
	^ppthezpXJpEJ
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJeqc >> ppvaluepXJpXJ [
	^ppthezpXJpXJ
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJeqc >> pthezpEJ [
	^pthezpEJ
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJeqc >> pthezpXJ [
	^pthezpXJ
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJeqc >> pvaluepEJ [
	^pthezpEJ
]

{ #category : #accessing }
MbDOrbitAnglezIeqcJeqc >> pvaluepXJ [
	^pthezpXJ
]
