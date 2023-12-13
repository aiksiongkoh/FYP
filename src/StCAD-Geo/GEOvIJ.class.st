Class {
	#name : #GEOvIJ,
	#superclass : #GEOFunctionIJ,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOvIJ class >> functionSymbol [
	^'vIJ'
]

{ #category : #'VisualWorks metadata' }
GEOvIJ class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOvIJ >> dataSeries [
	^geoIJ dataSeriesForChart collect: [:kineIkineJ | kineIkineJ vIJ]
]

{ #category : #accessing }
GEOvIJ >> dimension [
	^'velocity'
]

{ #category : #DYN }
GEOvIJ >> mbdClass [
	^MbDVelMagIecJec
]

{ #category : #DYN }
GEOvIJ >> mbdUnit [
	^self mbdUnits velocity
]
