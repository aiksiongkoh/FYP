Class {
	#name : #GEORefCurve,
	#superclass : #GEORefPoint,
	#instVars : [
		'rfCurvef'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'VisualWorks metadata' }
GEORefCurve class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEORefCurve >> addCurveMarkers: array [ 
	array do: [:marker | self addMarker: marker]
]

{ #category : #accessing }
GEORefCurve >> rfCurvef [
	^rfCurvef
]

{ #category : #accessing }
GEORefCurve >> rfCurvef: spline [ 
	rfCurvef := spline
]
