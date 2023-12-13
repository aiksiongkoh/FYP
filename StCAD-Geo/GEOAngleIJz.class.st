Class {
	#name : #GEOAngleIJz,
	#superclass : #GEOAngleIJ,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOAngleIJz class >> functionSymbol [
	^'angleIJz'
]

{ #category : #'VisualWorks metadata' }
GEOAngleIJz class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOAngleIJz >> dataSeries [
	^geoIJ dataSeriesForChart collect: [:kineIkineJ | kineIkineJ bryantIJ3]
]

{ #category : #DYN }
GEOAngleIJz >> mbdClass [
	^MbDAnglezIecJec
]
