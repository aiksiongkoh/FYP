Class {
	#name : #CADConstantVelocityJointGO,
	#superclass : #CADJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADConstantVelocityJointGO class >> geoClass [
	^GEOConstantVelocityJoint
]

{ #category : #'VisualWorks metadata' }
CADConstantVelocityJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADConstantVelocityJointGO >> handleLabel [
	^self handleLabel: 'cvl'
]
