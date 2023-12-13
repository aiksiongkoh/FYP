Class {
	#name : #MbDDispCompIeqcsJeqcKeqcs,
	#superclass : #MbDDispCompIeqcJeqcKeqcs,
	#instVars : [
		'sSizeI',
		'priIeJeKepsI',
		'ppriIeJeKepEIpsI',
		'ppriIeJeKepsIpsI',
		'ppriIeJeKepsIpEK',
		'ppriIeJeKepsIpsK'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDDispCompIeqcsJeqcKeqcs class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDispCompIeqcsJeqcKeqcs class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	^(afrmI isKindOf: MbDEndFrameqcs)
		& (afrmJ isMemberOf: MbDEndFrameqc) & (afrmK isKindOf: MbDEndFrameqcs)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				frmK: afrmK
				axisK: integer]
		ifFalse: [nil]
]

{ #category : #calc }
MbDDispCompIeqcsJeqcKeqcs >> calcPostDynCorrectorIteration [
	| prIeJeOpsIT pprIeJeOpEIpsI pprIeJeOpsIpsI ppriIeJeKepEIipsI pprIeJeOpEIipsI ppriIeJeKepsIipsI pprIeJeOpsIipsI ppriIeJeKepsIipsIj ppriIeJeKepsIipEK ppriIeJeKepsIipsK |
	super calcPostDynCorrectorIteration.
	prIeJeOpsIT := frmI prOeOps transpose negated.
	pprIeJeOpEIpsI := frmI pprOeOpEps negated.
	pprIeJeOpsIpsI := frmI pprOeOpsps negated.
	1 to: sSizeI do: [:i | priIeJeKepsI at: i put: (aAjOKe dot: (prIeJeOpsIT at: i))].
	1 to: 4 do: [:i | 
			ppriIeJeKepEIipsI := ppriIeJeKepEIpsI at: i.
			pprIeJeOpEIipsI := pprIeJeOpEIpsI at: i.
			1 to: sSizeI do: [:j | ppriIeJeKepEIipsI at: j put: (aAjOKe dot: (pprIeJeOpEIipsI at: j))]].
	1 to: sSizeI do: [:i | 
			ppriIeJeKepsIipsI := ppriIeJeKepsIpsI at: i.
			pprIeJeOpsIipsI := pprIeJeOpsIpsI at: i.
			ppriIeJeKepsIipsI at: i put: (aAjOKe dot: (pprIeJeOpsIipsI at: i)).
			i + 1 to: sSizeI do: [:j | 
					ppriIeJeKepsIipsIj := aAjOKe dot: (pprIeJeOpsIipsI at: j).
					ppriIeJeKepsIipsI at: j put: ppriIeJeKepsIipsIj.
					ppriIeJeKepsIpsI at: j and: i put: ppriIeJeKepsIipsIj]].
	1 to: sSizeI do: [:i | 
			ppriIeJeKepsIipEK := ppriIeJeKepsIpEK at: i.
			1 to: 4 do: [:j | ppriIeJeKepsIipEK at: j put: ((pAjOKepEKT at: j) dot: (prIeJeOpsIT at: i))]].
	1 to: sSizeI do: [:i | 
			ppriIeJeKepsIipsK := ppriIeJeKepsIpsK at: i.
			1 to: sSizeK do: [:j | ppriIeJeKepsIipsK at: j put: ((pAjOKepsKT at: j) dot: (prIeJeOpsIT at: i))]]
]

{ #category : #'initialize-release' }
MbDDispCompIeqcsJeqcKeqcs >> initializeLocally [
	super initializeLocally.
	sSizeI := frmI sSize.
	priIeJeKepsI := FullRow new: sSizeI.
	ppriIeJeKepEIpsI := FullMatrix new: 4 by: sSizeI.
	ppriIeJeKepsIpsI := FullMatrix new: sSizeI by: sSizeI.
	ppriIeJeKepsIpEK := FullMatrix new: sSizeI by: 4.
	ppriIeJeKepsIpsK := FullMatrix new: sSizeI by: sSizeK
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcKeqcs >> ppriIeJeKepEIpsI [
	^ppriIeJeKepEIpsI
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcKeqcs >> ppriIeJeKepsIpEK [
	^ppriIeJeKepsIpEK
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcKeqcs >> ppriIeJeKepsIpsI [
	^ppriIeJeKepsIpsI
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcKeqcs >> ppriIeJeKepsIpsK [
	^ppriIeJeKepsIpsK
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcKeqcs >> ppvaluepEIpsI [
	^ppriIeJeKepEIpsI
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcKeqcs >> ppvaluepsIpEK [
	^ppriIeJeKepsIpEK
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcKeqcs >> ppvaluepsIpsI [
	^ppriIeJeKepsIpsI
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcKeqcs >> ppvaluepsIpsK [
	^ppriIeJeKepsIpsK
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcKeqcs >> priIeJeKepsI [
	^priIeJeKepsI
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcKeqcs >> pvaluepsI [
	^priIeJeKepsI
]
