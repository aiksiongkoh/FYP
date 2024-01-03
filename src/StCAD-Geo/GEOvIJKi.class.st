Class {
	#name : #GEOvIJKi,
	#superclass : #GEOFunctionIJKi,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOvIJKi >> dataSeries [
	^geoIJ dataSeriesForChart collect: [:kineIkineJ | kineIkineJ perform: 'vIJ' , markerK , axisK printString]
]

{ #category : #accessing }
GEOvIJKi >> dimension [
	^'velocity'
]

{ #category : #DYN }
GEOvIJKi >> mbdClassKComp [
	^MbDVelCompIeqcJeqcKeqc
]

{ #category : #DYN }
GEOvIJKi >> mbdClassOComp [
	^MbDVelCompIeqcJeqcO
]

{ #category : #DYN }
GEOvIJKi >> mbdUnit [
	^self mbdUnits velocity
]
