"
OpenGLView controls aCamera specific to itself. aEditor and aUniverse may have many views and cameras.

Instance Variables:
	aCamera	<PerspectiveCamera>	description of aCamera
	bitmapSemaphore	<Semaphore>	description of bitmapSemaphore
	cachedBitmap	<OpenGLRetainedMedium>	description of cachedBitmap
	cachedRenderingContext	<JunOpenGLRenderingContext>	description of cachedRenderingContext
	displayListHolder	<ValueHolder>	description of displayListHolder
	preferredBounds	<Object>	description of preferredBounds


"
Class {
	#name : #OpenGLView,
	#superclass : #View,
	#instVars : [
		'aCamera',
		'preferredBounds',
		'cHandle',
		'cachedBitmap',
		'cachedRenderingContext',
		'displayListHolder',
		'bitmapSemaphore'
	],
	#category : #'StCAD-UI-StCAD-UI-App'
}

{ #category : #'VisualWorks metadata' }
OpenGLView class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
OpenGLView >> aCamera [
	^aCamera
]

{ #category : #accessing }
OpenGLView >> aCamera: anObject [
	aCamera := anObject
]

{ #category : #accessing }
OpenGLView >> addHandle: aHandle [ 
	cHandle add: aHandle.
	aHandle aView: self
]

{ #category : #converting }
OpenGLView >> asBitmap [
	| renderingContext |
	self 
		assert: [renderingContext := self renderingContext]
		do: 
			[self renderOn: renderingContext.
			renderingContext flush]
		ensure: [renderingContext release].
	^self cachedBitmap
]

{ #category : #converting }
OpenGLView >> asImage [
	^self asBitmap medium asImage
]

{ #category : #evaluating }
OpenGLView >> assert: assertBlock do: doBlock ensure: ensureBlock [ 
	assertBlock value.
	[doBlock value]
		ensure: [ensureBlock value]
]

{ #category : #'bounds accessing' }
OpenGLView >> bounds: newBounds [ 
	super bounds: newBounds.
	self flushCachedBitmap.
	self model changed: #value
]

{ #category : #private }
OpenGLView >> cachedBitmap [
	cachedBitmap isNil ifTrue: [self createBitmap].
	^cachedBitmap
]

{ #category : #accessing }
OpenGLView >> cachedBitmap: aBoolean [
]

{ #category : #displaying }
OpenGLView >> calcBoundsAndRedisplay: aUniverse [

	"aBoundingBoxPx is in OpenGL convention: origin is lower left corner, X right, Y up.
aBoundingRectPx is in VW convention: origin is upper left corner, X right, Y down."

	| aBoundingBoxPx yBoxRectBoxPx rRectOriginRectPx rRectCornerRectPx aBoundingRectPx |
	aBoundingBoxPx := self calcViewBoxFor: aUniverse aBoundingBox.
	yBoxRectBoxPx := self bounds extent y.
	rRectOriginRectPx := aBoundingBoxPx origin x
	                     @ (yBoxRectBoxPx - aBoundingBoxPx origin y).
	rRectCornerRectPx := aBoundingBoxPx corner x
	                     @ (yBoxRectBoxPx - aBoundingBoxPx corner y).
	aBoundingRectPx := Graphics_Rectangle
		                   vertex: rRectOriginRectPx
		                   vertex: rRectCornerRectPx. "VW_TRANSLATION:Graphics.Rectangle:Graphics_Rectangle"
	self preferredBounds quadrupleToContain: aBoundingRectPx.
	"	self invalidate."
	self container scrollCADSM
]

{ #category : #'bounds accessing' }
OpenGLView >> calcViewBoxFor: aJun3dBoundingBox [ 
	| aBitmap |
	aBitmap := self cachedBitmap.
	^aBitmap calcViewBoxFor: aJun3dBoundingBox with: aCamera
]

{ #category : #accessing }
OpenGLView >> clearcHandle [

	cHandle := StCAD_Misc_OrderedSet new "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
]

{ #category : #private }
OpenGLView >> createBitmap [
	cachedBitmap := OpenGLRetainedMedium extent: self bounds extent.
	cachedBitmap setBackground: self lookPreferences backgroundColor.
	^cachedBitmap
]

{ #category : #debug }
OpenGLView >> debug: aBlock [ 
	"aBlock value"
]

{ #category : #'controller accessing' }
OpenGLView >> defaultControllerClass [
	^OpenGLDisplayController
]

{ #category : #displaying }
OpenGLView >> displayOn: graphicsContext [ 
	bitmapSemaphore critical: 
			["self debugShow: graphicsContext clippingBounds."

			self asBitmap 
				displayOn: graphicsContext
				at: graphicsContext clippingBounds origin
				bounds: graphicsContext clippingBounds]
]

{ #category : #displaying }
OpenGLView >> displaySelectionTrackingFrom: arg1 to: arg2 [

	| graphicsContext renderingContext array |
	graphicsContext := self graphicsContext.
	bitmapSemaphore critical: [ 
		self
			assert: [ renderingContext := self renderingContext ]
			do: [ 
				self renderOn: renderingContext.
				renderingContext inScreenCoordDo: [ 
					array := (Graphics_Rectangle origin: arg1 corner: arg2)
						         asPointArray collect: [ :aPoint | 
						         FullColumn
							         with: aPoint x asDouble
							         with: aPoint y asDouble
							         with: 0.0 d ]. "VW_TRANSLATION:Graphics.Rectangle:Graphics_Rectangle"
					renderingContext lineWidth: 1.
					renderingContext paint: ColorValue yellow.
					renderingContext displayLines: array ].
				renderingContext flush ]
			ensure: [ renderingContext release ].
		self cachedBitmap
			displayOn: graphicsContext
			at: graphicsContext clippingBounds origin
			bounds: graphicsContext clippingBounds ]
]

{ #category : #private }
OpenGLView >> fit: aBoundingBox [ 
	self cachedBitmap makeCamera: aCamera fit: aBoundingBox.
	preferredBounds origin: 0 @ 0 corner: 1 @ 1
]

{ #category : #private }
OpenGLView >> flushCachedBitmap [
	self flushCachedRenderingContext.
	cachedBitmap notNil ifTrue: [bitmapSemaphore critical: [cachedBitmap release]].
	cachedBitmap := nil
]

{ #category : #private }
OpenGLView >> flushCachedRenderingContext [
	cachedRenderingContext notNil ifTrue: [cachedRenderingContext release].
	cachedRenderingContext := nil.
	displayListHolder := nil
]

{ #category : #'initialize-release' }
OpenGLView >> initialize [

	super initialize.
	preferredBounds := Graphics_Rectangle origin: 0 @ 0 corner: 1 @ 1. "VW_TRANSLATION:Graphics.Rectangle:Graphics_Rectangle"
	cHandle := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	bitmapSemaphore := Semaphore forMutualExclusion
]

{ #category : #accessing }
OpenGLView >> keyboardProcessor [
	^self topComponent keyboardProcessor
]

{ #category : #'menubar items' }
OpenGLView >> menuViewYupQuadmpm [
	aCamera menuViewYupQuadmpm
]

{ #category : #'menubar items' }
OpenGLView >> menuViewYupXright [
	aCamera menuViewYupXright
]

{ #category : #'menubar items' }
OpenGLView >> menuViewZupQuadmmp [
	aCamera menuViewZupQuadmmp
]

{ #category : #displaying }
OpenGLView >> pick3dObjectAt: rvGLpvGL [ 
	| pickingRenderingContext pickedObject |
	self 
		assert: 
			[pickingRenderingContext := OpenGLPickingRenderingContext 
						extent: self bounds extent]
		do: 
			[pickedObject := pickingRenderingContext 
						pickAt: rvGLpvGL
						aCamera: aCamera
						aModel: self model]
		ensure: [pickingRenderingContext release].
	^pickedObject
]

{ #category : #displaying }
OpenGLView >> pickAt: rvGLpvGL [ 
	| pickedObject |
	pickedObject := self pickHandleAt: rvGLpvGL.
	pickedObject ifNil: [pickedObject := self pick3dObjectAt: rvGLpvGL].
	^pickedObject
]

{ #category : #displaying }
OpenGLView >> pickHandleAt: rvGLpvGL [

	| cH |
	cH := cHandle select: [ :aHandle | 
		      | rvov rect |
		      rvov := aHandle originPx.
		      rect := (Graphics_Rectangle
			               origin: rvov x @ rvov y
			               corner: rvov x @ rvov y) expandedBy:
			              aHandle image extent // 2 + 1. "VW_TRANSLATION:Graphics.Rectangle:Graphics_Rectangle"
		      rect containsPoint: rvGLpvGL ].
	^ cH isEmpty
		  ifTrue: [ nil ]
		  ifFalse: [ 
			  cH := cH asSortedCollection: [ :a :b | 
				        a originPx z <= b originPx z ].
			  cH first ]
]

{ #category : #'bounds accessing' }
OpenGLView >> preferredBounds [
	^preferredBounds notNil 
		ifTrue: [preferredBounds]
		ifFalse: [super preferredBounds]
]

{ #category : #accessing }
OpenGLView >> preferredBounds: anObject [
	preferredBounds := anObject
]

{ #category : #accessing }
OpenGLView >> rCpCfromrvpv: rvtiltv [ 
	| rCtiltC |
	rCtiltC := aCamera height * rvtiltv / cachedBitmap extent y.
	^FullColumn 
		with: rCtiltC x
		with: rCtiltC y
		with: 0.0d
]

{ #category : #displaying }
OpenGLView >> redisplay [
	self flushCachedRenderingContext.
	self displayOn: self graphicsContext
]

{ #category : #'initialize-release' }
OpenGLView >> release [
	super release.
	self flushCachedBitmap
]

{ #category : #rendering }
OpenGLView >> renderOn: aRenderingContext [ 
	aRenderingContext clear.
	cHandle do: [:aHandle | aHandle renderOn: aRenderingContext].
	self model renderOn: aRenderingContext
]

{ #category : #rendering }
OpenGLView >> renderOn: renderingContext withDisplayList: aDisplayListHolder [ 
	self model renderOn: renderingContext withDisplayList: aDisplayListHolder
]

{ #category : #rendering }
OpenGLView >> renderingContext [
	| renderingContext |
	renderingContext := aCamera aRenderingContextOn: self cachedBitmap.
	^renderingContext
]

{ #category : #private }
OpenGLView >> scroll: aPoint [ 
	model scroll: aPoint.
	^aPoint
]

{ #category : #private }
OpenGLView >> scrollCameraBy: aPoint [ 
	self cachedBitmap scrollCamera: aCamera by: aPoint
]

{ #category : #private }
OpenGLView >> scrollProjector: displayProjector by: aPoint [ 
	self cachedBitmap scrollProjector: displayProjector by: aPoint
]

{ #category : #updating }
OpenGLView >> update: aspectSymbol with: aParameter from: aSender [ 
	((self respondsTo: #isOpen)
		and: [self isOpen])
		ifTrue: 
			[aspectSymbol = #object ifTrue: [^self redisplay].
			aspectSymbol = #light ifTrue: [^self redisplay].
			aspectSymbol = #projection ifTrue: [^self displayOn: self graphicsContext].
			aspectSymbol = #presentation ifTrue: [^self redisplay].
			aspectSymbol = #shading ifTrue: [^self redisplay].
			aspectSymbol = #selection ifTrue: [^self redisplay].
			aspectSymbol = #state ifTrue: [^self controller flushMovementVector].
			aspectSymbol = #texture ifTrue: [^self redisplay]].
	super update: aspectSymbol with: aParameter
]

{ #category : #private }
OpenGLView >> viewportInMedium [
	| rect |
	rect := self bounds translatedBy: (self localPointToGlobal: Point zero).
	^rect
]
