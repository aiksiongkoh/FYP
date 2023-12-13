Class {
	#name : #CADPointInLineJointGO,
	#superclass : #CADInLineJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADPointInLineJointGO class >> geoClass [
	^GEOPointInLineJoint
]

{ #category : #'VisualWorks metadata' }
CADPointInLineJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADPointInLineJointGO >> handleLabel [
	^self handleLabel: 'pil'
]
