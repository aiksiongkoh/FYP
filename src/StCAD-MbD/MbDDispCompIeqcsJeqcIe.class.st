Class {
	#name : #MbDDispCompIeqcsJeqcIe,
	#superclass : #MbDDispCompIeqcJeqcIe,
	#instVars : [
		'sSizeI',
		'priIeJeIepsI',
		'ppriIeJeIepXIpsI',
		'ppriIeJeIepEIpsI',
		'ppriIeJeIepXJpsI',
		'ppriIeJeIepEJpsI',
		'ppriIeJeIepsIpsI',
		'pAjOIepsIT',
		'ppAjOIepEIpsI',
		'ppAjOIepsIpsI'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDDispCompIeqcsJeqcIe >> calcPostDynCorrectorIteration [
	"ppAjOIepEIpEI is not longer constant and must be set before any calculation."

	| ppriIeJeIepXIipsI  mpprIeJeOpsIpsI ppAjOIepsIipsI mpprIeJeOpsIipsI ppriIeJeIepsIipsI term1 mterm2 mterm3 mterm4 mpprIeJeOpEIpsI ppAjOIepEIipsI mpprIeJeOpEIipsI ppriIeJeIepEIipsI  mprIeJeOpEIT mprIeJeOpsIT prIeJeOpEJT ppriIeJeIepXJipsI ppriIeJeIepEJipsI |
	ppAjOIepEIpEI := frmI ppAjOepEpE: axis.
	super calcPostDynCorrectorIteration.
	pAjOIepsIT := frmI pAjOepsT: axis.
	ppAjOIepEIpsI := frmI ppAjOepEps: axis.
	ppAjOIepsIpsI := frmI ppAjOepsps: axis.
	mprIeJeOpEIT := frmI prOeOpE transpose.
	prIeJeOpEJT := frmJ prOeOpE transpose.
	mprIeJeOpsIT := frmI prOeOps transpose.
	mpprIeJeOpEIpsI := frmI pprOeOpEps.
	mpprIeJeOpsIpsI := frmI pprOeOpsps.
	1 to: sSizeI do: [:i | priIeJeIepsI at: i put: ((pAjOIepsIT at: i) dot: rIeJeO) - (aAjOIe dot: (mprIeJeOpsIT at: i))].
	1 to: 3 do: [:i | 
			ppriIeJeIepXIipsI := ppriIeJeIepXIpsI at: i.
			1 to: sSizeI do: [:j | ppriIeJeIepXIipsI at: j put: (pAjOIepsIT at: j and: i) negated]].
	1 to: 3 do: [:i | 
			ppriIeJeIepXJipsI := ppriIeJeIepXJpsI at: i.
			1 to: sSizeI do: [:j | ppriIeJeIepXJipsI at: j put: (pAjOIepsIT at: j and: i) ]].
	1 to: 4 do: [:i | 
			ppAjOIepEIipsI := ppAjOIepEIpsI at: i.
			mpprIeJeOpEIipsI := mpprIeJeOpEIpsI at: i.
			ppriIeJeIepEIipsI := ppriIeJeIepEIpsI at: i.
			1 to: sSizeI do: [:j | 
					term1 := (ppAjOIepEIipsI at: j) dot: rIeJeO.
					mterm2 := (pAjOIepEIT at: i) dot: (mprIeJeOpsIT at: j).
					mterm3 := (pAjOIepsIT at: j) dot: (mprIeJeOpEIT at: i).
					mterm4 := aAjOIe dot: (mpprIeJeOpEIipsI at: j).
					ppriIeJeIepEIipsI at: j put: term1 - mterm2 - mterm3 - mterm4]].
	1 to: 4 do: [:i | 
			ppriIeJeIepEJipsI := ppriIeJeIepEJpsI at: i.
			1 to: sSizeI do: [:j | ppriIeJeIepEJipsI at: j put: ((pAjOIepsIT at: j) dot: (prIeJeOpEJT at: i))]].
	1 to: sSizeI do: [:i | 
			ppAjOIepsIipsI := ppAjOIepsIpsI at: i.
			mpprIeJeOpsIipsI := mpprIeJeOpsIpsI at: i.
			ppriIeJeIepsIipsI := ppriIeJeIepsIpsI at: i.
			i to: sSizeI do: [:j | 
					term1 := (ppAjOIepsIipsI at: j) dot: rIeJeO.
					mterm2 := (pAjOIepsIT at: i) dot: (mprIeJeOpsIT at: j).
					mterm3 := i = j
								ifTrue: [mterm2]
								ifFalse: [(pAjOIepsIT at: j) dot: (mprIeJeOpsIT at: i)].
					mterm4 := aAjOIe dot: (mpprIeJeOpsIipsI at: j).
					ppriIeJeIepsIipsI at: j put: term1 - mterm2 - mterm3 - mterm4]].
	ppriIeJeIepsIpsI symLowerWithUpper
]

{ #category : #'initialize-release' }
MbDDispCompIeqcsJeqcIe >> initializeGlobally [
	"Do nothing."
]

{ #category : #'initialize-release' }
MbDDispCompIeqcsJeqcIe >> initializeLocally [
	super initializeLocally.
	sSizeI := frmI sSize.
	priIeJeIepsI := FullRow new: sSizeI.
	ppriIeJeIepXIpsI := FullMatrix new: 3 by: sSizeI.
	ppriIeJeIepEIpsI := FullMatrix new: 4 by: sSizeI.
	ppriIeJeIepXJpsI := FullMatrix new: 3 by: sSizeI.
	ppriIeJeIepEJpsI := FullMatrix new: 4 by: sSizeI.
	ppriIeJeIepsIpsI := FullMatrix new: sSizeI by: sSizeI
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcIe >> ppriIeJeIepEIpsI [
	^ppriIeJeIepEIpsI
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcIe >> ppriIeJeIepEJpsI [
	^ppriIeJeIepEJpsI
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcIe >> ppriIeJeIepXIpsI [
	^ppriIeJeIepXIpsI
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcIe >> ppriIeJeIepXJpsI [
	^ppriIeJeIepXJpsI
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcIe >> ppriIeJeIepsIpsI [
	^ppriIeJeIepsIpsI
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcIe >> ppvaluepEIpsI [
	^ppriIeJeIepEIpsI
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcIe >> ppvaluepEJpsI [
	^ppriIeJeIepEJpsI
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcIe >> ppvaluepXIpsI [
	^ppriIeJeIepXIpsI
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcIe >> ppvaluepXJpsI [
	^ppriIeJeIepXJpsI
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcIe >> ppvaluepsIpsI [
	^ppriIeJeIepsIpsI
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcIe >> priIeJeIepsI [
	^priIeJeIepsI
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcIe >> pvaluepsI [
	^priIeJeIepsI
]
