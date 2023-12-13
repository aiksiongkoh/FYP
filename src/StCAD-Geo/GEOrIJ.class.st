Class {
	#name : #GEOrIJ,
	#superclass : #GEOFunctionIJ,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOrIJ class >> functionSymbol [
	^'rIJ'
]

{ #category : #'VisualWorks metadata' }
GEOrIJ class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOrIJ >> dataSeries [
	^geoIJ dataSeriesForChart collect: [:kineIkineJ | kineIkineJ rIJ]
]

{ #category : #accessing }
GEOrIJ >> dimension [
	^'length'
]

{ #category : #DYN }
GEOrIJ >> mbdClass [
	^MbDDistIeqcJeqc
]

{ #category : #DYN }
GEOrIJ >> mbdUnit [
	^self mbdUnits length
]
