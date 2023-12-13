Class {
	#name : #GEOForceIJ,
	#superclass : #GEOFunctionIJ,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'VisualWorks metadata' }
GEOForceIJ class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOForceIJ >> dimension [
	^'force'
]

{ #category : #DYN }
GEOForceIJ >> mbdUnit [
	^self mbdUnits force
]
