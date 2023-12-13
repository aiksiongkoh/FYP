Class {
	#name : #GEORevoluteJoint,
	#superclass : #GEOJoint,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEORevoluteJoint class >> mbdClass [
	^MbDRevoluteJoint
]

{ #category : #accessing }
GEORevoluteJoint class >> nameString [
	^'RevoluteJoint'
]

{ #category : #'VisualWorks metadata' }
GEORevoluteJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
