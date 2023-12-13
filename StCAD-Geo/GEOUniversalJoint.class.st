Class {
	#name : #GEOUniversalJoint,
	#superclass : #GEOJoint,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOUniversalJoint class >> mbdClass [
	^MbDUniversalJoint
]

{ #category : #accessing }
GEOUniversalJoint class >> nameString [
	^'UniversalJoint'
]

{ #category : #'VisualWorks metadata' }
GEOUniversalJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
