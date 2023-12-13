Class {
	#name : #CADMarkerDirectionDialog,
	#superclass : #CADFrameDirectionDialog,
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #'VisualWorks metadata' }
CADMarkerDirectionDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADMarkerDirectionDialog >> dialogTitle [
	^'Position Marker in its GuideFrame                           CADSM'
]
