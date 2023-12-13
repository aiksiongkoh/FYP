Class {
	#name : #CADSolidModelGO,
	#superclass : #CADGraphicObject,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #'VisualWorks metadata' }
CADSolidModelGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADSolidModelGO >> aCADPartGO [
	^container aCADPartGO
]

{ #category : #accessing }
CADSolidModelGO >> aColor [
	^container aColor
]

{ #category : #accessing }
CADSolidModelGO >> geoObject: geoSolidModel [ 
	| interface |
	super geoObject: geoSolidModel.
	interface := geoSolidModel interface.
	geoSolidModel faces asOrderedCollection do: [:face | interface createGOfor: face]
]

{ #category : #accessing }
CADSolidModelGO >> isSolidModel [
	^true
]
