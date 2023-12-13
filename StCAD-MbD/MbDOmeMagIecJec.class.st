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

{ #category : #'VisualWorks metadata' }
MbDOmeMagIecJec class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDOmeMagIecJec class >> withFrmI: afrmI frmJ: afrmJ [ 
	| instance |
	self allSubclasses
		do: 
			[:subclass | 
			instance := subclass withFrmI: afrmI frmJ: afrmJ.
			instance notNil ifTrue: [^instance]]
]

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
