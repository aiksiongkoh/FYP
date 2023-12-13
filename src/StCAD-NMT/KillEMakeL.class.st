Class {
	#name : #KillEMakeL,
	#superclass : #KillE,
	#instVars : [
		'aLoop',
		'newLoop'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Operator'
}

{ #category : #accessing }
KillEMakeL class >> aEdge: aEdge [ 
	^(super new)
		aEdge: aEdge;
		yourself
]

{ #category : #'VisualWorks metadata' }
KillEMakeL class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
KillEMakeL >> aLoop [
	^aLoop
]

{ #category : #accessing }
KillEMakeL >> aLoop: anObject [
	aLoop := anObject
]

{ #category : #accessing }
KillEMakeL >> breakLoopUse: aLoopUse [

	| cEdgeUse newLoopUse cIndex |
	cEdgeUse := aLoopUse cEdgeUse.
	aLoopUse cItemUse: StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	newLoopUse := newLoop newUse.
	cIndex := OrderedCollection new.
	1 to: cEdgeUse size do: [ :i | 
	(cEdgeUse at: i) aEdge == aEdge ifTrue: [ cIndex add: i ] ].
	self assert: [ cIndex size == 2 ].
	1 to: cIndex first - 1 do: [ :i | 
	aLoopUse addEdgeUse: (cEdgeUse at: i) ].
	cIndex last + 1 to: cEdgeUse size do: [ :i | 
	aLoopUse addEdgeUse: (cEdgeUse at: i) ].
	cIndex first + 1 to: cIndex last - 1 do: [ :i | 
	newLoopUse addEdgeUse: (cEdgeUse at: i) ].
	aLoopUse aFaceUse addLoopUse: newLoopUse.
	cIndex do: [ :aIndex | (cEdgeUse at: aIndex) die ]
]

{ #category : #accessing }
KillEMakeL >> execute [

	| aFace aModel aLoopUse |
	self assert: [aEdge cUse size = 4].
	self assert: 
			[aFace := aEdge cUse first aFace.
			aEdge cUse allSatisfy: [:aEdgeUse | aEdgeUse aFace = aFace]].
	aLoop := aEdge cUse first aLoop.
	aModel := aEdge aModel.
	newLoop := aModel newLoop.
	aLoopUse := aLoop cUse first.
	self breakLoopUse: aLoopUse.
	self breakLoopUse: aLoopUse mate.
	newLoop cUse first mate: newLoop cUse last
]

{ #category : #accessing }
KillEMakeL >> newLoop [
	^newLoop
]

{ #category : #accessing }
KillEMakeL >> newLoop: anObject [
	newLoop := anObject
]
