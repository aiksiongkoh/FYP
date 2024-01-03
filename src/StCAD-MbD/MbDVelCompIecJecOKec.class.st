Class {
	#name : #MbDVelCompIecJecOKec,
	#superclass : #MbDKinematicDotIeJe,
	#instVars : [
		'efrmK',
		'axisK',
		'viIeJeOKe',
		'aAjOKe',
		'vIeJeO'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDVelCompIecJecOKec >> calcPostDynCorrectorIteration [
	aAjOKe := efrmK aAjOe: axisK.
	vIeJeO := frmJ vOeO minusFullColumn: frmI vOeO.
	viIeJeOKe := aAjOKe dot: vIeJeO
]

{ #category : #accessing }
MbDVelCompIecJecOKec >> partFrameK [
	^efrmK partFrame
]

{ #category : #accessing }
MbDVelCompIecJecOKec >> value [
	^viIeJeOKe
]

{ #category : #'initialize-release' }
MbDVelCompIecJecOKec >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	frmI := afrmI.
	frmJ := afrmJ.
	efrmK := afrmK.
	axisK := integer
]
