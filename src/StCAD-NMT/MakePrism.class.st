Class {
	#name : #MakePrism,
	#superclass : #CompositeOperator,
	#instVars : [
		'aSketchFaceUse',
		'zStart',
		'zEnd',
		'newModel',
		'aOutsideRegion',
		'newTopFace',
		'newBottomFace',
		'cNewSideFace'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Operator'
}

{ #category : #'VisualWorks metadata' }
MakePrism class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
MakePrism >> aSketchFaceUse [
	^aSketchFaceUse
]

{ #category : #accessing }
MakePrism >> aSketchFaceUse: anObject [
	aSketchFaceUse := anObject
]

{ #category : #executing }
MakePrism >> addFaceGeometry [
	self addSideFaceGeometry.
	self modifyTopFaceGeometry
]

{ #category : #executing }
MakePrism >> addSideFaceGeometry [
	| outsideNewSideFaceUse firstLoopUse cEdgeUse firstEdgeUse |
	cNewSideFace do: 
			[:aNewSideFace | 
			outsideNewSideFaceUse := (aNewSideFace 
						selectFaceUse: [:aFaceUse | aFaceUse aRegion == aOutsideRegion]) soleItem.
			firstLoopUse := outsideNewSideFaceUse cLoopUse first.
			cEdgeUse := firstLoopUse cEdgeUse.
			firstEdgeUse := cEdgeUse first.
			self addSweepWithEdgeUse: firstEdgeUse.
			self addcSideLineWithcEdgeUse: cEdgeUse]
]

{ #category : #executing }
MakePrism >> addSideFaceGeometry1 [
	| aSketchRefFrame outsideNewSideFaceUse firstLoopUse cEdgeUse firstEdgeUse firstCurve aRectSurface aRectSurfaceRefFrame rSkoriginSk rSkxPointSk rSkyPointSk origin corner uvOFt |
	aSketchRefFrame := aSketchFaceUse aSketchRefFrame.
	cNewSideFace do: 
			[:aNewSideFace | 
			outsideNewSideFaceUse := (aNewSideFace 
						selectFaceUse: [:aFaceUse | aFaceUse aRegion == aOutsideRegion]) soleItem.
			firstLoopUse := outsideNewSideFaceUse cLoopUse first.
			cEdgeUse := firstLoopUse cEdgeUse.
			firstEdgeUse := cEdgeUse first.
			firstCurve := firstEdgeUse xyzOFu.
			(firstCurve isMemberOf: Line) 
				ifTrue: 
					[aRectSurface := RectSurface new.
					aRectSurfaceRefFrame := aRectSurface aRefFrame.
					aSketchRefFrame addSub: aRectSurfaceRefFrame.
					rSkoriginSk := firstEdgeUse aStartPoint.
					rSkxPointSk := firstEdgeUse aEndPoint.
					rSkyPointSk := (rSkoriginSk copy)
								at: 3 put: zEnd - zStart;
								yourself.
					aRectSurfaceRefFrame 
						rFfF: rSkoriginSk
						xPoint: rSkxPointSk
						yPoint: rSkyPointSk.
					origin := FullColumn zero: 3.
					corner := FullColumn 
								with: (rSkxPointSk - rSkoriginSk) length
								with: zEnd - zStart
								with: 0.0d.
					aRectSurface aBoundingBox: (BoundingBox origin: origin corner: corner).
					outsideNewSideFaceUse addPositiveSurface: aRectSurface.
					"Code below applies to face with single loop only."
					"Multiple loop face is not yet inplemented."
					uvOFt := Line new.
					aSketchRefFrame addSub: uvOFt aRefFrame.
					uvOFt rfstartf: (FullColumn zero: 2).
					uvOFt 
						rfendf: (FullColumn with: (rSkxPointSk - rSkoriginSk) length with: 0.0d).
					uvOFt calc.
					uvOFt privateCalcBoundingBox.
					firstEdgeUse addPositiveCurve: uvOFt]
				ifFalse: [(firstCurve isMemberOf: EllipticalArc) ifTrue: []]]
]

{ #category : #executing }
MakePrism >> addSideFaceGeometry2 [
	| outsideNewSideFaceUse firstLoopUse cEdgeUse firstEdgeUse firstCurve |
	cNewSideFace do: 
			[:aNewSideFace | 
			outsideNewSideFaceUse := (aNewSideFace 
						selectFaceUse: [:aFaceUse | aFaceUse aRegion == aOutsideRegion]) soleItem.
			firstLoopUse := outsideNewSideFaceUse cLoopUse first.
			cEdgeUse := firstLoopUse cEdgeUse.
			firstEdgeUse := cEdgeUse first.
			firstCurve := firstEdgeUse xyzOFu.
			(firstCurve isMemberOf: Line) 
				ifTrue: 
					[self addSideRectSurfaceWithEdgeUse: firstEdgeUse.
					self addcSideLineWithcEdgeUse: cEdgeUse]
				ifFalse: 
					[(firstCurve isMemberOf: EllipticArc) ifTrue: [self notYetImplemented]]]
]

{ #category : #executing }
MakePrism >> addSideRectSurfaceWithEdgeUse: aEdgeUse [ 
	| aRectSurface rSkoriginSk rSkxPointSk rSkyPointSk origin corner |
	aRectSurface := RectSurface new.
	aSketchFaceUse aSketch addSurface: aRectSurface.
	rSkoriginSk := aEdgeUse aStartPoint.
	rSkxPointSk := aEdgeUse aEndPoint.
	rSkyPointSk := (rSkoriginSk copy)
				at: 3 put: zEnd - zStart;
				yourself.
	aRectSurface aRefFrame 
		rFfF: rSkoriginSk
		xPoint: rSkxPointSk
		yPoint: rSkyPointSk.
	origin := FullColumn zero: 3.
	corner := FullColumn 
				with: (rSkxPointSk - rSkoriginSk) length
				with: zEnd - zStart
				with: 0.0d.
	aRectSurface aBoundingBox: (BoundingBox origin: origin corner: corner).
	aEdgeUse aFaceUse addPositiveSurface: aRectSurface
]

{ #category : #executing }
MakePrism >> addSweepWithEdgeUse: aEdgeUse [ 
	| aSweep aSketch trajectory |
	aSweep := Sweep new.
	aSketch := aSketchFaceUse aSketch.
	aSketch addSurface: aSweep.
	aSweep _aCurve: aEdgeUse aCurve copy.
	trajectory := (Line new)
				rfstartf: (FullColumn 
							with: 0.0d
							with: 0.0d
							with: zStart);
				rfendf: (FullColumn 
							with: 0.0d
							with: 0.0d
							with: zEnd);
				calc;
				privateCalcBoundingBox;
				yourself.
	aSweep _trajectory: trajectory.
	aSweep calc.
	aSweep privateCalcBoundingBox.
	aEdgeUse aFaceUse addPositiveSurface: aSweep
]

{ #category : #executing }
MakePrism >> addcSideLineWithcEdgeUse1: cEdgeUse [

	"Code below applies to face with single loop only."

	"Multiple loop face is not yet inplemented."

	| aSketchRefFrame firstEdgeUse rSkoriginSk rSkxPointSk xLength yLength aRectangle crfpointf |
	aSketchRefFrame := aSketchFaceUse aSketchRefFrame.
	firstEdgeUse := cEdgeUse first.
	rSkoriginSk := firstEdgeUse aStartPoint.
	rSkxPointSk := firstEdgeUse aEndPoint.
	xLength := (rSkxPointSk - rSkoriginSk) length.
	yLength := zEnd - zStart.
	aRectangle := StCAD_Geo_Rectangle xLength: xLength yLength: yLength. "VW_TRANSLATION:StCAD.Geo.Rectangle:StCAD_Geo_Rectangle"
	crfpointf := aRectangle rfpointsf.
	1 to: 4 do: [ :i | 
		| uvOFt |
		uvOFt := Line new.
		aSketchRefFrame addSub: uvOFt aRefFrame.
		uvOFt rfstartf: (crfpointf at: i) copy.
		uvOFt rfendf: (crfpointf at: i + 1) copy.
		uvOFt calc.
		uvOFt privateCalcBoundingBox.
		(cEdgeUse at: i) addPositiveCurve: uvOFt ]
]

{ #category : #executing }
MakePrism >> addcSideLineWithcEdgeUse: cEdgeUse [

	"Code below applies to face with single loop only."

	"Multiple loop face is not yet inplemented."

	| aRectangle crfpointf |
	aRectangle := StCAD_Geo_Rectangle xLength: 1.0 d yLength: 1.0 d. "VW_TRANSLATION:StCAD.Geo.Rectangle:StCAD_Geo_Rectangle"
	crfpointf := aRectangle rfpointsf.
	1 to: 4 do: [ :i | 
		| uvOFt |
		uvOFt := Line new.
		uvOFt rfstartf: (crfpointf at: i) copy.
		uvOFt rfendf: (crfpointf at: i + 1) copy.
		(cEdgeUse at: i) addPositiveCurve: uvOFt ]
]

{ #category : #accessing }
MakePrism >> cOperator [
	^cOperator
]

{ #category : #accessing }
MakePrism >> cOperator: anObject [
	cOperator := anObject
]

{ #category : #executing }
MakePrism >> execute [
	| bottomSketchFaceUse aMakeThinSolid |
	bottomSketchFaceUse := aSketchFaceUse copy.
	bottomSketchFaceUse aSurface aRefFrame rFfF at: 3 put: zStart.
	aMakeThinSolid := MakeThinSolid aSketchFaceUse: bottomSketchFaceUse.
	aMakeThinSolid do.
	newModel := aMakeThinSolid newModel.
	aOutsideRegion := newModel aOutsideRegion.
	newTopFace := aMakeThinSolid newTopFace.
	newBottomFace := aMakeThinSolid newBottomFace.
	cOperator add: aMakeThinSolid.
	self extrude
]

{ #category : #executing }
MakePrism >> extrude [
	| nLoop |
	nLoop := aSketchFaceUse cLoopUse size.
	self extrudeFirstLoop.
	2 to: nLoop do: [:i | self extrudeLoop: i]
]

{ #category : #executing }
MakePrism >> extrudeFirstLoop [
	(aSketchFaceUse cLoopUse at: 1) isSelfLoop 
		ifTrue: [self extrudeFirstSelfLoop]
		ifFalse: [self extrudeFirstNormalLoop]
]

{ #category : #executing }
MakePrism >> extrudeFirstNormalLoop [

	| topSketchFaceUse firstLoopUse cTopPoint nPoint oldFaceUse oldLoopUse cVertex cTopVertex cUpEdge aMMakeEV1 aMMakeEV2 aMMakeEFL aNewSideFace |
	topSketchFaceUse := aSketchFaceUse copy.
	topSketchFaceUse aSurface aRefFrame rFfF at: 3 put: zEnd.
	firstLoopUse := topSketchFaceUse cLoopUse at: 1.
	cTopPoint := firstLoopUse cEdgeUse collect: [ :aEdgeUse | 
		             aEdgeUse aVertexUse rSkFacePointSk ].
	nPoint := cTopPoint size.
	oldFaceUse := (newTopFace selectFaceUse: [ :argaFaceUse | 
		               argaFaceUse aRegion == aOutsideRegion ]) soleItem.
	oldLoopUse := (oldFaceUse selectLoopUse: [ :aLoopUse | true ])
		              soleItem.
	cVertex := oldLoopUse selectVertex: [ :aVertex | true ].
	cTopVertex := cVertex copyEmpty.
	cUpEdge := cVertex copyEmpty.
	cNewSideFace := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"

	"Make up edge."
	aMMakeEV1 := MMakeEV
		             inRegion: aOutsideRegion
		             inFace: newTopFace
		             aEdge: nil
		             fromVertex: (cVertex at: 2)
		             toPoint: (cTopPoint at: 2)
		             orient: nil.
	cOperator add: aMMakeEV1 do.
	cTopVertex add: aMMakeEV1 newVertex.
	cUpEdge add: aMMakeEV1 newEdge.

	"Make top level edge."
	aMMakeEV2 := MMakeEV
		             inRegion: aOutsideRegion
		             inFace: newTopFace
		             aEdge: nil
		             fromVertex: aMMakeEV1 newVertex
		             toPoint: (cTopPoint at: 1)
		             orient: nil.
	cOperator add: aMMakeEV2 do.
	cTopVertex addFirst: aMMakeEV2 newVertex.

	"Make down edge to create a new face."
	aMMakeEFL := MMakeE
		             inRegion: aOutsideRegion
		             inFace: newTopFace
		             aEdge: aMMakeEV2 newEdge
		             aVertex: aMMakeEV2 newVertex
		             orient: nil
		             aEdge: (oldLoopUse aEdgeAt: 1)
		             aVertex: (cVertex at: 1)
		             orient: nil.
	cOperator add: aMMakeEFL do.
	cUpEdge addFirst: aMMakeEFL newEdge.
	aNewSideFace := aMMakeEFL newFace.
	aNewSideFace startFirstLoopAtVertex: (cVertex at: 1).
	cNewSideFace add: aNewSideFace.
	2 to: nPoint - 1 do: [ :i | "Make up edge."
		aMMakeEV1 := MMakeEV
			             inRegion: aOutsideRegion
			             inFace: newTopFace
			             aEdge: nil
			             fromVertex: (cVertex at: i + 1)
			             toPoint: (cTopPoint at: i + 1)
			             orient: nil.
		cOperator add: aMMakeEV1 do.
		cTopVertex add: aMMakeEV1 newVertex.
		cUpEdge add: aMMakeEV1 newEdge.

		"Make top level edge to create a new face."
		aMMakeEFL := MMakeE
			             inRegion: aOutsideRegion
			             inFace: newTopFace
			             aEdge: (cUpEdge at: i + 1)
			             aVertex: (cTopVertex at: i + 1)
			             orient: nil
			             aEdge: (cUpEdge at: i)
			             aVertex: (cTopVertex at: i)
			             orient: nil.
		cOperator add: aMMakeEFL do.
		aNewSideFace := aMMakeEFL newFace.
		aNewSideFace startFirstLoopAtVertex: (cVertex at: i).
		cNewSideFace add: aNewSideFace ].

	"Make top level edge to create the last new face."
	aMMakeEFL := MMakeE
		             inRegion: aOutsideRegion
		             inFace: newTopFace
		             aEdge: (cUpEdge at: 1)
		             aVertex: (cTopVertex at: 1)
		             orient: nil
		             aEdge: (cUpEdge at: nPoint)
		             aVertex: (cTopVertex at: nPoint)
		             orient: nil.
	cOperator add: aMMakeEFL do.
	aNewSideFace := aMMakeEFL newFace.
	aNewSideFace startFirstLoopAtVertex: (cVertex at: nPoint).
	cNewSideFace add: aNewSideFace.
	newTopFace startFirstLoopAtVertex: (cTopVertex at: 1).
	self addFaceGeometry
]

{ #category : #executing }
MakePrism >> extrudeFirstSelfLoop [

	| topSketchFaceUse firstLoopUse cTopPoint oldFaceUse oldLoopUse cVertex cTopVertex cUpEdge aMMakeEV1 aMMakeEFL aNewSideFace startVertexUse |
	topSketchFaceUse := aSketchFaceUse copy.
	topSketchFaceUse aSurface aRefFrame rFfF at: 3 put: zEnd.
	firstLoopUse := topSketchFaceUse cLoopUse at: 1.
	cTopPoint := firstLoopUse cEdgeUse collect: [ :aEdgeUse | 
		             aEdgeUse aVertexUse rSkFacePointSk ].
	oldFaceUse := (newTopFace selectFaceUse: [ :argaFaceUse | 
		               argaFaceUse aRegion == aOutsideRegion ]) soleItem.
	oldLoopUse := (oldFaceUse selectLoopUse: [ :aLoopUse | true ])
		              soleItem.
	cVertex := oldLoopUse selectVertex: [ :aVertex | true ].
	cTopVertex := cVertex copyEmpty.
	cUpEdge := cVertex copyEmpty.
	cNewSideFace := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"

	"Make up edge."
	aMMakeEV1 := MMakeEV
		             inRegion: aOutsideRegion
		             inFace: newTopFace
		             aEdge: nil
		             fromVertex: (cVertex at: 1)
		             toPoint: (cTopPoint at: 1)
		             orient: nil.
	cOperator add: aMMakeEV1 do.
	cTopVertex add: aMMakeEV1 newVertex.
	cUpEdge add: aMMakeEV1 newEdge.

	"Make top edge to create a new face."
	aMMakeEFL := MMakeE
		             inRegion: aOutsideRegion
		             inFace: newTopFace
		             aEdge: (cUpEdge at: 1)
		             aVertex: (cTopVertex at: 1)
		             orient: nil
		             aEdge: (cUpEdge at: 1)
		             aVertex: (cTopVertex at: 1)
		             orient: nil.
	cOperator add: aMMakeEFL do.
	aNewSideFace := aMMakeEFL newFace.
	startVertexUse := aNewSideFace
		                  startVertexUseOf: (cVertex at: 1)
		                  inRegion: aOutsideRegion.
	aNewSideFace startFirstLoopAtVertexUse: startVertexUse.
	cNewSideFace add: aNewSideFace.
	startVertexUse := newTopFace
		                  startVertexUseOf: (cTopVertex at: 1)
		                  inRegion: aOutsideRegion.
	newTopFace startFirstLoopAtVertexUse: startVertexUse.
	self addFaceGeometry
]

{ #category : #executing }
MakePrism >> modifyTopFaceGeometry [
	| topSketchFaceUse outsideTopFaceUse aSurface firstLoopUse cEdgeUse firstSketchLoopUse cSketchEdgeUse |
	topSketchFaceUse := aSketchFaceUse copy.
	topSketchFaceUse aSurface aRefFrame rFfF at: 3 put: zEnd.
	aOutsideRegion := newModel aOutsideRegion.
	outsideTopFaceUse := (newTopFace 
				selectFaceUse: [:aFaceUse | aFaceUse aRegion == aOutsideRegion]) soleItem.
	aSurface := topSketchFaceUse aSurface.
	aSurface name: #top.
	outsideTopFaceUse addPositiveSurface: aSurface.
	"Code below applies to face with single loop only."
	"Multiple loop face is not yet inplemented."
	firstLoopUse := outsideTopFaceUse cLoopUse first.
	cEdgeUse := firstLoopUse cEdgeUse.
	firstSketchLoopUse := topSketchFaceUse cLoopUse first.
	cSketchEdgeUse := firstSketchLoopUse cEdgeUse.
	1 to: cEdgeUse size
		do: [:i | (cEdgeUse at: i) addPositiveCurve: (cSketchEdgeUse at: i) uvOFt copy]
]

{ #category : #accessing }
MakePrism >> newModel [
	^newModel
]

{ #category : #accessing }
MakePrism >> newModel: anObject [
	newModel := anObject
]

{ #category : #accessing }
MakePrism >> outsideTopFaceUse [
	^(newTopFace 
		selectFaceUse: [:aFaceUse | aFaceUse aRegion == aOutsideRegion]) soleItem
]

{ #category : #executing }
MakePrism >> precondition [
	^zStart <= zEnd
]

{ #category : #accessing }
MakePrism >> zEnd [
	^zEnd
]

{ #category : #accessing }
MakePrism >> zEnd: anObject [
	zEnd := anObject
]

{ #category : #accessing }
MakePrism >> zStart [
	^zStart
]

{ #category : #accessing }
MakePrism >> zStart: anObject [
	zStart := anObject
]
