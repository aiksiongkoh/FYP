Class {
	#name : #GEOomeIJ,
	#superclass : #GEOFunctionIJ,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOomeIJ class >> functionSymbol [
	^'omeIJ'
]

{ #category : #'VisualWorks metadata' }
GEOomeIJ class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOomeIJ >> dataSeries [
	^geoIJ dataSeriesForChart collect: [:kineIkineJ | kineIkineJ omeIJ]
]

{ #category : #accessing }
GEOomeIJ >> dimension [
	^'omega'
]

{ #category : #DYN }
GEOomeIJ >> mbdClass [
	^MbDOmeMagIecJec
]

{ #category : #DYN }
GEOomeIJ >> mbdUnit [
	^self mbdUnits omega
]
