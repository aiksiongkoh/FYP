Class {
	#name : #CADCylindricalJointGO,
	#superclass : #CADInLineJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADCylindricalJointGO class >> geoClass [
	^GEOCylindricalJoint
]

{ #category : #'VisualWorks metadata' }
CADCylindricalJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADCylindricalJointGO >> handleLabel [
	^self handleLabel: 'cyl'
]

{ #category : #testing }
CADCylindricalJointGO >> isZRotational [
	^true
]

{ #category : #testing }
CADCylindricalJointGO >> isZTranslational [
	^true
]
