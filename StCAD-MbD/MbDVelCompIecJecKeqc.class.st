Class {
	#name : #MbDVelCompIecJecKeqc,
	#superclass : #MbDVelCompIecJecKec,
	#instVars : [
		'pvIeJeKeipEK'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDVelCompIecJecKeqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDVelCompIecJecKeqc class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
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
MbDVelCompIecJecKeqc >> calcPostDynCorrectorIteration [
	| pAdotOKejpEK pAOKejpEK |
	super calcPostDynCorrectorIteration.
	pAdotOKejpEK := efrmK pAdotjOepE: axisK.
	pAOKejpEK := efrmK pAjOepE: axisK.
	pvIeJeKeipEK := (pAdotOKejpEK dot: rIeJeO)
				+ (pAOKejpEK dot: vIeJeO)
]

{ #category : #'initialize-release' }
MbDVelCompIecJecKeqc >> initialize [
	pvIeJeKeipEK := FullRow new: 4
]

{ #category : #accessing }
MbDVelCompIecJecKeqc >> pvaluepEK [
	^pvIeJeKeipEK
]
