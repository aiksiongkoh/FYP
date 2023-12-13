Class {
	#name : #MbDDispCompIecJecO,
	#superclass : #MbDKinematicIeJe,
	#instVars : [
		'axis',
		'riIeJeO'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDDispCompIecJecO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDispCompIecJecO class >> withFrmI: afrmI frmJ: afrmJ axis: i [ 
	| instance |
	self allSubclasses
		do: 
			[:subclass | 
			instance := subclass
						withFrmI: afrmI
						frmJ: afrmJ
						axis: i.
			instance notNil ifTrue: [^instance]]
]

{ #category : #calc }
MbDDispCompIecJecO >> calcPostDynCorrectorIteration [
	riIeJeO := (frmJ riOeO: axis) - (frmI riOeO: axis)
]

{ #category : #accessing }
MbDDispCompIecJecO >> riIeJeO [
	^riIeJeO
]

{ #category : #accessing }
MbDDispCompIecJecO >> value [
	^riIeJeO
]

{ #category : #'initialize-release' }
MbDDispCompIecJecO >> withFrmI: afrmI frmJ: afrmJ axis: aaxis [ 
	frmI := afrmI.
	frmJ := afrmJ.
	axis := aaxis
]
