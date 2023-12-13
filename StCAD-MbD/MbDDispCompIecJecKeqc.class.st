Class {
	#name : #MbDDispCompIecJecKeqc,
	#superclass : #MbDDispCompIecJecKec,
	#instVars : [
		'priIeJeKepEK',
		'ppriIeJeKepEKpEK',
		'pAjOKepEKT',
		'ppAjOKepEKpEK'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDDispCompIecJecKeqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDispCompIecJecKeqc class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	^(afrmI isMemberOf: MbDEndFramec)
		& (afrmJ isMemberOf: MbDEndFramec) & (afrmK isMemberOf: MbDEndFrameqc)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				frmK: afrmK
				axisK: integer]
		ifFalse: [nil]
]

{ #category : #accessing }
MbDDispCompIecJecKeqc >> axisK [
	^axisK
]

{ #category : #calc }
MbDDispCompIecJecKeqc >> calcPostDynCorrectorIteration [
	| ppAjOKepEKipEK ppriIeJeKepEKipEK ppriIeJeKepEKipEKj |
	aAjOKe := efrmK aAjOe: axisK.
	rIeJeO := frmJ rOeO - frmI rOeO.
	riIeJeKe := aAjOKe dot: rIeJeO.
	pAjOKepEKT := efrmK pAjOepET: axisK.
	ppAjOKepEKpEK := efrmK ppAjOepEpE: axisK.
	1 to: 4 do: [:i | priIeJeKepEK at: i put: ((pAjOKepEKT at: i) dot: rIeJeO)].
	1 to: 4 do: [:i | 
			ppAjOKepEKipEK := ppAjOKepEKpEK at: i.
			ppriIeJeKepEKipEK := ppriIeJeKepEKpEK at: i.
			ppriIeJeKepEKipEK at: i put: ((ppAjOKepEKipEK at: i) dot: rIeJeO).
			i + 1 to: 4 do: [:j | 
					ppriIeJeKepEKipEKj := (ppAjOKepEKipEK at: i) dot: rIeJeO.
					ppriIeJeKepEKipEK at: j put: ppriIeJeKepEKipEKj.
					ppriIeJeKepEKpEK at: j and: i put: ppriIeJeKepEKipEKj]]
]

{ #category : #'initialize-release' }
MbDDispCompIecJecKeqc >> initialize [
	priIeJeKepEK := FullRow new: 4.
	ppriIeJeKepEKpEK := FullMatrix new: 4 by: 4
]

{ #category : #'initialize-release' }
MbDDispCompIecJecKeqc >> initializeGlobally [
	ppAjOKepEKpEK := efrmK ppAjOepEpE: axisK
]

{ #category : #accessing }
MbDDispCompIecJecKeqc >> ppriIeJeKepEKpEK [
	^ppriIeJeKepEKpEK
]

{ #category : #accessing }
MbDDispCompIecJecKeqc >> ppvaluepEKpEK [
	^ppriIeJeKepEKpEK
]

{ #category : #accessing }
MbDDispCompIecJecKeqc >> priIeJeKepEK [
	^priIeJeKepEK
]

{ #category : #accessing }
MbDDispCompIecJecKeqc >> pvaluepEK [
	^priIeJeKepEK
]

{ #category : #accessing }
MbDDispCompIecJecKeqc >> riIeJeKe [
	^riIeJeKe
]

{ #category : #'initialize-release' }
MbDDispCompIecJecKeqc >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	frmI := afrmI.
	frmJ := afrmJ.
	efrmK := afrmK.
	axisK := integer
]
