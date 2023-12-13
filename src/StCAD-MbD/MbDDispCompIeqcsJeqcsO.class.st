Class {
	#name : #MbDDispCompIeqcsJeqcsO,
	#superclass : #MbDDispCompIeqcsJeqcO,
	#instVars : [
		'priIeJeOpsJ',
		'ppriIeJeOpEJpsJ',
		'ppriIeJeOpsJpsJ'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDDispCompIeqcsJeqcsO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDispCompIeqcsJeqcsO class >> withFrmI: afrmI frmJ: afrmJ axis: i [ 
	^(afrmI isMemberOf: MbDEndFrameqcs)
		& (afrmJ isMemberOf: MbDEndFrameqcs)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				axis: i]
		ifFalse: [nil]
]

{ #category : #calc }
MbDDispCompIeqcsJeqcsO >> calcPostDynCorrectorIteration [
	"ppriIeJeOpEJpEJ is no longer a constant."

	super calcPostDynCorrectorIteration.
	priIeJeOpsJ := frmJ priOeOps: axis.
	ppriIeJeOpEJpEJ := frmJ ppriOeOpEpE: axis.
	ppriIeJeOpEJpsJ := frmJ ppriOeOpEps: axis.
	ppriIeJeOpsJpsJ := frmJ ppriOeOpsps: axis
]

{ #category : #'initialize-release' }
MbDDispCompIeqcsJeqcsO >> initializeGlobally [
	"Do nothing."
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcsO >> ppriIeJeOpEJpsJ [
	^ppriIeJeOpEJpsJ
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcsO >> ppriIeJeOpsJpsJ [
	^ppriIeJeOpsJpsJ
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcsO >> ppvaluepEJpsJ [
	^ppriIeJeOpEJpsJ
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcsO >> ppvaluepsJpsJ [
	^ppriIeJeOpsJpsJ
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcsO >> priIeJeOpsJ [
	^priIeJeOpsJ
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcsO >> pvaluepsJ [
	^priIeJeOpsJ
]
