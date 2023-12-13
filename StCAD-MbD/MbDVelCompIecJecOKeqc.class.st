"
VelIeJeOKe has no omega cross effect. Ke is instantaneously fixed in space.
"
Class {
	#name : #MbDVelCompIecJecOKeqc,
	#superclass : #MbDVelCompIecJecOKec,
	#instVars : [
		'pviIeJeOKepEK'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDVelCompIecJecOKeqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDVelCompIecJecOKeqc class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	^(afrmI isMemberOf: MbDEndFramec)
		& (afrmJ isMemberOf: MbDEndFramec) & (afrmK isMemberOf: MbDEndFrameqc)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				frmK: afrmK
				axisK: integer]
		ifFalse: [nil]
]

{ #category : #calc }
MbDVelCompIecJecOKeqc >> calcPostDynCorrectorIteration [
	| pAjOKepEK |
	super calcPostDynCorrectorIteration.
	pAjOKepEK := efrmK pAjOepE: axisK.
	pviIeJeOKepEK := pAjOKepEK dot: vIeJeO
]

{ #category : #'initialize-release' }
MbDVelCompIecJecOKeqc >> initialize [
	pviIeJeOKepEK := FullRow new: 4
]

{ #category : #accessing }
MbDVelCompIecJecOKeqc >> pvaluepEK [
	^pviIeJeOKepEK
]
