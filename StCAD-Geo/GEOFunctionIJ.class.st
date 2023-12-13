Class {
	#name : #GEOFunctionIJ,
	#superclass : #GEOFunction,
	#instVars : [
		'geoIJ'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOFunctionIJ class >> functionTemplate [
	^self functionSymbol , '(geoIJ)'
]

{ #category : #'VisualWorks metadata' }
GEOFunctionIJ class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #'instance creation' }
GEOFunctionIJ class >> with: geoIJ [ 
	^super new geoIJ: geoIJ
]

{ #category : #'StCAD-UI' }
GEOFunctionIJ >> cadStringOn: aStream [ 
	aStream nextPutAll: self class functionSymbol.
	aStream nextPut: $(.
	aStream nextPutAll: geoIJ name.
	aStream nextPut: $)
]

{ #category : #DYN }
GEOFunctionIJ >> createMbD [
	| eFrmI eFrmJ distIeJe |
	eFrmI := geoIJ aMarkerI mbdObject.
	eFrmJ := geoIJ aMarkerJ mbdObject.
	distIeJe := MbDSymbolicFunction new.
	distIeJe x: (self mbdClass withFrmI: eFrmI frmJ: eFrmJ).
	self x: distIeJe expression: (distIeJe times: self mbdUnit)
]

{ #category : #DYN }
GEOFunctionIJ >> createPOVRay [
	| times dataSeries geoTime spline |
	times := self timeSeries.
	dataSeries := self dataSeries.
	geoTime := self geoTime.
	spline := GeneralSpline
				with: geoTime
				order: 0
				xs: times
				ys: dataSeries.
	self x: spline expression: spline
]

{ #category : #accessing }
GEOFunctionIJ >> geoIJ: geoij [ 
	geoIJ := geoij
]

{ #category : #DYN }
GEOFunctionIJ >> mbdClass [
	self subclassResponsibility
]

{ #category : #DYN }
GEOFunctionIJ >> mbdUnit [
	self subclassResponsibility
]

{ #category : #accessing }
GEOFunctionIJ >> timeSeries [
	^geoIJ timeSeries
]
