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
