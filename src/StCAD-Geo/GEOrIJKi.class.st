Class {
	#name : #GEOrIJKi,
	#superclass : #GEOFunctionIJKi,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOrIJKi >> dataSeries [
	^geoIJ dataSeriesForChart collect: [:kineIkineJ | kineIkineJ perform: 'rIJ' , markerK , axisK printString]
]

{ #category : #accessing }
GEOrIJKi >> dimension [
	^'length'
]

{ #category : #DYN }
GEOrIJKi >> mbdClassKComp [
	^MbDDispCompIecJecKec
]

{ #category : #DYN }
GEOrIJKi >> mbdClassOComp [
	^MbDDispCompIecJecO
]

{ #category : #DYN }
GEOrIJKi >> mbdUnit [
	^self mbdUnits length
]
