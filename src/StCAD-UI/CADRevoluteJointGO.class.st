Class {
	#name : #CADRevoluteJointGO,
	#superclass : #CADJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADRevoluteJointGO class >> geoClass [
	^GEORevoluteJoint
]

{ #category : #'VisualWorks metadata' }
CADRevoluteJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADRevoluteJointGO >> handleLabel [
	^self handleLabel: 'rev'
]

{ #category : #testing }
CADRevoluteJointGO >> isRevolute [
	^true
]

{ #category : #testing }
CADRevoluteJointGO >> isZRotational [
	^true
]
