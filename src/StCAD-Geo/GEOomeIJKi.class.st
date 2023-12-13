Class {
	#name : #GEOomeIJKi,
	#superclass : #GEOFunctionIJKi,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOomeIJKi class >> functionSymbol [
	^'omeIJKi'
]

{ #category : #'VisualWorks metadata' }
GEOomeIJKi class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOomeIJKi >> dataSeries [
	^geoIJ dataSeriesForChart collect: [:kineIkineJ | kineIkineJ perform: 'omeIJ' , markerK , axisK printString]
]

{ #category : #accessing }
GEOomeIJKi >> dimension [
	^'omega'
]

{ #category : #DYN }
GEOomeIJKi >> mbdClassKComp [
	^MbDOmeCompIecJecKec
]

{ #category : #DYN }
GEOomeIJKi >> mbdClassOComp [
	^MbDOmeCompIeqcJeqcO
]

{ #category : #DYN }
GEOomeIJKi >> mbdUnit [
	^self mbdUnits omega
]
