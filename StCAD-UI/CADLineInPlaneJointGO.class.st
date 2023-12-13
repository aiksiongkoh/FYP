Class {
	#name : #CADLineInPlaneJointGO,
	#superclass : #CADInPlaneJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADLineInPlaneJointGO class >> geoClass [
	^GEOLineInPlaneJoint
]

{ #category : #'VisualWorks metadata' }
CADLineInPlaneJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADLineInPlaneJointGO >> handleLabel [
	^self handleLabel: 'lip'
]
