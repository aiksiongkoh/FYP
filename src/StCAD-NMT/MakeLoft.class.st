Class {
	#name : #MakeLoft,
	#superclass : #CompositeOperator,
	#instVars : [
		'aRegion',
		'aFace',
		'cTopPoint',
		'cNewSideFace'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Operator'
}

{ #category : #'instance creation' }
MakeLoft class >> inRegion: aRegion onFace: aFace cTopPoint: cTopPoint [ 
	| aMakeLoft |
	aMakeLoft := self new.
	aMakeLoft aRegion: aRegion.
	aMakeLoft aFace: aFace.
	aMakeLoft cTopPoint: cTopPoint.
	^aMakeLoft
]

{ #category : #'VisualWorks metadata' }
MakeLoft class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
MakeLoft >> aFace [
	^aFace
]

{ #category : #accessing }
MakeLoft >> aFace: anObject [
	aFace := anObject
]

{ #category : #accessing }
MakeLoft >> aRegion [
	^aRegion
]

{ #category : #accessing }
MakeLoft >> aRegion: anObject [
	aRegion := anObject
]

{ #category : #accessing }
MakeLoft >> cTopPoint [
	^cTopPoint
]

{ #category : #accessing }
MakeLoft >> cTopPoint: anObject [
	cTopPoint := anObject
]

{ #category : #executing }
MakeLoft >> execute [
	| nPoint oldFaceUse oldLoopUse cVertex cTopVertex cUpEdge aMMakeEV1 aMMakeEV2 aMMakeEFL |
	nPoint := cTopPoint size - 1.	"Since first and last points are indentical."
	oldFaceUse := (aFace 
				selectFaceUse: [:aFaceUse | aFaceUse aRegion == aRegion]) soleItem.
	oldLoopUse := (oldFaceUse selectLoopUse: [:aLoopUse | true]) soleItem.
	cVertex := oldLoopUse selectVertex: [:aVertex | true].
	cTopVertex := cVertex copyEmpty.
	cUpEdge := cVertex copyEmpty.

	"Make up edge."
	aMMakeEV1 := MMakeEV 
				inRegion: aRegion
				inFace: aFace
				aEdge: nil
				fromVertex: (cVertex at: 2)
				toPoint: (cTopPoint at: 2)
				orient: nil.
	cOperator add: aMMakeEV1 do.
	cTopVertex add: aMMakeEV1 newVertex.
	cUpEdge add: aMMakeEV1 newEdge.

	"Make top level edge."
	aMMakeEV2 := MMakeEV 
				inRegion: aRegion
				inFace: aFace
				aEdge: nil
				fromVertex: aMMakeEV1 newVertex
				toPoint: (cTopPoint at: 1)
				orient: nil.
	cOperator add: aMMakeEV2 do.
	cTopVertex addFirst: aMMakeEV2 newVertex.

	"Make down edge to create a new face."
	aMMakeEFL := MMakeE 
				inRegion: aRegion
				inFace: aFace
				aEdge: aMMakeEV2 newEdge
				aVertex: aMMakeEV2 newVertex
				orient: nil
				aEdge: (oldLoopUse aEdgeAt: 1)
				aVertex: (cVertex at: 1)
				orient: nil.
	cOperator add: aMMakeEFL do.
	cUpEdge addFirst: aMMakeEFL newEdge.
	cNewSideFace add: aMMakeEFL newFace.
	2 to: nPoint - 1
		do: 
			[:i | 
			"Make up edge."

			aMMakeEV1 := MMakeEV 
						inRegion: aRegion
						inFace: aFace
						aEdge: nil
						fromVertex: (cVertex at: i + 1)
						toPoint: (cTopPoint at: i + 1)
						orient: nil.
			cOperator add: aMMakeEV1 do.
			cTopVertex add: aMMakeEV1 newVertex.
			cUpEdge add: aMMakeEV1 newEdge.

			"Make top level edge to create a new face."
			aMMakeEFL := MMakeE 
						inRegion: aRegion
						inFace: aFace
						aEdge: (cUpEdge at: i + 1)
						aVertex: (cTopVertex at: i + 1)
						orient: nil
						aEdge: (cUpEdge at: i)
						aVertex: (cTopVertex at: i)
						orient: nil.
			cOperator add: aMMakeEFL do.
			cNewSideFace add: aMMakeEFL newFace].

	"Make top level edge to create the last new face."
	aMMakeEFL := MMakeE 
				inRegion: aRegion
				inFace: aFace
				aEdge: (cUpEdge at: nPoint)
				aVertex: (cTopVertex at: nPoint)
				orient: nil
				aEdge: (cUpEdge at: 1)
				aVertex: (cTopVertex at: 1)
				orient: nil.
	cOperator add: aMMakeEFL do.
	cNewSideFace add: aMMakeEFL newFace
]

{ #category : #'initialize-release' }
MakeLoft >> initialize [

	super initialize.
	cNewSideFace := StCAD_Misc_OrderedSet new "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
]
