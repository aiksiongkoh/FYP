Class {
	#name : #GEOWEFace,
	#superclass : #GEOSolidModelingItem,
	#instVars : [
		'edge',
		'polyline'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'VisualWorks metadata' }
GEOWEFace class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOWEFace >> aPolyline [
	^polyline
]

{ #category : #accessing }
GEOWEFace >> addCurveMarker: geoMarker [ 
	geoMarker refFrame refFrame: polyline refFrame.
	container addCurveMarker: geoMarker
]

{ #category : #accessing }
GEOWEFace >> addMarker1: geoMarker [

	| markers |
	geoMarker container: self.
	geoMarker refFrame refFrame: polyline refFrame.
	markers := self markers.
	markers isNil ifTrue: [ 
		markers := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
		self markers: markers ].
	markers add: geoMarker
]

{ #category : #accessing }
GEOWEFace >> addMarker: geoMarker [ 
	geoMarker refFrame refFrame: polyline refFrame.
	geoMarker guideFrame: polyline refFrame.
	container addMarker: geoMarker
]

{ #category : #accessing }
GEOWEFace >> container: cont edge: edg [ 
	container := cont.
	edge := edg
]

{ #category : #accessing }
GEOWEFace >> edge [
	^edge
]

{ #category : #accessing }
GEOWEFace >> edge: wingedEdge [ 
	edge := wingedEdge
]

{ #category : #accessing }
GEOWEFace >> eqnOfPlaneInPart [
	| partRefFrame planeRefFrame abc rPtPlPt d answer partRefFrameAOfT |
	partRefFrame := self part refFrame.
	planeRefFrame := polyline refFrame.
	partRefFrameAOfT := partRefFrame aAOf transpose.
	abc := partRefFrameAOfT timesFullColumn: (planeRefFrame aAOf column: 3).
	rPtPlPt := partRefFrameAOfT timesFullColumn: planeRefFrame rOfO - partRefFrame rOfO.
	d := (abc dot: rPtPlPt) negated.
	answer := FullColumn new: 4.
	answer at: 1 putFullColumn: abc.
	answer at: 4 put: d.
	^answer
]

{ #category : #accessing }
GEOWEFace >> inPlaneFrame [
	^self interface projectionFrame
]

{ #category : #accessing }
GEOWEFace >> isFace [
	^true
]

{ #category : #accessing }
GEOWEFace >> isPlanar [
	^true
]

{ #category : #accessing }
GEOWEFace >> magnifySelf: aDouble [ 
	self aPolyline magnifySelf: aDouble
]

{ #category : #accessing }
GEOWEFace >> markers [
	^container markers
]

{ #category : #accessing }
GEOWEFace >> movingFrame [
	^self part refFrame
]

{ #category : #accessing }
GEOWEFace >> nvertex [
	^polyline rfpointsf size - 1
]

{ #category : #accessing }
GEOWEFace >> plane [
	^polyline refFrame
]

{ #category : #accessing }
GEOWEFace >> polyline [
	^polyline
]

{ #category : #accessing }
GEOWEFace >> polyline: poly [ 
	polyline := poly.
	polyline container: self
]

{ #category : #copying }
GEOWEFace >> postCopy [
	"edge is updated in GEOSolidModel>postCopy."

	super postCopy.
	self polyline: polyline copy
]

{ #category : #copying }
GEOWEFace >> postCopy1 [
	"Do self>markers first because marker set is stored in eventTable."
	"edge is updated in GEOSolidModel>postCopy."

	| originalMarkers |
	originalMarkers := self markers.
	super postCopy.
	self polyline: polyline copy.
	originalMarkers notNil ifTrue: [originalMarkers do: [:marker | self addMarker: marker copy]]
]

{ #category : #copying }
GEOWEFace >> preSave [
	super preSave.
	polyline preSave
]

{ #category : #accessing }
GEOWEFace >> rOpointsO [
	| rPvertexsP nvertex rOpointsO partRefFrame rOPO aAOP rPpP rOpO |
	rPvertexsP := edge faceVertexsFor: self.
	nvertex := rPvertexsP size.
	rOpointsO := Array new: nvertex + 1.
	partRefFrame := self part refFrame.
	rOPO := partRefFrame rOfO.
	aAOP := partRefFrame aAOf.
	1 to: nvertex
		do: 
			[:i | 
			rPpP := (rPvertexsP at: i) point.
			rOpO := rOPO + (aAOP timesFullColumn: rPpP).
			rOpointsO at: i put: rOpO].
	rOpointsO at: nvertex + 1 put: (rOpointsO at: 1).
	^rOpointsO
]

{ #category : #accessing }
GEOWEFace >> rPpointsP [
	| partRefFrame |
	partRefFrame := self part refFrame.
	^polyline rOpointsO collect: [:rOpO | partRefFrame rfpffromrOpO: rOpO]
]

{ #category : #accessing }
GEOWEFace >> refFrame [
	^polyline refFrame
]

{ #category : #copying }
GEOWEFace >> release [
	polyline release.
	super release
]

{ #category : #rendering }
GEOWEFace >> renderOn1: aRenderingContext [ 
	polyline renderPolygonOn: aRenderingContext
]

{ #category : #rendering }
GEOWEFace >> renderOn: aRenderingContext [ 
	polyline renderPolyfaceOn: aRenderingContext
]

{ #category : #accessing }
GEOWEFace >> solidModel [
	^container ifNotNil: [:aSup | aSup solidModel]
]

{ #category : #accessing }
GEOWEFace >> translateSelfBy: delta [ 
	^self part translateSelfBy: delta
]
