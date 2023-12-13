Class {
	#name : #MbDVelCompIeqcJeqcKeqcs,
	#superclass : #MbDVelCompIeqcJeqcKeqc,
	#instVars : [
		'pvIeJeKeipsK'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDVelCompIeqcJeqcKeqcs class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDVelCompIeqcJeqcKeqcs class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFrameqc) & (afrmK isKindOf: MbDEndFrameqcs)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				frmK: afrmK
				axisK: integer]
		ifFalse: [nil]
]

{ #category : #calc }
MbDVelCompIeqcJeqcKeqcs >> calcPostDynCorrectorIteration [
	| pAdotOKejpsK pAOKejpsK |
	super calcPostDynCorrectorIteration.
	pAdotOKejpsK := efrmK pAdotjOeps: axisK.
	pAOKejpsK := efrmK pAjOeps: axisK.
	pvIeJeKeipsK := (pAdotOKejpsK dot: rIeJeO)
				+ (pAOKejpsK dot: vIeJeO)
]

{ #category : #accessing }
MbDVelCompIeqcJeqcKeqcs >> pvaluepsK [
	^pvIeJeKeipsK
]
