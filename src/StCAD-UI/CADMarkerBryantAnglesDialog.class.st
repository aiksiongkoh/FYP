Class {
	#name : #CADMarkerBryantAnglesDialog,
	#superclass : #CADFrameBryantAnglesDialog,
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #'VisualWorks metadata' }
CADMarkerBryantAnglesDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADMarkerBryantAnglesDialog >> dialogTitle [
	^'Position Marker in its GuideFrame                           CADSM'
]
