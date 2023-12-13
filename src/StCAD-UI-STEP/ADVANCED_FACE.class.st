Class {
	#name : #'ADVANCED_FACE',
	#superclass : #'FACE_SURFACE',
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
ADVANCED_FACE class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
ADVANCED_FACE >> aSurface [
	^aSurface ifNil: 
			[aSurface := self face_geometry aSurfaceWithBounds: bounds.
			same_sense ifTrue: [aSurface] ifFalse: [aSurface reverseSelf]]
]

{ #category : #building }
ADVANCED_FACE >> addGeometry [
	| newFaceUse |
	newFaceUse := self newFaceUse.
	newFaceUse
		aSurface: self aSurface;
		isSameSense: true.
	newFaceUse cLoopUse with: bounds
		parallelDo: [:aLoopUse :aFACE_BOUND | aLoopUse addGeometry: aFACE_BOUND onFACE: self].
	newFaceUse
		conditionSelf;
		addMateGeometry
]

{ #category : #accessing }
ADVANCED_FACE >> bounds [
	^bounds
]

{ #category : #accessing }
ADVANCED_FACE >> bounds: anObject [ 
	bounds := anObject
]

{ #category : #building }
ADVANCED_FACE >> buildInRegion: aaRegion [

	aSurface := nil.
	aRegion := aaRegion.
	cOperator := StCAD_Misc_OrderedSet new: 10. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	self makeWireframe.
	self makeFace.
	self killDummyEdges.
	[ self addGeometry ]
		on: SurfaceChangedException
		do: [ :ex | 
			self aSurface glSurface: nil.
			ex retry ]
]

{ #category : #accessing }
ADVANCED_FACE >> cCurve [
	| nLoop bound aWriteStream |
	self conditionBounds.
	nLoop := bounds size.
	^nLoop == 1 
		ifTrue: [bounds first cCurve]
		ifFalse: 
			[bound := bounds first.
			aWriteStream := (Array new: 10) writeStream.
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
ADVANCED_FACE >> cEdge [

	| answer |
	answer := StCAD_Misc_OrderedSet new: 10. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	cOperator do: [ :aOp | 
		(aOp respondsTo: #newEdge) ifTrue: [ answer add: aOp newEdge ] ].
	^ answer
]

{ #category : #accessing }
ADVANCED_FACE >> cEdgeUse [

	| answer aVertex aEdge aEdgeUse cOp |
	answer := StCAD_Misc_OrderedSet new: 10. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	cOp := cOperator select: [ :aOp | aOp respondsTo: #newEdge ].
	cOp size = 1
		ifTrue: [ "We have self-loop."
			self assert: [ bounds size = 1 ].
			aEdge := cOp first newEdge.
			aEdgeUse := aEdge cUse detect: [ :aaEdgeUse | 
				            aaEdgeUse xyzCurve
					            equal: self cCurve first
					            ltol: 1.0d-9 ].
			answer add: aEdgeUse ]
		ifFalse: [ 
			cOp do: [ :aOp | 
				aVertex := aOp aVertex.
				aEdge := aOp newEdge.
				aEdgeUse := aEdge isCyclic
					            ifTrue: [ 
						            aEdge cUse detect: [ :aaEdgeUse | 
							            aaEdgeUse isSameSense not and: [ 
								            aaEdgeUse aVertex == aVertex ] ] ]
					            ifFalse: [ 
					            aEdge cUse detect: [ :aaEdgeUse | 
						            aaEdgeUse aVertex == aVertex ] ].
				answer add: aEdgeUse ] ].
	^ answer
]

{ #category : #accessing }
ADVANCED_FACE >> cPoint [
	| nLoop bound startPoint aWriteStream |
	self conditionBounds.
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
ADVANCED_FACE >> conditionBounds [

	| outerbound |
	(bounds first isMemberOf: StCAD_UI_STEP_FACE_OUTER_BOUND) ifFalse: [ 
		outerbound := (bounds select: [ :a | 
			               a isMemberOf: StCAD_UI_STEP_FACE_OUTER_BOUND ])
			              soleItem.
		outerbound ifNil: [ super conditionBounds ] ifNotNil: [ 
			bounds remove: outerbound.
			bounds addFirst: outerbound ] ] "VW_TRANSLATION:StCAD.UI.STEP.FACE_OUTER_BOUND:StCAD_UI_STEP_FACE_OUTER_BOUND"
]

{ #category : #debug }
ADVANCED_FACE >> debug [

	| aVERTEX_POINT tol |
	aVERTEX_POINT := StCAD_Math_FullColumn
		                 with: 1127.13 d
		                 with: 377.67 d
		                 with: 120.0 d. "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn"
	tol := 1.0d-2.
	^ self hasVERTEX_POINT: aVERTEX_POINT tol: tol
]

{ #category : #accessing }
ADVANCED_FACE >> face_geometry [
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
ADVANCED_FACE >> face_geometry: anObject [
	face_geometry := anObject
]

{ #category : #accessing }
ADVANCED_FACE >> hasVERTEX_POINT: aVERTEX_POINT tol: tol [ 
	bounds do: 
			[:aFACE_OUTER_BOUND | 
			(aFACE_OUTER_BOUND hasVERTEX_POINT: aVERTEX_POINT tol: tol) 
				ifTrue: [^true]].
	^false
]

{ #category : #building }
ADVANCED_FACE >> killDummyEdges [

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
ADVANCED_FACE >> makeFace [

	| aMakeFU |
	aMakeFU := StCAD_NMT_MakeFU withcEdge: self cEdgeUse. "VW_TRANSLATION:StCAD.NMT.MakeFU:StCAD_NMT_MakeFU"
	aMakeFU do.
	cOperator add: aMakeFU
]

{ #category : #building }
ADVANCED_FACE >> makeWireframe [

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
ADVANCED_FACE >> newFaceUse [

	^ (cOperator select: [ :aOp | 
		   aOp isMemberOf: StCAD_NMT_MakeFU "VW_TRANSLATION:StCAD.NMT.MakeFU:StCAD_NMT_MakeFU" ])
		  soleItem newFaceUse
]

{ #category : #printing }
ADVANCED_FACE >> printVerboseOn: aStream [ 
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
ADVANCED_FACE >> same_sense [
	^same_sense
]

{ #category : #accessing }
ADVANCED_FACE >> same_sense: anObject [
	same_sense := anObject
]

{ #category : #debug }
ADVANCED_FACE >> show [

	self showWithSurface: true WithAxes: false
]

{ #category : #debug }
ADVANCED_FACE >> showEdges [

	self showWithSurface: false WithAxes: false
]

{ #category : #debug }
ADVANCED_FACE >> showEdgesWithAxes [

	self showWithSurface: false WithAxes: true
]

{ #category : #debug }
ADVANCED_FACE >> showWithAxes [

	self showWithSurface: true WithAxes: true
]

{ #category : #debug }
ADVANCED_FACE >> showWithSurface: withSurface WithAxes: withAxes [

	| compoundObject cColorValue cCurve aCurve aJunOpenGL3dObject |
	compoundObject := JunOpenGL3dCompoundObject new.
	withSurface
		ifTrue: [compoundObject add: self aSurface asJunOpenGL3dObject].
	cColorValue := MathArray
				with: ColorValue red
				with: ColorValue green
				with: ColorValue blue.
	cCurve := self cCurve select: [:a | a notNil].
	1 to: cCurve size
		do: 
			[:i |
			aCurve := cCurve at: i.
			aJunOpenGL3dObject := (aCurve asJunOpenGL3dObject)
						lineWidth: 3;
						yourself.
			i == 1
				ifTrue: [aJunOpenGL3dObject paint: ColorValue magenta]
				ifFalse: [aJunOpenGL3dObject paint: (cColorValue cyclic_at: i)].
			compoundObject add: aJunOpenGL3dObject.
			aJunOpenGL3dObject := (JunOpenGL3dVertex point: aCurve rFstartF)
						size: 2 * i + 2;
						paint: ColorValue red;
						yourself.
			compoundObject add: aJunOpenGL3dObject].
	withAxes
		ifTrue: [compoundObject showWithAxes]
		ifFalse: [compoundObject show]
]

{ #category : #accessing }
ADVANCED_FACE >> startPoint [
	^bounds first startPoint
]
