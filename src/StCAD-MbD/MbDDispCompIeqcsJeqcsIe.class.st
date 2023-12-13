Class {
	#name : #MbDDispCompIeqcsJeqcsIe,
	#superclass : #MbDDispCompIeqcsJeqcIe,
	#instVars : [
		'sSizeJ',
		'priIeJeIepsJ',
		'ppriIeJeIepEIpsJ',
		'ppriIeJeIepEJpsJ',
		'ppriIeJeIepsIpsJ',
		'ppriIeJeIepsJpsJ'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDDispCompIeqcsJeqcsIe class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDispCompIeqcsJeqcsIe class >> withFrmI: afrmI frmJ: afrmJ axis: aaxis [ 
	^(afrmI isKindOf: MbDEndFrameqcs)
		& (afrmJ isKindOf: MbDEndFrameqcs)
		ifTrue: [self new withFrmI: afrmI frmJ: afrmJ axis: aaxis]
		ifFalse: [nil]
]

{ #category : #calc }
MbDDispCompIeqcsJeqcsIe >> calcPostDynCorrectorIteration [
	| prIeJeOpsJ pprIeJeOpEJpsJ pprIeJeOpsJpsJ pprIeJeOpEJipsJ ppriIeJeIepEJipsJ pprIeJeOpsJipsJ ppriIeJeIepsJipsJ |
	super calcPostDynCorrectorIteration.
	prIeJeOpsJ := frmJ prOeOps.
	pprIeJeOpEJpsJ := frmJ pprOeOpEps.
	pprIeJeOpsJpsJ := frmJ pprOeOpsps.
	priIeJeIepsJ := aAjOIe dot: prIeJeOpsJ.
	ppriIeJeIepEIpsJ := pAjOIepEIT timesFullMatrix: prIeJeOpsJ.
	1 to: 4 do: [:i | 
			pprIeJeOpEJipsJ := pprIeJeOpEJpsJ at: i.
			ppriIeJeIepEJipsJ := ppriIeJeIepEJpsJ at: i.
			1 to: sSizeJ do: [:j | ppriIeJeIepEJipsJ at: j put: (aAjOIe dot: (pprIeJeOpEJipsJ at: j))]].
	ppriIeJeIepsIpsJ := pAjOIepsIT timesFullMatrix: prIeJeOpsJ.
	1 to: sSizeJ do: [:i | 
			pprIeJeOpsJipsJ := pprIeJeOpsJpsJ at: i.
			ppriIeJeIepsJipsJ := ppriIeJeIepsJpsJ at: i.
			i to: sSizeJ do: [:j | ppriIeJeIepsJipsJ at: j put: (aAjOIe dot: (pprIeJeOpsJipsJ at: j))]].
	ppriIeJeIepsJpsJ symLowerWithUpper
]

{ #category : #'initialize-release' }
MbDDispCompIeqcsJeqcsIe >> initializeLocally [
	super initializeLocally.
	sSizeJ := frmJ sSize.
	priIeJeIepsJ := FullRow new: sSizeJ.
	ppriIeJeIepEIpsJ := FullMatrix new: 4 by: sSizeJ.
	ppriIeJeIepEJpsJ := FullMatrix new: 4 by: sSizeJ.
	ppriIeJeIepsIpsJ := FullMatrix new: sSizeI by: sSizeJ.
	ppriIeJeIepsJpsJ := FullMatrix new: sSizeJ by: sSizeJ
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcsIe >> ppriIeJeIepEIpsJ [
	^ppriIeJeIepEIpsJ
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcsIe >> ppriIeJeIepEJpsJ [
	^ppriIeJeIepEJpsJ
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcsIe >> ppriIeJeIepsIpsJ [
	^ppriIeJeIepsIpsJ
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcsIe >> ppriIeJeIepsJpsJ [
	^ppriIeJeIepsJpsJ
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcsIe >> priIeJeIepsJ [
	^priIeJeIepsJ
]
