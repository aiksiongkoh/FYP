Class {
	#name : #CADDXFBLOCKGO,
	#superclass : #CADGraphicObject,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #'VisualWorks metadata' }
CADDXFBLOCKGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADDXFBLOCKGO >> dimension [
	^3
]

{ #category : #accessing }
CADDXFBLOCKGO >> geoObject: geoSketch [ 
	| interface |
	super geoObject: geoSketch.
	interface := geoSketch interface.
	geoSketch graphics do: [:graphic | interface createGOfor: graphic]
]
