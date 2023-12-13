"
CADDrawingPane uses pixel coordinates consistently, unlike GFDrawingPane which uses a mix.

Instance Variables:

"
Class {
	#name : #CADDrawingPane,
	#superclass : #GFDrawingPane,
	#category : #'StCAD-UI-CADApp'
}

{ #category : #'VisualWorks metadata' }
CADDrawingPane class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'Polymorphic'
	)

]

{ #category : #accessing }
CADDrawingPane >> aParallelCameraWithBounds: aRect [ 
	^model aParallelCameraWithBounds: aRect
]

{ #category : #accessing }
CADDrawingPane >> aPerspectiveCameraWithBounds: aRect [ 
	^model aPerspectiveCameraWithBounds: aRect
]

{ #category : #accessing }
CADDrawingPane >> appWindowToOriginOffset [
	^self localPointToGlobal: self bounds origin
]

{ #category : #evaluating }
CADDrawingPane >> assert: assertBlock do: doBlock ensure: ensureBlock [ 
	assertBlock value.
	[doBlock value] ensure: [ensureBlock value]
]

{ #category : #accessing }
CADDrawingPane >> backColor [
	^SymbolicPaint inactiveBackground
]

{ #category : #accessing }
CADDrawingPane >> button1DoubleClick: rSpPx [ 
	displaySystem interface button1DoubleClick: rSpPx
]

{ #category : #accessing }
CADDrawingPane >> button1Down: rSpPx [ 
	displaySystem button1Down: rSpPx
]

{ #category : #accessing }
CADDrawingPane >> button2Down: rSpPx [ 
	displaySystem button2Down: rSpPx
]

{ #category : #accessing }
CADDrawingPane >> cachedBitmap [
	displaySystem isNil ifTrue: [self createBitmap].
	^displaySystem
]

{ #category : #displaying }
CADDrawingPane >> createBitmap [
	displaySystem := OpenGLRetainedMedium extent: self bounds extent.
	displaySystem setBackground: self lookPreferences backgroundColor.
	^displaySystem
]

{ #category : #accessing }
CADDrawingPane >> defaultControllerClass [
	^CADPaneController.
]

{ #category : #accessing }
CADDrawingPane >> display: invalidRectangle [ 
	"Rectangle is converted from Pixel coordinates to Drawing coordinates."
	"	Transcript cr; show: 'CADDrawingPane>display:'."

	displaySystem displayViewRectangle: (self unscaleRectangle: invalidRectangle)
]

{ #category : #accessing }
CADDrawingPane >> displayOn1: aGraphicsContext [ 
	"Modified to accept arbitrary location of drawing coordinates 
	origin."
	"	Transcript cr; show: 'CADDrawingPane>displayOn:'."

	aGraphicsContext translateBy: displaySystem interface drawing cornerToOriginOffset.
	self display: aGraphicsContext clippingBounds
]

{ #category : #displaying }
CADDrawingPane >> displayOn: aGraphicsContext [ 
	"Modified to accept arbitrary location of drawing coordinates 
	origin."

	self display: aGraphicsContext clippingBounds
]

{ #category : #accessing }
CADDrawingPane >> displaySystem: aDisplaySystem [ 
	displaySystem := aDisplaySystem
]

{ #category : #accessing }
CADDrawingPane >> drawingRect [
	^model drawingRect
]

{ #category : #accessing }
CADDrawingPane >> initialize [
	scrollPoint := 8 @ 8.
	pagePoint := 64 @ 64
]

{ #category : #accessing }
CADDrawingPane >> preferredBounds [
	displaySystem isNil ifTrue: [^super preferredBounds].
	^self drawingRect
]

{ #category : #accessing }
CADDrawingPane >> rDrawingOriginToTopLeftOfDisplayedAreaOfDrawingInPixels [
	"ScrollWrapper origin is the same as the Drawing origin."

	| scrollWrapper |
	scrollWrapper := self container.
	^scrollWrapper translation
]

{ #category : #accessing }
CADDrawingPane >> rSsliderPx [
	"Container of DrawingPane is aScrollingWrapper."
	"Displacement from ScrollArea origin to current position of slider 
	in pixel coordinates."

	^self container scrollOffset
]

{ #category : #accessing }
CADDrawingPane >> rSsliderPx1 [
	"Container of DrawingPane is aScrollingWrapper."
	"Displacement from ScrollArea origin to current position of slider in pixel coordinates."

	^self container translation negated
]

{ #category : #displaying }
CADDrawingPane >> renderOn: aRenderingContext [ 
	self model renderOn: aRenderingContext
]

{ #category : #accessing }
CADDrawingPane >> scaleRectangle: rect [

	"Modified to account for flipping of y axis."

	| scale |
	self scaling ifFalse: [ ^ rect ].
	scale := self scale.
	^ Graphics_Rectangle
		  vertex: rect origin * scale
		  vertex: rect extent * scale "VW_TRANSLATION:Graphics.Rectangle:Graphics_Rectangle"
]

{ #category : #accessing }
CADDrawingPane >> scaling [
	^false
]

{ #category : #accessing }
CADDrawingPane >> scrollTopCorner: aPoint [ 
	self container scrollBy: aPoint
]

{ #category : #accessing }
CADDrawingPane >> sliderTranslation [
	"Container of DrawingPane is aScrollingWrapper."
	"Slider translation is the displacement from origin to current position of slider in pixel coordinates."

	^self container translation negated
]

{ #category : #accessing }
CADDrawingPane >> unscaleRectangle: rect [

	"Copyright (C) 1993-1996 Polymorphic Software, Inc. All Rights Reserved"

	"Modified to account for flipping of y axis."

	| scale |
	self scaling ifFalse: [ ^ rect ].
	scale := self scale.
	^ Graphics_Rectangle
		  vertex: rect origin / scale
		  vertex: rect corner / scale "VW_TRANSLATION:Graphics.Rectangle:Graphics_Rectangle"
]

{ #category : #displaying }
CADDrawingPane >> useOpenGL [
	displaySystem := nil
]

{ #category : #displaying }
CADDrawingPane >> useOpenGL1 [
	displaySystem := OpenGLRetainedMedium extent: self bounds extent.
	displaySystem setBackground: self lookPreferences backgroundColor
]
