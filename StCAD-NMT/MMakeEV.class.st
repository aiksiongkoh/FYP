Class {
	#name : #MMakeEV,
	#superclass : #ManifoldMake,
	#instVars : [
		'aRegion',
		'aFace',
		'aEdge',
		'aVertex',
		'aPoint',
		'orient',
		'newEdge',
		'aCurve',
		'newVertex'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Operator'
}

{ #category : #'instance creation' }
MMakeEV class >> inRegion: aRegion inFace: aFace aEdge: aEdge fromVertex: aVertex toPoint: aPoint orient: orient [ 
	| aMMakeEV |
	aMMakeEV := self new.
	aMMakeEV aRegion: aRegion.
	aMMakeEV aFace: aFace.
	aMMakeEV aEdge: aEdge.
	aMMakeEV aVertex: aVertex.
	aMMakeEV aPoint: aPoint.
	aMMakeEV orient: orient.
	^aMMakeEV
]

{ #category : #'VisualWorks metadata' }
MMakeEV class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
MMakeEV >> aEdge [
	^aEdge
]

{ #category : #accessing }
MMakeEV >> aEdge: anObject [
	aEdge := anObject
]

{ #category : #accessing }
MMakeEV >> aFace [
	^aFace
]

{ #category : #accessing }
MMakeEV >> aFace: anObject [
	aFace := anObject
]

{ #category : #accessing }
MMakeEV >> aPoint [
	^aPoint
]

{ #category : #accessing }
MMakeEV >> aPoint: anObject [
	aPoint := anObject
]

{ #category : #accessing }
MMakeEV >> aRegion [
	^aRegion
]

{ #category : #accessing }
MMakeEV >> aRegion: anObject [
	aRegion := anObject
]

{ #category : #accessing }
MMakeEV >> aVertex [
	^aVertex
]

{ #category : #accessing }
MMakeEV >> aVertex: anObject [
	aVertex := anObject
]

{ #category : #executing }
MMakeEV >> execute [
	"
	To do:
	Account for repeated use of vertex in loop.
	"

	| aModel oldFaceUse oldLoopUse oldVertexUse oldEdgeUseNext outEdgeUse inEdgeUse otherOldFaceUse otherOldLoopUse otherOldVertexUse otherOldEdgeUseNext otherOutEdgeUse otherInEdgeUse |
	aModel := aRegion aModel.
	newVertex := aModel newVertex: aPoint.
	newEdge := aModel 
				newEdgeWith: aVertex
				and: newVertex
				aCurve: aCurve.

	"Processing side facing aRegion."
	oldFaceUse := (aFace 
				selectFaceUse: [:aFaceUse | aFaceUse aRegion == aRegion]) soleItem.
	oldLoopUse := (oldFaceUse 
				selectLoopUse: [:aLoopUse | aLoopUse includesVertex: aVertex]) soleItem.
	oldVertexUse := (oldFaceUse 
				selectVertexUse: [:aVertexUse | aVertexUse aNMTItem == aVertex]) soleItem.
	outEdgeUse := newEdge newUse.
	inEdgeUse := newEdge newUse.
	inEdgeUse aVertexUse: newVertex newUse.
	outEdgeUse radial: inEdgeUse.
	oldLoopUse isVertexLoop 
		ifTrue: 
			[outEdgeUse aVertexUse: oldVertexUse.
			oldLoopUse addEdgeUse: outEdgeUse.
			oldLoopUse addEdgeUse: inEdgeUse]
		ifFalse: 
			[outEdgeUse aVertexUse: aVertex newUse.
			oldLoopUse isSelfLoop 
				ifTrue: 
					[oldLoopUse addEdgeUse: outEdgeUse.
					oldLoopUse addEdgeUse: inEdgeUse]
				ifFalse: 
					[oldEdgeUseNext := oldVertexUse aEdgeUse.
					oldLoopUse addEdgeUse: outEdgeUse before: oldEdgeUseNext.
					oldLoopUse addEdgeUse: inEdgeUse before: oldEdgeUseNext]].

	"Processing side facing otherRegion."
	otherOldFaceUse := oldFaceUse mate.
	otherOldLoopUse := oldLoopUse mate.
	otherOldVertexUse := (otherOldFaceUse 
				selectVertexUse: [:aVertexUse | aVertexUse aNMTItem == aVertex]) soleItem.
	otherOutEdgeUse := newEdge newUse.
	otherInEdgeUse := newEdge newUse.
	otherInEdgeUse aVertexUse: newVertex newUse.
	otherOutEdgeUse radial: otherInEdgeUse.
	outEdgeUse mate: otherInEdgeUse.
	inEdgeUse mate: otherOutEdgeUse.
	otherOldLoopUse isVertexLoop 
		ifTrue: 
			[otherOutEdgeUse aVertexUse: otherOldVertexUse.
			otherOldLoopUse addEdgeUse: otherOutEdgeUse.
			otherOldLoopUse addEdgeUse: otherInEdgeUse]
		ifFalse: 
			[otherOutEdgeUse aVertexUse: aVertex newUse.
			otherOldLoopUse isSelfLoop 
				ifTrue: 
					[otherOldLoopUse addEdgeUse: otherOutEdgeUse.
					otherOldLoopUse addEdgeUse: otherInEdgeUse]
				ifFalse: 
					[otherOldEdgeUseNext := otherOldVertexUse aEdgeUse.
					otherOldLoopUse addEdgeUse: otherOutEdgeUse before: otherOldEdgeUseNext.
					otherOldLoopUse addEdgeUse: otherInEdgeUse before: otherOldEdgeUseNext]]
]

{ #category : #accessing }
MMakeEV >> newEdge [
	^newEdge
]

{ #category : #accessing }
MMakeEV >> newEdge: anObject [
	newEdge := anObject
]

{ #category : #accessing }
MMakeEV >> newVertex [
	^newVertex
]

{ #category : #accessing }
MMakeEV >> newVertex: anObject [
	newVertex := anObject
]

{ #category : #accessing }
MMakeEV >> orient [
	^orient
]

{ #category : #accessing }
MMakeEV >> orient: anObject [
	orient := anObject
]
