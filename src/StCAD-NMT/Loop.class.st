Class {
	#name : #Loop,
	#superclass : #ManyUseItem,
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'VisualWorks metadata' }
Loop class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
Loop >> cCurve [
	^cUse first crFcurveF
]

{ #category : #accessing }
Loop >> crFcurveF [

	^cUse first crFcurveF
]

{ #category : #printing }
Loop >> printOn: aStream [ 
	aStream nextPutAll: 'aL'.
	aStream print: (self selectLoop: [:item | true]) size.
	aStream nextPutAll: ':E'.
	aStream print: (self selectEdge: [:item | true]) size.
	aStream nextPutAll: ':V'.
	aStream print: (self selectVertex: [:item | true]) size.
	aStream nextPutAll: ':LU'.
	aStream print: (self selectLoopUse: [:item | true]) size.
	aStream nextPutAll: ':EU'.
	aStream print: (self selectEdgeUse: [:item | true]) size.
	aStream nextPutAll: ':VU'.
	aStream print: (self selectVertexUse: [:item | true]) size
]

{ #category : #accessing }
Loop >> removeSup [
	aSup ifNotNil: [:aaSup | aaSup removeLoop: self]
]

{ #category : #enumerating }
Loop >> selectEdge: aBlock into: aSet [ 
	cUse do: [:each | each selectEdge: aBlock into: aSet]
]

{ #category : #enumerating }
Loop >> selectEdgeUse: aBlock into: aSet [ 
	cUse do: [:each | each selectEdgeUse: aBlock into: aSet]
]

{ #category : #enumerating }
Loop >> selectLoop: aBlock into: aSet [ 
	(aBlock value: self) ifTrue: [aSet add: self]
]

{ #category : #enumerating }
Loop >> selectLoopUse: aBlock into: aSet [ 
	cUse do: [:each | each selectLoopUse: aBlock into: aSet]
]

{ #category : #enumerating }
Loop >> selectVertex: aBlock into: aSet [ 
	cUse do: [:each | each selectVertex: aBlock into: aSet]
]

{ #category : #enumerating }
Loop >> selectVertexUse: aBlock into: aSet [ 
	cUse do: [:each | each selectVertexUse: aBlock into: aSet]
]

{ #category : #accessing }
Loop >> startLoopAtVertex: argVertex [ 
	cUse do: [:aLoopUse | aLoopUse startLoopAtVertex: argVertex]
]

{ #category : #accessing }
Loop >> startLoopAtVertexUse: argVertexUse [ 
	| aLoopUse mateargVertexUse |
	aLoopUse := (self 
				selectLoopUse: [:argLoopUse | argLoopUse includesVertexUse: argVertexUse]) 
					soleItem.
	aLoopUse startLoopAtVertexUse: argVertexUse.
	mateargVertexUse := aLoopUse cEdgeUse last mate aVertexUse.
	aLoopUse := (self 
				selectLoopUse: [:argLoopUse | argLoopUse includesVertexUse: mateargVertexUse]) 
					soleItem.
	aLoopUse startLoopAtVertexUse: mateargVertexUse
]

{ #category : #accessing }
Loop >> useClass [

	^ StCAD_NMT_LoopUse "VW_TRANSLATION:StCAD.NMT.LoopUse:StCAD_NMT_LoopUse"
]
