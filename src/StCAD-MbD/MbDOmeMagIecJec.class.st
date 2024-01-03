Class {
	#name : #MbDOmeMagIecJec,
	#superclass : #MbDKinematicDotIeJe,
	#instVars : [
		'omeIeJe',
		'omeIeJeO',
		'uomeIeJeO'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDOmeMagIecJec >> calcPostDynCorrectorIteration [
	omeIeJeO := frmJ omeOeO - frmI omeOeO.
	omeIeJe := omeIeJeO length.
	uomeIeJeO := omeIeJe = 0
				ifTrue: [(FullColumn zero: 3)]
				ifFalse: [omeIeJeO times: 1.0d / omeIeJe]
]

{ #category : #accessing }
MbDOmeMagIecJec >> value [
	^omeIeJe
]
