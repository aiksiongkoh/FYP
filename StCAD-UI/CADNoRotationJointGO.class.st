Class {
	#name : #CADNoRotationJointGO,
	#superclass : #CADJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADNoRotationJointGO class >> geoClass [
	^GEONoRotationJoint
]

{ #category : #'VisualWorks metadata' }
CADNoRotationJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADNoRotationJointGO >> handleLabel [
	^self handleLabel: 'nrt'
]
