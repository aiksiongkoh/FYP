Class {
	#name : #MbDSmallAnglexIeqcJec,
	#superclass : #MbDSmallAnglexIecJec,
	#instVars : [
		'pthexpEI',
		'ppthexpEIpEI'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDSmallAnglexIeqcJec class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDSmallAnglexIeqcJec class >> withFrmI: afrmI frmJ: afrmJ [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFramec)
		ifTrue: [self new withFrmI: afrmI frmJ: afrmJ]
		ifFalse: [nil]
]

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
