Class {
	#name : #MbDSmallAngleyIeqcJec,
	#superclass : #MbDSmallAngleyIecJec,
	#instVars : [
		'ptheypEI',
		'pptheypEIpEI'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDSmallAngleyIeqcJec class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDSmallAngleyIeqcJec class >> withFrmI: afrmI frmJ: afrmJ [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFramec)
		ifTrue: [self new withFrmI: afrmI frmJ: afrmJ]
		ifFalse: [nil]
]

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
