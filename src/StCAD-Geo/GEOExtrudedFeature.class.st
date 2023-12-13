Class {
	#name : #GEOExtrudedFeature,
	#superclass : #GEOSketchedFeature,
	#instVars : [
		'zStart',
		'zEnd'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'VisualWorks metadata' }
GEOExtrudedFeature class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOExtrudedFeature >> aSketch [
	^sketch
]

{ #category : #accessing }
GEOExtrudedFeature >> asTreeNode [
	| answer stream |
	answer := super asTreeNode.
	stream := String new writeStream.
	stream nextPutAll: 'Extrusion'.
	stream space.
	stream print: zStart.
	stream space.
	stream print: zEnd.
	answer displayString: stream contents.
	^answer
]

{ #category : #ops }
GEOExtrudedFeature >> buildIn: solidModel [ 
	solidModel buildExtrudedFeature: self
]

{ #category : #ops }
GEOExtrudedFeature >> facesEdgesVertexs [
	"
	.											minusZendface 
	.												12 
	me(n+2-i)		1		mv(n+2-i)		2		me(n+2-i-1)		1		mv(n+2-i-1)		2		me(n+2-i-2)	 
	21						1						21							1	 						21 
	sfi-1			12		sei				21		sfi					12		sei+1				21		sfi+1	 
	21						2						21							2	 						21 
	ei-1			2		vi				1		ei					2		vi+1				1		ei+1	 
	.												12 
	.											plusZendface	 
	
	"
	| faces edges vertexs partRefFrame rGpolylineGs zfaceData zfaceFaces zfaceEdges zfaceVertexs mzfaceData mzfaceFaces mzfaceEdges mzfaceVertexs sideFaces sideEdges nvertex block mblock edge points polyline face iminus iplus mi miplus zfaceEdgeiminus sideEdgeiminus sideFaceiminus mzfaceEdgei sideEdgei zfaceEdgei sideFacei mzfaceEdgeiplus sideEdgeiplus |
	faces := OrderedCollection new.
	edges := OrderedCollection new.
	vertexs := OrderedCollection new.
	partRefFrame := self part refFrame.
	rGpolylineGs := sketch asPolylines.
	rGpolylineGs do: 
			[:rGpolylineG |
			zfaceData := self zFaceDataFrom: rGpolylineG sign: 1.
			zfaceFaces := zfaceData at: 1.
			zfaceEdges := zfaceData at: 2.
			zfaceVertexs := zfaceData at: 3.
			mzfaceData := self zFaceDataFrom: rGpolylineG sign: -1.
			mzfaceFaces := mzfaceData at: 1.
			mzfaceEdges := mzfaceData at: 2.
			mzfaceVertexs := mzfaceData at: 3.
			sideFaces := OrderedCollection new.
			sideEdges := OrderedCollection new.
			nvertex := zfaceVertexs size.
			block := [:index | (index - 1) \\ nvertex + 1.].
			mblock := [:index | block value: nvertex + 2 - index.].
			1 to: nvertex
				do: 
					[:i |
					edge := GEOWingedEdge new.
					edge vertex1: (mzfaceVertexs at: (mblock value: i)).
					edge vertex2: (zfaceVertexs at: i).
					sideEdges add: edge.
					points := MathArray new: 5.
					points at: 1 put: (mzfaceVertexs at: (mblock value: i)) point.
					points at: 2 put: (zfaceVertexs at: i) point.
					points at: 3 put: (zfaceVertexs at: (block value: i - 1)) point.
					points at: 4 put: (mzfaceVertexs at: (mblock value: i - 1)) point.
					points at: 5 put: (points at: 1).
					polyline := GEOPolyline refFrame: partRefFrame rFpointsF: points.
					face := GEOWEFace new.
					face edge: edge.
					face polyline: polyline.
					sideFaces add: face.].
			1 to: nvertex
				do: 
					[:i |
					iminus := block value: i - 1.
					iplus := block value: i + 1.
					mi := mblock value: i.
					miplus := mblock value: i + 1.
					zfaceEdgeiminus := zfaceEdges at: iminus.
					sideEdgeiminus := sideEdges at: iminus.
					sideFaceiminus := sideFaces at: iminus.
					mzfaceEdgei := mzfaceEdges at: mi.
					sideEdgei := sideEdges at: i.
					zfaceEdgei := zfaceEdges at: i.
					sideFacei := sideFaces at: i.
					mzfaceEdgeiplus := mzfaceEdges at: miplus.
					sideEdgeiplus := sideEdges at: iplus.
					mzfaceEdgei edge11: sideEdgeiplus.
					mzfaceEdgei edge21: sideEdgeiminus.
					mzfaceEdgei face21: sideFaceiminus.
					sideEdgei edge11: mzfaceEdgei.
					sideEdgei edge12: mzfaceEdgeiplus.
					sideEdgei edge21: zfaceEdgeiminus.
					sideEdgei edge22: zfaceEdgei.
					sideEdgei face12: sideFaceiminus.
					sideEdgei face21: sideFacei.
					zfaceEdgei edge12: sideEdgei.
					zfaceEdgei edge22: sideEdgeiplus.
					zfaceEdgei face21: sideFacei.].
			faces addAll: mzfaceFaces.
			faces addAll: sideFaces.
			faces addAll: zfaceFaces.
			edges addAll: mzfaceEdges.
			edges addAll: sideEdges.
			edges addAll: zfaceEdges.
			vertexs addAll: mzfaceVertexs.
			vertexs addAll: zfaceVertexs.].
	faces
		do: [:aFace | aFace polyline refFrame removeFramesBetweenSelfAnd: partRefFrame.].
	^Array with: faces with: edges with: vertexs.
]

{ #category : #accessing }
GEOExtrudedFeature >> magnifySelf: aDouble [ 
	zStart := zStart * aDouble.
	zEnd := zEnd * aDouble.
	self aSketch magnifySelf: aDouble
]

{ #category : #printing }
GEOExtrudedFeature >> printOn: aStream [ 
	| title |
	title := self class name.
	aStream nextPutAll: ((title at: 1) isVowel
			ifTrue: ['an ']
			ifFalse: ['a ']).
	aStream print: self class.
	aStream space.
	aStream print: zStart.
	aStream space.
	aStream print: zEnd
]

{ #category : #printing }
GEOExtrudedFeature >> storeOn: aStream level: level [ 
	aStream storeLevel: level title: 'Extrusion'.
	aStream
		storeLevel: level + 1
		title: 'zStart'
		object: zStart.
	aStream
		storeLevel: level + 1
		title: 'zEnd'
		object: zEnd.
	self sketch storeOn: aStream level: level + 1
]

{ #category : #printing }
GEOExtrudedFeature >> storePOVOn: aStream level: level [ 
	"
	prism uses xz points extruded in y.	
	'freeCAD' uses xy points extruded in z.
	Hence the need for negation and rotation.
	"

	| rGpolylineGs npoints array index block |
	aStream storePOVLevel: level title: 'prism{'.
	rGpolylineGs := sketch asPolylines.
	npoints := rGpolylineGs inject: 0
				into: [:size :poly | size + poly rPpointsP size].
	array := Array 
				with: zStart negated asFloat printForExport
				with: zEnd negated asFloat printForExport
				with: npoints printForExport.
	aStream storePOVLevel: level + 1
		title: ('<1s>, <2s>, <3s>,' expandMacrosWithArguments: array).
	index := 0.
	block := 
			[:rPpointP | 
			aStream nextPut: $<.
			aStream nextPutAll: (rPpointP at: 1) asFloat printForExport.
			aStream nextPutAll: ', '.
			aStream nextPutAll: (rPpointP at: 2) asFloat printForExport.
			aStream nextPut: $>.
			index := index + 1].
	rGpolylineGs do: 
			[:rGpolylineG | 
			rGpolylineG rPpointsP do: 
					[:rPpointP | 
					block value: rPpointP.
					index < npoints ifTrue: [aStream nextPutAll: ', '] ifFalse: [aStream cr]]].
	aStream storePOVLevel: level + 1 title: 'texture {pigment { color Blue }}'.
	aStream storePOVLevel: level + 1 title: 'rotate <-90, 0, 0>'.
	aStream storePOVLevel: level title: '}'
]

{ #category : #accessing }
GEOExtrudedFeature >> zEnd [
	^zEnd == nil
		ifTrue: [1.0d]
		ifFalse: [zEnd]
]

{ #category : #accessing }
GEOExtrudedFeature >> zEnd: double [ 
	zEnd := double
]

{ #category : #ops }
GEOExtrudedFeature >> zFaceDataFrom: graphicPolyline sign: sign [
	"
	graphicPolyline is in the plane of the sketch. 
	graphicPolyline is closed. 
	graphicPolyline is in graphic coordinates. 
	The points follows the right hand rule about the z axis. 
	
	
	v4		2		e3		1		v3	 
	1				11				2 
	e4		11	 zFace		11		e2	 
	2				11				1 
	v1		1		e1		2		v2	 
	
	
	mv2		1		me2		2		mv3	 
	2					11					1 
	me1		11		mzFace	11		me3	 
	1					11					2 
	mv1		2		me4		1		mv4	 
	"
	| faces edges vertexs nvertex vertex vertexi edge iplus zFace iminus block zFacePolyline zGvalueG rPpointsP |
	faces := OrderedCollection new.
	edges := OrderedCollection new.
	vertexs := OrderedCollection new.
	zFacePolyline := graphicPolyline copy.
	zGvalueG := sign positive ifTrue: [zEnd.] ifFalse: [zStart.].
	zFacePolyline refFrame
		translateSelfBy: (FullColumn with: 0.0d with: 0.0d with: zGvalueG).
	sign positive ifFalse: [zFacePolyline makeOppositeFacePositive.].
	rPpointsP := zFacePolyline rPpointsP.
	nvertex := rPpointsP size - 1.
	block := [:index | (index - 1) \\ nvertex + 1.].
	1 to: nvertex
		do: 
			[:i |
			vertex := GEOWEVertex new.
			vertex point: (rPpointsP at: i).
			vertexs add: vertex.].
	1 to: nvertex
		do: 
			[:i |
			vertexi := vertexs at: i.
			edge := GEOWingedEdge new.
			vertexi edge: edge.
			edge vertex1: vertexi.
			iplus := block value: i + 1.
			edge vertex2: (vertexs at: iplus).
			edges add: edge.].
	zFace := GEOWEFace new.
	zFace edge: (edges at: 1).
	zFace polyline: zFacePolyline.
	faces add: zFace.
	1 to: nvertex
		do: 
			[:i |
			edge := edges at: i.
			iminus := block value: i - 1.
			iplus := block value: i + 1.
			edge edge11: (edges at: iminus).
			edge face12: zFace.
			edge edge21: (edges at: iplus).].
	^Array with: faces with: edges with: vertexs.
]

{ #category : #accessing }
GEOExtrudedFeature >> zStart [
	^zStart == nil
		ifTrue: [0.0d]
		ifFalse: [zStart]
]

{ #category : #accessing }
GEOExtrudedFeature >> zStart: double [ 
	zStart := double
]
