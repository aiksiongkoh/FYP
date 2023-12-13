Class {
	#name : #Polyline,
	#superclass : #Curve3D,
	#instVars : [
		'crfpointf',
		'isClosed'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
Polyline class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
Polyline >> crFpointF [
	^self crfpointf collect: [:rfpointf | aRefFrame rFpFfromrfpf: rfpointf]
]

{ #category : #accessing }
Polyline >> createNurbs [
	^NurbsCurve fromPolyline: self
]

{ #category : #accessing }
Polyline >> crfpointf [
	^crfpointf
]

{ #category : #accessing }
Polyline >> crfpointf: cPoint [ 
	crfpointf := cPoint.
	isClosed := crfpointf first = crfpointf last.
	self changed
]

{ #category : #ops }
Polyline >> magnifySelf: aDouble [

	super magnifySelf: aDouble.
	crfpointf magnifySelf: aDouble
]

{ #category : #calc }
Polyline >> privateCalcBoundingBox [

	aBoundingBox := StCAD_Misc_BoundingBox new. "VW_TRANSLATION:StCAD.Misc.BoundingBox:StCAD_Misc_BoundingBox"
	crfpointf do: [ :rfpointf | aBoundingBox expandToBound: rfpointf ]
]

{ #category : #accessing }
Polyline >> rfpointsf [
	^crfpointf
]

{ #category : #accessing }
Polyline >> rfpointsf: array [ 
	crfpointf := array.
	isClosed := crfpointf first = crfpointf last.
	self changed
]
