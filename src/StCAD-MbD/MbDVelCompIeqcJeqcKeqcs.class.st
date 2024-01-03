Class {
	#name : #MbDVelCompIeqcJeqcKeqcs,
	#superclass : #MbDVelCompIeqcJeqcKeqc,
	#instVars : [
		'pvIeJeKeipsK'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

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
