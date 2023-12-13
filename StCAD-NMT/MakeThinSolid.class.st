Class {
	#name : #MakeThinSolid,
	#superclass : #CompositeOperator,
	#instVars : [
		'aSketchFaceUse',
		'newModel',
		'newTopFace',
		'newBottomFace'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Operator'
}

{ #category : #'instance creation' }
MakeThinSolid class >> aSketchFaceUse: aSketchFaceUse [ 
	| aMakeThinSolid |
	aMakeThinSolid := self new.
	aMakeThinSolid aSketchFaceUse: aSketchFaceUse.
	^aMakeThinSolid
]

{ #category : #'instance creation' }
MakeThinSolid class >> cPoint: crPPointP [ 
	| aMakeThinSolid |
	aMakeThinSolid := self new.
	aMakeThinSolid cPoint: crPPointP.
	^aMakeThinSolid
]

{ #category : #'VisualWorks metadata' }
MakeThinSolid class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
MakeThinSolid >> aSketchFaceUse [
	^aSketchFaceUse
]

{ #category : #accessing }
MakeThinSolid >> aSketchFaceUse: anObject [
	aSketchFaceUse := anObject
]

{ #category : #executing }
MakeThinSolid >> addBottomFaceGeometry [
	| aOutsideRegion insideBottomFaceUse |
	aOutsideRegion := newModel aOutsideRegion.
	insideBottomFaceUse := (newBottomFace 
				selectFaceUse: [:aFaceUse | aFaceUse aRegion ~= aOutsideRegion]) soleItem.
	self addGeometryToPositiveFaceUse: insideBottomFaceUse.
	insideBottomFaceUse aSurface name: #bottom
]

{ #category : #executing }
MakeThinSolid >> addBottomFaceUseGeometry [
	| aOutsideRegion outsideBottomFaceUse |
	aOutsideRegion := newModel aOutsideRegion.
	outsideBottomFaceUse := (newBottomFace 
				selectFaceUse: [:aFaceUse | aFaceUse aRegion == aOutsideRegion]) soleItem.
	self addGeometryToPositiveFaceUse: outsideBottomFaceUse mate
]

{ #category : #executing }
MakeThinSolid >> addFaceGeometry1 [
	| aRectSurface aRectSurfaceRefFrame aBoundingBox firstLoopUse |
	aRectSurface := RectSurface new.
	aRectSurfaceRefFrame := aRectSurface aRefFrame.
	aSketchFaceUse aSketchRefFrame addSub: aRectSurfaceRefFrame.
	aBoundingBox := aRectSurface aBoundingBox.
	firstLoopUse := aSketchFaceUse cLoopUse at: 1.
	firstLoopUse cEdgeUse 
		do: [:aEdgeUse | aBoundingBox expandToBound: aEdgeUse xyzOFu aBoundingBoxF].
	aRectSurfaceRefFrame rFfF at: 3 put: (aBoundingBox minCorner at: 3).
	aBoundingBox zeroZcoord.
	newTopFace aSurface: aRectSurface.
	newBottomFace aSurface: aRectSurface copy.
	self addTopFaceUseGeometry.
	self addBottomFaceUseGeometry
]

{ #category : #executing }
MakeThinSolid >> addGeometryToPositiveFaceUse1: positiveFaceUse [ 
	"The edgeuses in positiveFaceUse matches the ordering in cEdgeUse."

	| negativeFaceUse positivecEdgeUse aEdgeUse positiveEdgeUse negativeEdgeUse firstLoopUse cEdgeUse |
	negativeFaceUse := positiveFaceUse mate.
	positiveFaceUse isSameSense: true.
	negativeFaceUse isSameSense: false.
	"Code below applies to face with single loop only."
	"Multiple loop face is not yet inplemented."
	positivecEdgeUse := positiveFaceUse cLoopUse first cItemUse.
	firstLoopUse := aSketchFaceUse cLoopUse at: 1.
	cEdgeUse := firstLoopUse cEdgeUse.
	1 to: cEdgeUse size
		do: 
			[:i | 
			aEdgeUse := cEdgeUse at: i.
			positiveEdgeUse := positivecEdgeUse at: i.
			negativeEdgeUse := positiveEdgeUse mate.
			positiveEdgeUse isSameSense: aEdgeUse isSameSense.
			negativeEdgeUse isSameSense: aEdgeUse isSameSense not.
			positiveEdgeUse uvOFt: aEdgeUse uvOFt.
			negativeEdgeUse uvOFt: aEdgeUse uvOFt]
]

{ #category : #executing }
MakeThinSolid >> addGeometryToPositiveFaceUse: positiveFaceUse [ 
	"The geometry in positiveFaceUse is made to match those in sketchFaceUse."

	| aSketch aSurface firstLoopUse cEdgeUse firstSketchLoopUse cSketchEdgeUse |
	aSketch := aSketchFaceUse aSketch.
	aSurface := aSketchFaceUse aSurface copy.
	aSketch addSurface: aSurface.
	positiveFaceUse addPositiveSurface: aSurface.
	"Code below applies to face with single loop only."
	"Multiple loop face is not yet inplemented."
	firstLoopUse := positiveFaceUse cLoopUse first.
	cEdgeUse := firstLoopUse cEdgeUse.
	firstSketchLoopUse := aSketchFaceUse cLoopUse first.
	cSketchEdgeUse := firstSketchLoopUse cEdgeUse.
	1 to: cEdgeUse size
		do: [:i | (cEdgeUse at: i) addPositiveCurve: (cSketchEdgeUse at: i) uvOFt copy]
]

{ #category : #executing }
MakeThinSolid >> addTopFaceGeometry [
	| aOutsideRegion outsideTopFaceUse |
	aOutsideRegion := newModel aOutsideRegion.
	outsideTopFaceUse := (newTopFace 
				selectFaceUse: [:aFaceUse | aFaceUse aRegion == aOutsideRegion]) soleItem.
	self addGeometryToPositiveFaceUse: outsideTopFaceUse.
	outsideTopFaceUse aSurface name: #top
]

{ #category : #executing }
MakeThinSolid >> addTopFaceUseGeometry [
	| aOutsideRegion outsideTopFaceUse |
	aOutsideRegion := newModel aOutsideRegion.
	outsideTopFaceUse := (newTopFace 
				selectFaceUse: [:aFaceUse | aFaceUse aRegion == aOutsideRegion]) soleItem.
	self addGeometryToPositiveFaceUse: outsideTopFaceUse
]

{ #category : #executing }
MakeThinSolid >> execute [
	| nLoop |
	nLoop := aSketchFaceUse cLoopUse size.
	self executeFirstLoop.
	2 to: nLoop do: [:i | self executeLoop: i]
]

{ #category : #executing }
MakeThinSolid >> execute2 [
	| crSkVertexSk nPoint aOutsideRegion aMakeSV aVertex1 aMakeRSFL aFace1 fromVertex indexOfFirstMMakeEV aMMakeEV aMMakeEFL |
	crSkVertexSk := aSketchFaceUse crSkVertexSk.
	nPoint := crSkVertexSk size.
	aOutsideRegion := newModel aOutsideRegion.
	aMakeSV := MakeSV inRegion: aOutsideRegion
				aPoint: (crSkVertexSk at: 1) rSkPointSk.
	cOperator add: aMakeSV do.
	aVertex1 := aMakeSV newVertex.
	aMakeRSFL := MakeRSFL inRegion: aOutsideRegion aVertex: aVertex1.
	cOperator add: aMakeRSFL do.
	aFace1 := aMakeRSFL newFace.
	fromVertex := aVertex1.
	indexOfFirstMMakeEV := cOperator size + 1.
	1 to: nPoint - 1
		do: 
			[:i | 
			aMMakeEV := MMakeEV 
						inRegion: aOutsideRegion
						inFace: aFace1
						aEdge: nil
						fromVertex: fromVertex
						toPoint: (crSkVertexSk at: i + 1) rSkPointSk
						orient: nil.
			cOperator add: aMMakeEV do.
			fromVertex := aMMakeEV newVertex].
	aMMakeEFL := MMakeE 
				inRegion: aOutsideRegion
				inFace: aFace1
				aEdge: cOperator last newEdge
				aVertex: fromVertex
				orient: nil
				aEdge: (cOperator at: indexOfFirstMMakeEV) newEdge
				aVertex: aVertex1
				orient: nil.
	cOperator add: aMMakeEFL do.
	newTopFace := aMMakeEFL newFace.
	newBottomFace := aMMakeEFL aFace.
	self addFaceGeometry
]

{ #category : #executing }
MakeThinSolid >> executeFirstLoop [
	"This is the outer loop of a face."

	| firstLoopUse crSkVertexSk nPoint aOutsideRegion aMakeSV aVertex1 aMakeRSFL aFace1 fromVertex indexOfFirstMMakeEV aMMakeEV penultimateEdge firstEdge aMMakeEFL |
	firstLoopUse := aSketchFaceUse cLoopUse at: 1.
	crSkVertexSk := firstLoopUse cEdgeUse 
				collect: [:aEdgeUse | aEdgeUse aVertexUse rSkFacePointSk].
	nPoint := crSkVertexSk size.
	aOutsideRegion := newModel aOutsideRegion.
	aMakeSV := MakeSV inRegion: aOutsideRegion aPoint: (crSkVertexSk at: 1).
	cOperator add: aMakeSV do.
	aVertex1 := aMakeSV newVertex.
	aMakeRSFL := MakeRSFL inRegion: aOutsideRegion aVertex: aVertex1.
	cOperator add: aMakeRSFL do.
	aFace1 := aMakeRSFL newFace.
	fromVertex := aVertex1.
	indexOfFirstMMakeEV := cOperator size + 1.
	1 to: nPoint - 1
		do: 
			[:i | 
			aMMakeEV := MMakeEV 
						inRegion: aOutsideRegion
						inFace: aFace1
						aEdge: nil
						fromVertex: fromVertex
						toPoint: (crSkVertexSk at: i + 1)
						orient: nil.
			cOperator add: aMMakeEV do.
			fromVertex := aMMakeEV newVertex].
	nPoint == 1 
		ifTrue: 
			["Self loop"

			penultimateEdge := nil.
			firstEdge := nil]
		ifFalse: 
			[penultimateEdge := cOperator last newEdge.
			firstEdge := (cOperator at: indexOfFirstMMakeEV) newEdge].
	aMMakeEFL := MMakeE 
				inRegion: aOutsideRegion
				inFace: aFace1
				aEdge: penultimateEdge
				aVertex: fromVertex
				orient: nil
				aEdge: firstEdge
				aVertex: aVertex1
				orient: nil.
	cOperator add: aMMakeEFL do.
	newTopFace := aMMakeEFL newFace.
	newBottomFace := aMMakeEFL aFace.
	self addTopFaceGeometry.
	self addBottomFaceGeometry
]

{ #category : #executing }
MakeThinSolid >> executeFirstLoop1 [
	"This is the outer loop of a face."

	| crSkVertexSk nPoint aOutsideRegion aMakeSV aVertex1 aMakeRSFL aFace1 fromVertex indexOfFirstMMakeEV aMMakeEV aMMakeEFL firstLoopUse |
	firstLoopUse := aSketchFaceUse cLoopUse at: 1.
	crSkVertexSk := firstLoopUse cEdgeUse 
				collect: [:aEdgeUse | aEdgeUse aVertexUse rSkFacePointSk].
	nPoint := crSkVertexSk size.
	aOutsideRegion := newModel aOutsideRegion.
	aMakeSV := MakeSV inRegion: aOutsideRegion aPoint: (crSkVertexSk at: 1).
	cOperator add: aMakeSV do.
	aVertex1 := aMakeSV newVertex.
	aMakeRSFL := MakeRSFL inRegion: aOutsideRegion aVertex: aVertex1.
	cOperator add: aMakeRSFL do.
	aFace1 := aMakeRSFL newFace.
	fromVertex := aVertex1.
	indexOfFirstMMakeEV := cOperator size + 1.
	1 to: nPoint - 1
		do: 
			[:i | 
			aMMakeEV := MMakeEV 
						inRegion: aOutsideRegion
						inFace: aFace1
						aEdge: nil
						fromVertex: fromVertex
						toPoint: (crSkVertexSk at: i + 1)
						orient: nil.
			cOperator add: aMMakeEV do.
			fromVertex := aMMakeEV newVertex].
	aMMakeEFL := MMakeE 
				inRegion: aOutsideRegion
				inFace: aFace1
				aEdge: cOperator last newEdge
				aVertex: fromVertex
				orient: nil
				aEdge: (cOperator at: indexOfFirstMMakeEV) newEdge
				aVertex: aVertex1
				orient: nil.
	cOperator add: aMMakeEFL do.
	newTopFace := aMMakeEFL newFace.
	newBottomFace := aMMakeEFL aFace.
	self addTopFaceGeometry.
	self addBottomFaceGeometry
]

{ #category : #'initialize-release' }
MakeThinSolid >> initialize [

	super initialize.
	newModel := StCAD_NMT_Model new "VW_TRANSLATION:StCAD.NMT.Model:StCAD_NMT_Model"
]

{ #category : #accessing }
MakeThinSolid >> newBottomFace [
	^newBottomFace
]

{ #category : #accessing }
MakeThinSolid >> newBottomFace: anObject [
	newBottomFace := anObject
]

{ #category : #accessing }
MakeThinSolid >> newModel [
	^newModel
]

{ #category : #accessing }
MakeThinSolid >> newModel: anObject [
	newModel := anObject
]

{ #category : #accessing }
MakeThinSolid >> newTopFace [
	^newTopFace
]

{ #category : #accessing }
MakeThinSolid >> newTopFace: anObject [
	newTopFace := anObject
]
