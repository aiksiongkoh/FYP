Class {
	#name : #MbDVelCompIeqcsJeqcKeqcs,
	#superclass : #MbDVelCompIeqcJeqcKeqcs,
	#instVars : [
		'pvIeJeKeipsI'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDVelCompIeqcsJeqcKeqcs >> calcPostDynCorrectorIteration [
	| mAdotOKej mAOKej mprIeJeOpsI mpvIeJeOpsI |
	super calcPostDynCorrectorIteration.
	mAdotOKej := aAdotOKej negated.
	mAOKej := aAOKej negated.
	mprIeJeOpsI := frmI prOeOps.
	mpvIeJeOpsI := frmI pvOeOps.
	pvIeJeKeipsI := (mAdotOKej dot: mprIeJeOpsI)
				+ (mAOKej dot: mpvIeJeOpsI)
]

{ #category : #accessing }
MbDVelCompIeqcsJeqcKeqcs >> pvaluepsI [
	^pvIeJeKeipsI
]
