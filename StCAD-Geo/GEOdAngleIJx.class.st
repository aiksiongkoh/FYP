Class {
	#name : #GEOdAngleIJx,
	#superclass : #GEOAngleIJ,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOdAngleIJx class >> functionSymbol [
	^'dAngleIJx'
]

{ #category : #'VisualWorks metadata' }
GEOdAngleIJx class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOdAngleIJx >> dataSeries [
	^geoIJ dataSeriesForChart collect: [:kineIkineJ | kineIkineJ bryantIJ1]
]

{ #category : #DYN }
GEOdAngleIJx >> mbdClass [
	^MbDSmallAnglexIecJec
]
