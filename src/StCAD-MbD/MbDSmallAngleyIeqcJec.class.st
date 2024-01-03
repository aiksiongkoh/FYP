Class {
	#name : #MbDSmallAngleyIeqcJec,
	#superclass : #MbDSmallAngleyIecJec,
	#instVars : [
		'ptheypEI',
		'pptheypEIpEI'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDSmallAngleyIeqcJec >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	ptheypEI := aA13IeJe pvaluepEI.
	pptheypEIpEI := aA13IeJe ppvaluepEIpEI
]

{ #category : #'initialize-release' }
MbDSmallAngleyIeqcJec >> initialize [
	aA13IeJe := MbDDirectionCosineIeqcJec new
]

{ #category : #accessing }
MbDSmallAngleyIeqcJec >> pptheypEIpEI [
	^pptheypEIpEI
]

{ #category : #accessing }
MbDSmallAngleyIeqcJec >> ppvaluepEIpEI [
	^pptheypEIpEI
]

{ #category : #accessing }
MbDSmallAngleyIeqcJec >> ptheypEI [
	^ptheypEI
]

{ #category : #accessing }
MbDSmallAngleyIeqcJec >> pvaluepEI [
	^ptheypEI
]
