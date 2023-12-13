Class {
	#name : #RefCurve,
	#superclass : #RefGeo,
	#instVars : [
		'rfEqnf'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
RefCurve class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
RefCurve >> addCurveMarkers: array [ 
	array do: [:marker | self addMarker: marker]
]

{ #category : #accessing }
RefCurve >> rfCurvef [
	^rfEqnf
]

{ #category : #accessing }
RefCurve >> rfCurvef: anObject [
	rfEqnf := anObject
]
