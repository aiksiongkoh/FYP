Class {
	#name : #GEOFixedJoint,
	#superclass : #GEOJoint,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOFixedJoint class >> mbdClass [
	^MbDFixedJoint
]

{ #category : #accessing }
GEOFixedJoint class >> nameString [
	^'FixedJoint'
]

{ #category : #'VisualWorks metadata' }
GEOFixedJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
