Class {
	#name : #GEONoRotationJoint,
	#superclass : #GEOJoint,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEONoRotationJoint class >> mbdClass [
	^MbDNoRotationJoint
]

{ #category : #accessing }
GEONoRotationJoint class >> nameString [
	^'NoRotationJoint'
]

{ #category : #'VisualWorks metadata' }
GEONoRotationJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
