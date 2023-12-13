Class {
	#name : #GEOvrIJ,
	#superclass : #GEOFunctionIJ,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOvrIJ class >> functionSymbol [
	^'vrIJ'
]

{ #category : #'VisualWorks metadata' }
GEOvrIJ class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOvrIJ >> dataSeries [
	^geoIJ dataSeriesForChart collect: [:kineIkineJ | kineIkineJ vIJRadial]
]

{ #category : #accessing }
GEOvrIJ >> dimension [
	^'velocity'
]

{ #category : #DYN }
GEOvrIJ >> mbdClass [
	^MbDVelRadIeqcJeqc
]

{ #category : #DYN }
GEOvrIJ >> mbdUnit [
	^self mbdUnits velocity
]
