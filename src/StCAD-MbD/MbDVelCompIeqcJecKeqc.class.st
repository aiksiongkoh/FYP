Class {
	#name : #MbDVelCompIeqcJecKeqc,
	#superclass : #MbDVelCompIecJecKeqc,
	#instVars : [
		'pvIeJeKeipXI',
		'pvIeJeKeipEI',
		'pvIeJeKeipXdotI',
		'pvIeJeKeipEdotI'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDVelCompIeqcJecKeqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDVelCompIeqcJecKeqc class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFramec) & (afrmK isMemberOf: MbDEndFrameqc)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				frmK: afrmK
				axisK: integer]
		ifFalse: [nil]
]

{ #category : #calc }
MbDVelCompIeqcJecKeqc >> calcPostDynCorrectorIteration [
	| mAdotOKej mAOKej mprIeJeOpEI mpvIeJeOpEI mpvIeJeOpEdotI |
	super calcPostDynCorrectorIteration.
	mAdotOKej := aAdotOKej negated.
	mAOKej := aAOKej negated.
	mprIeJeOpEI := frmI prOeOpE.
	mpvIeJeOpEI := frmI pvOeOpE.
	mpvIeJeOpEdotI := frmI pvOeOpEdot.
	pvIeJeKeipXI := mAdotOKej transpose.
	pvIeJeKeipEI := (mAdotOKej dot: mprIeJeOpEI)
				+ (mAOKej dot: mpvIeJeOpEI).
	pvIeJeKeipXdotI := mAOKej transpose.
	pvIeJeKeipEdotI := mAOKej dot: mpvIeJeOpEdotI
]

{ #category : #'initialize-release' }
MbDVelCompIeqcJecKeqc >> initialize [
	super initialize.
	pvIeJeKeipXI := FullRow new: 3.
	pvIeJeKeipEI := FullRow new: 4.
	pvIeJeKeipXdotI := FullRow new: 3.
	pvIeJeKeipEdotI := FullRow new: 4
]

{ #category : #accessing }
MbDVelCompIeqcJecKeqc >> pvaluepEI [
	^pvIeJeKeipEI
]

{ #category : #accessing }
MbDVelCompIeqcJecKeqc >> pvaluepEdotI [
	^pvIeJeKeipEdotI
]

{ #category : #accessing }
MbDVelCompIeqcJecKeqc >> pvaluepXI [
	^pvIeJeKeipXI
]

{ #category : #accessing }
MbDVelCompIeqcJecKeqc >> pvaluepXdotI [
	^pvIeJeKeipXdotI
]
