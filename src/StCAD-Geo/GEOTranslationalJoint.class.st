Class {
	#name : #GEOTranslationalJoint,
	#superclass : #GEOJoint,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOTranslationalJoint class >> mbdClass [
	^MbDTranslationalJoint
]

{ #category : #accessing }
GEOTranslationalJoint class >> nameString [
	^'TranslationalJoint'
]

{ #category : #'VisualWorks metadata' }
GEOTranslationalJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
