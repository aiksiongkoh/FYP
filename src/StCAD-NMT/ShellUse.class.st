Class {
	#name : #ShellUse,
	#superclass : #ItemUse,
	#instVars : [
		'cItemUse'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'VisualWorks metadata' }
ShellUse class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
ShellUse >> aShell [
	^aNMTItem
]

{ #category : #accessing }
ShellUse >> aShellUse [
	^self
]

{ #category : #accessing }
ShellUse >> addEdgeUse: aEdgeUse [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	(aEdgeUse isMemberOf: WireEdgeUse) 
		ifFalse: [aEdgeUse changeClassToThatOf: WireEdgeUse basicNew].
	aEdgeUse removeSup.
	cItemUse add: aEdgeUse.
	aEdgeUse aSup: self.
	^aEdgeUse
]

{ #category : #accessing }
ShellUse >> addFaceUse: aFaceUse [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aFaceUse removeSup.
	cItemUse add: aFaceUse.
	aFaceUse aSup: self.
	^aFaceUse
]

{ #category : #accessing }
ShellUse >> addSub: aSub [ 
	^aSub addIntoShellUse: self
]

{ #category : #accessing }
ShellUse >> addVertexUse: aVertexUse [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	(aVertexUse isMemberOf: ShellVertexUse) 
		ifFalse: [aVertexUse changeClassToThatOf: ShellVertexUse basicNew].
	aVertexUse removeSup.
	cItemUse add: aVertexUse.
	aVertexUse aSup: self.
	^aVertexUse
]

{ #category : #accessing }
ShellUse >> cSub [
	^cItemUse
]

{ #category : #testing }
ShellUse >> includes: aaNMTItem [ 
	^self == aaNMTItem 
		ifTrue: [true]
		ifFalse: 
			[(cItemUse detect: [:aItemUse | aItemUse includes: aaNMTItem] ifNone: nil) 
				notNil]
]

{ #category : #'initialize-release' }
ShellUse >> initialize [

	cItemUse := StCAD_Misc_OrderedSet new "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
]

{ #category : #printing }
ShellUse >> printOn: aStream [ 
	aStream nextPutAll: 'aSU'.
	aStream print: (self selectShellUse: [:item | true]) size.
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
ShellUse >> renderOn1: aRenderingContext [ 
	cItemUse do: [:aItemUse | aItemUse renderOn: aRenderingContext].
	aRenderingContext toTranscriptShowError
]

{ #category : #displaying }
ShellUse >> renderOn2: aRenderingContext [ 
	| aDummy |
	aDummy := cItemUse select: 
					[:aItemUse | 
					(aItemUse aSurface respondsTo: #cSingularity) 
						and: [aItemUse aSurface cSingularity isEmpty not]].
	aDummy do: [:aItemUse | aItemUse renderOn: aRenderingContext].
	aRenderingContext toTranscriptShowError
]

{ #category : #displaying }
ShellUse >> renderOn3: aRenderingContext [ 
	| aDummy |
	aDummy := cItemUse select: [:aItemUse | aItemUse aSurface name == #debug].
	aDummy do: [:aItemUse | aItemUse renderOn: aRenderingContext].
	aRenderingContext toTranscriptShowError
]

{ #category : #displaying }
ShellUse >> renderOn4: aRenderingContext [ 
	| aDummy |
	aDummy := cItemUse select: [:aItemUse | aItemUse aSurface name == #debug].
	aDummy isEmpty ifFalse: [(aDummy at: 1) renderOn: aRenderingContext].
	aDummy isEmpty ifFalse: [(aDummy at: 2) renderOn: aRenderingContext].
	aDummy isEmpty ifFalse: [(aDummy at: 3) renderOn: aRenderingContext].
	aRenderingContext toTranscriptShowError
]

{ #category : #displaying }
ShellUse >> renderOn5: aRenderingContext [ 
	(cItemUse at: 127) renderOn: aRenderingContext.
	aRenderingContext toTranscriptShowError
]

{ #category : #displaying }
ShellUse >> renderOn6: aRenderingContext [ 
	| n aItemUse |
	n := cItemUse size.
	1 to: n
		do: 
			[:i | 
			(i >= 1 and: [i <= 50]) 
				ifTrue: 
					[aItemUse := cItemUse at: i.
					aItemUse renderOn: aRenderingContext]].
	aRenderingContext toTranscriptShowError
]

{ #category : #displaying }
ShellUse >> renderOn: aRenderingContext [

	| debug |
	debug := false.
	debug
		ifTrue: 
			[self halt.
			(cItemUse at: 25) renderOn: aRenderingContext.
			(cItemUse at: 26) renderOn: aRenderingContext]
		ifFalse: [cItemUse do: [:aItemUse | aItemUse renderOn: aRenderingContext]].
	aRenderingContext toTranscriptShowError
]

{ #category : #enumerating }
ShellUse >> selectEdge: aBlock into: aSet [ 
	cItemUse do: [:each | each selectEdge: aBlock into: aSet]
]

{ #category : #enumerating }
ShellUse >> selectEdgeUse: aBlock into: aSet [ 
	cItemUse do: [:each | each selectEdgeUse: aBlock into: aSet]
]

{ #category : #enumerating }
ShellUse >> selectFace: aBlock into: aSet [ 
	cItemUse do: [:each | each selectFace: aBlock into: aSet]
]

{ #category : #enumerating }
ShellUse >> selectFaceUse: aBlock into: aSet [ 
	cItemUse do: [:each | each selectFaceUse: aBlock into: aSet]
]

{ #category : #enumerating }
ShellUse >> selectLoop: aBlock into: aSet [ 
	cItemUse do: [:each | each selectLoop: aBlock into: aSet]
]

{ #category : #enumerating }
ShellUse >> selectLoopUse: aBlock into: aSet [ 
	cItemUse do: [:each | each selectLoopUse: aBlock into: aSet]
]

{ #category : #enumerating }
ShellUse >> selectShell: aBlock into: aSet [ 
	aNMTItem selectShell: aBlock into: aSet
]

{ #category : #enumerating }
ShellUse >> selectShellUse: aBlock into: aSet [ 
	(aBlock value: self) ifTrue: [aSet add: self]
]

{ #category : #enumerating }
ShellUse >> selectVertex: aBlock into: aSet [ 
	cItemUse do: [:each | each selectVertex: aBlock into: aSet]
]

{ #category : #enumerating }
ShellUse >> selectVertexUse: aBlock into: aSet [ 
	cItemUse do: [:each | each selectVertexUse: aBlock into: aSet]
]
