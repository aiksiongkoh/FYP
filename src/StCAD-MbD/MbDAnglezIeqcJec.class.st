Class {
	#name : #MbDAnglezIeqcJec,
	#superclass : #MbDAnglezIecJec,
	#instVars : [
		'pthezpEI',
		'ppthezpEIpEI',
		'pcthezpEI',
		'psthezpEI'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDAnglezIeqcJec >> calcPostDynCorrectorIteration [
	| ppcthezpEIpEI ppsthezpEIpEI ppthezpEIpEIi ppcthezpEIpEIi ppsthezpEIpEIi pcthezpEIi psthezpEIi term1 term2 term3 pcthezpEIj psthezpEIj ppthezpEIpEIij |
	super calcPostDynCorrectorIteration.
	pcthezpEI := aA11IeJe pvaluepEI.
	psthezpEI := aA21IeJe pvaluepEI.
	ppcthezpEIpEI := aA11IeJe ppvaluepEIpEI.
	ppsthezpEIpEI := aA21IeJe ppvaluepEIpEI.
	1 to: 4 do: [:i | pthezpEI at: i put: (psthezpEI at: i) * cosOverSSq - ((pcthezpEI at: i) * sinOverSSq)].
	1 to: 4 do: [:i | 
			ppthezpEIpEIi := ppthezpEIpEI at: i.
			ppcthezpEIpEIi := ppcthezpEIpEI at: i.
			ppsthezpEIpEIi := ppsthezpEIpEI at: i.
			pcthezpEIi := pcthezpEI at: i.
			psthezpEIi := psthezpEI at: i.
			term1 := pcthezpEIi * pcthezpEIi - (psthezpEIi * psthezpEIi) * twoCosSinOverSSqSq.
			term2 := (ppsthezpEIpEIi at: i) * cosOverSSq - ((ppcthezpEIpEIi at: i) * sinOverSSq).
			term3 := psthezpEIi * pcthezpEIi + (pcthezpEIi * psthezpEIi) * dSqOverSSqSq.
			ppthezpEIpEIi at: i put: term1 + term2 + term3.
			i + 1 to: 4 do: [:j | 
					pcthezpEIj := pcthezpEI at: j.
					psthezpEIj := psthezpEI at: j.
					term1 := pcthezpEIi * pcthezpEIj - (psthezpEIi * psthezpEIj) * twoCosSinOverSSqSq.
					term2 := (ppsthezpEIpEIi at: j) * cosOverSSq - ((ppcthezpEIpEIi at: j) * sinOverSSq).
					term3 := psthezpEIi * pcthezpEIj + (pcthezpEIi * psthezpEIj) * dSqOverSSqSq.
					ppthezpEIpEIij := term1 + term2 + term3.
					ppthezpEIpEIi at: j put: ppthezpEIpEIij.
					ppthezpEIpEI at: j and: i put: ppthezpEIpEIij]]
]

{ #category : #'initialize-release' }
MbDAnglezIeqcJec >> initDirectionCosines [
	aA11IeJe := MbDDirectionCosineIeqcJec new.
	aA21IeJe := MbDDirectionCosineIeqcJec new
]

{ #category : #'initialize-release' }
MbDAnglezIeqcJec >> initialize [
	super initialize.
	pthezpEI := FullRow new: 4.
	ppthezpEIpEI := FullMatrix new: 4 by: 4
]

{ #category : #accessing }
MbDAnglezIeqcJec >> ppthezpEIpEI [
	^ppthezpEIpEI
]

{ #category : #accessing }
MbDAnglezIeqcJec >> ppvaluepEIpEI [
	^ppthezpEIpEI
]

{ #category : #accessing }
MbDAnglezIeqcJec >> pthezpEI [
	^pthezpEI
]

{ #category : #accessing }
MbDAnglezIeqcJec >> pvaluepEI [
	^pthezpEI
]
