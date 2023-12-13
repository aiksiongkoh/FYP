Class {
	#name : #OpenGLPickingRenderingContext,
	#superclass : #OpenGLRenderingContext,
	#instVars : [
		'selectionBufferSize'
	],
	#category : #'StCAD-UI-StCAD-UI-App'
}

{ #category : #'instance creation' }
OpenGLPickingRenderingContext class >> extent: aPoint [ 
	| medium |
	medium := OpenGLRetainedMedium extent: aPoint.
	^self on: medium
]

{ #category : #'instance creation' }
OpenGLPickingRenderingContext class >> extent: aPoint bufferSize: anInteger [ 
	| pickingRenderingContext |
	pickingRenderingContext := self extent: aPoint.
	pickingRenderingContext selectionBufferSize: anInteger.
	^pickingRenderingContext
]

{ #category : #'VisualWorks metadata' }
OpenGLPickingRenderingContext class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #displaying }
OpenGLPickingRenderingContext >> clearColorBuffer [
]

{ #category : #defaults }
OpenGLPickingRenderingContext >> defaultSelectionBufferSize [
	^1024
]

{ #category : #lighting }
OpenGLPickingRenderingContext >> diableLightIndex: index0to7 [
]

{ #category : #blending }
OpenGLPickingRenderingContext >> disableBlending [
]

{ #category : #material }
OpenGLPickingRenderingContext >> disableColorMaterial [
]

{ #category : #dithering }
OpenGLPickingRenderingContext >> disableDithering [
]

{ #category : #fogging }
OpenGLPickingRenderingContext >> disableFog [
]

{ #category : #lighting }
OpenGLPickingRenderingContext >> disableLighting [
]

{ #category : #smoothing }
OpenGLPickingRenderingContext >> disableLineSmooth [
]

{ #category : #normalizing }
OpenGLPickingRenderingContext >> disableNormalize [
]

{ #category : #smoothing }
OpenGLPickingRenderingContext >> disablePolygonSmooth [
]

{ #category : #displaying }
OpenGLPickingRenderingContext >> displayPolygon: aCollectionOfPoints [ 
	self
		activate: 
			[OpenGLInterface glBegin: OpenGLInterface GL_POLYGON.
			aCollectionOfPoints do: [:a3dPoint | OpenGLInterface
					glVertex3d: a3dPoint x asDouble
					with: a3dPoint y asDouble
					with: a3dPoint z asDouble].
			OpenGLInterface glEnd]
]

{ #category : #blending }
OpenGLPickingRenderingContext >> enableBlending [
]

{ #category : #material }
OpenGLPickingRenderingContext >> enableColorMaterial [
]

{ #category : #dithering }
OpenGLPickingRenderingContext >> enableDithering [
]

{ #category : #fogging }
OpenGLPickingRenderingContext >> enableFog [
]

{ #category : #lighting }
OpenGLPickingRenderingContext >> enableLightIndex: index0to7 [
]

{ #category : #lighting }
OpenGLPickingRenderingContext >> enableLighting [
]

{ #category : #smoothing }
OpenGLPickingRenderingContext >> enableLineSmooth [
]

{ #category : #normalizing }
OpenGLPickingRenderingContext >> enableNormalize [
]

{ #category : #smoothing }
OpenGLPickingRenderingContext >> enablePolygonSmooth [
]

{ #category : #stippling }
OpenGLPickingRenderingContext >> enablePolygonStipple [
]

{ #category : #'texture mapping' }
OpenGLPickingRenderingContext >> enableTexture2d [
]

{ #category : #shading }
OpenGLPickingRenderingContext >> flatShading [
]

{ #category : #fogging }
OpenGLPickingRenderingContext >> fogColor: aColorValue [
]

{ #category : #fogging }
OpenGLPickingRenderingContext >> fogExp2Density: aNumber [
]

{ #category : #fogging }
OpenGLPickingRenderingContext >> fogExpDensity: aNumber [
]

{ #category : #fogging }
OpenGLPickingRenderingContext >> fogLinearStartDensity: aNumber1 endDensity: aNumber2 [
]

{ #category : #'initialize-release' }
OpenGLPickingRenderingContext >> initialize [
	super initialize.
	super disableBlending.
	super disableLighting.
	super disableFog.
	super disablePolygonSmooth.
	super disableLineSmooth.
	super flatShading.
	super disableNormalize.
	super disableDithering.
	super enableDepthTest.
	self selectionBufferSize: self defaultSelectionBufferSize
]

{ #category : #lighting }
OpenGLPickingRenderingContext >> lightAmbientColor: aColorValue [
]

{ #category : #lighting }
OpenGLPickingRenderingContext >> lightAmbientColor: aColorValue alpha: aNumber [
]

{ #category : #lighting }
OpenGLPickingRenderingContext >> lightAmbientColor: aColorValue alpha: aNumber twoSide: aBoolean [
]

{ #category : #lighting }
OpenGLPickingRenderingContext >> lightIndex: index0to7 position: a3dPoint [
]

{ #category : #lighting }
OpenGLPickingRenderingContext >> lightIndex: index0to7 position: a3dPoint color: aColorValue [
]

{ #category : #lighting }
OpenGLPickingRenderingContext >> lightIndex: index0to7 position: a3dPoint parallel: aBoolean color: aColorValue [
]

{ #category : #lighting }
OpenGLPickingRenderingContext >> lightIndex: index0to7 position: a3dPoint parallel: aBoolean color: aColorValue alpha: aNumber [
]

{ #category : #smoothing }
OpenGLPickingRenderingContext >> lineSmoothDontCare [
]

{ #category : #smoothing }
OpenGLPickingRenderingContext >> lineSmoothNicest [
]

{ #category : #material }
OpenGLPickingRenderingContext >> materialAmbient: aColorValue [
]

{ #category : #material }
OpenGLPickingRenderingContext >> materialAmbient: aColorValue alpha: aNumber [
]

{ #category : #material }
OpenGLPickingRenderingContext >> materialDiffuse: aColorValue [
]

{ #category : #material }
OpenGLPickingRenderingContext >> materialDiffuse: aColorValue alpha: aNumber [
]

{ #category : #material }
OpenGLPickingRenderingContext >> materialEmission: aColorValue [
]

{ #category : #material }
OpenGLPickingRenderingContext >> materialEmission: aColorValue alpha: aNumber [
]

{ #category : #material }
OpenGLPickingRenderingContext >> materialShininess: aNumber [
]

{ #category : #material }
OpenGLPickingRenderingContext >> materialSpecular: aColorValue [
]

{ #category : #material }
OpenGLPickingRenderingContext >> materialSpecular: aColorValue alpha: aNumber [
]

{ #category : #private }
OpenGLPickingRenderingContext >> maxID [
	^OpenGLInterface GLuint baseType maxVal
]

{ #category : #utilities }
OpenGLPickingRenderingContext >> normalUnitVectorOfPoints: anArrayOfPoints [ 
	"1,1,1 / 3 sqrt"

	^0.57735027955204d , 0.57735027955204d , 0.57735027955204d
]

{ #category : #utilities }
OpenGLPickingRenderingContext >> normalVectorOfPoints: anArrayOfPoints [ 
	^1 , 1 , 1
]

{ #category : #accessing }
OpenGLPickingRenderingContext >> paint: aPaint alpha: aNumber [
	paint := aPaint.
	alpha := aNumber asFloat.
]

{ #category : #projecting }
OpenGLPickingRenderingContext >> perspective: aJunOpenGLPerspective [ 
	self
		activate: 
			[self setProjection: aJunOpenGLPerspective copy.
			OpenGLInterface glMatrixMode: OpenGLInterface GL_PROJECTION.
			OpenGLInterface glLoadIdentity.
			OpenGLInterface
				gluPerspective: self projection fovy deg asDouble
				with: (viewport width / viewport height) asDouble
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
OpenGLPickingRenderingContext >> pickAt: rvGLpvGL aCamera: aCamera [ 
	^aCamera pickAt: rvGLpvGL aContext: self
]

{ #category : #displaying }
OpenGLPickingRenderingContext >> pickAt: rvGLpvGL aCamera: aCamera aModel: aModel [ 
	self selectionBufferSize: 1024.
	self pickAt: rvGLpvGL aCamera: aCamera.
	^self selectNearestObjectWhile: 
			[aModel renderOn: self.
			self flush]
]

{ #category : #projecting }
OpenGLPickingRenderingContext >> pickAt: rvGLpvGL aPerspectiveCamera: aPerspectiveCamera [ 
	self activate: 
			[self setProjection: aPerspectiveCamera copy.
			OpenGLInterface glMatrixMode: OpenGLInterface GL_PROJECTION.
			OpenGLInterface glLoadIdentity.
			OpenGLInterface glGetIntegerv: OpenGLInterface GL_VIEWPORT
				with: viewportCPointer.
			OpenGLInterface 
				gluPickMatrix: rvGLpvGL x asDouble
				with: rvGLpvGL y asDouble
				with: 10 asDouble
				with: 10 asDouble
				with: viewportCPointer.
			OpenGLInterface 
				gluPerspective: self projection fovy deg asDouble
				with: (viewport width / viewport height) asDouble
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

{ #category : #smoothing }
OpenGLPickingRenderingContext >> polygonSmoothDontCare [
]

{ #category : #smoothing }
OpenGLPickingRenderingContext >> polygonSmoothFastest [
]

{ #category : #smoothing }
OpenGLPickingRenderingContext >> polygonSmoothNicest [
]

{ #category : #stippling }
OpenGLPickingRenderingContext >> polygonStipple: aJunOpenGLStipple [
]

{ #category : #selecting }
OpenGLPickingRenderingContext >> selectNearestObjectWhile: aBlock [ 
	| selectionBuffer |
	
	[| bufferSize status maxIndex pickedIndex pickedDepth index offset |
	bufferSize := self selectionBufferSize.
	selectionBuffer := OpenGLInterface GLuint malloc: bufferSize.
	self activate: 
			[OpenGLInterface glSelectBuffer: bufferSize with: selectionBuffer.
			OpenGLInterface glRenderMode: OpenGLInterface GL_SELECT.
			OpenGLInterface glInitNames.
			OpenGLInterface glPushName: 0].
	aBlock value.
	self 
		activate: [status := OpenGLInterface glRenderMode: OpenGLInterface GL_RENDER].
	self toTranscriptShow: status.
	maxIndex := status ~= -1 ifTrue: [status] ifFalse: [bufferSize].
	pickedIndex := 0.
	pickedDepth := self maxID.
	index := 1.
	offset := 0.
	[index <= maxIndex] whileTrue: 
			[| numNames minDepth name |
			numNames := selectionBuffer at: offset.
			minDepth := selectionBuffer at: offset + 1.
			name := selectionBuffer at: offset + 3.
			minDepth < pickedDepth 
				ifTrue: 
					[pickedIndex := name.
					pickedDepth := minDepth].
			offset := offset + 3 + numNames.
			index := index + 1].
	^pickedIndex > 0 ifTrue: [pickedIndex] ifFalse: [nil]] 
			ensure: [selectionBuffer notNil ifTrue: [selectionBuffer free]]
]

{ #category : #accessing }
OpenGLPickingRenderingContext >> selectionBufferSize [
	^selectionBufferSize
]

{ #category : #accessing }
OpenGLPickingRenderingContext >> selectionBufferSize: anInteger [ 
	selectionBufferSize := anInteger rounded abs max: 1
]

{ #category : #accessing }
OpenGLPickingRenderingContext >> setId: anInteger [ 
	self activate: [OpenGLInterface glLoadName: anInteger \\ self maxID]
]

{ #category : #shading }
OpenGLPickingRenderingContext >> smoothShading [
]

{ #category : #'texture mapping' }
OpenGLPickingRenderingContext >> texture: aTexture [
]
