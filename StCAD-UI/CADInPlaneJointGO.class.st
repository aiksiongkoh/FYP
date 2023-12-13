Class {
	#name : #CADInPlaneJointGO,
	#superclass : #CADJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #'VisualWorks metadata' }
CADInPlaneJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADInPlaneJointGO >> promptForFunction [
	| geoObject |
	geoObject := self metaObject.
	CADOffsetDialog openOn: geoObject
]
