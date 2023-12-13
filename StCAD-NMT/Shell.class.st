"
A Shell is a boundary of a Region. 
Region1 (has volume)
Shell1 (only one ShellUse1)
-----------------------------interface
Shell2 (only one ShellUse2)
Region2

or

Region1
Shell1 (only one ShellUse1)
-----------------------------interface
Vertex, Wireframe
"
Class {
	#name : #Shell,
	#superclass : #ManyUseItem,
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'VisualWorks metadata' }
Shell class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
Shell >> aShell [
	^self
]

{ #category : #printing }
Shell >> printOn: aStream [ 
	aStream nextPutAll: 'aS'.
	aStream print: (self selectShell: [:item | true]) size.
	aStream nextPutAll: ':F'.
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
Shell >> removeSup [
	aSup ifNotNil: [:aaSup | aaSup removeShell: self]
]

{ #category : #enumerating }
Shell >> selectEdge: aBlock into: aSet [ 
	cUse do: [:each | each selectEdge: aBlock into: aSet]
]

{ #category : #enumerating }
Shell >> selectEdgeUse: aBlock into: aSet [ 
	cUse do: [:each | each selectEdgeUse: aBlock into: aSet]
]

{ #category : #enumerating }
Shell >> selectFace: aBlock into: aSet [ 
	cUse do: [:each | each selectFace: aBlock into: aSet]
]

{ #category : #enumerating }
Shell >> selectFaceUse: aBlock into: aSet [ 
	cUse do: [:each | each selectFaceUse: aBlock into: aSet]
]

{ #category : #enumerating }
Shell >> selectLoop: aBlock into: aSet [ 
	cUse do: [:each | each selectLoop: aBlock into: aSet]
]

{ #category : #enumerating }
Shell >> selectLoopUse: aBlock into: aSet [ 
	cUse do: [:each | each selectLoopUse: aBlock into: aSet]
]

{ #category : #enumerating }
Shell >> selectShell: aBlock into: aSet [ 
	(aBlock value: self) ifTrue: [aSet add: self]
]

{ #category : #enumerating }
Shell >> selectShellUse: aBlock into: aSet [ 
	cUse do: [:each | each selectShellUse: aBlock into: aSet]
]

{ #category : #enumerating }
Shell >> selectVertex: aBlock into: aSet [ 
	cUse do: [:each | each selectVertex: aBlock into: aSet]
]

{ #category : #enumerating }
Shell >> selectVertexUse: aBlock into: aSet [ 
	cUse do: [:each | each selectVertexUse: aBlock into: aSet]
]

{ #category : #accessing }
Shell >> useClass [

	^ StCAD_NMT_ShellUse "VW_TRANSLATION:StCAD.NMT.ShellUse:StCAD_NMT_ShellUse"
]
