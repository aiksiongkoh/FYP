Class {
	#name : #GEOvIJ,
	#superclass : #GEOFunctionIJ,
	#category : #'StCAD-Geo-GEO'
}

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
