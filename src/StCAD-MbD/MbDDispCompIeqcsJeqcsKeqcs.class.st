Class {
	#name : #MbDDispCompIeqcsJeqcsKeqcs,
	#superclass : #MbDDispCompIeqcsJeqcKeqcs,
	#instVars : [
		'sSizeJ',
		'priIeJeKepsJ',
		'ppriIeJeKepEJpsJ',
		'ppriIeJeKepsJpsJ',
		'ppriIeJeKepsJpEK',
		'ppriIeJeKepsJpsK'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDDispCompIeqcsJeqcsKeqcs class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDispCompIeqcsJeqcsKeqcs class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	^(afrmI isKindOf: MbDEndFrameqcs)
		& (afrmJ isKindOf: MbDEndFrameqcs) & (afrmK isKindOf: MbDEndFrameqcs)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				frmK: afrmK
				axisK: integer]
		ifFalse: [nil]
]

{ #category : #calc }
MbDDispCompIeqcsJeqcsKeqcs >> calcPostDynCorrectorIteration [
	| prIeJeOpsJT pprIeJeOpEJpsJ pprIeJeOpsJpsJ ppriIeJeKepEJipsJ pprIeJeOpEJipsJ ppriIeJeKepsJipsJ pprIeJeOpsJipsJ ppriIeJeKepsJipsJj ppriIeJeKepsJipEK ppriIeJeKepsJipsK |
	super calcPostDynCorrectorIteration.
	prIeJeOpsJT := frmJ prOeOps transpose.
	pprIeJeOpEJpsJ := frmJ pprOeOpEps.
	pprIeJeOpsJpsJ := frmJ pprOeOpsps.
	1 to: sSizeI do: [:i | priIeJeKepsJ at: i put: (aAjOKe dot: (prIeJeOpsJT at: i))].
	1 to: 4 do: [:i | 
			ppriIeJeKepEJipsJ := ppriIeJeKepEJpsJ at: i.
			pprIeJeOpEJipsJ := pprIeJeOpEJpsJ at: i.
			1 to: sSizeI do: [:j | ppriIeJeKepEJipsJ at: j put: (aAjOKe dot: (pprIeJeOpEJipsJ at: j))]].
	1 to: sSizeI do: [:i | 
			ppriIeJeKepsJipsJ := ppriIeJeKepsJpsJ at: i.
			pprIeJeOpsJipsJ := pprIeJeOpsJpsJ at: i.
			ppriIeJeKepsJipsJ at: i put: (aAjOKe dot: (pprIeJeOpsJipsJ at: i)).
			i + 1 to: sSizeI do: [:j | 
					ppriIeJeKepsJipsJj := aAjOKe dot: (pprIeJeOpsJipsJ at: j).
					ppriIeJeKepsJipsJ at: j put: ppriIeJeKepsJipsJj.
					ppriIeJeKepsJpsJ at: j and: i put: ppriIeJeKepsJipsJj]].
	1 to: sSizeI do: [:i | 
			ppriIeJeKepsJipEK := ppriIeJeKepsJpEK at: i.
			1 to: 4 do: [:j | ppriIeJeKepsJipEK at: j put: ((pAjOKepEKT at: j) dot: (prIeJeOpsJT at: i))]].
	1 to: sSizeI do: [:i | 
			ppriIeJeKepsJipsK := ppriIeJeKepsJpsK at: i.
			1 to: sSizeK do: [:j | ppriIeJeKepsJipsK at: j put: ((pAjOKepsKT at: j) dot: (prIeJeOpsJT at: i))]]
]

{ #category : #'initialize-release' }
MbDDispCompIeqcsJeqcsKeqcs >> initializeLocally [
	super initializeLocally.
	sSizeJ := frmJ sSize.
	priIeJeKepsJ := FullRow new: sSizeJ.
	ppriIeJeKepEJpsJ := FullMatrix new: 4 by: sSizeJ.
	ppriIeJeKepsJpsJ := FullMatrix new: sSizeJ by: sSizeJ.
	ppriIeJeKepsJpEK := FullMatrix new: sSizeJ by: 4.
	ppriIeJeKepsJpsK := FullMatrix new: sSizeJ by: sSizeK
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcsKeqcs >> ppriIeJeKepEJpsJ [
	^ppriIeJeKepEJpsJ
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcsKeqcs >> ppriIeJeKepsJpEK [
	^ppriIeJeKepsJpEK
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcsKeqcs >> ppriIeJeKepsJpsJ [
	^ppriIeJeKepsJpsJ
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcsKeqcs >> ppriIeJeKepsJpsK [
	^ppriIeJeKepsJpsK
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcsKeqcs >> ppvaluepEJpsJ [
	^ppriIeJeKepEJpsJ
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcsKeqcs >> ppvaluepsJpEK [
	^ppriIeJeKepsJpEK
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcsKeqcs >> ppvaluepsJpsJ [
	^ppriIeJeKepsJpsJ
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcsKeqcs >> ppvaluepsJpsK [
	^ppriIeJeKepsJpsK
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcsKeqcs >> priIeJeKepsJ [
	^priIeJeKepsJ
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcsKeqcs >> pvaluepsJ [
	^priIeJeKepsJ
]
