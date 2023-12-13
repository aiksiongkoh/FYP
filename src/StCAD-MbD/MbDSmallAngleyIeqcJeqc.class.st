Class {
	#name : #MbDSmallAngleyIeqcJeqc,
	#superclass : #MbDSmallAngleyIeqcJec,
	#instVars : [
		'ptheypEJ',
		'pptheypEIpEJ',
		'pptheypEJpEJ'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDSmallAngleyIeqcJeqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDSmallAngleyIeqcJeqc class >> withFrmI: afrmI frmJ: afrmJ [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFrameqc)
		ifTrue: [self new withFrmI: afrmI frmJ: afrmJ]
		ifFalse: [nil]
]

{ #category : #calc }
MbDSmallAngleyIeqcJeqc >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	ptheypEJ := aA13IeJe pvaluepEJ.
	pptheypEIpEJ := aA13IeJe ppvaluepEIpEJ.
	pptheypEJpEJ := aA13IeJe ppvaluepEJpEJ
]

{ #category : #'initialize-release' }
MbDSmallAngleyIeqcJeqc >> initialize [
	aA13IeJe := MbDDirectionCosineIeqcJeqc new
]

{ #category : #accessing }
MbDSmallAngleyIeqcJeqc >> pptheypEIpEJ [
	^pptheypEIpEJ
]

{ #category : #accessing }
MbDSmallAngleyIeqcJeqc >> pptheypEJpEJ [
	^pptheypEJpEJ
]

{ #category : #accessing }
MbDSmallAngleyIeqcJeqc >> ppvaluepEIpEJ [
	^pptheypEIpEJ
]

{ #category : #accessing }
MbDSmallAngleyIeqcJeqc >> ppvaluepEJpEJ [
	^pptheypEJpEJ
]

{ #category : #accessing }
MbDSmallAngleyIeqcJeqc >> ptheypEJ [
	^ptheypEJ
]

{ #category : #accessing }
MbDSmallAngleyIeqcJeqc >> pvaluepEJ [
	^ptheypEJ
]
