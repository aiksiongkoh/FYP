Class {
	#name : #MbDDispCompIeqcJecKeqc,
	#superclass : #MbDDispCompIecJecKeqc,
	#instVars : [
		'priIeJeKepXI',
		'priIeJeKepEI',
		'ppriIeJeKepXIpEK',
		'ppriIeJeKepEIpEI',
		'ppriIeJeKepEIpEK'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDDispCompIeqcJecKeqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDispCompIeqcJecKeqc class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFramec) & (afrmK isMemberOf: MbDEndFrameqc)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				frmK: afrmK
				axisK: integer]
		ifFalse: [nil]
]

{ #category : #calc }
MbDDispCompIeqcJecKeqc >> calcPostDynCorrectorIteration [
	| mprIeJeOpEIT mpprIeJeOpEIpEI ppriIeJeKepXIipEK mpprIeJeOpEIipEI ppriIeJeKepEIipEI ppriIeJeKepEIipEIj mprIeJeOpEITi ppriIeJeKepEIipEK |
	super calcPostDynCorrectorIteration.
	mprIeJeOpEIT := frmI prOeOpE transpose.
	mpprIeJeOpEIpEI := frmI pprOeOpEpE.
	1 to: 3 do: [:i | priIeJeKepXI at: i put: 0.0d - (aAjOKe at: i)].
	1 to: 4 do: [:i | priIeJeKepEI at: i put: 0.0d - (aAjOKe dot: (mprIeJeOpEIT at: i))].
	1 to: 3 do: [:i | 
			ppriIeJeKepXIipEK := ppriIeJeKepXIpEK at: i.
			1 to: 4 do: [:j | ppriIeJeKepXIipEK at: j put: 0.0d - (pAjOKepEKT at: j and: i)]].
	1 to: 4 do: [:i | 
			mpprIeJeOpEIipEI := mpprIeJeOpEIpEI at: i.
			ppriIeJeKepEIipEI := ppriIeJeKepEIpEI at: i.
			ppriIeJeKepEIipEI at: i put: 0.0d - (aAjOKe dot: (mpprIeJeOpEIipEI at: i)).
			i + 1 to: 4 do: [:j | 
					ppriIeJeKepEIipEIj := 0.0d - (aAjOKe dot: (mpprIeJeOpEIipEI at: j)).
					ppriIeJeKepEIipEI at: j put: ppriIeJeKepEIipEIj.
					ppriIeJeKepEIpEI at: j and: i put: ppriIeJeKepEIipEIj]].
	1 to: 4 do: [:i | 
			mprIeJeOpEITi := mprIeJeOpEIT at: i.
			ppriIeJeKepEIipEK := ppriIeJeKepEIpEK at: i.
			1 to: 4 do: [:j | ppriIeJeKepEIipEK at: j put: 0.0d - ((pAjOKepEKT at: j) dot: mprIeJeOpEITi)]]
]

{ #category : #'initialize-release' }
MbDDispCompIeqcJecKeqc >> initialize [
	super initialize.
	priIeJeKepXI := FullRow new: 3.
	priIeJeKepEI := FullRow new: 4.
	ppriIeJeKepEIpEI := FullMatrix new: 4 by: 4.
	ppriIeJeKepXIpEK := FullMatrix new: 3 by: 4.
	ppriIeJeKepEIpEK := FullMatrix new: 4 by: 4
]

{ #category : #accessing }
MbDDispCompIeqcJecKeqc >> ppriIeJeKepEIpEI [
	^ppriIeJeKepEIpEI
]

{ #category : #accessing }
MbDDispCompIeqcJecKeqc >> ppriIeJeKepEIpEK [
	^ppriIeJeKepEIpEK
]

{ #category : #accessing }
MbDDispCompIeqcJecKeqc >> ppriIeJeKepXIpEK [
	^ppriIeJeKepXIpEK
]

{ #category : #accessing }
MbDDispCompIeqcJecKeqc >> ppvaluepEIpEI [
	^ppriIeJeKepEIpEI
]

{ #category : #accessing }
MbDDispCompIeqcJecKeqc >> ppvaluepEIpEK [
	^ppriIeJeKepEIpEK
]

{ #category : #accessing }
MbDDispCompIeqcJecKeqc >> ppvaluepXIpEK [
	^ppriIeJeKepXIpEK
]

{ #category : #accessing }
MbDDispCompIeqcJecKeqc >> priIeJeKepEI [
	^priIeJeKepEI
]

{ #category : #accessing }
MbDDispCompIeqcJecKeqc >> priIeJeKepXI [
	^priIeJeKepXI
]

{ #category : #accessing }
MbDDispCompIeqcJecKeqc >> pvaluepEI [
	^priIeJeKepEI
]

{ #category : #accessing }
MbDDispCompIeqcJecKeqc >> pvaluepXI [
	^priIeJeKepXI
]
