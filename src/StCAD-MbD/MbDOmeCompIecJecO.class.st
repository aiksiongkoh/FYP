Class {
	#name : #MbDOmeCompIecJecO,
	#superclass : #MbDKinematicDotIeJe,
	#instVars : [
		'axis',
		'omeIeJeOi'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDOmeCompIecJecO >> calcPostDynCorrectorIteration [
	omeIeJeOi := (frmJ omeOeO at: axis)
				- (frmI omeOeO at: axis)
]

{ #category : #accessing }
MbDOmeCompIecJecO >> value [
	^omeIeJeOi
]

{ #category : #'initialize-release' }
MbDOmeCompIecJecO >> withFrmI: afrmI frmJ: afrmJ axis: aaxis [ 
	frmI := afrmI.
	frmJ := afrmJ.
	axis := aaxis
]
