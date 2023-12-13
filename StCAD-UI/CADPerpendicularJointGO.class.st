Class {
	#name : #CADPerpendicularJointGO,
	#superclass : #CADJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADPerpendicularJointGO class >> geoClass [
	^GEOPerpendicularJoint
]

{ #category : #'VisualWorks metadata' }
CADPerpendicularJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADPerpendicularJointGO >> handleLabel [
	^self handleLabel: 'ppn'
]
