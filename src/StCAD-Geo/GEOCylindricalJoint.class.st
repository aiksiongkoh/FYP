Class {
	#name : #GEOCylindricalJoint,
	#superclass : #GEOInLineJoint,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOCylindricalJoint class >> mbdClass [
	^MbDCylindricalJoint
]

{ #category : #accessing }
GEOCylindricalJoint class >> nameString [
	^'CylindricalJoint'
]

{ #category : #'VisualWorks metadata' }
GEOCylindricalJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
