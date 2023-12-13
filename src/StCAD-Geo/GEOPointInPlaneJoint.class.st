Class {
	#name : #GEOPointInPlaneJoint,
	#superclass : #GEOInPlaneJoint,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOPointInPlaneJoint class >> mbdClass [
	^MbDPointInPlaneJoint
]

{ #category : #accessing }
GEOPointInPlaneJoint class >> nameString [
	^'PointInPlaneJoint'
]

{ #category : #'VisualWorks metadata' }
GEOPointInPlaneJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
