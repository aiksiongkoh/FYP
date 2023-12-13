Class {
	#name : #MbDVelCompIeqcsJeqcsKeqcs,
	#superclass : #MbDVelCompIeqcsJeqcKeqcs,
	#instVars : [
		'pvIeJeKeipsJ'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDVelCompIeqcsJeqcsKeqcs class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDVelCompIeqcsJeqcsKeqcs class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	^(afrmI isKindOf: MbDEndFrameqcs)
		& (afrmJ isKindOf: MbDEndFrameqcs) & (afrmK isKindOf: MbDEndFrameqcs)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				frmK: afrmK
				axisK: integer]
		ifFalse: [nil]
]

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
