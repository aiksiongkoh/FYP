"
When edge is not on a surface, aCurve is defined as xyz as function of u.
When edge is on a surface, aCurve is not used. The edgeuse stores the geometric information.

Instance Variables:
	aCurve	<Object>	description of aCurve


"
Class {
	#name : #Edge,
	#superclass : #ManyUseItem,
	#instVars : [
		'aCurve'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'VisualWorks metadata' }
Edge class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
Edge >> aCurve [
	^aCurve
]

{ #category : #accessing }
Edge >> aCurve: anObject [
	aCurve := anObject
]

{ #category : #accessing }
Edge >> cVertex [

	| aEdgeUse |
	aEdgeUse := cUse first.
	^ StCAD_Misc_OrderedSet
		  with: aEdgeUse aVertex
		  with: aEdgeUse mate aVertex "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
]

{ #category : #testing }
Edge >> isCyclic [

	| aEdgeUse |
	aEdgeUse := cUse first.
	^aEdgeUse aVertex == aEdgeUse mate aVertex
]

{ #category : #printing }
Edge >> printOn: aStream [ 
	aStream nextPutAll: 'aE'.
	aStream print: (self selectEdge: [:item | true]) size.
	aStream nextPutAll: ':V'.
	aStream print: (self selectVertex: [:item | true]) size.
	aStream nextPutAll: ':EU'.
	aStream print: (self selectEdgeUse: [:item | true]) size.
	aStream nextPutAll: ':VU'.
	aStream print: (self selectVertexUse: [:item | true]) size
]

{ #category : #accessing }
Edge >> removeSup [
	aSup ifNotNil: [:aaSup | aaSup removeEdge: self]
]

{ #category : #enumerating }
Edge >> selectCurve: aBlock into: aSet [ 
	cUse do: [:each | each selectCurve: aBlock into: aSet]
]

{ #category : #enumerating }
Edge >> selectEdge: aBlock into: aSet [ 
	(aBlock value: self) ifTrue: [aSet add: self]
]

{ #category : #enumerating }
Edge >> selectEdgeUse: aBlock into: aSet [ 
	cUse do: [:each | each selectEdgeUse: aBlock into: aSet]
]

{ #category : #enumerating }
Edge >> selectVertex: aBlock into: aSet [ 
	cUse do: [:each | each selectVertex: aBlock into: aSet]
]

{ #category : #enumerating }
Edge >> selectVertexUse: aBlock into: aSet [ 
	cUse do: [:each | each selectVertexUse: aBlock into: aSet]
]

{ #category : #accessing }
Edge >> useClass [

	^ StCAD_NMT_EdgeUse "VW_TRANSLATION:StCAD.NMT.EdgeUse:StCAD_NMT_EdgeUse"
]
