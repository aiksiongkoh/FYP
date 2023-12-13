Class {
	#name : #MbDDispCompIeqcsJeqcO,
	#superclass : #MbDDispCompIeqcJeqcO,
	#instVars : [
		'priIeJeOpsI',
		'ppriIeJeOpEIpsI',
		'ppriIeJeOpsIpsI'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDDispCompIeqcsJeqcO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDispCompIeqcsJeqcO class >> withFrmI: afrmI frmJ: afrmJ axis: i [ 
	^(afrmI isMemberOf: MbDEndFrameqcs)
		& (afrmJ isMemberOf: MbDEndFrameqc)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				axis: i]
		ifFalse: [nil]
]

{ #category : #calc }
MbDDispCompIeqcsJeqcO >> calcPostDynCorrectorIteration [
	"ppriIeJeOpEIpEI is no longer a constant."

	super calcPostDynCorrectorIteration.
	priIeJeOpsI := (frmI priOeOps: axis) negated.
	ppriIeJeOpEIpEI := (frmI ppriOeOpEpE: axis) negated.
	ppriIeJeOpEIpsI := (frmI ppriOeOpEps: axis) negated.
	ppriIeJeOpsIpsI := (frmI ppriOeOpsps: axis) negated
]

{ #category : #'initialize-release' }
MbDDispCompIeqcsJeqcO >> initializeGlobally [
	ppriIeJeOpEJpEJ := frmJ ppriOeOpEpE: axis
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcO >> ppriIeJeOpEIpsI [
	^ppriIeJeOpEIpsI
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcO >> ppriIeJeOpsIpsI [
	^ppriIeJeOpsIpsI
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcO >> ppvaluepEIpsI [
	^ppriIeJeOpEIpsI
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcO >> ppvaluepsIpsI [
	^ppriIeJeOpsIpsI
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcO >> priIeJeOpsI [
	^priIeJeOpsI
]

{ #category : #accessing }
MbDDispCompIeqcsJeqcO >> pvaluepsI [
	^priIeJeOpsI
]
