Class {
	#name : #MbDDispCompIecJecIe,
	#superclass : #MbDKinematicIeJe,
	#instVars : [
		'axis',
		'riIeJeIe',
		'aAjOIe',
		'rIeJeO'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #accessing }
MbDDispCompIecJecIe >> axis [
	^axis
]

{ #category : #calc }
MbDDispCompIecJecIe >> calcPostDynCorrectorIteration [
	aAjOIe := frmI aAjOe: axis.
	rIeJeO := frmJ rOeO - frmI rOeO.
	riIeJeIe := aAjOIe dot: rIeJeO
]

{ #category : #accessing }
MbDDispCompIecJecIe >> riIeJeIe [
	^riIeJeIe
]

{ #category : #accessing }
MbDDispCompIecJecIe >> value [
	^riIeJeIe
]

{ #category : #'initialize-release' }
MbDDispCompIecJecIe >> withFrmI: afrmI frmJ: afrmJ axis: aaxis [ 
	frmI := afrmI.
	frmJ := afrmJ.
	axis := aaxis
]
