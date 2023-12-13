Class {
	#name : #MMakeEFL,
	#superclass : #MMakeE,
	#instVars : [
		'newLoop',
		'newFace'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Operator'
}

{ #category : #'VisualWorks metadata' }
MMakeEFL class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #executing }
MMakeEFL >> collectEdgeUseIn: argcEdgeUse betweenVertex: argVertex1 andVertex: argVertex2 [ 
	"
	To do:
	Account for repeated use of vertex in loop.
	"

	| index1 index2 |
	index1 := argcEdgeUse 
				findFirst: [:aEdgeUse | aEdgeUse includesVertex: argVertex1].
	index2 := argcEdgeUse 
				findFirst: [:aEdgeUse | aEdgeUse includesVertex: argVertex2].
	(index1 == 0 or: [index2 == 0]) 
		ifTrue: [self error: 'Vertex not in loop.'].
	^index1 == index2 
		ifTrue: [argcEdgeUse species withSize: 0]
		ifFalse: 
			[index2 := index2 - 1.
			index2 == 0 ifTrue: [index2 := argcEdgeUse size].
			argcEdgeUse copyWrapFrom: index1 to: index2]
]

{ #category : #executing }
MMakeEFL >> createNormalFace [
	"
	To do:
	Account for holes.
	"

	| aModel oldFaceUse oldLoopUse cEdgeUse1 cEdgeUse2 newFaceUse newLoopUse newEdgeUse12 newEdgeUse21 otherOldFaceUse otherOldLoopUse otherNewFaceUse otherNewLoopUse otherNewEdgeUse21 otherNewEdgeUse12 cEdgeUse |
	aModel := aRegion aModel.
	newFace := aModel newFace.
	newLoop := aModel newLoop.
	newEdge := aModel 
				newEdgeWith: aVertex1
				and: aVertex2
				aCurve: aCurve.

	"Processing side facing aRegion."
	oldFaceUse := (aFace 
				selectFaceUse: [:aFaceUse | aFaceUse aRegion == aRegion]) soleItem.
	oldLoopUse := (oldFaceUse selectLoopUse: 
					[:aLoopUse | 
					(aLoopUse includesVertex: aVertex1) 
						and: [aLoopUse includesVertex: aVertex2]]) 
				soleItem.
	cEdgeUse := oldLoopUse cItemUse.
	cEdgeUse1 := self 
				collectEdgeUseIn: cEdgeUse
				betweenVertex: aVertex2
				andVertex: aVertex1.
	cEdgeUse2 := self 
				collectEdgeUseIn: cEdgeUse
				betweenVertex: aVertex1
				andVertex: aVertex2.
	newFaceUse := newFace newUse.
	oldFaceUse aShellUse addFaceUse: newFaceUse.
	newLoopUse := newLoop newUse.
	newFaceUse addLoopUse: newLoopUse.
	cEdgeUse1 do: [:aEdgeUse | newLoopUse addEdgeUse: aEdgeUse].
	newEdgeUse12 := newEdge newUse.
	newEdgeUse12 aVertexUse: aVertex1 newUse.
	newLoopUse addEdgeUse: newEdgeUse12.	"new faceuse and loopuse in aRegion is complete."
	oldLoopUse emptySelf.
	newEdgeUse21 := newEdge newUse.
	newEdgeUse21 aVertexUse: aVertex2 newUse.
	newEdgeUse12 radial: newEdgeUse21.
	oldLoopUse addEdgeUse: newEdgeUse21.
	cEdgeUse2 do: [:aEdgeUse | oldLoopUse addEdgeUse: aEdgeUse].	"old faceuse and loopuse in aRegion is complete."

	"Processing side facing otherRegion."
	otherOldFaceUse := oldFaceUse mate.
	otherOldLoopUse := oldLoopUse mate.
	cEdgeUse := otherOldLoopUse cItemUse.
	cEdgeUse1 := self 
				collectEdgeUseIn: cEdgeUse
				betweenVertex: aVertex1
				andVertex: aVertex2.
	cEdgeUse2 := self 
				collectEdgeUseIn: cEdgeUse
				betweenVertex: aVertex2
				andVertex: aVertex1.
	otherNewFaceUse := newFace newUse.
	otherOldFaceUse aShellUse addFaceUse: otherNewFaceUse.
	otherNewLoopUse := newLoop newUse.
	otherNewFaceUse addLoopUse: otherNewLoopUse.
	otherNewEdgeUse21 := newEdge newUse.
	otherNewEdgeUse21 aVertexUse: aVertex2 newUse.
	otherNewLoopUse addEdgeUse: otherNewEdgeUse21.
	cEdgeUse1 do: [:aEdgeUse | otherNewLoopUse addEdgeUse: aEdgeUse].	"otherNew faceuse and loopuse in aRegion is complete."
	otherOldLoopUse emptySelf.
	cEdgeUse2 do: [:aEdgeUse | otherOldLoopUse addEdgeUse: aEdgeUse].
	otherNewEdgeUse12 := newEdge newUse.
	otherNewEdgeUse12 aVertexUse: aVertex1 newUse.
	otherNewEdgeUse12 radial: otherNewEdgeUse21.
	otherOldLoopUse addEdgeUse: otherNewEdgeUse12.	"otherOld faceuse and loopuse in aRegion is complete."
	newEdgeUse12 mate: otherNewEdgeUse21.
	newEdgeUse21 mate: otherNewEdgeUse12.
	newLoopUse mate: otherNewLoopUse.
	newFaceUse mate: otherNewFaceUse
]

{ #category : #executing }
MMakeEFL >> createSelfLoopFace [

	"
	To do:
	Account for holes.
	"

	| aModel oldFaceUse oldLoopUse cEdgeUse1 cEdgeUse2 newFaceUse newLoopUse newEdgeUse12 newEdgeUse21 otherOldFaceUse otherOldLoopUse otherNewFaceUse otherNewLoopUse otherNewEdgeUse21 otherNewEdgeUse12 cEdgeUse index2 index1 |
	aModel := aRegion aModel.
	newFace := aModel newFace.
	newLoop := aModel newLoop.
	newEdge := aModel newEdgeWith: aVertex1 and: aVertex2 aCurve: aCurve.

	"Processing side facing aRegion."
	oldFaceUse := (aFace selectFaceUse: [ :aFaceUse | 
		               aFaceUse aRegion == aRegion ]) soleItem.
	oldLoopUse := (oldFaceUse selectLoopUse: [ :aLoopUse | 
		               (aLoopUse includesVertex: aVertex1) and: [ 
			               aLoopUse includesVertex: aVertex2 ] ]) soleItem.
	oldLoopUse isVertexLoop
		ifTrue: [ 
			cEdgeUse1 := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
			cEdgeUse2 := StCAD_Misc_OrderedSet new ]
		ifFalse: [ 
			cEdgeUse := oldLoopUse cItemUse.
			index2 := cEdgeUse findFirst: [ :aEdgeUse | 
				          aEdgeUse includesVertex: aVertex2 ].
			index1 := index2 - 1.
			index1 == 0 ifTrue: [ index1 := cEdgeUse size ].
			cEdgeUse1 := cEdgeUse copyWrapFrom: index2 to: index1.
			cEdgeUse2 := StCAD_Misc_OrderedSet new ].
	newFaceUse := newFace newUse.
	oldFaceUse aShellUse addFaceUse: newFaceUse.
	newLoopUse := newLoop newUse.
	newFaceUse addLoopUse: newLoopUse.
	cEdgeUse1 do: [ :aEdgeUse | newLoopUse addEdgeUse: aEdgeUse ].
	newEdgeUse12 := newEdge newUse.
	newEdgeUse12 aVertexUse: aVertex1 newUse.
	newLoopUse addEdgeUse: newEdgeUse12. "new faceuse and loopuse in aRegion is complete."
	oldLoopUse emptySelf.
	newEdgeUse21 := newEdge newUse.
	newEdgeUse21 aVertexUse: aVertex2 newUse.
	newEdgeUse12 radial: newEdgeUse21.
	oldLoopUse addEdgeUse: newEdgeUse21.
	cEdgeUse2 do: [ :aEdgeUse | oldLoopUse addEdgeUse: aEdgeUse ]. "old faceuse and loopuse in aRegion is complete."

	"Processing side facing otherRegion."
	otherOldFaceUse := oldFaceUse mate.
	otherOldLoopUse := oldLoopUse mate.
	otherOldLoopUse isVertexLoop
		ifTrue: [ 
			cEdgeUse1 := StCAD_Misc_OrderedSet new.
			cEdgeUse2 := StCAD_Misc_OrderedSet new ]
		ifFalse: [ 
			cEdgeUse := otherOldLoopUse cItemUse.
			index1 := cEdgeUse findFirst: [ :aEdgeUse | 
				          aEdgeUse includesVertex: aVertex1 ].
			index2 := index1 - 1.
			index2 == 0 ifTrue: [ index2 := cEdgeUse size ].
			cEdgeUse1 := cEdgeUse copyWrapFrom: index1 to: index2.
			cEdgeUse2 := StCAD_Misc_OrderedSet new ].
	otherNewFaceUse := newFace newUse.
	otherOldFaceUse aShellUse addFaceUse: otherNewFaceUse.
	otherNewLoopUse := newLoop newUse.
	otherNewFaceUse addLoopUse: otherNewLoopUse.
	otherNewEdgeUse21 := newEdge newUse.
	otherNewEdgeUse21 aVertexUse: aVertex2 newUse.
	otherNewLoopUse addEdgeUse: otherNewEdgeUse21.
	cEdgeUse1 do: [ :aEdgeUse | otherNewLoopUse addEdgeUse: aEdgeUse ]. "otherNew faceuse and loopuse in aRegion is complete."
	otherOldLoopUse emptySelf.
	cEdgeUse2 do: [ :aEdgeUse | otherOldLoopUse addEdgeUse: aEdgeUse ].
	otherNewEdgeUse12 := newEdge newUse.
	otherNewEdgeUse12 aVertexUse: aVertex1 newUse.
	otherNewEdgeUse12 radial: otherNewEdgeUse21.
	otherOldLoopUse addEdgeUse: otherNewEdgeUse12. "otherOld faceuse and loopuse in aRegion is complete."
	newEdgeUse12 mate: otherNewEdgeUse21.
	newEdgeUse21 mate: otherNewEdgeUse12.
	newLoopUse mate: otherNewLoopUse.
	newFaceUse mate: otherNewFaceUse
]

{ #category : #executing }
MMakeEFL >> execute [
	"
	To do:
	Account for holes.
	"

	aVertex1 == aVertex2 
		ifTrue: [self createSelfLoopFace]
		ifFalse: [self createNormalFace]
]

{ #category : #accessing }
MMakeEFL >> newFace [
	^newFace
]

{ #category : #accessing }
MMakeEFL >> newFace: anObject [
	newFace := anObject
]
