Class {
	#name : #MbDOmeCompIecJecKeqc,
	#superclass : #MbDOmeCompIecJecKec,
	#instVars : [
		'pomeiIeJeKepEK'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDOmeCompIecJecKeqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDOmeCompIecJecKeqc class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	^(afrmI isMemberOf: MbDEndFramec)
		& (afrmJ isMemberOf: MbDEndFramec)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				frmK: afrmK
				axisK: integer]
		ifFalse: [nil]
]

{ #category : #calc }
MbDOmeCompIecJecKeqc >> calcPostDynCorrectorIteration [
	| pAjOKepEK |
	aAjOKe := efrmK aAjOe: axisK.
	omeIeJeO := frmJ omeOeO - frmI omeOeO.
	omeiIeJeKe := aAjOKe dot: omeIeJeO.
	pAjOKepEK := efrmK pAjOepE: axisK.
	pomeiIeJeKepEK := pAjOKepEK dot: omeIeJeO
]

{ #category : #'initialize-release' }
MbDOmeCompIecJecKeqc >> initialize [
	pomeiIeJeKepEK := FullRow new: 4
]

{ #category : #accessing }
MbDOmeCompIecJecKeqc >> partFrameK [
	^efrmK partFrame
]

{ #category : #accessing }
MbDOmeCompIecJecKeqc >> pvaluepEK [
	^pomeiIeJeKepEK
]

{ #category : #accessing }
MbDOmeCompIecJecKeqc >> value [
	^omeiIeJeKe
]

{ #category : #'initialize-release' }
MbDOmeCompIecJecKeqc >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	frmI := afrmI.
	frmJ := afrmJ.
	efrmK := afrmK.
	axisK := integer
]
