Class {
	#name : #GEOAllowZRotation,
	#superclass : #GEOMotion,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOAllowZRotation class >> mbdClass [
	^MbDAllowZRotation
]

{ #category : #accessing }
GEOAllowZRotation class >> nameString [
	^'AllowRotation'
]

{ #category : #'VisualWorks metadata' }
GEOAllowZRotation class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
