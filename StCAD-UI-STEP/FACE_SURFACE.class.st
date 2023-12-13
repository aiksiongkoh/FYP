Class {
	#name : #'FACE_SURFACE',
	#superclass : #FACE,
	#instVars : [
		'face_geometry',
		'same_sense',
		'aSurface',
		'aRegion',
		'cOperator'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
FACE_SURFACE class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
FACE_SURFACE >> aSurface [
	^aSurface ifNil: 
			[aSurface := self face_geometry aSurfaceWithBounds: bounds.
			same_sense ifTrue: [aSurface] ifFalse: [aSurface reverseSelf]]
]

{ #category : #building }
FACE_SURFACE >> addGeometry [
	| newFaceUse |
	newFaceUse := self newFaceUse.
	newFaceUse cLoopUse with: bounds
		parallelDo: [:aLoopUse :aFACE_BOUND | aLoopUse addGeometry: aFACE_BOUND onFACE: self].
	newFaceUse
		conditionSelf;
		addMateGeometry
]

{ #category : #building }
FACE_SURFACE >> buildInRegion: aaRegion [

	aRegion := aaRegion.
	cOperator := StCAD_Misc_OrderedSet new: 10. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	self
		conditionBounds;
		makeWireframe;
		makeFace;
		killDummyEdges;
		conditionFace
]

{ #category : #accessing }
FACE_SURFACE >> cCurve [
	| nLoop bound aWriteStream |
	nLoop := bounds size.
	^nLoop == 1 
		ifTrue: [bounds first cCurve]
		ifFalse: 
			[aWriteStream := (Array new: 10) writeStream.
			bound := bounds first.
			bound cCurve do: [:aCurve | aWriteStream nextPut: aCurve].
			2 to: nLoop
				do: 
					[:i | 
					"Connect outer loop to inner loops."

					aWriteStream nextPut: nil.
					bound := bounds at: i.
					bound cCurve do: [:aCurve | aWriteStream nextPut: aCurve].
					aWriteStream nextPut: nil].
			aWriteStream contents]
]

{ #category : #accessing }
FACE_SURFACE >> cEdge [

	| answer |
	answer := StCAD_Misc_OrderedSet new: 10. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	cOperator do: [ :aOp | 
		(aOp respondsTo: #newEdge) ifTrue: [ answer add: aOp newEdge ] ].
	^ answer
]

{ #category : #accessing }
FACE_SURFACE >> cEdgeUse [

	| answer aVertex aEdge aEdgeUse aCurve |
	answer := StCAD_Misc_OrderedSet new: 10. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	cOperator do: [ :aOp | 
		(aOp respondsTo: #newEdge) ifTrue: [ 
			aVertex := aOp aVertex.
			aEdge := aOp newEdge.
			aCurve := aOp aCurve.
			aEdgeUse := (aEdge cUse select: [ :aaEdgeUse | 
				             aaEdgeUse aVertex == aVertex and: [ 
					             aaEdgeUse xyzCurve = aCurve ] ]) first.
			answer add: aEdgeUse ] ].
	^ answer
]

{ #category : #'As yet unclassified' }
FACE_SURFACE >> cEdgeUse1 [

	| answer aVertex aEdge aEdgeUse |
	answer := StCAD_Misc_OrderedSet new: 10. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	cOperator do: [ :aOp | 
		(aOp respondsTo: #newEdge) ifTrue: [ 
			aVertex := aOp aVertex.
			aEdge := aOp newEdge.
			aEdgeUse := (aEdge cUse select: [ :aaEdgeUse | 
				             aaEdgeUse aVertex == aVertex ]) first.
			answer add: aEdgeUse ] ].
	^ answer
]

{ #category : #accessing }
FACE_SURFACE >> cPoint [
	| nLoop bound startPoint aWriteStream |
	nLoop := bounds size.
	^nLoop == 1 
		ifTrue: [bounds first cPoint]
		ifFalse: 
			[bound := bounds first.
			startPoint := bound startPoint.
			aWriteStream := (Array new: 10) writeStream.
			bound cPoint do: [:aPoint | aWriteStream nextPut: aPoint].
			2 to: nLoop
				do: 
					[:i | 
					"Connect outer loop to inner loops."

					aWriteStream nextPut: startPoint.
					bound := bounds at: i.
					bound cPoint do: [:aPoint | aWriteStream nextPut: aPoint].
					aWriteStream nextPut: bound startPoint].
			aWriteStream contents]
]

{ #category : #building }
FACE_SURFACE >> conditionBounds [

	bounds sortWith: [ :aFACE_BOUND :bFACE_BOUND | 
		aFACE_BOUND aBoundingBox diagonal_length
		>= bFACE_BOUND aBoundingBox diagonal_length ].
	bounds first changeClassToThatOf:
		StCAD_UI_STEP_FACE_OUTER_BOUND basicNew "VW_TRANSLATION:StCAD.UI.STEP.FACE_OUTER_BOUND:StCAD_UI_STEP_FACE_OUTER_BOUND"
]

{ #category : #building }
FACE_SURFACE >> conditionBounds1 [

	| outerbound |
	(bounds first isMemberOf: StCAD_UI_STEP_FACE_OUTER_BOUND) ifFalse: [ 
		outerbound := (bounds select: [ :a | 
			               a isMemberOf: StCAD_UI_STEP_FACE_OUTER_BOUND ])
			              soleItem.
		outerbound
			ifNotNil: [ 
				bounds remove: outerbound ifAbsent: nil.
				bounds addFirst: outerbound ]
			ifNil: [ 
				bounds first changeClassToThatOf:
					StCAD_UI_STEP_FACE_OUTER_BOUND basicNew ] ] "VW_TRANSLATION:StCAD.UI.STEP.FACE_OUTER_BOUND:StCAD_UI_STEP_FACE_OUTER_BOUND"
]

{ #category : #'As yet unclassified' }
FACE_SURFACE >> conditionFace [

	| newFaceUse cLoopUse uvBoundTol |
	(self aSurface isKindOf: StCAD_Geo_SurfaceOfRevolution) ifTrue: [ 
		newFaceUse := self newFaceUse.
		cLoopUse := newFaceUse cLoopUse.
		uvBoundTol := aSurface uvBoundTol.
		cLoopUse do: [ :aLoopUse | aLoopUse conditionSelfWithin: uvBoundTol ].
		newFaceUse finalize_cLoopUse ] "VW_TRANSLATION:StCAD.Geo.SurfaceOfRevolution:StCAD_Geo_SurfaceOfRevolution"
]

{ #category : #debug }
FACE_SURFACE >> debug [

	| aVERTEX_POINT tol |
	aVERTEX_POINT := StCAD_Math_FullColumn
		                 with: 1127.13 d
		                 with: 377.67 d
		                 with: 120.0 d. "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn"
	tol := 1.0d-2.
	^ self hasVERTEX_POINT: aVERTEX_POINT tol: tol
]

{ #category : #accessing }
FACE_SURFACE >> face_geometry [
	face_geometry isSequenceable 
		ifTrue: 
			[| cClass aSURFACE |
			cClass := OrderedCollection new: 4.
			cClass add: RATIONAL_B_SPLINE_SURFACE.
			cClass add: B_SPLINE_SURFACE_WITH_KNOTS.
			cClass detect: 
					[:aClass | 
					aSURFACE := face_geometry detect: [:a | a isMemberOf: aClass] ifNone: nil.
					aSURFACE ~~ nil].
			aSURFACE fillWith: face_geometry.
			face_geometry := aSURFACE].
	^face_geometry
]

{ #category : #accessing }
FACE_SURFACE >> face_geometry: anObject [
	face_geometry := anObject
]

{ #category : #accessing }
FACE_SURFACE >> hasVERTEX_POINT: aVERTEX_POINT tol: tol [ 
	bounds do: 
			[:aFACE_OUTER_BOUND | 
			(aFACE_OUTER_BOUND hasVERTEX_POINT: aVERTEX_POINT tol: tol) 
				ifTrue: [^true]].
	^false
]

{ #category : #building }
FACE_SURFACE >> killDummyEdges [

	| cLoopUse cEdgeUse cDeadEdge iEdge aKillEMakeL |
	bounds size > 1 ifTrue: [ 
		cLoopUse := self newFaceUse cLoopUse.
		self assert: [ cLoopUse size = 1 ].
		cEdgeUse := cLoopUse first cEdgeUse.
		cDeadEdge := StCAD_Misc_OrderedSet new: bounds size. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
		iEdge := bounds first size.
		2 to: bounds size do: [ :i | 
			iEdge := iEdge + 2 + (bounds at: i) size.
			cDeadEdge add: (cEdgeUse at: iEdge) aEdge ].
		cDeadEdge do: [ :aEdge | 
			aKillEMakeL := StCAD_NMT_KillEMakeL aEdge: aEdge. "VW_TRANSLATION:StCAD.NMT.KillEMakeL:StCAD_NMT_KillEMakeL"
			aKillEMakeL do.
			cOperator add: aKillEMakeL ] ]
]

{ #category : #building }
FACE_SURFACE >> makeFace [

	| aMakeFU |
	aMakeFU := StCAD_NMT_MakeFU
		           withcEdge: self cEdgeUse
		           aSurface: self aSurface. "VW_TRANSLATION:StCAD.NMT.MakeFU:StCAD_NMT_MakeFU"
	aMakeFU do.
	cOperator add: aMakeFU
]

{ #category : #building }
FACE_SURFACE >> makeFaceBad [

	| count aNMTSurface cEdgeUse aMakeFU |
	count := 0.
	aNMTSurface := self aSurface.
	cEdgeUse := self cEdgeUse.

	[ 
	count := count + 1.
	aMakeFU := StCAD_NMT_MakeFU withcEdge: cEdgeUse aSurface: aNMTSurface. "VW_TRANSLATION:StCAD.NMT.MakeFU:StCAD_NMT_MakeFU"
	aMakeFU do ]
		on: SurfaceChangedException
		do: [ :ex | 
			aMakeFU die.
			aNMTSurface := ex parameter.
			count < 5
				ifTrue: [ ex retry ]
				ifFalse: [ ex pass ] ].
	cOperator add: aMakeFU
]

{ #category : #building }
FACE_SURFACE >> makeWireframe [

	| cPoint cCurve aMakeSV aVertex aMakeEV aMakeE |
	cPoint := self cPoint.
	cCurve := self cCurve.
	aMakeSV := StCAD_NMT_MakeSV inRegion: aRegion aPoint: cPoint first. "VW_TRANSLATION:StCAD.NMT.MakeSV:StCAD_NMT_MakeSV"
	aMakeSV do.
	aVertex := aMakeSV newVertex.
	cOperator add: aMakeSV.
	2 to: cPoint size do: [ :i | 
		aMakeEV := StCAD_NMT_MakeEV
			           inRegion: aRegion
			           fromVertex: aVertex
			           toPoint: (cPoint at: i)
			           aCurve: (cCurve at: i - 1). "VW_TRANSLATION:StCAD.NMT.MakeEV:StCAD_NMT_MakeEV"
		aMakeEV do.
		aVertex := aMakeEV newVertex.
		cOperator add: aMakeEV ].
	aMakeE := StCAD_NMT_MakeE
		          inRegion: aRegion
		          fromVertex: aVertex
		          toVertex: aMakeSV newVertex
		          aCurve: cCurve last. "VW_TRANSLATION:StCAD.NMT.MakeE:StCAD_NMT_MakeE"
	aMakeE do.
	cOperator add: aMakeE
]

{ #category : #accessing }
FACE_SURFACE >> newFaceUse [

	^ (cOperator select: [ :aOp | 
		   aOp isMemberOf: StCAD_NMT_MakeFU "VW_TRANSLATION:StCAD.NMT.MakeFU:StCAD_NMT_MakeFU" ])
		  soleItem newFaceUse
]

{ #category : #printing }
FACE_SURFACE >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'ADVANCED_FACE';
		cr;
		nextPutAll: 'same_sense = ';
		printVerbose: same_sense;
		cr;
		printVerbose: face_geometry;
		cr;
		printVerbose: bounds
]

{ #category : #accessing }
FACE_SURFACE >> same_sense [
	^same_sense
]

{ #category : #accessing }
FACE_SURFACE >> same_sense: anObject [
	same_sense := anObject
]

{ #category : #accessing }
FACE_SURFACE >> startPoint [
	^bounds first startPoint
]
