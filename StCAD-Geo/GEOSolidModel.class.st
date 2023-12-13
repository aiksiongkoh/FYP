Class {
	#name : #GEOSolidModel,
	#superclass : #GEOSolidModelingItem,
	#instVars : [
		'vertexs',
		'edges',
		'faces',
		'boundingBox',
		'momentsOfVolume'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'triggering events' }
GEOSolidModel class >> constructEventsTriggered [
	^(super constructEventsTriggered)
		add: #getDisplayList;
		yourself
]

{ #category : #'instance creation' }
GEOSolidModel class >> for: part [ 
	^super new part: part
]

{ #category : #'VisualWorks metadata' }
GEOSolidModel class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOSolidModel >> aAPp [
	^momentsOfVolume aAPp
]

{ #category : #accessing }
GEOSolidModel >> aBoundingBox [
	^boundingBox
]

{ #category : #accessing }
GEOSolidModel >> aDisplayList [
	^self triggerEvent: #getDisplayList
]

{ #category : #accessing }
GEOSolidModel >> aDisplayList: aDisplayList [ 
	self removeActionsForEvent: #getDisplayList.
	aDisplayList notNil 
		ifTrue: 
			[self 
				when: #getDisplayList
				ask: aDisplayList
				perform: #yourself]
]

{ #category : #accessing }
GEOSolidModel >> addCurveMarker: geoMarker [ 
	container addCurveMarker: geoMarker
]

{ #category : #accessing }
GEOSolidModel >> addMarker: geoMarker [ 
	container addMarker: geoMarker
]

{ #category : #accessing }
GEOSolidModel >> boundingBox [
	^boundingBox
]

{ #category : #building }
GEOSolidModel >> buildExtrudedFeature: geoExtrudedFeature [ 
	| fsEsVs |
	fsEsVs := geoExtrudedFeature facesEdgesVertexs.
	fsEsVs do: [:fs | fs do: [:f | f container: self]].
	faces addAll: (fsEsVs at: 1).
	edges addAll: (fsEsVs at: 2).
	vertexs addAll: (fsEsVs at: 3)
]

{ #category : #accessing }
GEOSolidModel >> cEdge [
	^edges
]

{ #category : #accessing }
GEOSolidModel >> cFace [
	^faces
]

{ #category : #accessing }
GEOSolidModel >> cMomentOfVolume [
	^momentsOfVolume
]

{ #category : #accessing }
GEOSolidModel >> cVertex [
	^vertexs
]

{ #category : #calc }
GEOSolidModel >> calcBoundingBox [
	"Assume solidModel has been built and valid."

	boundingBox := BoundingBox new.
	vertexs inject: boundingBox
		into: [:bbox :vertex | bbox expandToBound: vertex point]
]

{ #category : #calc }
GEOSolidModel >> calcMomentsOfVolume [
	momentsOfVolume := GEOInertiaMatrixSolver new momentsOfVolume: self
]

{ #category : #accessing }
GEOSolidModel >> center [
	^boundingBox center
]

{ #category : #accessing }
GEOSolidModel >> faces [
	^faces
]

{ #category : #accessing }
GEOSolidModel >> featureOrder [
	^container featureOrder
]

{ #category : #testing }
GEOSolidModel >> hasCentroid [
	^momentsOfVolume notNil
]

{ #category : #'initialize-release' }
GEOSolidModel >> initialize [

	vertexs := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	edges := StCAD_Misc_OrderedSet new.
	faces := StCAD_Misc_OrderedSet new.
	boundingBox := BoundingBox new
]

{ #category : #accessing }
GEOSolidModel >> magnifySelf: aDouble [ 
	self cVertex do: [:aVertex | aVertex magnifySelf: aDouble].
	self cEdge do: [:aEdge | aEdge magnifySelf: aDouble].
	self cFace do: [:aFace | aFace magnifySelf: aDouble].
	self aBoundingBox magnifySelf: aDouble.
	self cMomentOfVolume 
		ifNotNil: [:cMomentOfVolume | cMomentOfVolume magnifySelf: aDouble]
]

{ #category : #accessing }
GEOSolidModel >> markers [
	^container markers
]

{ #category : #accessing }
GEOSolidModel >> momentsOfVolume [
	^momentsOfVolume
]

{ #category : #accessing }
GEOSolidModel >> momentsOfVolume: momentsOfVol [ 
	momentsOfVolume := momentsOfVol
]

{ #category : #accessing }
GEOSolidModel >> part: part [ 
	container := part
]

{ #category : #copying }
GEOSolidModel >> preSave [
	super preSave.
	faces do: [:face | face preSave].
	self removeDisplayList
]

{ #category : #accessing }
GEOSolidModel >> refFrame [
	^container refFrame
]

{ #category : #'initialize-release' }
GEOSolidModel >> release [
	self removeDisplayList.
	faces do: [:face | face release].
	super release
]

{ #category : #building }
GEOSolidModel >> releaseFacesEdgesVertexs [

	self removeDisplayList.
	faces do: [ :face | face release ].
	edges do: [ :edge | edge release ].
	vertexs do: [ :vertex | vertex release ].
	vertexs := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	edges := StCAD_Misc_OrderedSet new.
	faces := StCAD_Misc_OrderedSet new.
	boundingBox := BoundingBox new.
	momentsOfVolume := nil
]

{ #category : #building }
GEOSolidModel >> removeDisplayList [
	self aDisplayList ifNotNil: 
			[:listID | 
			self interface display aOpenGLContext removeDisplayList: listID.
			self aDisplayList: nil]
]

{ #category : #'initialize-release' }
GEOSolidModel >> removeGEO: aGEO [ 
	"Do nothing for now."
]

{ #category : #rendering }
GEOSolidModel >> renderOn1: aRenderingContext [ 
	faces do: [:face | face renderOn: aRenderingContext]
]

{ #category : #rendering }
GEOSolidModel >> renderOn2: aRenderingContext [ 
	| array |
aRenderingContext enableDepthTest.
	array := faces asArray.
"	(array at: 1) renderOn: aRenderingContext."
	(array at: 3) renderOn: aRenderingContext.
	(array at: 2) renderOn: aRenderingContext.
"	(array at: 4) renderOn: aRenderingContext."
"	(array at: 5) renderOn: aRenderingContext."
"	(array at: 6) renderOn: aRenderingContext"
]

{ #category : #rendering }
GEOSolidModel >> renderOn3: aOpenGLContext [ 
	| block |
	block := 
			[| listID |
			listID := aOpenGLContext 
						createDisplayList: [faces do: [:face | face renderOn: aOpenGLContext]]
						displayImmediately: false.
			self aDisplayList: listID.
			aOpenGLContext callDisplayList: listID].
	self aDisplayList ifNil: block
		ifNotNil: 
			[:listID | 
			(aOpenGLContext isDisplayList: listID) 
				ifTrue: [aOpenGLContext callDisplayList: listID]
				ifFalse: block]
]

{ #category : #rendering }
GEOSolidModel >> renderOn: aOpenGLContext [ 
	| block |
	block := 
			[| listID |
			listID := aOpenGLContext 
						createDisplayList: [faces do: [:face | face renderOn: aOpenGLContext]]
						displayImmediately: false.
			self aDisplayList: listID.
			aOpenGLContext callDisplayList: listID].
	self aDisplayList ifNil: block
		ifNotNil: 
			[:listID | 
			(aOpenGLContext isDisplayList: listID) 
				ifTrue: [aOpenGLContext callDisplayList: listID]
				ifFalse: block]
]

{ #category : #accessing }
GEOSolidModel >> solidModel [
	^self
]
