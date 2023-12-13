Class {
	#name : #CADCircleGO,
	#superclass : #CADEllipseGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #'instance creation' }
CADCircleGO class >> creationTool [
	^CADCreationTool
		icon: (GFTool stockIconFor: 'Ellipse')
		cursor: self gfCursorClass crossHair
		class: self
		name: 'Circle'
]

{ #category : #'instance creation' }
CADCircleGO class >> geoClass [
	^GEOCircle
]

{ #category : #'VisualWorks metadata' }
CADCircleGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]
