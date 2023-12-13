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

{ #category : #'VisualWorks metadata' }
MbDDispCompIecJecIe class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDispCompIecJecIe class >> withFrmI: afrmI frmJ: afrmJ axis: aaxis [ 
	| instance |
	self allSubclasses
		do: 
			[:subclass | 
			instance := subclass withFrmI: afrmI frmJ: afrmJ axis: aaxis.
			instance notNil ifTrue: [^instance]]
]

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
