Class {
	#name : #MbDDispCompIeqctJeqcKeqct,
	#superclass : #MbDDispCompIeqcJeqcKeqct,
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #accIC }
MbDDispCompIeqctJeqcKeqct >> preAccIC [
	| pAjOKept mprIeJeOpt mpprIeJeOpEITpt mpprIeJeOptpt |
	super preAccIC.
	pAjOKept := efrmK pAjOept: axisK.
	mprIeJeOpt := frmI prOeOpt.
	mpprIeJeOpEITpt := frmI pprOeOpEpt transpose.
	mpprIeJeOptpt := frmI pprOeOptpt.
	1 to: 4 do: [:i | ppriIeJeKepEIpt at: i minusNumber: (aAjOKe dot: (mpprIeJeOpEITpt at: i))].
	1 to: 4 do: [:i | ppriIeJeKepEKpt at: i minusNumber: ((pAjOKepEKT at: i) dot: mprIeJeOpt)].
	ppriIeJeKeptpt := ppriIeJeKeptpt - (2.0d * (pAjOKept dot: mprIeJeOpt)) - (aAjOKe dot: mpprIeJeOptpt)
]

{ #category : #velIC }
MbDDispCompIeqctJeqcKeqct >> preVelIC [
	| mprIeJeOpt |
	super preVelIC.
	mprIeJeOpt := frmI prOeOpt.
	priIeJeKept := priIeJeKept - (aAjOKe dot: mprIeJeOpt)
]
