Class {
	#name : #MbDDispCompIecJecO,
	#superclass : #MbDKinematicIeJe,
	#instVars : [
		'axis',
		'riIeJeO'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDDispCompIecJecO >> calcPostDynCorrectorIteration [
	riIeJeO := (frmJ riOeO: axis) - (frmI riOeO: axis)
]

{ #category : #accessing }
MbDDispCompIecJecO >> riIeJeO [
	^riIeJeO
]

{ #category : #accessing }
MbDDispCompIecJecO >> value [
	^riIeJeO
]

{ #category : #'initialize-release' }
MbDDispCompIecJecO >> withFrmI: afrmI frmJ: afrmJ axis: aaxis [ 
	frmI := afrmI.
	frmJ := afrmJ.
	axis := aaxis
]
