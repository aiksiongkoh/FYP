Class {
	#name : #MbDDispCompIeqctJeqcIe,
	#superclass : #MbDDispCompIeqcJeqcIe,
	#instVars : [
		'priIeJeIept',
		'ppriIeJeIepXIpt',
		'ppriIeJeIepEIpt',
		'ppriIeJeIepXJpt',
		'ppriIeJeIepEJpt',
		'ppriIeJeIeptpt'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDDispCompIeqctJeqcIe >> calcPostDynCorrectorIteration [
	"ppAjOIepEIpEI is not longer constant and must be set before any calculation."

	ppAjOIepEIpEI := frmI ppAjOepEpE: axis.
	super calcPostDynCorrectorIteration
]

{ #category : #'initialize-release' }
MbDDispCompIeqctJeqcIe >> initialize [
	super initialize.
	ppriIeJeIepXIpt := FullRow new: 3.
	ppriIeJeIepEIpt := FullRow new: 4.
	ppriIeJeIepXJpt := FullRow new: 3.
	ppriIeJeIepEJpt := FullRow new: 4
]

{ #category : #'initialize-release' }
MbDDispCompIeqctJeqcIe >> initializeGlobally [
	"Do nothing."
]

{ #category : #accessing }
MbDDispCompIeqctJeqcIe >> ppriIeJeIepEIpt [
	^ppriIeJeIepEIpt
]

{ #category : #accessing }
MbDDispCompIeqctJeqcIe >> ppriIeJeIepEJpt [
	^ppriIeJeIepEJpt
]

{ #category : #accessing }
MbDDispCompIeqctJeqcIe >> ppriIeJeIepXIpt [
	^ppriIeJeIepXIpt
]

{ #category : #accessing }
MbDDispCompIeqctJeqcIe >> ppriIeJeIepXJpt [
	^ppriIeJeIepXJpt
]

{ #category : #accessing }
MbDDispCompIeqctJeqcIe >> ppriIeJeIeptpt [
	^ppriIeJeIeptpt
]

{ #category : #accIC }
MbDDispCompIeqctJeqcIe >> preAccIC [
	| pAjOIept ppAjOIepEITpt ppAjOIeptpt mprIeJeOpEIT mprIeJeOpt mpprIeJeOpEITpt mpprIeJeOptpt ppAjOIepEITpti pAjOIepEITi mprIeJeOpEITi mpprIeJeOpEITpti ppriIeJeIepEIpti prIeJeOpEJT |
	super preAccIC.
	pAjOIept := frmI pAjOept: axis.
	ppAjOIepEITpt := frmI ppAjOepETpt: axis.
	ppAjOIeptpt := frmI ppAjOeptpt: axis.
	mprIeJeOpEIT := frmI prOeOpE transpose.
	prIeJeOpEJT := frmJ prOeOpE transpose.
	mprIeJeOpt := frmI prOeOpt.
	mpprIeJeOpEITpt := frmI pprOeOpEpt transpose.
	mpprIeJeOptpt := frmI pprOeOptpt.
	1 to: 3 do: [:i | ppriIeJeIepXIpt at: i put: (pAjOIept at: i) negated].
	1 to: 3 do: [:i | ppriIeJeIepXJpt at: i put: (pAjOIept at: i)].
	1 to: 4 do: [:i | 
			ppAjOIepEITpti := ppAjOIepEITpt at: i.
			pAjOIepEITi := pAjOIepEIT at: i.
			mprIeJeOpEITi := mprIeJeOpEIT at: i.
			mpprIeJeOpEITpti := mpprIeJeOpEITpt at: i.
			ppriIeJeIepEIpti := (ppAjOIepEITpti dot: rIeJeO)
						- (pAjOIepEITi dot: mprIeJeOpt) - (pAjOIept dot: mprIeJeOpEITi) - (aAjOIe dot: mpprIeJeOpEITpti).
			ppriIeJeIepEIpt at: i put: ppriIeJeIepEIpti].
	1 to: 4 do: [:i | ppriIeJeIepEJpt at: i put: (pAjOIept dot: (prIeJeOpEJT at: i))].
	ppriIeJeIeptpt := (ppAjOIeptpt dot: rIeJeO)
				- (pAjOIept dot: mprIeJeOpt) - (pAjOIept dot: mprIeJeOpt) - (aAjOIe dot: mpprIeJeOptpt)
]

{ #category : #velIC }
MbDDispCompIeqctJeqcIe >> preVelIC [
	| pAjOIept mprIeJeOpt |
	super preVelIC.
	pAjOIept := frmI pAjOept: axis.
	mprIeJeOpt := frmI prOeOpt.
	priIeJeIept := (pAjOIept dot: rIeJeO) - (aAjOIe dot: mprIeJeOpt)
]

{ #category : #accessing }
MbDDispCompIeqctJeqcIe >> priIeJeIept [
	^priIeJeIept
]
