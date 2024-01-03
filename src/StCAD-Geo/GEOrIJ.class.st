Class {
	#name : #GEOrIJ,
	#superclass : #GEOFunctionIJ,
	#category : #'StCAD-Geo-GEO'
}

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
