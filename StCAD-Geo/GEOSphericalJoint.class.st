Class {
	#name : #GEOSphericalJoint,
	#superclass : #GEOJoint,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOSphericalJoint class >> mbdClass [
	^MbDSphericalJoint
]

{ #category : #accessing }
GEOSphericalJoint class >> nameString [
	^'SphericalJoint'
]

{ #category : #'VisualWorks metadata' }
GEOSphericalJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
