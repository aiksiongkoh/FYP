Class {
	#name : #MbDVelCompIeqcsJeqcsKeqcs,
	#superclass : #MbDVelCompIeqcsJeqcKeqcs,
	#instVars : [
		'pvIeJeKeipsJ'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDVelCompIeqcsJeqcsKeqcs >> calcPostDynCorrectorIteration [
	| prIeJeOpsJ pvIeJeOpsJ |
	super calcPostDynCorrectorIteration.
	prIeJeOpsJ := frmJ prOeOps.
	pvIeJeOpsJ := frmJ pvOeOps.
	pvIeJeKeipsJ := (aAdotOKej dot: prIeJeOpsJ)
				+ (aAOKej dot: pvIeJeOpsJ)
]

{ #category : #accessing }
MbDVelCompIeqcsJeqcsKeqcs >> pvaluepsJ [
	^pvIeJeKeipsJ
]
