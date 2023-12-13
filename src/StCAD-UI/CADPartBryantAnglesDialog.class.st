Class {
	#name : #CADPartBryantAnglesDialog,
	#superclass : #CADFrameBryantAnglesDialog,
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #'VisualWorks metadata' }
CADPartBryantAnglesDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADPartBryantAnglesDialog >> dialogTitle [
	^'Position Part in Assembly                              CADSM'
]
