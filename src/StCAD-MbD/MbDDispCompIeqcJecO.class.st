Class {
	#name : #MbDDispCompIeqcJecO,
	#superclass : #MbDDispCompIecJecO,
	#instVars : [
		'priIeJeOpXI',
		'priIeJeOpEI',
		'ppriIeJeOpEIpEI'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDDispCompIeqcJecO >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	priIeJeOpEI := (frmI priOeOpE: axis) negated
]

{ #category : #'initialize-release' }
MbDDispCompIeqcJecO >> initializeGlobally [
	super initializeGlobally.
	priIeJeOpXI := (FullRow zero: 3).
	priIeJeOpXI at: axis put: -1.0d.
	ppriIeJeOpEIpEI := (frmI ppriOeOpEpE: axis) negated
]

{ #category : #accessing }
MbDDispCompIeqcJecO >> ppriIeJeOpEIpEI [
	^ppriIeJeOpEIpEI
]

{ #category : #accessing }
MbDDispCompIeqcJecO >> ppvaluepEIpEI [
	^ppriIeJeOpEIpEI
]

{ #category : #accessing }
MbDDispCompIeqcJecO >> priIeJeOpEI [
	^priIeJeOpEI
]

{ #category : #accessing }
MbDDispCompIeqcJecO >> pvaluepEI [
	^priIeJeOpEI
]

{ #category : #accessing }
MbDDispCompIeqcJecO >> pvaluepXI [
	^priIeJeOpXI
]
