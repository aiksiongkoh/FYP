Class {
	#name : #CADUniversalJointGO,
	#superclass : #CADJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADUniversalJointGO class >> geoClass [
	^GEOUniversalJoint
]

{ #category : #'VisualWorks metadata' }
CADUniversalJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADUniversalJointGO >> handleLabel [
	^self handleLabel: 'uni'
]
