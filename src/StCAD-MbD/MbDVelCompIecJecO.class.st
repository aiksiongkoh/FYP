Class {
	#name : #MbDVelCompIecJecO,
	#superclass : #MbDKinematicDotIeJe,
	#instVars : [
		'axis',
		'vIeJeOi'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDVelCompIecJecO >> calcPostDynCorrectorIteration [
	vIeJeOi := (frmJ vOeO at: axis)
				- (frmI vOeO at: axis)
]

{ #category : #accessing }
MbDVelCompIecJecO >> value [
	^vIeJeOi
]

{ #category : #'initialize-release' }
MbDVelCompIecJecO >> withFrmI: afrmI frmJ: afrmJ axis: aaxis [ 
	frmI := afrmI.
	frmJ := afrmJ.
	axis := aaxis
]
