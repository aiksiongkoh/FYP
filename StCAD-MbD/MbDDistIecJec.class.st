Class {
	#name : #MbDDistIecJec,
	#superclass : #MbDKinematicIeJe,
	#instVars : [
		'rIeJe',
		'rIeJeO',
		'uIeJeO',
		'muIeJeO'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDDistIecJec class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDistIecJec class >> withFrmI: afrmI frmJ: afrmJ [ 
	| instance |
	self allSubclasses
		do: 
			[:subclass | 
			instance := subclass withFrmI: afrmI frmJ: afrmJ.
			instance notNil ifTrue: [^instance]]
]

{ #category : #calc }
MbDDistIecJec >> calcPostDynCorrectorIteration [
	rIeJeO := frmJ rOeO - frmI rOeO.
	rIeJe := rIeJeO length.
	self calcPrivate
]

{ #category : #calc }
MbDDistIecJec >> calcPrivate [
	rIeJe = 0.0d ifTrue: [^self].
	uIeJeO := rIeJeO times: 1.0d / rIeJe.
	muIeJeO := uIeJeO negated
]

{ #category : #accessing }
MbDDistIecJec >> rIeJe [
	^rIeJe
]

{ #category : #accessing }
MbDDistIecJec >> rIeJeIe [
	^frmI aAOe transposeTimesFullColumn: rIeJeO
]

{ #category : #accessing }
MbDDistIecJec >> rIeJeO [
	^rIeJeO
]

{ #category : #accessing }
MbDDistIecJec >> uIeJeO [
	^uIeJeO
]

{ #category : #accessing }
MbDDistIecJec >> value [
	^rIeJe
]
