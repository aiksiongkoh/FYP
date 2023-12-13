Class {
	#name : #OpenGLRenderingContext,
	#superclass : #JunOpenGLRenderingContext,
	#instVars : [
		'modelviewCPointer',
		'projectionCPointer',
		'viewportCPointer',
		'cDoubleCPointer'
	],
	#category : #'StCAD-UI-StCAD-UI-App'
}

{ #category : #'VisualWorks metadata' }
OpenGLRenderingContext class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'Jun'
	)

]

{ #category : #activation }
OpenGLRenderingContext >> activate: aBlock [ 
	^self critical: 
			[handle isNil ifTrue: [self basicRestoreHandle].
			handle isNil ifTrue: [^self error: 'Failed to restore rendering context'].
			ActiveContext == self 
				ifFalse: 
					[handle makeCurrent.
					ActiveContext := self].
			aBlock value]
]

{ #category : #bounds }
OpenGLRenderingContext >> calcViewBoxFor: aBoundingBox with: aCamera [ 
	| crOpO crvpv boundingBox |
	self parallelProjection: aCamera.
	crOpO := aBoundingBox cCorner.
	crvpv := self crvpvFromcrOpO: crOpO.
	boundingBox := BoundingBox new.
	crvpv inject: boundingBox into: [:bbox :rvpv | bbox expandToBound: rvpv].
	^boundingBox
]

{ #category : #displaying }
OpenGLRenderingContext >> ccgluvTrimNurbs1 [

	| cPoint aPoint bPoint cgluvTrimNurbs aNurbs |
	cPoint := OrderedCollection new.
	cPoint add: (FullColumn with: 0.0d with: 0.0d).
	cPoint add: (FullColumn with: 1.0d with: 0.0d).
	cPoint add: (FullColumn with: 1.0d with: 1.0d).
	cPoint add: (FullColumn with: 0.0d with: 1.0d).
	cPoint add: cPoint first.
	aPoint := cPoint first.
	cgluvTrimNurbs := OrderedCollection new.
	2 to: cPoint size
		do: 
			[:i |
			bPoint := cPoint at: i.
			aNurbs := NurbsCurve fromStart: aPoint copy toEnd: bPoint copy.
			aPoint := bPoint.
			cgluvTrimNurbs add: aNurbs].
	^Array with: cgluvTrimNurbs
]

{ #category : #displaying }
OpenGLRenderingContext >> ccgluvTrimNurbs2 [

	| cPoint aPoint bPoint cgluvTrimNurbs aNurbs |
	cPoint := OrderedCollection new.
	cPoint add: (FullColumn with: 0.1d with: 0.1d).
	cPoint add: (FullColumn with: 0.9d with: 0.1d).
	cPoint add: (FullColumn with: 0.9 with: 0.9).
	cPoint add: cPoint first.
	aPoint := cPoint first.
	cgluvTrimNurbs := OrderedCollection new.
	2 to: cPoint size
		do: 
			[:i |
			bPoint := cPoint at: i.
			aNurbs := NurbsCurve fromStart: aPoint copy toEnd: bPoint copy.
			aPoint := bPoint.
			cgluvTrimNurbs add: aNurbs].
	^Array with: cgluvTrimNurbs
]

{ #category : #projection }
OpenGLRenderingContext >> crOqOFromrOpO: rOpO crpqv1: crpqv [
	"
	Given rOpO =  r from O to p in O components.
	Given collection of rpqv.
	rpqv = r from p to q in viewport components.
	Answer collection of rOqO.
	"
	^self activate: 
			[| viewportPointer modelviewPointer projectionPointer rvpv1Pointer rvpv2Pointer rvpv3Pointer rvpv1 rvpv2 rvpv3 rOqO1Pointer rOqO2Pointer rOqO3Pointer answer |
			modelviewPointer := CLimitedPrecisionRealType double gcMalloc: 16.
			projectionPointer := CLimitedPrecisionRealType double gcMalloc: 16.
			viewportPointer := CIntegerType long gcMalloc: 4.
			OpenGLInterface glGetDoublev: OpenGLInterface GL_MODELVIEW_MATRIX
				with: modelviewPointer.
			OpenGLInterface glGetDoublev: OpenGLInterface GL_PROJECTION_MATRIX
				with: projectionPointer.
			OpenGLInterface glGetIntegerv: OpenGLInterface GL_VIEWPORT
				with: viewportPointer.
			rvpv1Pointer := CLimitedPrecisionRealType double gcMalloc: 1.
			rvpv2Pointer := CLimitedPrecisionRealType double gcMalloc: 1.
			rvpv3Pointer := CLimitedPrecisionRealType double gcMalloc: 1.
			OpenGLInterface
				gluProject: rOpO x asDouble
				with: rOpO y asDouble
				with: rOpO z asDouble
				with: modelviewPointer
				with: projectionPointer
				with: viewportPointer
				with: rvpv1Pointer
				with: rvpv2Pointer
				with: rvpv3Pointer.
			rvpv1 := rvpv1Pointer contents.
			rvpv2 := rvpv2Pointer contents.
			rvpv3 := rvpv3Pointer contents.
			rOqO1Pointer := CLimitedPrecisionRealType double gcMalloc: 1.
			rOqO2Pointer := CLimitedPrecisionRealType double gcMalloc: 1.
			rOqO3Pointer := CLimitedPrecisionRealType double gcMalloc: 1.
			answer := crpqv collect: 
							[:rpqv |
							OpenGLInterface
								gluUnProject: rvpv1 + rpqv x
								with: rvpv2 + rpqv y
								with: rvpv3
								with: modelviewPointer
								with: projectionPointer
								with: viewportPointer
								with: rOqO1Pointer
								with: rOqO2Pointer
								with: rOqO3Pointer.
							FullColumn
								with: rOqO1Pointer contents
								with: rOqO2Pointer contents
								with: rOqO3Pointer contents.].
			answer.].
]

{ #category : #projection }
OpenGLRenderingContext >> crOqOFromrOpO: rOpO crpqv2: crpqv [
	"
	Given rOpO =  r from O to p in O components.
	Given collection of rpqv.
	rpqv = r from p to q in viewport components.
	Answer collection of rOqO.
	"
	| rvpv |
	rvpv := self rvpvFromrOpO: rOpO.
	^self activate: 
			[| rvpv1 rvpv2 rvpv3 rOqO1Pointer rOqO2Pointer rOqO3Pointer answer |
			rvpv1 := rvpv at: 1.
			rvpv2 := rvpv at: 2.
			rvpv3 := rvpv at: 3.
			rOqO1Pointer := cDoubleCPointer.
			rOqO2Pointer := cDoubleCPointer + 1.
			rOqO3Pointer := cDoubleCPointer + 2.
			answer := crpqv collect: 
							[:rpqv |
							OpenGLInterface
								gluUnProject: rvpv1 + rpqv x
								with: rvpv2 + rpqv y
								with: rvpv3
								with: modelviewCPointer
								with: projectionCPointer
								with: viewportCPointer
								with: rOqO1Pointer
								with: rOqO2Pointer
								with: rOqO3Pointer.
							FullColumn
								with: rOqO1Pointer contents
								with: rOqO2Pointer contents
								with: rOqO3Pointer contents.].
			answer.].
]

{ #category : #projection }
OpenGLRenderingContext >> crOqOFromrOpO: rOpO crpqv: crpqv [
	"
	Given rOpO =  r from O to p in O components.
	Given collection of rpqv.
	rpqv = r from p to q in viewport components.
	Answer collection of rOqO.
	"
	| rvpv |
	rvpv := self rvpvFromrOpO: rOpO.
	^self activate: 
			[| rvpv1 rvpv2 rvpv3 rOqO1Pointer rOqO2Pointer rOqO3Pointer answer |
			rvpv1 := rvpv at: 1.
			rvpv2 := rvpv at: 2.
			rvpv3 := rvpv at: 3.
			rOqO1Pointer := cDoubleCPointer.
			rOqO2Pointer := cDoubleCPointer + 1.
			rOqO3Pointer := cDoubleCPointer + 2.
			answer := crpqv collect: 
							[:rpqv |
							OpenGLInterface
								gluUnProject: rvpv1 + rpqv x
								with: rvpv2 + rpqv y
								with: rvpv3
								with: modelviewCPointer
								with: projectionCPointer
								with: viewportCPointer
								with: rOqO1Pointer
								with: rOqO2Pointer
								with: rOqO3Pointer.
							FullColumn
								with: rOqO1Pointer contents
								with: rOqO2Pointer contents
								with: rOqO3Pointer contents.].
			answer.].
]

{ #category : #private }
OpenGLRenderingContext >> critical: aBlock [ 
	^CriticalSectionSemaphore critical: aBlock
]

{ #category : #projection }
OpenGLRenderingContext >> crvpvFromcrOpO1: crOpO [
	"
	Given collection of rOpO.
	rOpO =  r from O to p in O components.
	Answer collection of rvpv.
	"
	^self activate: 
			[| modelviewPointer projectionPointer viewportPointer rvpv1Pointer rvpv2Pointer rvpv3Pointer answer |
			modelviewPointer := CLimitedPrecisionRealType double gcMalloc: 16.
			projectionPointer := CLimitedPrecisionRealType double gcMalloc: 16.
			viewportPointer := CIntegerType long gcMalloc: 4.
			OpenGLInterface glGetDoublev: OpenGLInterface GL_MODELVIEW_MATRIX
				with: modelviewPointer.
			OpenGLInterface glGetDoublev: OpenGLInterface GL_PROJECTION_MATRIX
				with: projectionPointer.
			OpenGLInterface glGetIntegerv: OpenGLInterface GL_VIEWPORT
				with: viewportPointer.
			rvpv1Pointer := CLimitedPrecisionRealType double gcMalloc: 1.
			rvpv2Pointer := CLimitedPrecisionRealType double gcMalloc: 1.
			rvpv3Pointer := CLimitedPrecisionRealType double gcMalloc: 1.
			answer := crOpO collect: 
							[:rOpO |
							OpenGLInterface
								gluProject: rOpO x asDouble
								with: rOpO y asDouble
								with: rOpO z asDouble
								with: modelviewPointer
								with: projectionPointer
								with: viewportPointer
								with: rvpv1Pointer
								with: rvpv2Pointer
								with: rvpv3Pointer.
							FullColumn
								with: rvpv1Pointer contents
								with: rvpv2Pointer contents
								with: rvpv3Pointer contents.].
			answer.].
]

{ #category : #projection }
OpenGLRenderingContext >> crvpvFromcrOpO: crOpO [
	"
	Given collection of rOpO.
	rOpO =  r from O to p in O components.
	Answer collection of rvpv.
	"
	^self activate: 
			[| rvpv1Pointer rvpv2Pointer rvpv3Pointer answer |
			OpenGLInterface glGetDoublev: OpenGLInterface GL_MODELVIEW_MATRIX
				with: modelviewCPointer.
			OpenGLInterface glGetDoublev: OpenGLInterface GL_PROJECTION_MATRIX
				with: projectionCPointer.
			"self debugShow: projectionCPointer contents."
			OpenGLInterface glGetIntegerv: OpenGLInterface GL_VIEWPORT
				with: viewportCPointer.
			rvpv1Pointer := cDoubleCPointer.
			rvpv2Pointer := cDoubleCPointer + 1.
			rvpv3Pointer := cDoubleCPointer + 2.
			answer := crOpO collect: 
							[:rOpO |
							OpenGLInterface
								gluProject: rOpO x asDouble
								with: rOpO y asDouble
								with: rOpO z asDouble
								with: modelviewCPointer
								with: projectionCPointer
								with: viewportCPointer
								with: rvpv1Pointer
								with: rvpv2Pointer
								with: rvpv3Pointer.
							FullColumn
								with: rvpv1Pointer contents
								with: rvpv2Pointer contents
								with: rvpv3Pointer contents.].
			answer.].
]

{ #category : #defaults }
OpenGLRenderingContext >> defaultNurbsSamplingTolerance [
	^8.0
]

{ #category : #private }
OpenGLRenderingContext >> displayFaceUse: aFaceUse displayMode0: mode [

	| glNurbsSurface ccgluvTrimNurbs cuKnot cvKnot uSize vSize ccPoint ccWeight floatArray cuKnotPointer cvKnotPointer floatArrayPointer |
	glNurbsSurface := aFaceUse glSurface.
	ccgluvTrimNurbs := aFaceUse ccgluvTrimNurbs.
	cuKnot := glNurbsSurface cuKnot collect: [:each | each asFloat].
	cvKnot := glNurbsSurface cvKnot collect: [:each | each asFloat].
	uSize := glNurbsSurface uSize.
	vSize := glNurbsSurface vSize.
	ccPoint := glNurbsSurface ccPoint.
	ccWeight := glNurbsSurface ccWeight.
	floatArray := WriteStream on: Array new.
	1 to: uSize
		do: 
			[:i |
			| ccPointi ccWeighti |
			ccPointi := ccPoint at: i.
			ccWeighti := ccWeight at: i.
			1 to: vSize
				do: 
					[:j |
					| pointij weightij |
					pointij := ccPointi at: j.
					weightij := ccWeighti at: j.
					floatArray nextPut: (pointij x * weightij) asFloat.
					floatArray nextPut: (pointij y * weightij) asFloat.
					floatArray nextPut: (pointij z * weightij) asFloat.
					floatArray nextPut: weightij asFloat]].
	floatArray := floatArray contents.
	cuKnotPointer := JunForeignHeap copyFloatArrayToGcHeap: cuKnot.
	cvKnotPointer := JunForeignHeap copyFloatArrayToGcHeap: cvKnot.
	floatArrayPointer := JunForeignHeap copyFloatArrayToGcHeap: floatArray.
	self activate: 
			[| aNurbsRenderer |
			self _enable: #GL_AUTO_NORMAL.
			aNurbsRenderer := OpenGLInterface gluNewNurbsRenderer.
			OpenGLInterface
				gluNurbsProperty: aNurbsRenderer
				with: OpenGLInterface GLU_CULLING
				with: OpenGLInterface GLU_TRUE.
			OpenGLInterface
				gluNurbsProperty: aNurbsRenderer
				with: OpenGLInterface GLU_SAMPLING_TOLERANCE
				with: nurbsSamplingTolerance.
			OpenGLInterface
				gluNurbsProperty: aNurbsRenderer
				with: OpenGLInterface GLU_DISPLAY_MODE
				with: mode.
			OpenGLInterface gluBeginSurface: aNurbsRenderer.
			OpenGLInterface
				gluNurbsSurface: aNurbsRenderer
				with: cuKnot size
				with: cuKnotPointer
				with: cvKnot size
				with: cvKnotPointer
				with: 4 * vSize
				with: 4
				with: floatArrayPointer
				with: glNurbsSurface uOrder
				with: glNurbsSurface vOrder
				with: OpenGLInterface GL_MAP2_VERTEX_4.
			ccgluvTrimNurbs do: 
					[:cgluvTrimNurbs |
					OpenGLInterface gluBeginTrim: aNurbsRenderer.
					cgluvTrimNurbs do: 
							[:gluvTrimNurbs |
							self
								displayTrimNurbs: gluvTrimNurbs
								aNurbsSurface: glNurbsSurface
								aNurbsRenderer: aNurbsRenderer].
					OpenGLInterface gluEndTrim: aNurbsRenderer].
			OpenGLInterface gluEndSurface: aNurbsRenderer.
			OpenGLInterface gluDeleteNurbsRenderer: aNurbsRenderer]
]

{ #category : #private }
OpenGLRenderingContext >> displayFaceUse: aFaceUse displayMode1: mode [

	| glNurbsSurface ccgluvTrimNurbs cuKnot cvKnot uSize vSize ccPoint ccWeight floatArray cuKnotPointer cvKnotPointer floatArrayPointer |
	glNurbsSurface := aFaceUse glSurface.
	ccgluvTrimNurbs := Array new.
	cuKnot := glNurbsSurface cuKnot collect: [:each | each asFloat].
	cvKnot := glNurbsSurface cvKnot collect: [:each | each asFloat].
	uSize := glNurbsSurface uSize.
	vSize := glNurbsSurface vSize.
	ccPoint := glNurbsSurface ccPoint.
	ccWeight := glNurbsSurface ccWeight.
	floatArray := WriteStream on: Array new.
	1 to: uSize
		do: 
			[:i |
			| ccPointi ccWeighti |
			ccPointi := ccPoint at: i.
			ccWeighti := ccWeight at: i.
			1 to: vSize
				do: 
					[:j |
					| pointij weightij |
					pointij := ccPointi at: j.
					weightij := ccWeighti at: j.
					floatArray nextPut: (pointij x * weightij) asFloat.
					floatArray nextPut: (pointij y * weightij) asFloat.
					floatArray nextPut: (pointij z * weightij) asFloat.
					floatArray nextPut: weightij asFloat]].
	floatArray := floatArray contents.
	cuKnotPointer := JunForeignHeap copyFloatArrayToGcHeap: cuKnot.
	cvKnotPointer := JunForeignHeap copyFloatArrayToGcHeap: cvKnot.
	floatArrayPointer := JunForeignHeap copyFloatArrayToGcHeap: floatArray.
	self activate: 
			[| aNurbsRenderer |
			self _enable: #GL_AUTO_NORMAL.
			aNurbsRenderer := OpenGLInterface gluNewNurbsRenderer.
			OpenGLInterface
				gluNurbsProperty: aNurbsRenderer
				with: OpenGLInterface GLU_CULLING
				with: OpenGLInterface GLU_TRUE.
			OpenGLInterface
				gluNurbsProperty: aNurbsRenderer
				with: OpenGLInterface GLU_SAMPLING_TOLERANCE
				with: nurbsSamplingTolerance.
			OpenGLInterface
				gluNurbsProperty: aNurbsRenderer
				with: OpenGLInterface GLU_DISPLAY_MODE
				with: mode.
			OpenGLInterface gluBeginSurface: aNurbsRenderer.
			OpenGLInterface
				gluNurbsSurface: aNurbsRenderer
				with: cuKnot size
				with: cuKnotPointer
				with: cvKnot size
				with: cvKnotPointer
				with: 4 * vSize
				with: 4
				with: floatArrayPointer
				with: glNurbsSurface uOrder
				with: glNurbsSurface vOrder
				with: OpenGLInterface GL_MAP2_VERTEX_4.
			ccgluvTrimNurbs do: 
					[:cgluvTrimNurbs |
					OpenGLInterface gluBeginTrim: aNurbsRenderer.
					cgluvTrimNurbs do: 
							[:gluvTrimNurbs |
							self
								displayTrimNurbs: gluvTrimNurbs
								aNurbsSurface: glNurbsSurface
								aNurbsRenderer: aNurbsRenderer].
					OpenGLInterface gluEndTrim: aNurbsRenderer].
			OpenGLInterface gluEndSurface: aNurbsRenderer.
			OpenGLInterface gluDeleteNurbsRenderer: aNurbsRenderer]
]

{ #category : #private }
OpenGLRenderingContext >> displayFaceUse: aFaceUse displayMode2: mode [ 
	| aNurbsSurface cuKnot cvKnot uSize vSize ccPoint ccWeight floatArray cuKnotPointer cvKnotPointer floatArrayPointer |
	aFaceUse cLoopUse size > 1 
		ifTrue: 
			[aNurbsSurface := aFaceUse aNurbs.
			cuKnot := aNurbsSurface cuKnot collect: [:each | each asFloat].
			cvKnot := aNurbsSurface cvKnot collect: [:each | each asFloat].
			uSize := aNurbsSurface uSize.
			vSize := aNurbsSurface vSize.
			ccPoint := aNurbsSurface ccPoint.
			ccWeight := aNurbsSurface ccWeight.
			floatArray := WriteStream on: Array new.
			1 to: uSize
				do: 
					[:i | 
					| ccPointi ccWeighti |
					ccPointi := ccPoint at: i.
					ccWeighti := ccWeight at: i.
					1 to: vSize
						do: 
							[:j | 
							| pointij weightij |
							pointij := ccPointi at: j.
							weightij := ccWeighti at: j.
							floatArray nextPut: (pointij x * weightij) asFloat.
							floatArray nextPut: (pointij y * weightij) asFloat.
							floatArray nextPut: (pointij z * weightij) asFloat.
							floatArray nextPut: weightij asFloat]].
			floatArray := floatArray contents.
			cuKnotPointer := JunForeignHeap copyFloatArrayToGcHeap: cuKnot.
			cvKnotPointer := JunForeignHeap copyFloatArrayToGcHeap: cvKnot.
			floatArrayPointer := JunForeignHeap copyFloatArrayToGcHeap: floatArray.
			self activate: 
					[| aNurbsRenderer |
					self _enable: #GL_AUTO_NORMAL.
					aNurbsRenderer := OpenGLInterface gluNewNurbsRenderer.
					OpenGLInterface 
						gluNurbsProperty: aNurbsRenderer
						with: OpenGLInterface GLU_SAMPLING_TOLERANCE
						with: nurbsSamplingTolerance.
					OpenGLInterface 
						gluNurbsProperty: aNurbsRenderer
						with: OpenGLInterface GLU_DISPLAY_MODE
						with: mode.
					OpenGLInterface gluBeginSurface: aNurbsRenderer.
					OpenGLInterface 
						gluNurbsSurface: aNurbsRenderer
						with: cuKnot size
						with: cuKnotPointer
						with: cvKnot size
						with: cvKnotPointer
						with: 4 * vSize
						with: 4
						with: floatArrayPointer
						with: aNurbsSurface uOrder
						with: aNurbsSurface vOrder
						with: OpenGLInterface GL_MAP2_VERTEX_4.
					aFaceUse cLoopUse do: 
							[:aLoopUse | 
							self 
								displayTrimLoopUse: aLoopUse
								aNurbsSurface: aNurbsSurface
								aNurbsRenderer: aNurbsRenderer].
					OpenGLInterface gluEndSurface: aNurbsRenderer.
					OpenGLInterface gluDeleteNurbsRenderer: aNurbsRenderer].
			cuKnotPointer free.
			cvKnotPointer free.
			floatArrayPointer free]
]

{ #category : #private }
OpenGLRenderingContext >> displayFaceUse: aFaceUse displayMode3: mode [ 
	| aNurbsSurface cuKnot cvKnot uSize vSize ccPoint ccWeight floatArray cuKnotPointer cvKnotPointer floatArrayPointer |
	aNurbsSurface := aFaceUse glSurface.
	cuKnot := aNurbsSurface cuKnot collect: [:each | each asFloat].
	cvKnot := aNurbsSurface cvKnot collect: [:each | each asFloat].
	uSize := aNurbsSurface uSize.
	vSize := aNurbsSurface vSize.
	ccPoint := aNurbsSurface ccPoint.
	ccWeight := aNurbsSurface ccWeight.
	floatArray := WriteStream on: Array new.
	1 to: uSize
		do: 
			[:i | 
			| ccPointi ccWeighti |
			ccPointi := ccPoint at: i.
			ccWeighti := ccWeight at: i.
			1 to: vSize
				do: 
					[:j | 
					| pointij weightij |
					pointij := ccPointi at: j.
					weightij := ccWeighti at: j.
					floatArray nextPut: (pointij x * weightij) asFloat.
					floatArray nextPut: (pointij y * weightij) asFloat.
					floatArray nextPut: (pointij z * weightij) asFloat.
					floatArray nextPut: weightij asFloat]].
	floatArray := floatArray contents.
	cuKnotPointer := JunForeignHeap copyFloatArrayToGcHeap: cuKnot.
	cvKnotPointer := JunForeignHeap copyFloatArrayToGcHeap: cvKnot.
	floatArrayPointer := JunForeignHeap copyFloatArrayToGcHeap: floatArray.
	self activate: 
			[| aNurbsRenderer |
			self _enable: #GL_AUTO_NORMAL.
			aNurbsRenderer := OpenGLInterface gluNewNurbsRenderer.
			OpenGLInterface 
				gluNurbsProperty: aNurbsRenderer
				with: OpenGLInterface GLU_CULLING
				with: OpenGLInterface GLU_TRUE.
			OpenGLInterface 
				gluNurbsProperty: aNurbsRenderer
				with: OpenGLInterface GLU_SAMPLING_TOLERANCE
				with: nurbsSamplingTolerance.
			OpenGLInterface 
				gluNurbsProperty: aNurbsRenderer
				with: OpenGLInterface GLU_DISPLAY_MODE
				with: mode.
			OpenGLInterface gluBeginSurface: aNurbsRenderer.
			OpenGLInterface 
				gluNurbsSurface: aNurbsRenderer
				with: cuKnot size
				with: cuKnotPointer
				with: cvKnot size
				with: cvKnotPointer
				with: 4 * vSize
				with: 4
				with: floatArrayPointer
				with: aNurbsSurface uOrder
				with: aNurbsSurface vOrder
				with: OpenGLInterface GL_MAP2_VERTEX_4.
			aFaceUse cLoopUse do: 
					[:aLoopUse | 
					self 
						displayTrimLoopUse: aLoopUse
						aNurbsSurface: aNurbsSurface
						aNurbsRenderer: aNurbsRenderer].
			OpenGLInterface gluEndSurface: aNurbsRenderer.
			OpenGLInterface gluDeleteNurbsRenderer: aNurbsRenderer].
	cuKnotPointer free.
	cvKnotPointer free.
	floatArrayPointer free
]

{ #category : #private }
OpenGLRenderingContext >> displayFaceUse: aFaceUse displayMode4: mode [ 
	| aNurbsSurface cuKnot cvKnot uSize vSize ccPoint ccWeight floatArray cuKnotPointer cvKnotPointer floatArrayPointer |
	aNurbsSurface := aFaceUse glSurface.
	cuKnot := aNurbsSurface cuKnot collect: [:each | each asFloat].
	cvKnot := aNurbsSurface cvKnot collect: [:each | each asFloat].
	uSize := aNurbsSurface uSize.
	vSize := aNurbsSurface vSize.
	ccPoint := aNurbsSurface ccPoint.
	ccWeight := aNurbsSurface ccWeight.
	floatArray := WriteStream on: Array new.
	1 to: uSize
		do: 
			[:i | 
			| ccPointi ccWeighti |
			ccPointi := ccPoint at: i.
			ccWeighti := ccWeight at: i.
			1 to: vSize
				do: 
					[:j | 
					| pointij weightij |
					pointij := ccPointi at: j.
					weightij := ccWeighti at: j.
					floatArray nextPut: (pointij x * weightij) asFloat.
					floatArray nextPut: (pointij y * weightij) asFloat.
					floatArray nextPut: (pointij z * weightij) asFloat.
					floatArray nextPut: weightij asFloat]].
	floatArray := floatArray contents.
	cuKnotPointer := JunForeignHeap copyFloatArrayToGcHeap: cuKnot.
	cvKnotPointer := JunForeignHeap copyFloatArrayToGcHeap: cvKnot.
	floatArrayPointer := JunForeignHeap copyFloatArrayToGcHeap: floatArray.
	self activate: 
			[| aNurbsRenderer |
			self _enable: #GL_AUTO_NORMAL.
			aNurbsRenderer := OpenGLInterface gluNewNurbsRenderer.
			OpenGLInterface 
				gluNurbsProperty: aNurbsRenderer
				with: OpenGLInterface GLU_CULLING
				with: OpenGLInterface GLU_TRUE.
			OpenGLInterface 
				gluNurbsProperty: aNurbsRenderer
				with: OpenGLInterface GLU_SAMPLING_TOLERANCE
				with: nurbsSamplingTolerance.
			OpenGLInterface 
				gluNurbsProperty: aNurbsRenderer
				with: OpenGLInterface GLU_DISPLAY_MODE
				with: mode.
			OpenGLInterface gluBeginSurface: aNurbsRenderer.
			OpenGLInterface 
				gluNurbsSurface: aNurbsRenderer
				with: cuKnot size
				with: cuKnotPointer
				with: cvKnot size
				with: cvKnotPointer
				with: 4 * vSize
				with: 4
				with: floatArrayPointer
				with: aNurbsSurface uOrder
				with: aNurbsSurface vOrder
				with: OpenGLInterface GL_MAP2_VERTEX_4.
					self 
						displayTrimLoopUse: aFaceUse cLoopUse first
						aNurbsSurface: aNurbsSurface
						aNurbsRenderer: aNurbsRenderer.
			OpenGLInterface gluEndSurface: aNurbsRenderer.
			OpenGLInterface gluDeleteNurbsRenderer: aNurbsRenderer].
	cuKnotPointer free.
	cvKnotPointer free.
	floatArrayPointer free
]

{ #category : #private }
OpenGLRenderingContext >> displayFaceUse: aFaceUse displayMode: mode [

	| glNurbsSurface ccgluvTrimNurbs cuKnot cvKnot uSize vSize ccPoint ccWeight floatArray cuKnotPointer cvKnotPointer floatArrayPointer |
	glNurbsSurface := aFaceUse glSurface.
	ccgluvTrimNurbs := aFaceUse ccgluvTrimNurbs.
	cuKnot := glNurbsSurface cuKnot collect: [:each | each asFloat].
	cvKnot := glNurbsSurface cvKnot collect: [:each | each asFloat].
	uSize := glNurbsSurface uSize.
	vSize := glNurbsSurface vSize.
	ccPoint := glNurbsSurface ccPoint.
	ccWeight := glNurbsSurface ccWeight.
	floatArray := WriteStream on: Array new.
	1 to: uSize
		do: 
			[:i |
			| ccPointi ccWeighti |
			ccPointi := ccPoint at: i.
			ccWeighti := ccWeight at: i.
			1 to: vSize
				do: 
					[:j |
					| pointij weightij |
					pointij := ccPointi at: j.
					weightij := ccWeighti at: j.
					floatArray nextPut: (pointij x * weightij) asFloat.
					floatArray nextPut: (pointij y * weightij) asFloat.
					floatArray nextPut: (pointij z * weightij) asFloat.
					floatArray nextPut: weightij asFloat]].
	floatArray := floatArray contents.
	cuKnotPointer := JunForeignHeap copyFloatArrayToGcHeap: cuKnot.
	cvKnotPointer := JunForeignHeap copyFloatArrayToGcHeap: cvKnot.
	floatArrayPointer := JunForeignHeap copyFloatArrayToGcHeap: floatArray.
	self activate: 
			[| aNurbsRenderer |
			self _enable: #GL_AUTO_NORMAL.
			aNurbsRenderer := OpenGLInterface gluNewNurbsRenderer.
			OpenGLInterface
				gluNurbsProperty: aNurbsRenderer
				with: OpenGLInterface GLU_CULLING
				with: OpenGLInterface GLU_TRUE.
			OpenGLInterface
				gluNurbsProperty: aNurbsRenderer
				with: OpenGLInterface GLU_SAMPLING_TOLERANCE
				with: nurbsSamplingTolerance.
			OpenGLInterface
				gluNurbsProperty: aNurbsRenderer
				with: OpenGLInterface GLU_DISPLAY_MODE
				with: mode.
			OpenGLInterface gluBeginSurface: aNurbsRenderer.
			OpenGLInterface
				gluNurbsSurface: aNurbsRenderer
				with: cuKnot size
				with: cuKnotPointer
				with: cvKnot size
				with: cvKnotPointer
				with: 4 * vSize
				with: 4
				with: floatArrayPointer
				with: glNurbsSurface uOrder
				with: glNurbsSurface vOrder
				with: OpenGLInterface GL_MAP2_VERTEX_4.
			ccgluvTrimNurbs do: 
					[:cgluvTrimNurbs |
					OpenGLInterface gluBeginTrim: aNurbsRenderer.
					cgluvTrimNurbs do: 
							[:gluvTrimNurbs |
							self
								displayTrimNurbs: gluvTrimNurbs
								aNurbsSurface: glNurbsSurface
								aNurbsRenderer: aNurbsRenderer].
					OpenGLInterface gluEndTrim: aNurbsRenderer].
			OpenGLInterface gluEndSurface: aNurbsRenderer.
			OpenGLInterface gluDeleteNurbsRenderer: aNurbsRenderer]
]

{ #category : #displaying }
OpenGLRenderingContext >> displayImage: aOpenGLImage rOpO: rOpO [ 
	self activate: 
			[OpenGLInterface glPixelStorei: OpenGLInterface GL_UNPACK_ALIGNMENT with: 1.
			OpenGLInterface 
				glRasterPos3d: rOpO x
				with: rOpO y
				with: rOpO z.
			OpenGLInterface 
				glDrawPixels: aOpenGLImage width
				with: aOpenGLImage height
				with: OpenGLInterface GL_RGB
				with: OpenGLInterface GL_UNSIGNED_BYTE
				with: aOpenGLImage pointerOfPixels]
]

{ #category : #displaying }
OpenGLRenderingContext >> displayImage: aOpenGLImage rOpO: rOpO rpqv: rpqv [ 
	"
	rOpO =  r from O to p in O components.
	rpqv = r from p to q (image lower left corner) in viewport components.
	"

	| rOqO |
	rOqO := self rOqOFromrOpO: rOpO rpqv: rpqv.
	self displayImage: aOpenGLImage rOpO: rOqO
]

{ #category : #displaying }
OpenGLRenderingContext >> displayLineFromrOpO: rOpO rpqv: rpqv [ 
	"
	"

	| rOqO |
	self lineWidth: 1.
	self paint: ColorValue yellow.
	rOqO := self rOqOFromrOpO: rOpO rpqv: rpqv.
	self displayLine: (Array with: rOpO with: rOqO)
]

{ #category : #displaying }
OpenGLRenderingContext >> displayNurbsCurve: aNurbsCurve [ 
	| aNurbs knotVector controlPoints weights floatArray |
	knotVector := aNurbsCurve knotVector collect: [:each | each asFloat].
	controlPoints := aNurbsCurve controlPoints.
	weights := aNurbsCurve weights.
	floatArray := WriteStream on: Array new.
	controlPoints with: weights
		do: 
			[:point :weight | 
			floatArray nextPut: (point x * weight) asFloat.
			floatArray nextPut: (point y * weight) asFloat.
			floatArray nextPut: (point z * weight) asFloat.
			floatArray nextPut: weight asFloat].
	floatArray := floatArray contents.
	self activate: 
			[self _enable: #GL_AUTO_NORMAL.
			aNurbs := OpenGLInterface gluNewNurbsRenderer.
			OpenGLInterface 
				gluNurbsProperty: aNurbs
				with: OpenGLInterface GLU_SAMPLING_TOLERANCE
				with: nurbsSamplingTolerance.
			OpenGLInterface glPushMatrix.
			OpenGLInterface gluBeginCurve: aNurbs.
			OpenGLInterface 
				gluNurbsCurve: aNurbs
				with: knotVector size
				with: (JunForeignHeap copyFloatArrayToGcHeap: knotVector)
				with: 4
				with: (JunForeignHeap copyFloatArrayToGcHeap: floatArray)
				with: aNurbsCurve order
				with: OpenGLInterface GL_MAP1_VERTEX_4.
			OpenGLInterface gluEndCurve: aNurbs.
			OpenGLInterface glPopMatrix.
			OpenGLInterface gluDeleteNurbsRenderer: aNurbs]
]

{ #category : #displaying }
OpenGLRenderingContext >> displayNurbsSurface: aNurbsSurface [ 
	| savedPaint |
	self presentation = #wireframe 
		ifTrue: 
			[self displayNurbsSurface: aNurbsSurface
				displayMode: OpenGLInterface GLU_OUTLINE_POLYGON.
			^self].
	self presentation = #hiddenline 
		ifTrue: 
			[self disableLighting.
			savedPaint := nil.
			self paint = ColorValue white 
				ifTrue: 
					[savedPaint := self paint.
					self paint: (ColorValue brightness: 0.95)].
			OpenGLInterface glEnable: OpenGLInterface GL_DEPTH_TEST.
			OpenGLInterface glPolygonMode: OpenGLInterface GL_FRONT_AND_BACK
				with: OpenGLInterface GL_LINE.
			self displayNurbsSurface: aNurbsSurface
				displayMode: OpenGLInterface GLU_OUTLINE_POLYGON.
			savedPaint isNil ifFalse: [self paint: savedPaint].
			savedPaint := self paint.
			self paint: ColorValue white.
			OpenGLInterface glPolygonMode: OpenGLInterface GL_FRONT_AND_BACK
				with: OpenGLInterface GL_FILL.
			OpenGLInterface glEnable: OpenGLInterface GL_POLYGON_OFFSET_FILL.
			OpenGLInterface glPolygonOffset: 1.0 with: 1.0.
			self displayNurbsSurface: aNurbsSurface
				displayMode: OpenGLInterface GLU_FILL.
			OpenGLInterface glDisable: OpenGLInterface GL_POLYGON_OFFSET_FILL.
			self paint: savedPaint.
			self enableLighting.
			^self].
	^self displayNurbsSurface: aNurbsSurface
		displayMode: OpenGLInterface GLU_FILL
]

{ #category : #private }
OpenGLRenderingContext >> displayNurbsSurface: aNurbsSurface displayMode: mode [ 
	| aNurbs uKnotVector vKnotVector floatArray uSize vSize |
	uKnotVector := aNurbsSurface uKnotVector collect: [:each | each asFloat].
	vKnotVector := aNurbsSurface vKnotVector collect: [:each | each asFloat].
	uSize := aNurbsSurface uSize.
	vSize := aNurbsSurface vSize.
	floatArray := WriteStream on: Array new.
	1 to: uSize
		do: 
			[:uIndex | 
			1 to: vSize
				do: 
					[:vIndex | 
					| point weight |
					point := aNurbsSurface controlPointAtU: uIndex v: vIndex.
					weight := aNurbsSurface weightAtU: uIndex v: vIndex.
					floatArray nextPut: (point x * weight) asFloat.
					floatArray nextPut: (point y * weight) asFloat.
					floatArray nextPut: (point z * weight) asFloat.
					floatArray nextPut: weight asFloat]].
	floatArray := floatArray contents.
	self activate: 
			[self _enable: #GL_AUTO_NORMAL.
			aNurbs := OpenGLInterface gluNewNurbsRenderer.
			OpenGLInterface 
				gluNurbsProperty: aNurbs
				with: OpenGLInterface GLU_SAMPLING_TOLERANCE
				with: nurbsSamplingTolerance.
			OpenGLInterface 
				gluNurbsProperty: aNurbs
				with: OpenGLInterface GLU_DISPLAY_MODE
				with: mode.
			OpenGLInterface glPushMatrix.
			OpenGLInterface gluBeginSurface: aNurbs.
			OpenGLInterface 
				gluNurbsSurface: aNurbs
				with: uKnotVector size
				with: (JunForeignHeap copyFloatArrayToGcHeap: uKnotVector)
				with: vKnotVector size
				with: (JunForeignHeap copyFloatArrayToGcHeap: vKnotVector)
				with: 4 * vSize
				with: 4
				with: (JunForeignHeap copyFloatArrayToGcHeap: floatArray)
				with: aNurbsSurface uOrder
				with: aNurbsSurface vOrder
				with: OpenGLInterface GL_MAP2_VERTEX_4.
			aNurbsSurface trimCurvesDo: 
					[:trimCurve | 
					trimCurve 
						renderOn: self
						with: aNurbsSurface
						for: aNurbs].
			OpenGLInterface gluEndSurface: aNurbs.
			OpenGLInterface glPopMatrix.
			OpenGLInterface gluDeleteNurbsRenderer: aNurbs]
]

{ #category : #displaying }
OpenGLRenderingContext >> displayRotateHandle1: aRotateHandle [ 
	| aOpenGLImage rOpO rvpv xOffset rpqv |
	aOpenGLImage := OpenGLImage aImage: aRotateHandle image.
	rOpO := aRotateHandle aSpatialItem aBoundingBox center.
	rvpv := self rvpvFromrOpO: rOpO.
	xOffset := 100.0d.
	rvpv at: 1 plusNumber: xOffset.
	aRotateHandle originPx: rvpv.
	rpqv := FullColumn 
				with: (aOpenGLImage width // 2 + 1) negated asDouble + xOffset
				with: (aOpenGLImage height // 2) negated asDouble
				with: 0.0d.
	self 
		displayImage: aOpenGLImage
		rOpO: rOpO
		rpqv: rpqv.
	rpqv := FullColumn 
				with: xOffset
				with: 0.0d
				with: 0.0d.
	self displayLineFromrOpO: rOpO rpqv: rpqv
]

{ #category : #displaying }
OpenGLRenderingContext >> displayRotateHandle: aRotateHandle [ 
	"Add 0.01d to remove rounding jitter."

	| aOpenGLImage rOpO rvpv xOffset rpqv rqsv |
	aOpenGLImage := OpenGLImage aImage: aRotateHandle image.
	rOpO := aRotateHandle aSpatialItem aBoundingBox center.
	rvpv := (self rvpvFromrOpO: rOpO) plusNumber: 0.01d.
	xOffset := 100.0d.
	rpqv := FullColumn 
				with: xOffset
				with: 0.0d
				with: 0.0d.
	aRotateHandle originPx: rvpv + rpqv.
	rqsv := FullColumn 
				with: (aOpenGLImage width // 2 + 1) negated asDouble
				with: (aOpenGLImage height // 2) negated asDouble
				with: 0.0d.
	self inScreenCoordDo: 
			[self displayImage: aOpenGLImage rOpO: rvpv + rpqv + rqsv.
			self lineWidth: 1.
			self paint: ColorValue yellow.
			self displayLine: (Array with: rvpv with: rvpv + rpqv)]
]

{ #category : #displaying }
OpenGLRenderingContext >> displayTiltHandle1: aTiltHandle [ 
	| aOpenGLImage rOpO rpqv |
	aOpenGLImage := OpenGLImage aImage: aTiltHandle image.
	rOpO := aTiltHandle aSpatialItem aBoundingBox center.
	aTiltHandle originPx: (self rvpvFromrOpO: rOpO).
	rpqv := FullColumn 
				with: (aOpenGLImage width // 2 + 1) negated asDouble
				with: (aOpenGLImage height // 2) negated asDouble
				with: 0.0d.
	self 
		displayImage: aOpenGLImage
		rOpO: rOpO
		rpqv: rpqv
]

{ #category : #displaying }
OpenGLRenderingContext >> displayTiltHandle2: aTiltHandle [ 
	"Add 0.01d to remove rounding jitter."

	| aOpenGLImage rOpO rpqv rvpv |
	aOpenGLImage := OpenGLImage aImage: aTiltHandle image.
	rOpO := aTiltHandle aSpatialItem aBoundingBox center.
	rvpv := (self rvpvFromrOpO: rOpO) plusNumber: 0.01d.
	aTiltHandle originPx: rvpv.
	rpqv := FullColumn 
				with: (aOpenGLImage width // 2 + 1) negated asDouble
				with: (aOpenGLImage height // 2) negated asDouble
				with: 0.0d.
	self inScreenCoordDo: [self displayImage: aOpenGLImage rOpO: rvpv + rpqv]
]

{ #category : #displaying }
OpenGLRenderingContext >> displayTiltHandle: aTiltHandle [ 
	"Add 0.01d to remove rounding jitter."

	| aOpenGLImage rOpO rpqv rvpv |
	aOpenGLImage := OpenGLImage aImage: aTiltHandle image.
	rOpO := aTiltHandle aSpatialItem aBoundingBox center.
	rvpv := (self rvpvFromrOpO: rOpO) plusNumber: 0.01d.
	aTiltHandle originPx: rvpv.
	rpqv := FullColumn 
				with: (aOpenGLImage width // 2 + 1) negated asDouble
				with: (aOpenGLImage height // 2) negated asDouble
				with: 0.0d.
	self inScreenCoordDo: 
			[self displayImage: aOpenGLImage rOpO: rvpv + rpqv.
			"self debugShow: (self rvpvFromrOpO: rvpv + rpqv)"]
]

{ #category : #displaying }
OpenGLRenderingContext >> displayTrimLoopUse: aLoopUse aNurbsSurface: aNurbsSurface aNurbsRenderer000: aNurbsRenderer [

	| cPoint aPoint bPoint aNurbs |
	cPoint := OrderedCollection new.
	aLoopUse cglTrimNurbs do: 
			[:glTrimNurbs |
			| acPoint |
			acPoint := glTrimNurbs cPoint.
			(1 to: acPoint size - 1 by: 20) do: [:i | cPoint add: (acPoint at: i)]].
	cPoint add: cPoint first.
	OpenGLInterface gluBeginTrim: aNurbsRenderer.
	aPoint := cPoint first.
	2 to: cPoint size
		do: 
			[:i |
			bPoint := cPoint at: i.
			aNurbs := NurbsCurve fromStart: aPoint copy toEnd: bPoint copy.
			aPoint := bPoint.
			self
				displayTrimNurbs: aNurbs
				aNurbsSurface: aNurbsSurface
				aNurbsRenderer: aNurbsRenderer].
	OpenGLInterface gluEndTrim: aNurbsRenderer
]

{ #category : #displaying }
OpenGLRenderingContext >> displayTrimLoopUse: aLoopUse aNurbsSurface: aNurbsSurface aNurbsRenderer00: aNurbsRenderer [ 
	| cPoint aPoint bPoint aNurbs |
	OpenGLInterface gluBeginTrim: aNurbsRenderer.
	cPoint := OrderedCollection new.
	cPoint 
		add: (FullColumn newWithElements: #(0.89306376501028d 0.05286776856637d)).
	cPoint add: (FullColumn 
				newWithElements: #(0.91051005031531d 0.050416305423135d)).
	cPoint 
		add: (FullColumn newWithElements: #(0.55956198999169d 0.12434274142751d)).
	cPoint 
		add: (FullColumn newWithElements: #(0.32822830038302d 0.21341458877918d)).
	cPoint 
		add: (FullColumn newWithElements: #(0.31864019344699d 0.50710408340249d)).
	cPoint 
		add: (FullColumn newWithElements: #(0.29910843245846d 0.74126103634664d)).
	cPoint 
		add: (FullColumn newWithElements: #(0.29862089017272d 0.74845943579944d)).
	cPoint 
		add: (FullColumn newWithElements: #(0.85355642432794d 0.96640565341161d)).
	cPoint 
		add: (FullColumn newWithElements: #(0.99473935872219d 0.98882289731593d)).
	cPoint 
		add: (FullColumn newWithElements: #(0.72410380782429d 0.99898389640984d)).
	cPoint 
		add: (FullColumn newWithElements: #(0.5910902646662d 0.97512508160207d)).
	cPoint add: (FullColumn 
				newWithElements: #(0.0052606413749663d 0.76453788056835d)).
	cPoint add: (FullColumn 
				newWithElements: #(0.0052606412602262d 0.25425883608951d)).
	cPoint add: (FullColumn 
				newWithElements: #(0.36096422706368d 0.090423628771569d)).
	cPoint 
		add: (FullColumn newWithElements: #(0.5910902647298d 0.043671635072852d)).
	cPoint add: (FullColumn 
				newWithElements: #(0.82889601567772d 0.0010161035901582d)).
	cPoint add: cPoint first.
	aPoint := cPoint first.
	2 to: cPoint size
		do: 
			[:i | 
			bPoint := cPoint at: i.
			aNurbs := NurbsCurve fromStart: aPoint copy toEnd: bPoint copy.
			aPoint := bPoint.
			self 
				displayTrimNurbs: aNurbs
				aNurbsSurface: aNurbsSurface
				aNurbsRenderer: aNurbsRenderer].
	OpenGLInterface gluEndTrim: aNurbsRenderer
]

{ #category : #displaying }
OpenGLRenderingContext >> displayTrimLoopUse: aLoopUse aNurbsSurface: aNurbsSurface aNurbsRenderer0: aNurbsRenderer [ 
	| cPoint aPoint bPoint aNurbs |
	OpenGLInterface gluBeginTrim: aNurbsRenderer.
	cPoint := OrderedCollection new.
	cPoint add: (FullColumn with: 0.0d with: 0.0d).
	cPoint add: (FullColumn with: 1.0d with: 0.0d).
	cPoint add: (FullColumn with: 1.0d with: 1.0d).
	cPoint add: (FullColumn with: 0.0d with: 1.0d).
	cPoint add: cPoint first.
	aPoint := cPoint first.
	2 to: cPoint size
		do: 
			[:i | 
			bPoint := cPoint at: i.
			aNurbs := NurbsCurve fromStart: aPoint copy toEnd: bPoint copy.
			aPoint := bPoint.
			self 
				displayTrimNurbs: aNurbs
				aNurbsSurface: aNurbsSurface
				aNurbsRenderer: aNurbsRenderer].
	OpenGLInterface gluEndTrim: aNurbsRenderer
]

{ #category : #displaying }
OpenGLRenderingContext >> displayTrimLoopUse: aLoopUse aNurbsSurface: aNurbsSurface aNurbsRenderer1: aNurbsRenderer [ 
	OpenGLInterface gluBeginTrim: aNurbsRenderer.
	aLoopUse cglTrimNurbs do: 
			[:glTrimNurbs | 
			self 
				displayTrimNurbs: glTrimNurbs
				aNurbsSurface: aNurbsSurface
				aNurbsRenderer: aNurbsRenderer].
	OpenGLInterface gluEndTrim: aNurbsRenderer
]

{ #category : #displaying }
OpenGLRenderingContext >> displayTrimLoopUse: aLoopUse aNurbsSurface: aNurbsSurface aNurbsRenderer2: aNurbsRenderer [ 
	| cPoint aNurbs |
	OpenGLInterface gluBeginTrim: aNurbsRenderer.
	cPoint := OrderedCollection new.
	cPoint add: (FullColumn with: 0.0d with: 0.0d).
	cPoint add: (FullColumn with: 1.0d with: 0.0d).
	cPoint add: (FullColumn with: 1.0d with: 1.0d).
	cPoint add: (FullColumn with: 0.0d with: 1.0d).
	cPoint add: cPoint first.
	aNurbs := NurbsCurve fromcDataPoint: cPoint uDegree: 1.
	self 
		displayTrimNurbs: aNurbs
		aNurbsSurface: aNurbsSurface
		aNurbsRenderer: aNurbsRenderer.
	OpenGLInterface gluEndTrim: aNurbsRenderer
]

{ #category : #displaying }
OpenGLRenderingContext >> displayTrimLoopUse: aLoopUse aNurbsSurface: aNurbsSurface aNurbsRenderer30: aNurbsRenderer [ 
	| aStream cglTrimNurbs aNurbs |
	OpenGLInterface gluBeginTrim: aNurbsRenderer.
	aStream := (FullColumn new: 10) writeStream.
	cglTrimNurbs := aLoopUse cglTrimNurbs.
	cglTrimNurbs 
		do: [:glTrimNurbs | aStream nextPutAll: (glTrimNurbs cPoint copy allButLast: 1)].
	aStream nextPut: cglTrimNurbs first cPoint first copy.
	aNurbs := NurbsCurve fromcDataPoint: aStream contents uDegree: 1.
	self 
		displayTrimNurbs: aNurbs
		aNurbsSurface: aNurbsSurface
		aNurbsRenderer: aNurbsRenderer.
	OpenGLInterface gluEndTrim: aNurbsRenderer
]

{ #category : #displaying }
OpenGLRenderingContext >> displayTrimLoopUse: aLoopUse aNurbsSurface: aNurbsSurface aNurbsRenderer31: aNurbsRenderer [

	| aStream cglTrimNurbs aNurbs |
	OpenGLInterface gluBeginTrim: aNurbsRenderer.
	aStream := (FullColumn new: 10) writeStream.
	cglTrimNurbs := aLoopUse cglTrimNurbs.
	cglTrimNurbs do: 
			[:glTrimNurbs |
			| cPoint |
			cPoint := glTrimNurbs cPoint.
			(1 to: cPoint size - 1 by: 15) do: [:i | aStream nextPut: (cPoint at: i)]].
	aStream nextPut: cglTrimNurbs first cPoint first copy.
	aNurbs := NurbsCurve fromcDataPoint: aStream contents uDegree: 1.
	Dummy := aNurbs.
	self
		displayTrimNurbs: aNurbs
		aNurbsSurface: aNurbsSurface
		aNurbsRenderer: aNurbsRenderer.
	OpenGLInterface gluEndTrim: aNurbsRenderer
]

{ #category : #displaying }
OpenGLRenderingContext >> displayTrimLoopUse: aLoopUse aNurbsSurface: aNurbsSurface aNurbsRenderer3: aNurbsRenderer [ 
	| aStream cglTrimNurbs aNurbs |
	OpenGLInterface gluBeginTrim: aNurbsRenderer.
	aStream := (FullColumn new: 10) writeStream.
	cglTrimNurbs := aLoopUse cglTrimNurbs.
	cglTrimNurbs 
		do: [:glTrimNurbs | aStream nextPut: glTrimNurbs cPoint first copy].
	aStream nextPut: cglTrimNurbs first cPoint first copy.
	aNurbs := NurbsCurve fromcDataPoint: aStream contents uDegree: 1.
	self 
		displayTrimNurbs: aNurbs
		aNurbsSurface: aNurbsSurface
		aNurbsRenderer: aNurbsRenderer.
	OpenGLInterface gluEndTrim: aNurbsRenderer
]

{ #category : #displaying }
OpenGLRenderingContext >> displayTrimLoopUse: aLoopUse aNurbsSurface: aNurbsSurface aNurbsRenderer4: aNurbsRenderer [ 
	| tol uvStart uvEnd cNurbs v aPoint bPoint cPoint dPoint |
	OpenGLInterface gluBeginTrim: aNurbsRenderer.
	aLoopUse cEdgeUse do: 
			[:aEdgeUse | 
			aEdgeUse glNurbs cLineNurbs do: 
					[:aLine | 
					self 
						displayTrimNurbs: aLine
						aNurbsSurface: aNurbsSurface
						aNurbsRenderer: aNurbsRenderer]].
	tol := 1.0d-9.
	uvStart := aLoopUse uvStart.
	uvEnd := aLoopUse uvEnd.
	(uvStart - uvEnd) length < tol 
		ifFalse: 
			[(aLoopUse aSurface isMemberOf: SphericalSurface) 
				ifTrue: 
					[cNurbs := OrderedCollection new: 3.
					v := uvStart u < uvEnd u ifTrue: [1.0d] ifFalse: [0.0d].
					aPoint := uvEnd.
					bPoint := FullColumn with: uvEnd u with: v.
					cPoint := FullColumn with: uvStart u with: v.
					dPoint := uvStart.
					cNurbs add: (NurbsCurve fromStart: aPoint copy toEnd: bPoint copy).
					cNurbs add: (NurbsCurve fromStart: bPoint copy toEnd: cPoint copy).
					cNurbs add: (NurbsCurve fromStart: cPoint copy toEnd: dPoint copy).
					cNurbs do: 
							[:aNurbs | 
							self 
								displayTrimNurbs: aNurbs
								aNurbsSurface: aNurbsSurface
								aNurbsRenderer: aNurbsRenderer]]
				ifFalse: [self assert: [false]]].
	OpenGLInterface gluEndTrim: aNurbsRenderer
]

{ #category : #displaying }
OpenGLRenderingContext >> displayTrimLoopUse: aLoopUse aNurbsSurface: aNurbsSurface aNurbsRenderer5: aNurbsRenderer [ 
	| cEdgeUse n glNurbs |
	cEdgeUse := aLoopUse cEdgeUse.
	n := cEdgeUse size.
	OpenGLInterface gluBeginTrim: aNurbsRenderer.
	cEdgeUse := aLoopUse cEdgeUse.
	1 to: n
		do: 
			[:i | 
			| aEdgeUse |
			aEdgeUse := cEdgeUse at: i.
			glNurbs := ((n = 2 
						ifTrue: [#()	"1"	"2"]
						ifFalse: [#(2 4 6 8 10 12 14 16)	"1"	"3"	"5"	"7"	"9"	"11"	"13"	"15"]) 
							includes: i) 
							ifTrue: [NurbsCurve fromStart: aEdgeUse uvStart toEnd: aEdgeUse uvEnd]
							ifFalse: [aEdgeUse glNurbs].
			self 
				displayTrimNurbs: glNurbs
				aNurbsSurface: aNurbsSurface
				aNurbsRenderer: aNurbsRenderer].
	OpenGLInterface gluEndTrim: aNurbsRenderer
]

{ #category : #displaying }
OpenGLRenderingContext >> displayTrimLoopUse: aLoopUse aNurbsSurface: aNurbsSurface aNurbsRenderer6: aNurbsRenderer [ 
	| cglTrimNurbs n uvStart uvEnd |
	OpenGLInterface gluBeginTrim: aNurbsRenderer.
	cglTrimNurbs := aLoopUse cglTrimNurbs.
	n := cglTrimNurbs size.
	1 to: n
		do: 
			[:i | 
			| glTrimNurbs |
			glTrimNurbs := i = 1 
						ifTrue: [cglTrimNurbs at: i]
						ifFalse: 
							[uvStart := (cglTrimNurbs at: (i - 1 cyclic: n)) cPoint last.
							uvEnd := (cglTrimNurbs at: (i + 1 cyclic: n)) cPoint first.
							NurbsCurve fromStart: uvStart toEnd: uvEnd].
			self 
				displayTrimNurbs: glTrimNurbs
				aNurbsSurface: aNurbsSurface
				aNurbsRenderer: aNurbsRenderer].
	OpenGLInterface gluEndTrim: aNurbsRenderer
]

{ #category : #displaying }
OpenGLRenderingContext >> displayTrimLoopUse: aLoopUse aNurbsSurface: aNurbsSurface aNurbsRenderer7: aNurbsRenderer [ 
	| cglTrimNurbs n uvStart uvEnd |
	OpenGLInterface gluBeginTrim: aNurbsRenderer.
	cglTrimNurbs := aLoopUse cglTrimNurbs.
	n := cglTrimNurbs size.
	1 to: n
		do: 
			[:i | 
			| glTrimNurbs |
			glTrimNurbs := i = 1 
						ifTrue: 
							[uvStart := (cglTrimNurbs at: (i - 1 cyclic: n)) cPoint last.
							uvEnd := (cglTrimNurbs at: (i + 1 cyclic: n)) cPoint first.
							NurbsCurve fromStart: uvStart toEnd: uvEnd]
						ifFalse: [cglTrimNurbs at: i].
			self 
				displayTrimNurbs: glTrimNurbs
				aNurbsSurface: aNurbsSurface
				aNurbsRenderer: aNurbsRenderer].
	OpenGLInterface gluEndTrim: aNurbsRenderer
]

{ #category : #displaying }
OpenGLRenderingContext >> displayTrimLoopUse: aLoopUse aNurbsSurface: aNurbsSurface aNurbsRenderer: aNurbsRenderer [ 
	| cPoint aPoint bPoint aNurbs |
	OpenGLInterface gluBeginTrim: aNurbsRenderer.
	cPoint := OrderedCollection new.
	cPoint add: (FullColumn with: 0.0d with: 0.0d).
	cPoint add: (FullColumn with: 1.0d with: 0.0d).
	cPoint add: (FullColumn with: 1.0d with: 1.0d).
	cPoint add: (FullColumn with: 0.0d with: 1.0d).
	cPoint add: cPoint first.
	aPoint := cPoint first.
	2 to: cPoint size
		do: 
			[:i | 
			bPoint := cPoint at: i.
			aNurbs := NurbsCurve fromStart: aPoint copy toEnd: bPoint copy.
			aPoint := bPoint.
			self 
				displayTrimNurbs: aNurbs
				aNurbsSurface: aNurbsSurface
				aNurbsRenderer: aNurbsRenderer].
	OpenGLInterface gluEndTrim: aNurbsRenderer
]

{ #category : #displaying }
OpenGLRenderingContext >> displayTrimNurbs: aNurbsCurve aNurbsSurface: aNurbsSurface aNurbsRenderer0: aNurbsRenderer [ 
	| cuKnot cPoint cWeight floatArray cuKnotPointer floatArrayPointer |
	cuKnot := aNurbsCurve cuKnot collect: [:each | each asFloat].
	cPoint := aNurbsCurve cPoint.
	cWeight := aNurbsCurve cWeight.
	floatArray := WriteStream on: Array new.
	1 to: cPoint size
		do: 
			[:i | 
			| point weight |
			point := cPoint at: i.
			weight := cWeight at: i.
			floatArray nextPut: (point x * weight) asFloat.
			floatArray nextPut: (point y * weight) asFloat.
			floatArray nextPut: weight asFloat].
	floatArray := floatArray contents.
	cuKnotPointer := JunForeignHeap copyFloatArrayToGcHeap: cuKnot.
	floatArrayPointer := JunForeignHeap copyFloatArrayToGcHeap: floatArray.
	OpenGLInterface 
		gluNurbsCurve: aNurbsRenderer
		with: cuKnot size
		with: cuKnotPointer
		with: 3
		with: floatArrayPointer
		with: aNurbsCurve order
		with: OpenGLInterface GLU_MAP1_TRIM_3.
]

{ #category : #displaying }
OpenGLRenderingContext >> displayTrimNurbs: aNurbsCurve aNurbsSurface: aNurbsSurface aNurbsRenderer1: aNurbsRenderer [

	| cuKnot cPoint cWeight floatArray cuKnotPointer floatArrayPointer |
	cuKnot := aNurbsCurve cuKnot collect: [:each | each asFloat].
	cPoint := aNurbsCurve cPoint.
	cWeight := aNurbsCurve cWeight.
	floatArray := WriteStream on: Array new.
	1 to: cPoint size
		do: 
			[:i |
			| point weight |
			point := cPoint at: i.
			weight := cWeight at: i.
			floatArray nextPut: (point x * weight * 0.9d) asFloat.
			floatArray nextPut: (point y * weight * 0.9d) asFloat.
			floatArray nextPut: weight asFloat].
	floatArray := floatArray contents.
	Transcript cr; show: floatArray printString.
	cuKnotPointer := JunForeignHeap copyFloatArrayToGcHeap: cuKnot.
	floatArrayPointer := JunForeignHeap copyFloatArrayToGcHeap: floatArray.
	OpenGLInterface
		gluNurbsCurve: aNurbsRenderer
		with: cuKnot size
		with: cuKnotPointer
		with: 3
		with: floatArrayPointer
		with: aNurbsCurve order
		with: OpenGLInterface GLU_MAP1_TRIM_3.
]

{ #category : #displaying }
OpenGLRenderingContext >> displayTrimNurbs: aNurbsCurve aNurbsSurface: aNurbsSurface aNurbsRenderer: aNurbsRenderer [ 
	| cuKnot cPoint cWeight floatArray cuKnotPointer floatArrayPointer |
	cuKnot := aNurbsCurve cuKnot collect: [:each | each asFloat].
	cPoint := aNurbsCurve cPoint.
	cWeight := aNurbsCurve cWeight.
	floatArray := WriteStream on: Array new.
	1 to: cPoint size
		do: 
			[:i | 
			| point weight |
			point := cPoint at: i.
			weight := cWeight at: i.
			floatArray nextPut: (point x * weight) asFloat.
			floatArray nextPut: (point y * weight) asFloat.
			floatArray nextPut: weight asFloat].
	floatArray := floatArray contents.
	cuKnotPointer := JunForeignHeap copyFloatArrayToGcHeap: cuKnot.
	floatArrayPointer := JunForeignHeap copyFloatArrayToGcHeap: floatArray.
	OpenGLInterface 
		gluNurbsCurve: aNurbsRenderer
		with: cuKnot size
		with: cuKnotPointer
		with: 3
		with: floatArrayPointer
		with: aNurbsCurve order
		with: OpenGLInterface GLU_MAP1_TRIM_3.

]

{ #category : #transformation }
OpenGLRenderingContext >> inScreenCoordDo1: aBlock [ 
	self activate: 
			[OpenGLInterface glMatrixMode: OpenGLInterface GL_PROJECTION.
			OpenGLInterface glPushMatrix.
			OpenGLInterface glLoadIdentity.
			OpenGLInterface 
				gluOrtho2D: 0.0d
				with: medium extent x asDouble
				with: 0.0d
				with: medium extent y asDouble.
			OpenGLInterface glMatrixMode: OpenGLInterface GL_MODELVIEW.
			OpenGLInterface glPushMatrix.
			OpenGLInterface glLoadIdentity].
	aBlock ensure: 
			[self activate: 
					[OpenGLInterface glMatrixMode: OpenGLInterface GL_PROJECTION.
					OpenGLInterface glPopMatrix.
					OpenGLInterface glMatrixMode: OpenGLInterface GL_MODELVIEW.
					OpenGLInterface glPopMatrix]]
]

{ #category : #transformation }
OpenGLRenderingContext >> inScreenCoordDo: aBlock [ 
	self activate: 
			[OpenGLInterface glMatrixMode: OpenGLInterface GL_PROJECTION.
			OpenGLInterface glPushMatrix.
			OpenGLInterface glLoadIdentity.
			OpenGLInterface 
				glOrtho: 1.0d
				with: medium extent x asDouble
				with: 1.0d
				with: medium extent y asDouble
				with: -100.0d
				with: 100.0d.
			OpenGLInterface glMatrixMode: OpenGLInterface GL_MODELVIEW.
			OpenGLInterface glPushMatrix.
			OpenGLInterface glLoadIdentity].
	aBlock ensure: 
			[self activate: 
					[OpenGLInterface glMatrixMode: OpenGLInterface GL_PROJECTION.
					OpenGLInterface glPopMatrix.
					OpenGLInterface glMatrixMode: OpenGLInterface GL_MODELVIEW.
					OpenGLInterface glPopMatrix]]
]

{ #category : #'initialize-release' }
OpenGLRenderingContext >> initialize [
	super initialize.
	modelviewCPointer := OpenGLInterface GLdouble gcMalloc: 16.
	projectionCPointer := OpenGLInterface GLdouble gcMalloc: 16.
	viewportCPointer := OpenGLInterface GLint gcMalloc: 4.
	cDoubleCPointer := OpenGLInterface GLdouble gcMalloc: 4
]

{ #category : #'display list' }
OpenGLRenderingContext >> isDisplayList: anInteger [ 
	| integer |
	integer := self activate: [OpenGLInterface glIsList: anInteger].
	^integer == 1 
		ifTrue: [true]
		ifFalse: [integer == 0 ifTrue: [false] ifFalse: [self halt: 'check this']]
]

{ #category : #projection }
OpenGLRenderingContext >> obeyCamera: aCamera [ 
	self perform: aCamera shading.
	self disableLineSmooth.
	self disablePolygonSmooth.
	self disableBlending.
	aCamera lineSmooth 
		ifTrue: 
			[self lineSmoothNicest.
			self enableLineSmooth.
			self enableBlending].
	aCamera polygonSmooth 
		ifTrue: 
			[self polygonSmoothFastest.
			self enablePolygonSmooth.
			self enableBlending]
]

{ #category : #projection }
OpenGLRenderingContext >> obeyParallelCamera: aCamera [ 
	self obeyCamera: aCamera.
	self parallelProjection: aCamera.
	self flush
]

{ #category : #projection }
OpenGLRenderingContext >> obeyPerspectiveCamera: aCamera [ 
	self obeyCamera: aCamera.
	self perspectiveCorrectionHint.
	self perspective: aCamera.
	self flush
]

{ #category : #projection }
OpenGLRenderingContext >> parallelProjection: aCamera [ 
	| aspect halfHeight halfWidth left right bottom top |
	self setProjection: aCamera copy.
	aCamera isPerspective 
		ifTrue: 
			[aspect := (viewport width / viewport height) asDouble.
			halfHeight := projection height / 2.
			halfWidth := halfHeight * aspect.
			left := halfWidth negated.
			right := halfWidth.
			bottom := halfHeight negated.
			top := halfHeight]
		ifFalse: 
			[left := projection left.
			right := projection right.
			bottom := projection bottom.
			top := projection top].
	self activate: 
			[OpenGLInterface glMatrixMode: OpenGLInterface GL_PROJECTION.
			OpenGLInterface glLoadIdentity.
			OpenGLInterface 
				glOrtho: left
				with: right
				with: bottom
				with: top
				with: projection near
				with: projection far.
			OpenGLInterface glMatrixMode: OpenGLInterface GL_MODELVIEW.
			OpenGLInterface glLoadIdentity.
			OpenGLInterface 
				gluLookAt: projection eyePoint x
				with: projection eyePoint y
				with: projection eyePoint z
				with: projection sightPoint x
				with: projection sightPoint y
				with: projection sightPoint z
				with: projection upVector x
				with: projection upVector y
				with: projection upVector z]
]

{ #category : #displaying }
OpenGLRenderingContext >> perspectiveCorrectionHint [
	OpenGLInterface glHint: OpenGLInterface GL_PERSPECTIVE_CORRECTION_HINT
		with: OpenGLInterface GL_NICEST
]

{ #category : #transformation }
OpenGLRenderingContext >> pushName: aName transformation: aMFf while: aBlock [ 
	aName ifNil: 
			[aMFf ifNil: [aBlock value]
				ifNotNil: [self pushTransformation: aMFf while: aBlock]]
		ifNotNil: 
			[aMFf ifNil: [self pushName: aName while: aBlock]
				ifNotNil: 
					[self pushName: aName while: [self pushTransformation: aMFf while: aBlock]]]
]

{ #category : #transformation }
OpenGLRenderingContext >> pushName: aName while: aBlock [ 
	self activate: [OpenGLInterface glPushName: aName hash].
	aBlock ensure: [self activate: [OpenGLInterface glPopName]]
]

{ #category : #transformation }
OpenGLRenderingContext >> pushTransformation: aMFf while: aBlock [ 
	| origTransformation matrixPointer |
	origTransformation := transformation.
	transformation := aMFf product: transformation.
	matrixPointer := JunForeignHeap copyDoubleArrayToGcHeap: aMFf asArray.
	self activate: 
			[OpenGLInterface glPushMatrix.
			OpenGLInterface glMultMatrixd: matrixPointer].
	matrixPointer free.
	aBlock ensure: 
			[self activate: [OpenGLInterface glPopMatrix].
			transformation := origTransformation]
]

{ #category : #projection }
OpenGLRenderingContext >> rOqOFromrOpO: rOpO rpqv: rpqv [ 
	^(self crOqOFromrOpO: rOpO crpqv: (Array with: rpqv)) at: 1
]

{ #category : #projection }
OpenGLRenderingContext >> rvpvFromrOpO: rOpO [ 
	^(self crvpvFromcrOpO: (Array with: rOpO)) at: 1
]

{ #category : #scrolling }
OpenGLRenderingContext >> scrollCamera: aCamera by: aPoint [ 
	| rOpO crpqv rOqO |
	self parallelProjection: aCamera.
	rOpO := aCamera eyePoint.
	crpqv := OrderedCollection with: aPoint x negated @ aPoint y.
	rOqO := (self crOqOFromrOpO: rOpO crpqv: crpqv) first.
	aCamera eyePoint: rOqO
]

{ #category : #private }
OpenGLRenderingContext >> toTranscriptShowError [

	| errNum string |
	errNum := OpenGLInterface glGetError.
	errNum = OpenGLInterface GL_NO_ERROR
		ifFalse: 
			[string := (OpenGLInterface gluErrorString: errNum) copyCStringFromHeap.
			self toTranscriptCrShow: string]
]

{ #category : #private }
OpenGLRenderingContext >> trimNurbsCurve: aNurbsCurve for: aNurbsHandle [ 
	| knotVector controlPoints weights floatArray |
	knotVector := aNurbsCurve knotVector collect: [:each | each asFloat].
	controlPoints := aNurbsCurve controlPoints.
	weights := aNurbsCurve weights.
	floatArray := WriteStream on: Array new.
	controlPoints with: weights
		do: 
			[:point :weight | 
			floatArray nextPut: (point x * weight) asFloat.
			floatArray nextPut: (point y * weight) asFloat.
			floatArray nextPut: weight asFloat].
	floatArray := floatArray contents.
	OpenGLInterface gluBeginTrim: aNurbsHandle.
	OpenGLInterface 
		gluNurbsCurve: aNurbsHandle
		with: knotVector size
		with: (JunForeignHeap copyFloatArrayToGcHeap: knotVector)
		with: 3
		with: (JunForeignHeap copyFloatArrayToGcHeap: floatArray)
		with: aNurbsCurve order
		with: OpenGLInterface GLU_MAP1_TRIM_3.
	OpenGLInterface gluEndTrim: aNurbsHandle
]
