Class {
	#name : #MbDVelCompIeqcJeqcKeqc,
	#superclass : #MbDVelCompIeqcJecKeqc,
	#instVars : [
		'pvIeJeKeipXJ',
		'pvIeJeKeipEJ',
		'pvIeJeKeipXdotJ',
		'pvIeJeKeipEdotJ'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDVelCompIeqcJeqcKeqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDVelCompIeqcJeqcKeqc class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFrameqc) & (afrmK isMemberOf: MbDEndFrameqc)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				frmK: afrmK
				axisK: integer]
		ifFalse: [nil]
]

{ #category : #calc }
MbDVelCompIeqcJeqcKeqc >> calcPostDynCorrectorIteration [
	| prIeJeOpEJ pvIeJeOpEJ pvIeJeOpEdotJ |
	super calcPostDynCorrectorIteration.
	prIeJeOpEJ := frmJ prOeOpE.
	pvIeJeOpEJ := frmJ pvOeOpE.
	pvIeJeOpEdotJ := frmJ pvOeOpEdot.
	pvIeJeKeipXJ := aAdotOKej transpose.
	pvIeJeKeipEJ := (aAdotOKej dot: prIeJeOpEJ)
				+ (aAOKej dot: pvIeJeOpEJ).
	pvIeJeKeipXdotJ := aAOKej transpose.
	pvIeJeKeipEdotJ := aAOKej dot: pvIeJeOpEdotJ
]

{ #category : #'initialize-release' }
MbDVelCompIeqcJeqcKeqc >> initialize [
	super initialize.
	pvIeJeKeipXJ := FullRow new: 3.
	pvIeJeKeipEJ := FullRow new: 4.
	pvIeJeKeipXdotJ := FullRow new: 3.
	pvIeJeKeipEdotJ := FullRow new: 4
]

{ #category : #accessing }
MbDVelCompIeqcJeqcKeqc >> pvaluepEJ [
	^pvIeJeKeipEJ
]

{ #category : #accessing }
MbDVelCompIeqcJeqcKeqc >> pvaluepEdotJ [
	^pvIeJeKeipEdotJ
]

{ #category : #accessing }
MbDVelCompIeqcJeqcKeqc >> pvaluepXJ [
	^pvIeJeKeipXJ
]

{ #category : #accessing }
MbDVelCompIeqcJeqcKeqc >> pvaluepXdotJ [
	^pvIeJeKeipXdotJ
]
