"
The outward normal is positive. Use the Right Hand Rule to determine loop orientation. CCW loop means the normal is pointing towards observer. CW loop means a hole.
In NMT the faceuse normal points into the region containing it. The outward normal points into the infinite outside region.

For non manifold face chose the positive side to have normal_z > 0. 
If normal_z = 0, choose normal_y > 0. 
If normal_z = normal_y = 0, choose normal_x > 0.

Instance Variables:
	aSurface	<Object>	xyz as function of uv.
	cFaceUse	<Object>	description of cFaceUse


"
Class {
	#name : #Face,
	#superclass : #ManyUseItem,
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'binary storage' }
Face class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [
	"
	Change 
	StCAD.StGeo.GEOInPlaneJoint 
	(eventTable container constraints markerI markerJ ) 
	to 
	StCAD.StGeo.GEOPointInPlaneJoint 
	(eventTable container constraints markerI markerJ offset)
	"

	oldVersion == nil
		ifTrue: 
			[| inst |
			self halt.
			inst := GEOPointInPlaneJoint basicNew.
			^
			[:oldObj |
			| new |
			self halt.
			new := Array new: 6.
			new
				replaceFrom: 1
				to: 5
				with: oldObj
				startingAt: 1.
			oldObj become: new.
			oldObj changeClassToThatOf: inst.
			oldObj offset: 0.0d.
			oldObj]].
	^super binaryReaderBlockForVersion: oldVersion format: oldFormat
]

{ #category : #'VisualWorks metadata' }
Face class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #printing }
Face >> printOn: aStream [ 
	aStream nextPutAll: 'aF'.
	aStream print: (self selectFace: [:item | true]) size.
	aStream nextPutAll: ':L'.
	aStream print: (self selectLoop: [:item | true]) size.
	aStream nextPutAll: ':E'.
	aStream print: (self selectEdge: [:item | true]) size.
	aStream nextPutAll: ':V'.
	aStream print: (self selectVertex: [:item | true]) size.
	aStream nextPutAll: ':FU'.
	aStream print: (self selectFaceUse: [:item | true]) size.
	aStream nextPutAll: ':LU'.
	aStream print: (self selectLoopUse: [:item | true]) size.
	aStream nextPutAll: ':EU'.
	aStream print: (self selectEdgeUse: [:item | true]) size.
	aStream nextPutAll: ':VU'.
	aStream print: (self selectVertexUse: [:item | true]) size
]

{ #category : #accessing }
Face >> removeSup [
	aSup ifNotNil: [:aaSup | aaSup removeFace: self]
]

{ #category : #enumerating }
Face >> selectEdge: aBlock into: aSet [ 
	cUse do: [:each | each selectEdge: aBlock into: aSet]
]

{ #category : #enumerating }
Face >> selectEdgeUse: aBlock into: aSet [ 
	cUse do: [:each | each selectEdgeUse: aBlock into: aSet]
]

{ #category : #enumerating }
Face >> selectFace: aBlock into: aSet [ 
	(aBlock value: self) ifTrue: [aSet add: self]
]

{ #category : #enumerating }
Face >> selectFaceUse: aBlock into: aSet [ 
	cUse do: [:each | each selectFaceUse: aBlock into: aSet]
]

{ #category : #enumerating }
Face >> selectLoop: aBlock into: aSet [ 
	cUse do: [:each | each selectLoop: aBlock into: aSet]
]

{ #category : #enumerating }
Face >> selectLoopUse: aBlock into: aSet [ 
	cUse do: [:each | each selectLoopUse: aBlock into: aSet]
]

{ #category : #accessing }
Face >> selectSurface: aBlock into: aSet [ 
	cUse do: [:each | each selectSurface: aBlock into: aSet]
]

{ #category : #enumerating }
Face >> selectVertex: aBlock into: aSet [ 
	cUse do: [:each | each selectVertex: aBlock into: aSet]
]

{ #category : #enumerating }
Face >> selectVertexUse: aBlock into: aSet [ 
	cUse do: [:each | each selectVertexUse: aBlock into: aSet]
]

{ #category : #ops }
Face >> startFirstLoopAtVertex: aVertex [ 
	(self selectLoop: [:aLoop | true]) first startLoopAtVertex: aVertex
]

{ #category : #ops }
Face >> startFirstLoopAtVertexUse: aVertexUse [ 
	(self selectLoop: [:aLoop | true]) first startLoopAtVertexUse: aVertexUse
]

{ #category : #ops }
Face >> startVertexUseOf: aVertex inRegion: aRegion [ 
	| aLoopUse cVertexUse |
	aLoopUse := (self 
				selectLoopUse: [:argLoopUse | argLoopUse aRegion == aRegion]) soleItem.
	cVertexUse := aLoopUse 
				selectVertexUse: [:aVertexUse | aVertexUse aVertex == aVertex].
	^cVertexUse size == 1 
		ifTrue: [cVertexUse first]
		ifFalse: [cVertexUse detect: [:aVertexUse | aVertexUse aVertex == aVertex]]
]

{ #category : #accessing }
Face >> useClass [

	^ StCAD_NMT_FaceUse "VW_TRANSLATION:StCAD.NMT.FaceUse:StCAD_NMT_FaceUse"
]
