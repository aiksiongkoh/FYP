Class {
	#name : #MbDVelMagIecJec,
	#superclass : #MbDKinematicDotIeJe,
	#instVars : [
		'vIeJe',
		'vIeJeO',
		'uvIeJeO'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDVelMagIecJec >> calcPostDynCorrectorIteration [
	vIeJeO := frmJ vOeO - frmI vOeO.
	vIeJe := vIeJeO length.
	uvIeJeO := vIeJe = 0
				ifTrue: [(FullColumn zero: 3)]
				ifFalse: [vIeJeO times: 1.0d / vIeJe]
]

{ #category : #accessing }
MbDVelMagIecJec >> value [
	^vIeJe
]
