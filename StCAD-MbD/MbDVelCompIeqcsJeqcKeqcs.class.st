Class {
	#name : #MbDVelCompIeqcsJeqcKeqcs,
	#superclass : #MbDVelCompIeqcJeqcKeqcs,
	#instVars : [
		'pvIeJeKeipsI'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDVelCompIeqcsJeqcKeqcs class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDVelCompIeqcsJeqcKeqcs class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	^(afrmI isKindOf: MbDEndFrameqcs)
		& (afrmJ isMemberOf: MbDEndFrameqc) & (afrmK isKindOf: MbDEndFrameqcs)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				frmK: afrmK
				axisK: integer]
		ifFalse: [nil]
]

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
