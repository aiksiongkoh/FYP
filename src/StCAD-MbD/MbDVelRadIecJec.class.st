"
Radial velocity of Je wrt Ie.
"
Class {
	#name : #MbDVelRadIecJec,
	#superclass : #MbDKinematicDotIeJe,
	#instVars : [
		'rIeJe',
		'rIeJeO',
		'uIeJeO',
		'vIeJe',
		'vIeJeO'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDVelRadIecJec >> calcPostDynCorrectorIteration [
	rIeJeO := frmJ rOeO - frmI rOeO.
	rIeJe := rIeJeO length.
	rIeJe = 0.0d ifTrue: [^self].
	uIeJeO := rIeJeO times: 1.0d / rIeJe.
	vIeJeO := frmJ vOeO - frmI vOeO.
	vIeJe := vIeJeO dot: uIeJeO
]

{ #category : #accessing }
MbDVelRadIecJec >> value [
	^vIeJe
]
