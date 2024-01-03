Class {
	#name : #MbDSmallAnglexIeqcJeqc,
	#superclass : #MbDSmallAnglexIeqcJec,
	#instVars : [
		'pthexpEJ',
		'ppthexpEIpEJ',
		'ppthexpEJpEJ'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDSmallAnglexIeqcJeqc >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	pthexpEJ := aA23IeJe pvaluepEJ negated.
	ppthexpEIpEJ := aA23IeJe ppvaluepEIpEJ negated.
	ppthexpEJpEJ := aA23IeJe ppvaluepEJpEJ negated
]

{ #category : #'initialize-release' }
MbDSmallAnglexIeqcJeqc >> initialize [
	aA23IeJe := MbDDirectionCosineIeqcJeqc new
]

{ #category : #accessing }
MbDSmallAnglexIeqcJeqc >> ppthexpEIpEJ [
	^ppthexpEIpEJ
]

{ #category : #accessing }
MbDSmallAnglexIeqcJeqc >> ppthexpEJpEJ [
	^ppthexpEJpEJ
]

{ #category : #accessing }
MbDSmallAnglexIeqcJeqc >> ppvaluepEIpEJ [
	^ppthexpEIpEJ
]

{ #category : #accessing }
MbDSmallAnglexIeqcJeqc >> ppvaluepEJpEJ [
	^ppthexpEJpEJ
]

{ #category : #accessing }
MbDSmallAnglexIeqcJeqc >> pthexpEJ [
	^pthexpEJ
]

{ #category : #accessing }
MbDSmallAnglexIeqcJeqc >> pvaluepEJ [
	^pthexpEJ
]
