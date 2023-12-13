Class {
	#name : #MbDDispCompIeqcJeqcIe,
	#superclass : #MbDDispCompIeqcJecIe,
	#instVars : [
		'priIeJeIepXJ',
		'priIeJeIepEJ',
		'ppriIeJeIepEIpXJ',
		'ppriIeJeIepEIpEJ',
		'ppriIeJeIepEJpEJ'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDDispCompIeqcJeqcIe class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDispCompIeqcJeqcIe class >> withFrmI: afrmI frmJ: afrmJ axis: aaxis [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFrameqc)
		ifTrue: [self new withFrmI: afrmI frmJ: afrmJ axis: aaxis]
		ifFalse: [nil]
]

{ #category : #calc }
MbDDispCompIeqcJeqcIe >> calcPostDynCorrectorIteration [
	| prIeJeOpEJ pprIeJeOpEJpEJ pprIeJeOpEJipEJ ppriIeJeIepEJipEJ term1 |
	super calcPostDynCorrectorIteration.
	prIeJeOpEJ := frmJ prOeOpE.
	pprIeJeOpEJpEJ := frmJ pprOeOpEpE.
	priIeJeIepXJ equalFullRow: aAjOIe.
	priIeJeIepEJ := aAjOIe dot: prIeJeOpEJ.
	ppriIeJeIepEIpXJ := pAjOIepEIT.
	ppriIeJeIepEIpEJ := pAjOIepEIT timesFullMatrix: prIeJeOpEJ.
	1 to: 4 do: [:i | 
			pprIeJeOpEJipEJ := pprIeJeOpEJpEJ at: i.
			ppriIeJeIepEJipEJ := ppriIeJeIepEJpEJ at: i.
			i to: 4 do: [:j | 
					term1 := aAjOIe dot: (pprIeJeOpEJipEJ at: j).
					ppriIeJeIepEJipEJ at: j put: term1]].
	ppriIeJeIepEJpEJ symLowerWithUpper
]

{ #category : #'initialize-release' }
MbDDispCompIeqcJeqcIe >> initialize [
	super initialize.
	priIeJeIepXJ := FullRow new: 3.
	priIeJeIepEJ := FullRow new: 4.
	ppriIeJeIepEIpXJ := FullMatrix new: 4 by: 3.
	ppriIeJeIepEIpEJ := FullMatrix new: 4 by: 4.
	ppriIeJeIepEJpEJ := FullMatrix new: 4 by: 4
]

{ #category : #accessing }
MbDDispCompIeqcJeqcIe >> ppriIeJeIepEIpEJ [
	^ppriIeJeIepEIpEJ
]

{ #category : #accessing }
MbDDispCompIeqcJeqcIe >> ppriIeJeIepEIpXJ [
	^ppriIeJeIepEIpXJ
]

{ #category : #accessing }
MbDDispCompIeqcJeqcIe >> ppriIeJeIepEJpEJ [
	^ppriIeJeIepEJpEJ
]

{ #category : #accessing }
MbDDispCompIeqcJeqcIe >> ppvaluepEIpEJ [
	^ppriIeJeIepEIpEJ
]

{ #category : #accessing }
MbDDispCompIeqcJeqcIe >> ppvaluepEIpXJ [
	^ppriIeJeIepEIpXJ
]

{ #category : #accessing }
MbDDispCompIeqcJeqcIe >> ppvaluepEJpEJ [
	^ppriIeJeIepEJpEJ
]

{ #category : #accessing }
MbDDispCompIeqcJeqcIe >> priIeJeIepEJ [
	^priIeJeIepEJ
]

{ #category : #accessing }
MbDDispCompIeqcJeqcIe >> priIeJeIepXJ [
	^priIeJeIepXJ
]

{ #category : #accessing }
MbDDispCompIeqcJeqcIe >> pvaluepEJ [
	^priIeJeIepEJ
]

{ #category : #accessing }
MbDDispCompIeqcJeqcIe >> pvaluepXJ [
	^priIeJeIepXJ
]
