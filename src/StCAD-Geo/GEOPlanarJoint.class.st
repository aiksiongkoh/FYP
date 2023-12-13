Class {
	#name : #GEOPlanarJoint,
	#superclass : #GEOInPlaneJoint,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOPlanarJoint class >> mbdClass [
	^MbDPlanarJoint
]

{ #category : #accessing }
GEOPlanarJoint class >> nameString [
	^'PlanarJoint'
]

{ #category : #'VisualWorks metadata' }
GEOPlanarJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
