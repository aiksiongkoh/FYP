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

{ #category : #'VisualWorks metadata' }
MbDSmallAnglexIeqcJeqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDSmallAnglexIeqcJeqc class >> withFrmI: afrmI frmJ: afrmJ [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFrameqc)
		ifTrue: [self new withFrmI: afrmI frmJ: afrmJ]
		ifFalse: [nil]
]

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
