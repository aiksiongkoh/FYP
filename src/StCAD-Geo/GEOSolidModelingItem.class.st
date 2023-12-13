Class {
	#name : #GEOSolidModelingItem,
	#superclass : #GEOContainedItem,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'VisualWorks metadata' }
GEOSolidModelingItem class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOSolidModelingItem >> rDfD [
	^container rDfD
]
