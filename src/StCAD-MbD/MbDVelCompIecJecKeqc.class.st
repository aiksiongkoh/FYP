Class {
	#name : #MbDVelCompIecJecKeqc,
	#superclass : #MbDVelCompIecJecKec,
	#instVars : [
		'pvIeJeKeipEK'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

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
