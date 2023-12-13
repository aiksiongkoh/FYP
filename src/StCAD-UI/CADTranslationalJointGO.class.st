Class {
	#name : #CADTranslationalJointGO,
	#superclass : #CADJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADTranslationalJointGO class >> geoClass [
	^GEOTranslationalJoint
]

{ #category : #'VisualWorks metadata' }
CADTranslationalJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADTranslationalJointGO >> handleLabel [
	^self handleLabel: 'trn'
]

{ #category : #testing }
CADTranslationalJointGO >> isZTranslational [
	^true
]
