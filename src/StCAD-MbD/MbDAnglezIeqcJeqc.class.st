Class {
	#name : #MbDAnglezIeqcJeqc,
	#superclass : #MbDAnglezIeqcJec,
	#instVars : [
		'pthezpEJ',
		'ppthezpEIpEJ',
		'ppthezpEJpEJ'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDAnglezIeqcJeqc >> calcPostDynCorrectorIteration [
	| pcthezpEJ psthezpEJ ppcthezpEIpEJ ppsthezpEIpEJ ppcthezpEJpEJ ppsthezpEJpEJ ppthezpEIpEJi ppcthezpEIpEJi ppsthezpEIpEJi pcthezpEIi psthezpEIi pcthezpEJj psthezpEJj term1 term2 term3 ppthezpEJpEJi ppcthezpEJpEJi ppsthezpEJpEJi pcthezpEJi psthezpEJi ppthezpEJpEJij |
	super calcPostDynCorrectorIteration.
	pcthezpEJ := aA11IeJe pvaluepEJ.
	psthezpEJ := aA21IeJe pvaluepEJ.
	ppcthezpEIpEJ := aA11IeJe ppvaluepEIpEJ.
	ppsthezpEIpEJ := aA21IeJe ppvaluepEIpEJ.
	ppcthezpEJpEJ := aA11IeJe ppvaluepEJpEJ.
	ppsthezpEJpEJ := aA21IeJe ppvaluepEJpEJ.
	1 to: 4 do: [:i | pthezpEJ at: i put: (psthezpEJ at: i) * cosOverSSq - ((pcthezpEJ at: i) * sinOverSSq)].
	1 to: 4 do: [:i | 
			ppthezpEIpEJi := ppthezpEIpEJ at: i.
			ppcthezpEIpEJi := ppcthezpEIpEJ at: i.
			ppsthezpEIpEJi := ppsthezpEIpEJ at: i.
			pcthezpEIi := pcthezpEI at: i.
			psthezpEIi := psthezpEI at: i.
			1 to: 4 do: [:j | 
					pcthezpEJj := pcthezpEJ at: j.
					psthezpEJj := psthezpEJ at: j.
					term1 := pcthezpEIi * pcthezpEJj - (psthezpEIi * psthezpEJj) * twoCosSinOverSSqSq.
					term2 := (ppsthezpEIpEJi at: j) * cosOverSSq - ((ppcthezpEIpEJi at: j) * sinOverSSq).
					term3 := psthezpEIi * pcthezpEJj + (pcthezpEIi * psthezpEJj) * dSqOverSSqSq.
					ppthezpEIpEJi at: j put: term1 + term2 + term3]].
	1 to: 4 do: [:i | 
			ppthezpEJpEJi := ppthezpEJpEJ at: i.
			ppcthezpEJpEJi := ppcthezpEJpEJ at: i.
			ppsthezpEJpEJi := ppsthezpEJpEJ at: i.
			pcthezpEJi := pcthezpEJ at: i.
			psthezpEJi := psthezpEJ at: i.
			term1 := pcthezpEJi * pcthezpEJi - (psthezpEJi * psthezpEJi) * twoCosSinOverSSqSq.
			term2 := (ppsthezpEJpEJi at: i) * cosOverSSq - ((ppcthezpEJpEJi at: i) * sinOverSSq).
			term3 := psthezpEJi * pcthezpEJi + (pcthezpEJi * psthezpEJi) * dSqOverSSqSq.
			ppthezpEJpEJi at: i put: term1 + term2 + term3.
			i + 1 to: 4 do: [:j | 
					pcthezpEJj := pcthezpEJ at: j.
					psthezpEJj := psthezpEJ at: j.
					term1 := pcthezpEJi * pcthezpEJj - (psthezpEJi * psthezpEJj) * twoCosSinOverSSqSq.
					term2 := (ppsthezpEJpEJi at: j) * cosOverSSq - ((ppcthezpEJpEJi at: j) * sinOverSSq).
					term3 := psthezpEJi * pcthezpEJj + (pcthezpEJi * psthezpEJj) * dSqOverSSqSq.
					ppthezpEJpEJij := term1 + term2 + term3.
					ppthezpEJpEJi at: j put: ppthezpEJpEJij.
					ppthezpEJpEJ at: j and: i put: ppthezpEJpEJij]]
]

{ #category : #'initialize-release' }
MbDAnglezIeqcJeqc >> initDirectionCosines [
	aA11IeJe := MbDDirectionCosineIeqcJeqc new.
	aA21IeJe := MbDDirectionCosineIeqcJeqc new
]

{ #category : #'initialize-release' }
MbDAnglezIeqcJeqc >> initialize [
	super initialize.
	pthezpEJ := FullRow new: 4.
	ppthezpEIpEJ := FullMatrix new: 4 by: 4.
	ppthezpEJpEJ := FullMatrix new: 4 by: 4
]

{ #category : #accessing }
MbDAnglezIeqcJeqc >> ppthezpEIpEJ [
	^ppthezpEIpEJ
]

{ #category : #accessing }
MbDAnglezIeqcJeqc >> ppthezpEJpEJ [
	^ppthezpEJpEJ
]

{ #category : #accessing }
MbDAnglezIeqcJeqc >> ppvaluepEIpEJ [
	^ppthezpEIpEJ
]

{ #category : #accessing }
MbDAnglezIeqcJeqc >> ppvaluepEJpEJ [
	^ppthezpEJpEJ
]

{ #category : #accessing }
MbDAnglezIeqcJeqc >> pthezpEJ [
	^pthezpEJ
]

{ #category : #accessing }
MbDAnglezIeqcJeqc >> pvaluepEJ [
	^pthezpEJ
]
