Class {
	#name : #CADSphericalJointGO,
	#superclass : #CADJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADSphericalJointGO class >> geoClass [
	^GEOSphericalJoint
]

{ #category : #'VisualWorks metadata' }
CADSphericalJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADSphericalJointGO >> handleLabel [
	^self handleLabel: 'sph'
]
