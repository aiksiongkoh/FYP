Class {
	#name : #MbDSmallAnglexIeqcJec,
	#superclass : #MbDSmallAnglexIecJec,
	#instVars : [
		'pthexpEI',
		'ppthexpEIpEI'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDSmallAnglexIeqcJec >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	pthexpEI := aA23IeJe pvaluepEI negated.
	ppthexpEIpEI := aA23IeJe ppvaluepEIpEI negated
]

{ #category : #'initialize-release' }
MbDSmallAnglexIeqcJec >> initialize [
	aA23IeJe := MbDDirectionCosineIeqcJec new
]

{ #category : #accessing }
MbDSmallAnglexIeqcJec >> ppthexpEIpEI [
	^ppthexpEIpEI
]

{ #category : #accessing }
MbDSmallAnglexIeqcJec >> ppvaluepEIpEI [
	^ppthexpEIpEI
]

{ #category : #accessing }
MbDSmallAnglexIeqcJec >> pthexpEI [
	^pthexpEI
]

{ #category : #accessing }
MbDSmallAnglexIeqcJec >> pvaluepEI [
	^pthexpEI
]
