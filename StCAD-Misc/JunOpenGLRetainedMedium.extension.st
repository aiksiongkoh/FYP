Extension { #name : #JunOpenGLRetainedMedium }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGLRetainedMedium >> calcViewBoxFor: aJun3dBoundingBox with: projection [

	| viewportPointer modelviewPointer projectionPointer windowxPointer windowyPointer windowzPointer block vertexs boundingBox |
	self renderingContext parallelProjection: projection.
	viewportPointer := CIntegerType long gcMalloc: 4.
	modelviewPointer := CLimitedPrecisionRealType double gcMalloc: 16.
	projectionPointer := CLimitedPrecisionRealType double gcMalloc: 16.
	windowxPointer := CLimitedPrecisionRealType double gcMalloc: 1.
	windowyPointer := CLimitedPrecisionRealType double gcMalloc: 1.
	windowzPointer := CLimitedPrecisionRealType double gcMalloc: 1.
	OpenGLInterface
		glGetIntegerv: OpenGLInterface GL_VIEWPORT
		with: viewportPointer.
	OpenGLInterface
		glGetDoublev: OpenGLInterface GL_MODELVIEW_MATRIX
		with: modelviewPointer.
	OpenGLInterface
		glGetDoublev: OpenGLInterface GL_PROJECTION_MATRIX
		with: projectionPointer.
	block := [ :xyz | 
	         OpenGLInterface
		         gluProject: xyz x asDouble
		         with: xyz y asDouble
		         with: xyz z asDouble
		         with: modelviewPointer
		         with: projectionPointer
		         with: viewportPointer
		         with: windowxPointer
		         with: windowyPointer
		         with: windowzPointer.
	         StCAD_Math_FullColumn
		         with: windowxPointer contents
		         with: windowyPointer contents
		         with: windowzPointer contents "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn" ].
	vertexs := aJun3dBoundingBox vertexes.
	boundingBox := StCAD_Misc_BoundingBox new. "VW_TRANSLATION:StCAD.Misc.BoundingBox:StCAD_Misc_BoundingBox"
	vertexs
		inject: boundingBox
		into: [ :bbox :vertex | bbox expandToBound: (block value: vertex) ].
	^ boundingBox
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGLRetainedMedium >> scrollProjector: aProjector by: aPoint [

	| projection viewportPointer modelviewPointer projectionPointer windowxPointer windowyPointer windowzPointer cadsmxPointer cadsmyPointer cadsmzPointer block eyePointPx sightPointPx |
	projection := aProjector projection.
	self renderingContext parallelProjection:
		projection asParallelProjection.
	viewportPointer := CIntegerType long gcMalloc: 4.
	modelviewPointer := CLimitedPrecisionRealType double gcMalloc: 16.
	projectionPointer := CLimitedPrecisionRealType double gcMalloc: 16.
	windowxPointer := CLimitedPrecisionRealType double gcMalloc: 1.
	windowyPointer := CLimitedPrecisionRealType double gcMalloc: 1.
	windowzPointer := CLimitedPrecisionRealType double gcMalloc: 1.
	cadsmxPointer := CLimitedPrecisionRealType double gcMalloc: 1.
	cadsmyPointer := CLimitedPrecisionRealType double gcMalloc: 1.
	cadsmzPointer := CLimitedPrecisionRealType double gcMalloc: 1.
	OpenGLInterface
		glGetIntegerv: OpenGLInterface GL_VIEWPORT
		with: viewportPointer.
	OpenGLInterface
		glGetDoublev: OpenGLInterface GL_MODELVIEW_MATRIX
		with: modelviewPointer.
	OpenGLInterface
		glGetDoublev: OpenGLInterface GL_PROJECTION_MATRIX
		with: projectionPointer.
	block := [ :xyz | 
	         OpenGLInterface
		         gluProject: xyz x asDouble
		         with: xyz y asDouble
		         with: xyz z asDouble
		         with: modelviewPointer
		         with: projectionPointer
		         with: viewportPointer
		         with: windowxPointer
		         with: windowyPointer
		         with: windowzPointer.
	         StCAD_Math_FullColumn
		         with: windowxPointer contents
		         with: windowyPointer contents
		         with: windowzPointer contents "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn" ].
	eyePointPx := block value: projection eyePoint.
	sightPointPx := block value: projection sightPoint.
	eyePointPx x: eyePointPx x + aPoint x negated.
	eyePointPx y: eyePointPx y + aPoint y.
	sightPointPx x: sightPointPx x + aPoint x negated.
	sightPointPx y: sightPointPx y + aPoint y.
	block := [ :xyz | 
	         OpenGLInterface
		         gluUnProject: xyz x asDouble
		         with: xyz y asDouble
		         with: xyz z asDouble
		         with: modelviewPointer
		         with: projectionPointer
		         with: viewportPointer
		         with: cadsmxPointer
		         with: cadsmyPointer
		         with: cadsmzPointer.
	         Jun3dPoint
		         x: cadsmxPointer contents
		         y: cadsmyPointer contents
		         z: cadsmzPointer contents ].
	projection eyePoint: (block value: eyePointPx).
	projection sightPoint: (block value: sightPointPx).
	aProjector setProjection: projection
]
