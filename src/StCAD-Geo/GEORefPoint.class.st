Class {
	#name : #GEORefPoint,
	#superclass : #GEOAnyGraphic,
	#instVars : [
		'markers'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'VisualWorks metadata' }
GEORefPoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEORefPoint >> addMarker: geoMarker [ 
	geoMarker refFrame refFrame: refFrame.
	markers add: geoMarker
]

{ #category : #accessing }
GEORefPoint >> addMarkers: array [ 
	array do: [:marker | self addMarker: marker]
]

{ #category : #'initialize-release' }
GEORefPoint >> initialize [

	super initialize.
	markers := StCAD_Misc_OrderedSet new "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
]

{ #category : #accessing }
GEORefPoint >> markers [
	^markers
]
