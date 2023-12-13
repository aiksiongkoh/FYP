Class {
	#name : #Region,
	#superclass : #ConcreteNMT,
	#instVars : [
		'cShellUse'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'VisualWorks metadata' }
Region class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
Region >> aRegion [
	^self
]

{ #category : #accessing }
Region >> addShellUse: aShellUse [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aShellUse removeSup.
	cShellUse add: aShellUse.
	aShellUse aSup: self.
	^aShellUse
]

{ #category : #accessing }
Region >> cShellUse [
	^cShellUse
]

{ #category : #accessing }
Region >> cShellUse: acShellUse [ 
	cShellUse := acShellUse
]

{ #category : #accessing }
Region >> cSub [
	^cShellUse
]

{ #category : #'initialize-release' }
Region >> initialize [

	cShellUse := StCAD_Misc_OrderedSet new "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
]

{ #category : #printing }
Region >> printOn: aStream [ 
	aStream nextPutAll: 'aR'.
	aStream print: (self selectRegion: [:item | true]) size.
	aStream nextPutAll: ':S'.
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

{ #category : #displaying }
Region >> renderOn: aRenderingContext [ 
	cShellUse do: [:aShell | aShell renderOn: aRenderingContext]
]

{ #category : #enumerating }
Region >> selectEdge: aBlock into: aSet [ 
	cShellUse do: [:each | each selectEdge: aBlock into: aSet]
]

{ #category : #enumerating }
Region >> selectEdgeUse: aBlock into: aSet [ 
	cShellUse do: [:each | each selectEdgeUse: aBlock into: aSet]
]

{ #category : #enumerating }
Region >> selectFace: aBlock into: aSet [ 
	cShellUse do: [:each | each selectFace: aBlock into: aSet]
]

{ #category : #enumerating }
Region >> selectFaceUse: aBlock into: aSet [ 
	cShellUse do: [:each | each selectFaceUse: aBlock into: aSet]
]

{ #category : #enumerating }
Region >> selectLoop: aBlock into: aSet [ 
	cShellUse do: [:each | each selectLoop: aBlock into: aSet]
]

{ #category : #enumerating }
Region >> selectLoopUse: aBlock into: aSet [ 
	cShellUse do: [:each | each selectLoopUse: aBlock into: aSet]
]

{ #category : #enumerating }
Region >> selectRegion: aBlock into: aSet [ 
	(aBlock value: self) ifTrue: [aSet add: self]
]

{ #category : #enumerating }
Region >> selectShell: aBlock into: aSet [ 
	cShellUse do: [:each | each selectShell: aBlock into: aSet]
]

{ #category : #enumerating }
Region >> selectShellUse: aBlock into: aSet [ 
	cShellUse do: [:each | each selectShellUse: aBlock into: aSet]
]

{ #category : #enumerating }
Region >> selectVertex: aBlock into: aSet [ 
	cShellUse do: [:each | each selectVertex: aBlock into: aSet]
]

{ #category : #enumerating }
Region >> selectVertexUse: aBlock into: aSet [ 
	cShellUse do: [:each | each selectVertexUse: aBlock into: aSet]
]
