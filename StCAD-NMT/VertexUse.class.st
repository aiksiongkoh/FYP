"
aVertexUse can be contained by aShell, aLoopUse, aEdgeUse.
In aShell, tORuORuvORxyz is not used. The xyz coordinates is stored in aVertexUse corresponding vertex.
In aLoopUse, tORuORuvORxyz stores the u0v0 such that the vertex is positioned at xyz(u0v0) on the face.
In aEdgeUse which is a wireframe, tORuORuvORxyz stores the u0 such that the vertex is positioned at xyz(u0) on the edge.
In aEdgeUse which is on a face, tORuORuvORxyz stores the t0 such that the vertex is positioned at xyz(uv(t0)) on the face.

Instance Variables:
	tORuORuvORxyz	<Object>	description of tORuORuvORxyz


"
Class {
	#name : #VertexUse,
	#superclass : #ItemUse,
	#instVars : [
		'aPoint'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'VisualWorks metadata' }
VertexUse class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
VertexUse >> aEdgeUse [
	^aSup aEdgeUse
]

{ #category : #accessing }
VertexUse >> aPoint [
	^aNMTItem aPoint
]

{ #category : #accessing }
VertexUse >> aVertex [
	^aNMTItem
]

{ #category : #accessing }
VertexUse >> aVertexUse [
	^self
]

{ #category : #copying }
VertexUse >> copy [
	^self aNMTItem newUse
]

{ #category : #testing }
VertexUse >> includes: argNMTItem [ 
	^self == argNMTItem ifTrue: [true] ifFalse: [aNMTItem == argNMTItem]
]

{ #category : #testing }
VertexUse >> isVertexUse [
	^true
]

{ #category : #printing }
VertexUse >> printOn: aStream [ 
	aStream nextPutAll: 'VU('.
	self aPoint do: [:element | element printOn: aStream]
		separatedBy: [aStream space].
	aStream nextPut: $)
]

{ #category : #accessing }
VertexUse >> rSkFacePointSk [
	^aSup rSkFacePointSkAt: self t0
]

{ #category : #enumerating }
VertexUse >> selectEdge: aBlock into: aSet [ 
	"Do nothing."
]

{ #category : #enumerating }
VertexUse >> selectEdgeUse: aBlock into: aSet [ 
	"Do nothing."
]

{ #category : #enumerating }
VertexUse >> selectFace: aBlock into: aSet [ 
	"Do nothing."
]

{ #category : #enumerating }
VertexUse >> selectFaceUse: aBlock into: aSet [ 
	"Do nothing."
]

{ #category : #enumerating }
VertexUse >> selectLoop: aBlock into: aSet [ 
	"Do nothing."
]

{ #category : #enumerating }
VertexUse >> selectLoopUse: aBlock into: aSet [ 
	"Do nothing."
]

{ #category : #enumerating }
VertexUse >> selectVertex: aBlock into: aSet [ 
	aNMTItem selectVertex: aBlock into: aSet
]

{ #category : #enumerating }
VertexUse >> selectVertexUse: aBlock into: aSet [ 
	(aBlock value: self) ifTrue: [aSet add: self]
]

{ #category : #accessing }
VertexUse >> t0 [
	^aPoint
]

{ #category : #accessing }
VertexUse >> t: anObject [ 
	aPoint := anObject
]

{ #category : #accessing }
VertexUse >> tORuORuvORxyz [
	^aPoint
]

{ #category : #accessing }
VertexUse >> tORuORuvORxyz: anObject [
	aPoint := anObject
]

{ #category : #accessing }
VertexUse >> u0 [
	^aPoint
]
