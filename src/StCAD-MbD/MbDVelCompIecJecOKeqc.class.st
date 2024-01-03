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
