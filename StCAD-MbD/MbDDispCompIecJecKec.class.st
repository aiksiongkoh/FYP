Class {
	#name : #MbDDispCompIecJecKec,
	#superclass : #MbDKinematicIeJe,
	#instVars : [
		'efrmK',
		'axisK',
		'riIeJeKe',
		'aAjOKe',
		'rIeJeO'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDDispCompIecJecKec class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDispCompIecJecKec class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	| instance |
	self allSubclasses
		do: 
			[:subclass | 
			instance := subclass
						withFrmI: afrmI
						frmJ: afrmJ
						frmK: afrmK
						axisK: integer.
			instance notNil ifTrue: [^instance]]
]

{ #category : #accessing }
MbDDispCompIecJecKec >> partFrameK [
	^efrmK partFrame
]

{ #category : #accessing }
MbDDispCompIecJecKec >> value [
	^riIeJeKe
]
