Class {
	#name : #MbDDispCompIeqcJeqcKeqcs,
	#superclass : #MbDDispCompIeqcJeqcKeqc,
	#instVars : [
		'sSizeK',
		'priIeJeKepsK',
		'ppriIeJeKepXIpsK',
		'ppriIeJeKepEIpsK',
		'ppriIeJeKepXJpsK',
		'ppriIeJeKepEJpsK',
		'ppriIeJeKepEKpsK',
		'ppriIeJeKepsKpsK',
		'pAjOKepsKT',
		'ppAjOKepEKpsK',
		'ppAjOKepsKpsK'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDDispCompIeqcJeqcKeqcs class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDispCompIeqcJeqcKeqcs class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFrameqc) & (afrmK isKindOf: MbDEndFrameqcs)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				frmK: afrmK
				axisK: integer]
		ifFalse: [nil]
]

{ #category : #calc }
MbDDispCompIeqcJeqcKeqcs >> calcPostDynCorrectorIteration [
	"ppAjOIepEKpEK is not longer constant and must be set before any calculation."

	| mprIeJeOpEIT prIeJeOpEJT ppriIeJeKepXIipsK ppriIeJeKepXJipsK ppriIeJeKepEIipsK ppriIeJeKepEJipsK ppAjOKepsKipsK ppriIeJeKepsKipsK ppriIeJeKepsKipsKj ppAjOKepEKipsK ppriIeJeKepEKipsK |
	ppAjOKepEKpEK := efrmK ppAjOepEpE: axisK.
	super calcPostDynCorrectorIteration.
	pAjOKepsKT := efrmK pAjOepsT: axisK.
	ppAjOKepEKpsK := efrmK ppAjOepEps: axisK.
	ppAjOKepsKpsK := efrmK ppAjOepsps: axisK.
	mprIeJeOpEIT := frmI prOeOpE transpose.
	prIeJeOpEJT := frmJ prOeOpE transpose.
	1 to: sSizeK do: [:i | priIeJeKepsK at: i put: ((pAjOKepsKT at: i)
				dot: rIeJeO)].
	1 to: 3 do: [:i | 
			ppriIeJeKepXIipsK := ppriIeJeKepXIpsK at: i.
			1 to: sSizeK do: [:j | ppriIeJeKepXIipsK at: j put: 0.0d - (pAjOKepsKT at: j and: i)]].
	1 to: 3 do: [:i | 
			ppriIeJeKepXJipsK := ppriIeJeKepXJpsK at: i.
			1 to: sSizeK do: [:j | ppriIeJeKepXJipsK at: j put: (pAjOKepsKT at: j and: i)]].
	1 to: 4 do: [:i | 
			ppriIeJeKepEIipsK := ppriIeJeKepEIpsK at: i.
			1 to: sSizeK do: [:j | ppriIeJeKepEIipsK at: j put: 0.0d - ((pAjOKepsKT at: j) dot: (mprIeJeOpEIT at: i))]].
	1 to: 4 do: [:i | 
			ppriIeJeKepEJipsK := ppriIeJeKepEJpsK at: i.
			1 to: sSizeK do: [:j | ppriIeJeKepEJipsK at: j put: ((pAjOKepsKT at: j) dot: (prIeJeOpEJT at: i))]].
	1 to: 4 do: [:i | 
			ppAjOKepEKipsK := ppAjOKepEKpsK at: i.
			ppriIeJeKepEKipsK := ppriIeJeKepEKpsK at: i.
			1 to: sSizeK do: [:j | ppriIeJeKepEKipsK at: j put: ((ppAjOKepEKipsK at: j) dot: rIeJeO)]].
	1 to: sSizeK do: [:i | 
			ppAjOKepsKipsK := ppAjOKepsKpsK at: i.
			ppriIeJeKepsKipsK := ppriIeJeKepsKpsK at: i.
			ppriIeJeKepsKipsK at: i put: ((ppAjOKepsKipsK at: i) dot: rIeJeO).
			i + 1 to: sSizeK do: [:j | 
					ppriIeJeKepsKipsKj := (ppAjOKepsKipsK at: j) dot: rIeJeO.
					ppriIeJeKepsKipsK at: j put: ppriIeJeKepsKipsKj.
					ppriIeJeKepsKpsK at: j and: i put: ppriIeJeKepsKipsKj]]
]

{ #category : #'initialize-release' }
MbDDispCompIeqcJeqcKeqcs >> initializeGlobally [
	"Do nothing."
]

{ #category : #'initialize-release' }
MbDDispCompIeqcJeqcKeqcs >> initializeLocally [
	super initializeLocally.
	sSizeK := efrmK sSize.
	priIeJeKepsK := FullRow new: sSizeK.
	ppriIeJeKepXIpsK := FullMatrix new: 3 by: sSizeK.
	ppriIeJeKepEIpsK := FullMatrix new: 4 by: sSizeK.
	ppriIeJeKepXJpsK := FullMatrix new: 3 by: sSizeK.
	ppriIeJeKepEJpsK := FullMatrix new: 4 by: sSizeK.
	ppriIeJeKepEKpsK := FullMatrix new: 4 by: sSizeK.
	ppriIeJeKepsKpsK := FullMatrix new: sSizeK by: sSizeK
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqcs >> ppriIeJeKepEIpsK [
	^ppriIeJeKepEIpsK
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqcs >> ppriIeJeKepEJpsK [
	^ppriIeJeKepEJpsK
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqcs >> ppriIeJeKepEKpsK [
	^ppriIeJeKepEKpsK
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqcs >> ppriIeJeKepXIpsK [
	^ppriIeJeKepXIpsK
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqcs >> ppriIeJeKepXJpsK [
	^ppriIeJeKepXJpsK
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqcs >> ppriIeJeKepsKpsK [
	^ppriIeJeKepsKpsK
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqcs >> ppvaluepEIpsK [
	^ppriIeJeKepEIpsK
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqcs >> ppvaluepEJpsK [
	^ppriIeJeKepEJpsK
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqcs >> ppvaluepEKpsK [
	^ppriIeJeKepEKpsK
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqcs >> ppvaluepXIpsK [
	^ppriIeJeKepXIpsK
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqcs >> ppvaluepXJpsK [
	^ppriIeJeKepXJpsK
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqcs >> ppvaluepsKpsK [
	^ppriIeJeKepsKpsK
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqcs >> priIeJeKepsK [
	^priIeJeKepsK
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqcs >> pvaluepsK [
	^priIeJeKepsK
]
