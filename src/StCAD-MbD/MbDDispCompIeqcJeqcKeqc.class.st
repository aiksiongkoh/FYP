Class {
	#name : #MbDDispCompIeqcJeqcKeqc,
	#superclass : #MbDDispCompIeqcJecKeqc,
	#instVars : [
		'priIeJeKepXJ',
		'priIeJeKepEJ',
		'ppriIeJeKepXJpEK',
		'ppriIeJeKepEJpEJ',
		'ppriIeJeKepEJpEK'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDDispCompIeqcJeqcKeqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDispCompIeqcJeqcKeqc class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFrameqc) & (afrmK isMemberOf: MbDEndFrameqc)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				frmK: afrmK
				axisK: integer]
		ifFalse: [nil]
]

{ #category : #calc }
MbDDispCompIeqcJeqcKeqc >> calcPostDynCorrectorIteration [
	| prIeJeOpEJT pprIeJeOpEJpEJ ppriIeJeKepXJipEK pprIeJeOpEJipEJ ppriIeJeKepEJipEJ ppriIeJeKepEJipEJj prIeJeOpEJTi ppriIeJeKepEJipEK |
	super calcPostDynCorrectorIteration.
	prIeJeOpEJT := frmJ prOeOpE transpose.
	pprIeJeOpEJpEJ := frmJ pprOeOpEpE.
	1 to: 3 do: [:i | priIeJeKepXJ at: i put: (aAjOKe at: i)].
	1 to: 4 do: [:i | priIeJeKepEJ at: i put: (aAjOKe dot: (prIeJeOpEJT at: i))].
	1 to: 3 do: [:i | 
			ppriIeJeKepXJipEK := ppriIeJeKepXJpEK at: i.
			1 to: 4 do: [:j | ppriIeJeKepXJipEK at: j put: (pAjOKepEKT at: j and: i)]].
	1 to: 4 do: [:i | 
			pprIeJeOpEJipEJ := pprIeJeOpEJpEJ at: i.
			ppriIeJeKepEJipEJ := ppriIeJeKepEJpEJ at: i.
			ppriIeJeKepEJipEJ at: i put: (aAjOKe dot: (pprIeJeOpEJipEJ at: i)).
			i + 1 to: 4 do: [:j | 
					ppriIeJeKepEJipEJj := (aAjOKe dot: (pprIeJeOpEJipEJ at: j)).
					ppriIeJeKepEJipEJ at: j put: ppriIeJeKepEJipEJj.
					ppriIeJeKepEJpEJ at: j and: i put: ppriIeJeKepEJipEJj]].
	1 to: 4 do: [:i | 
			prIeJeOpEJTi := prIeJeOpEJT at: i.
			ppriIeJeKepEJipEK := ppriIeJeKepEJpEK at: i.
			1 to: 4 do: [:j | ppriIeJeKepEJipEK at: j put: ((pAjOKepEKT at: j) dot: prIeJeOpEJTi)]]
]

{ #category : #'initialize-release' }
MbDDispCompIeqcJeqcKeqc >> initialize [
	super initialize.
	priIeJeKepXJ := FullRow new: 3.
	priIeJeKepEJ := FullRow new: 4.
	ppriIeJeKepEJpEJ := FullMatrix new: 4 by: 4.
	ppriIeJeKepXJpEK := FullMatrix new: 3 by: 4.
	ppriIeJeKepEJpEK := FullMatrix new: 4 by: 4
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqc >> ppriIeJeKepEJpEJ [
	^ppriIeJeKepEJpEJ
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqc >> ppriIeJeKepEJpEK [
	^ppriIeJeKepEJpEK
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqc >> ppriIeJeKepXJpEK [
	^ppriIeJeKepXJpEK
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqc >> ppvaluepEJpEJ [
	^ppriIeJeKepEJpEJ
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqc >> ppvaluepEJpEK [
	^ppriIeJeKepEJpEK
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqc >> ppvaluepXJpEK [
	^ppriIeJeKepXJpEK
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqc >> priIeJeKepEJ [
	^priIeJeKepEJ
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqc >> priIeJeKepXJ [
	^priIeJeKepXJ
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqc >> pvaluepEJ [
	^priIeJeKepEJ
]

{ #category : #accessing }
MbDDispCompIeqcJeqcKeqc >> pvaluepXJ [
	^priIeJeKepXJ
]
