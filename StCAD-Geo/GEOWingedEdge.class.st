Class {
	#name : #GEOWingedEdge,
	#superclass : #GEOSolidModelingItem,
	#instVars : [
		'vertex1',
		'vertex2',
		'face12',
		'face21',
		'edge11',
		'edge12',
		'edge21',
		'edge22'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'VisualWorks metadata' }
GEOWingedEdge class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOWingedEdge >> edge11 [
	^edge11
]

{ #category : #accessing }
GEOWingedEdge >> edge11: edge [ 
	edge11 := edge
]

{ #category : #accessing }
GEOWingedEdge >> edge12 [
	^edge12
]

{ #category : #accessing }
GEOWingedEdge >> edge12: edge [ 
	edge12 := edge
]

{ #category : #accessing }
GEOWingedEdge >> edge21 [
	^edge21
]

{ #category : #accessing }
GEOWingedEdge >> edge21: edge [ 
	edge21 := edge
]

{ #category : #accessing }
GEOWingedEdge >> edge22 [
	^edge22
]

{ #category : #accessing }
GEOWingedEdge >> edge22: edge [ 
	edge22 := edge
]

{ #category : #accessing }
GEOWingedEdge >> face12 [
	^face12
]

{ #category : #accessing }
GEOWingedEdge >> face12: face [ 
	face12 := face
]

{ #category : #accessing }
GEOWingedEdge >> face21 [
	^face21
]

{ #category : #accessing }
GEOWingedEdge >> face21: face [ 
	face21 := face
]

{ #category : #accessing }
GEOWingedEdge >> facePlaneFor: face [
]

{ #category : #accessing }
GEOWingedEdge >> faceVertexsFor: face [ 
	| vertexs |
	vertexs := OrderedCollection new.
	self faceVertexsFor: face in: vertexs.
	^vertexs
]

{ #category : #accessing }
GEOWingedEdge >> faceVertexsFor: face in: vertexs [ 
	| firstVertex nextVertex nextEdges |
	face == face12
		ifTrue: 
			[firstVertex := vertex1.
			nextVertex := vertex2.
			nextEdges := Array with: edge21 with: edge22]
		ifFalse: [face == face21
				ifTrue: 
					[firstVertex := vertex2.
					nextVertex := vertex1.
					nextEdges := Array with: edge11 with: edge12]
				ifFalse: [^self]].
	vertexs add: firstVertex.
	nextVertex == (vertexs at: 1) ifFalse: ["Continue till end of loop is found."
		nextEdges do: [:edge | edge faceVertexsFor: face in: vertexs]]
]

{ #category : #accessing }
GEOWingedEdge >> magnifySelf: aDouble [ 
	"Do nothing. Work done by vertexs and faces."
]

{ #category : #accessing }
GEOWingedEdge >> vertex1 [
	^vertex1
]

{ #category : #accessing }
GEOWingedEdge >> vertex1: vertex [ 
	vertex1 := vertex
]

{ #category : #accessing }
GEOWingedEdge >> vertex2 [
	^vertex2
]

{ #category : #accessing }
GEOWingedEdge >> vertex2: vertex [ 
	vertex2 := vertex
]
