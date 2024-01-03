Class {
	#name : #GEOdAngleIJy,
	#superclass : #GEOAngleIJ,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOdAngleIJy >> dataSeries [
	^geoIJ dataSeriesForChart collect: [:kineIkineJ | kineIkineJ bryantIJ2]
]

{ #category : #DYN }
GEOdAngleIJy >> mbdClass [
	^MbDSmallAngleyIecJec
]
