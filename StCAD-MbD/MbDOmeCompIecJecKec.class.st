Class {
	#name : #MbDOmeCompIecJecKec,
	#superclass : #MbDKinematicDotIeJe,
	#instVars : [
		'efrmK',
		'axisK',
		'omeiIeJeKe',
		'aAjOKe',
		'omeIeJeO'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDOmeCompIecJecKec class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDOmeCompIecJecKec class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
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
