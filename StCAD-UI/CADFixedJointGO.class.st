Class {
	#name : #CADFixedJointGO,
	#superclass : #CADJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADFixedJointGO class >> geoClass [
	^GEOFixedJoint
]

{ #category : #'VisualWorks metadata' }
CADFixedJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADFixedJointGO >> handleLabel [
	^self handleLabel: 'fix'
]
