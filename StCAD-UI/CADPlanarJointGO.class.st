Class {
	#name : #CADPlanarJointGO,
	#superclass : #CADInPlaneJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADPlanarJointGO class >> geoClass [
	^GEOPlanarJoint
]

{ #category : #'VisualWorks metadata' }
CADPlanarJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADPlanarJointGO >> handleLabel [
	^self handleLabel: 'pln'
]
