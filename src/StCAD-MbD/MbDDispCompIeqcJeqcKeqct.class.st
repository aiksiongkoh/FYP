Class {
	#name : #MbDDispCompIeqcJeqcKeqct,
	#superclass : #MbDDispCompIeqcJeqcKeqc,
	#instVars : [
		'priIeJeKept',
		'ppriIeJeKepXIpt',
		'ppriIeJeKepEIpt',
		'ppriIeJeKepXJpt',
		'ppriIeJeKepEJpt',
		'ppriIeJeKepEKpt',
		'ppriIeJeKeptpt'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDDispCompIeqcJeqcKeqct class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDispCompIeqcJeqcKeqct class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFrameqc) & (afrmK isMemberOf: MbDEndFrameqct)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				frmK: afrmK
				axisK: integer]
		ifFalse: [nil]
]

{ #category : #calc }
MbDDispCompIeqcJeqcKeqct >> calcPostDynCorrectorIteration [
	"ppAjOIepEKpEK is not longer constant and must be set before any calculation."

	ppAjOKepEKpEK := efrmK ppAjOepEpE: axisK.
	super calcPostDynCorrectorIteration
]

{ #category : #'initialize-release' }
MbDDispCompIeqcJeqcKeqct >> initialize [
	super initialize.
	ppriIeJeKepXIpt := FullRow new: 3.
	ppriIeJeKepEIpt := FullRow new: 4.
	ppriIeJeKepXJpt := FullRow new: 3.
	ppriIeJeKepEJpt := FullRow new: 4.
	ppriIeJeKepEKpt := FullRow new: 4
]

{ #category : #'initialize-release' }
MbDDispCompIeqcJeqcKeqct >> initializeGlobally [
	"Do nothing."
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqct >> ppriIeJeKepEIpt [
	^ppriIeJeKepEIpt
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqct >> ppriIeJeKepEJpt [
	^ppriIeJeKepEJpt
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqct >> ppriIeJeKepXIpt [
	^ppriIeJeKepXIpt
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqct >> ppriIeJeKepXJpt [
	^ppriIeJeKepXJpt
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqct >> ppriIeJeKeptpt [
	^ppriIeJeKeptpt
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqct >> ppvaluepEIpt [
	^ppriIeJeKepEIpt
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqct >> ppvaluepEJpt [
	^ppriIeJeKepEJpt
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqct >> ppvaluepEKpt [
	^ppriIeJeKepEKpt
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqct >> ppvaluepXIpt [
	^ppriIeJeKepXIpt
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqct >> ppvaluepXJpt [
	^ppriIeJeKepXJpt
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqct >> ppvalueptpt [
	^ppriIeJeKeptpt
]

{ #category : #accIC }
MbDDispCompIeqcJeqcKeqct >> preAccIC [
	| pAjOKept ppAjOKepEKTpt ppAjOKeptpt prIeJeOpEIT prIeJeOpEJT |
	super preAccIC.
	pAjOKept := efrmK pAjOept: axisK.
	ppAjOKepEKTpt := efrmK ppAjOepETpt: axisK.
	ppAjOKeptpt := efrmK ppAjOeptpt: axisK.
	prIeJeOpEIT := frmI prOeOpE transpose negated.
	prIeJeOpEJT := frmJ prOeOpE transpose.
	1 to: 3 do: [:i | ppriIeJeKepXIpt at: i put: (pAjOKept at: i) negated].
	1 to: 3 do: [:i | ppriIeJeKepXJpt at: i put: (pAjOKept at: i)].
	1 to: 4 do: [:i | ppriIeJeKepEIpt at: i put: (pAjOKept dot: (prIeJeOpEIT at: i))].
	1 to: 4 do: [:i | ppriIeJeKepEJpt at: i put: (pAjOKept dot: (prIeJeOpEJT at: i))].
	1 to: 4 do: [:i | ppriIeJeKepEKpt at: i put: ((ppAjOKepEKTpt at: i) dot: rIeJeO)].
	ppriIeJeKeptpt := ppAjOKeptpt dot: rIeJeO
]

{ #category : #velIC }
MbDDispCompIeqcJeqcKeqct >> preVelIC [
	| pAjOKept |
	super preVelIC.
	pAjOKept := efrmK pAjOept: axisK.
	priIeJeKept := pAjOKept dot: rIeJeO
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqct >> priIeJeKept [
	^priIeJeKept
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqct >> pvaluept [
	^priIeJeKept
]
