Class {
	#name : #CADPartDirectionDialog,
	#superclass : #CADFrameDirectionDialog,
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #'VisualWorks metadata' }
CADPartDirectionDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADPartDirectionDialog >> dialogTitle [
	^'Position Part in Assembly               CADSM'
]
