Class {
	#name : #MbDOmeCompIeqcJecKeqc,
	#superclass : #MbDOmeCompIecJecKeqc,
	#instVars : [
		'pomeiIeJeKepEI',
		'pomeiIeJeKepEdotI'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDOmeCompIeqcJecKeqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDOmeCompIeqcJecKeqc class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFramec)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				frmK: afrmK
				axisK: integer]
		ifFalse: [nil]
]

{ #category : #calc }
MbDOmeCompIeqcJecKeqc >> calcPostDynCorrectorIteration [
	| mpomeIeJeOpEI mpomeIeJeOpEdotI mAjOKe |
	super calcPostDynCorrectorIteration.
	mpomeIeJeOpEI := frmI pomeOeOpE.
	mpomeIeJeOpEdotI := frmI pomeOeOpEdot.
	mAjOKe := aAjOKe negated.
	pomeiIeJeKepEI := mAjOKe dot: mpomeIeJeOpEI.
	pomeiIeJeKepEdotI := mAjOKe dot: mpomeIeJeOpEdotI
]

{ #category : #'initialize-release' }
MbDOmeCompIeqcJecKeqc >> initialize [
	super initialize.
	pomeiIeJeKepEI := FullRow new: 4.
	pomeiIeJeKepEdotI := FullRow new: 4
]

{ #category : #accessing }
MbDOmeCompIeqcJecKeqc >> pvaluepEI [
	^pomeiIeJeKepEI
]

{ #category : #accessing }
MbDOmeCompIeqcJecKeqc >> pvaluepEdotI [
	^pomeiIeJeKepEdotI
]
