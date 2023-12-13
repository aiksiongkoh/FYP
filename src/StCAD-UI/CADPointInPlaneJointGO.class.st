Class {
	#name : #CADPointInPlaneJointGO,
	#superclass : #CADInPlaneJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADPointInPlaneJointGO class >> geoClass [
	^GEOPointInPlaneJoint
]

{ #category : #'VisualWorks metadata' }
CADPointInPlaneJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADPointInPlaneJointGO >> handleLabel [
	^self handleLabel: 'pip'
]
