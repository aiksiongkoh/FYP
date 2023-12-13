Class {
	#name : #CADSketchGO,
	#superclass : #CADGraphicObject,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #'VisualWorks metadata' }
CADSketchGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADSketchGO >> dimension [
	^2
]

{ #category : #accessing }
CADSketchGO >> geoObject: geoSketch [ 
	| interface |
	super geoObject: geoSketch.
	interface := geoSketch interface.
	geoSketch graphics do: [:graphic | interface createGOfor: graphic].
	interface
		when: #noActiveSketch
		ask: self
		perform: #release
]
