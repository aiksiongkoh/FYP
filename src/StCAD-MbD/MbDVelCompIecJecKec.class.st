Class {
	#name : #MbDVelCompIecJecKec,
	#superclass : #MbDKinematicDotIeJe,
	#instVars : [
		'efrmK',
		'axisK',
		'vIeJeKei',
		'aAdotOKej',
		'rIeJeO',
		'aAOKej',
		'vIeJeO'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDVelCompIecJecKec >> calcPostDynCorrectorIteration [
	aAdotOKej := efrmK aAdotjOe: axisK.
	aAOKej := efrmK aAjOe: axisK.
	rIeJeO := frmJ rOeO minusFullColumn: frmI rOeO.
	vIeJeO := frmJ vOeO minusFullColumn: frmI vOeO.
	vIeJeKei := (aAdotOKej dot: rIeJeO)
				+ (aAOKej dot: vIeJeO)
]

{ #category : #accessing }
MbDVelCompIecJecKec >> partFrameK [
	^efrmK partFrame
]

{ #category : #accessing }
MbDVelCompIecJecKec >> value [
	^vIeJeKei
]

{ #category : #'initialize-release' }
MbDVelCompIecJecKec >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	frmI := afrmI.
	frmJ := afrmJ.
	efrmK := afrmK.
	axisK := integer
]
