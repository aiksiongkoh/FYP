Class {
	#name : #CADDoubleBufferingGraphicsDisplaySystem,
	#superclass : #GFDoubleBufferingGraphicsDisplaySystem,
	#instVars : [
		'isOpenGL',
		'aOpenGLMedium',
		'aOpenGLContext',
		'aOpenGLSemaphore'
	],
	#category : #'StCAD-UI-CAD'
}

{ #category : #'VisualWorks metadata' }
CADDoubleBufferingGraphicsDisplaySystem class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'Polymorphic'
	)

]

{ #category : #accessing }
CADDoubleBufferingGraphicsDisplaySystem >> aOpenGLContext [
	^aOpenGLContext
]

{ #category : #accessing }
CADDoubleBufferingGraphicsDisplaySystem >> aOpenGLContext: anObject [
	^aOpenGLContext := anObject
]

{ #category : #evaluating }
CADDoubleBufferingGraphicsDisplaySystem >> assert: assertBlock do: doBlock ensure: ensureBlock [ 
	assertBlock value.
	[doBlock value] ensure: [ensureBlock value]
]

{ #category : #accessing }
CADDoubleBufferingGraphicsDisplaySystem >> button1Down: rSpPx [ 
	interface button1Down: rSpPx
]

{ #category : #accessing }
CADDoubleBufferingGraphicsDisplaySystem >> button2Down: rSpPx [ 
	interface button2Down: rSpPx
]

{ #category : #calc }
CADDoubleBufferingGraphicsDisplaySystem >> cursorPointSnapped: snap limit: limit [ 
	^interface
		snaprDpPx: mousePoint
		if: snap
		limit: limit
]

{ #category : #accessing }
CADDoubleBufferingGraphicsDisplaySystem >> damageRegion: aRectangle [ 
	| limitRect damagedRect |
	limitRect := -32768 @ -32768 corner: 32767 @ 32767.
	damagedRect := aRectangle intersect: limitRect.
	damagedRegion valid ifFalse: [damagedRegion initializeFrom: damagedRect]
		ifTrue: [damagedRegion mergeWith: damagedRect]
]

{ #category : #calc }
CADDoubleBufferingGraphicsDisplaySystem >> display1: clipRect [ 
	"Modified to accept arbitrary location of drawing coordinates origin."
	"clipRect is in Drawing coordinates."

	| sPen origin extent adRect |
	displayPane topComponent == nil ifTrue: [^self].
	(sPen := scratch pen) nonScaledTranslation: interface drawing rSDPx - displayPane rSsliderPx.
	origin := clipRect origin.
	extent := clipRect extent.
	sPen clippingRectangle: (adRect := origin extent: extent).
	sPen
		gfFillOrigin: origin
		extent: extent
		color: displayPane backColor.
	interface drawing display: adRect with: sPen.
	self updateDisplayPaneOrigin: origin extent: extent.
	interface showHandles
]

{ #category : #displaying }
CADDoubleBufferingGraphicsDisplaySystem >> display: clipRect [ 
	isOpenGL 
		ifTrue: [self displayOpenGLRectangle: clipRect]
		ifFalse: [self displayBasic: clipRect]
]

{ #category : #calc }
CADDoubleBufferingGraphicsDisplaySystem >> displayAll [
	"	Transcript cr; show: 'CADDoubleBufferingGraphicsDisplaySystem>displayAll'."

	self display: self drawingRect
]

{ #category : #displaying }
CADDoubleBufferingGraphicsDisplaySystem >> displayBasic: clipRect [ 
	"Modified to accept arbitrary location of drawing coordinates 
	origin."
	"clipRect is in Drawing coordinates."

	| sPen origin extent adRect |
	displayPane topComponent == nil ifTrue: [^self].
	(sPen := scratch pen) nonScaledTranslation: self rDrawingOriginToTopLeftOfDisplayedAreaOfDrawingInPixels.
	origin := clipRect origin.
	extent := clipRect extent.
	sPen clippingRectangle: (adRect := origin extent: extent).
	sPen
		gfFillOrigin: origin
		extent: extent
		color: displayPane backColor.
	interface drawing display: adRect with: sPen.
	self updateDisplayPaneOrigin: origin extent: extent.
	interface showHandles
]

{ #category : #calc }
CADDoubleBufferingGraphicsDisplaySystem >> displayHandles1: handles [ 
	"Modified to accept arbitrary location of drawing coordinates origin."
	"	Transcript cr; show: 'CADDoubleBufferingGraphicsDisplaySystem>displayHandles:'."

	pen == nil ifTrue: [^self].
	pen nonScaledTranslation: displayPane appWindowToOriginOffset + interface drawing rSDPx - displayPane rSsliderPx.
	pen nonScalingClippingRectangle: (displayPane bounds translatedBy: interface drawing rSDPx negated).
	handles do: [:each | each displayWith: pen]
]

{ #category : #calc }
CADDoubleBufferingGraphicsDisplaySystem >> displayHandles: handles [ 
	"Modified to accept arbitrary location of drawing coordinates 
	origin."
	"	Transcript cr; show: 
	'CADDoubleBufferingGraphicsDisplaySystem>displayHandles:'."

	| rAppWindowToTopLeftOfPanePixel |
	pen == nil ifTrue: [^self].
	rAppWindowToTopLeftOfPanePixel := displayPane appWindowToOriginOffset.
	pen nonScaledTranslation: rAppWindowToTopLeftOfPanePixel + self rDrawingOriginToTopLeftOfDisplayedAreaOfDrawingInPixels.
	pen nonScalingClippingRectangle: displayPane bounds.
	handles do: [:each | each displayWith: pen]
]

{ #category : #displaying }
CADDoubleBufferingGraphicsDisplaySystem >> displayOpenGLRectangle1: aRect [ 
	| rAppWindowToTopLeftOfPanePixel clippingBounds newMediumBlock aCamera aOpenGLBounds |
	rAppWindowToTopLeftOfPanePixel := displayPane appWindowToOriginOffset.
	pen nonScaledTranslation: rAppWindowToTopLeftOfPanePixel 
				+ self rDrawingOriginToTopLeftOfDisplayedAreaOfDrawingInPixels.
	pen nonScalingClippingRectangle: (aRect intersect: displayPane bounds).
	clippingBounds := pen clippingBounds.
	clippingBounds extent > 0 
		ifTrue: 
			[newMediumBlock := 
					[aOpenGLMedium := OpenGLRetainedMedium 
								extent: clippingBounds extent.
					aOpenGLMedium setBackground: displayPane lookPreferences backgroundColor].
			aOpenGLMedium ifNil: newMediumBlock.
			aOpenGLSemaphore critical: 
					[self 
						assert: 
							[clippingBounds extent ~= aOpenGLMedium extent ifTrue: newMediumBlock.
							aCamera := interface aParallelCameraWithBounds: clippingBounds.
							aCamera smoothShading.
							aOpenGLContext := aCamera aRenderingContextOn: aOpenGLMedium]
						do: 
							[interface renderOn: aOpenGLContext.
							aOpenGLContext flush]
						ensure: [aOpenGLContext release].
					pen translateBy: clippingBounds origin.
					aOpenGLBounds := pen clippingBounds.
					aOpenGLMedium 
						displayOn: pen
						at: aOpenGLBounds origin
						bounds: aOpenGLBounds.
					pen translateBy: clippingBounds origin negated].
			interface showHandles]
]

{ #category : #displaying }
CADDoubleBufferingGraphicsDisplaySystem >> displayOpenGLRectangle2: aRect [ 
	| rAppWindowToTopLeftOfPanePixel clippingBounds newMediumBlock aCamera listID aOpenGLBounds |
	rAppWindowToTopLeftOfPanePixel := displayPane appWindowToOriginOffset.
	pen nonScaledTranslation: rAppWindowToTopLeftOfPanePixel 
				+ self rDrawingOriginToTopLeftOfDisplayedAreaOfDrawingInPixels.
	pen nonScalingClippingRectangle: (aRect intersect: displayPane bounds).
	clippingBounds := pen clippingBounds.
	clippingBounds extent > 0 
		ifTrue: 
			[newMediumBlock := 
					[aOpenGLMedium := OpenGLRetainedMedium 
								extent: clippingBounds extent.
					aOpenGLMedium setBackground: displayPane lookPreferences backgroundColor].
			aOpenGLMedium ifNil: newMediumBlock.
			aOpenGLSemaphore critical: 
					[self 
						assert: 
							[clippingBounds extent ~= aOpenGLMedium extent ifTrue: newMediumBlock.
							aCamera := interface aParallelCameraWithBounds: clippingBounds.
							aCamera smoothShading.
							aOpenGLContext := aCamera aRenderingContextOn: aOpenGLMedium]
						do: 
							["Use display List to overcome bug in OpenGL on Win2k and WinXP."

							listID := aOpenGLContext 
										createDisplayList: [interface renderOn: aOpenGLContext]
										displayImmediately: false.
							aOpenGLContext callDisplayList: listID.
							aOpenGLContext removeDisplayList: listID.
							aOpenGLContext flush]
						ensure: [aOpenGLContext release].
					pen translateBy: clippingBounds origin.
					aOpenGLBounds := pen clippingBounds.
					aOpenGLMedium 
						displayOn: pen
						at: aOpenGLBounds origin
						bounds: aOpenGLBounds.
					pen translateBy: clippingBounds origin negated].
			interface showHandles]
]

{ #category : #displaying }
CADDoubleBufferingGraphicsDisplaySystem >> displayOpenGLRectangle3: aRect [ 
	| rAppWindowToTopLeftOfPanePixel clippingBounds newMediumBlock aCamera aOpenGLBounds |
	rAppWindowToTopLeftOfPanePixel := displayPane appWindowToOriginOffset.
	pen nonScaledTranslation: rAppWindowToTopLeftOfPanePixel 
				+ self rDrawingOriginToTopLeftOfDisplayedAreaOfDrawingInPixels.
	pen nonScalingClippingRectangle: (aRect intersect: displayPane bounds).
	clippingBounds := pen clippingBounds.
	clippingBounds extent > 0 
		ifTrue: 
			[newMediumBlock := 
					[aOpenGLMedium := OpenGLRetainedMedium extent: 800 @ 800.
					aOpenGLMedium setBackground: displayPane lookPreferences backgroundColor].
			aOpenGLMedium ifNil: newMediumBlock.
			aOpenGLSemaphore critical: 
					[self 
						assert: 
							[clippingBounds extent ~= aOpenGLMedium extent ifTrue: newMediumBlock.
							aCamera := interface aParallelCameraWithBounds: clippingBounds.
							aCamera smoothShading.
							aOpenGLContext := aCamera aRenderingContextOn: aOpenGLMedium.
							aOpenGLContext viewport: (0 @ 0 extent: clippingBounds extent)]
						do: 
							[interface renderOn: aOpenGLContext.
							aOpenGLContext flush]
						ensure: [aOpenGLContext release].
					pen translateBy: clippingBounds origin.
					aOpenGLBounds := pen clippingBounds.
					aOpenGLMedium 
						displayOn: pen
						at: aOpenGLBounds origin
						bounds: aOpenGLBounds.
					pen translateBy: clippingBounds origin negated].
			interface showHandles]
]

{ #category : #displaying }
CADDoubleBufferingGraphicsDisplaySystem >> displayOpenGLRectangle4: aRect [ 
	| rAppWindowToTopLeftOfPanePixel clippingBounds clipExtent block aCamera newExtent mediumExtent aOpenGLBounds |
	rAppWindowToTopLeftOfPanePixel := displayPane appWindowToOriginOffset.
	pen nonScaledTranslation: rAppWindowToTopLeftOfPanePixel 
				+ self rDrawingOriginToTopLeftOfDisplayedAreaOfDrawingInPixels.
	pen nonScalingClippingRectangle: (aRect intersect: displayPane bounds).
	clippingBounds := pen clippingBounds.
	clipExtent := clippingBounds extent.
	clipExtent > 0 
		ifTrue: 
			[aOpenGLSemaphore critical: 
					[self 
						assert: 
							[block := 
									[:extent | 
									aOpenGLMedium := OpenGLRetainedMedium extent: extent.
									aOpenGLMedium setBackground: displayPane lookPreferences backgroundColor.
									aCamera := interface aParallelCameraWithBounds: clippingBounds.
									aOpenGLContext := aCamera aRenderingContextOn: aOpenGLMedium].
							aOpenGLMedium ifNil: 
									[newExtent := 800 @ 600.
									block value: newExtent].
							mediumExtent := aOpenGLMedium extent.
							clipExtent > mediumExtent 
								ifTrue: 
									[aOpenGLMedium releaseMedium.
									aOpenGLContext release.
									newExtent := (clipExtent x max: mediumExtent x) 
												@ (clipExtent y max: mediumExtent y).
									block value: newExtent].
							aOpenGLContext initializeContext.
							aOpenGLContext clear.
							aCamera := interface aParallelCameraWithBounds: clippingBounds.
							aCamera smoothShading.
							aOpenGLContext obeyParallelCamera: aCamera.
							aOpenGLContext viewport: (0 @ 0 extent: clipExtent)]
						do: 
							[interface renderOn: aOpenGLContext.
							aOpenGLContext flush]
						ensure: [aOpenGLContext deactivate].
					pen translateBy: clippingBounds origin.
					aOpenGLBounds := pen clippingBounds.
					aOpenGLMedium 
						displayOn: pen
						at: aOpenGLBounds origin
						bounds: aOpenGLBounds.
					pen translateBy: clippingBounds origin negated].
			interface showHandles]
]

{ #category : #displaying }
CADDoubleBufferingGraphicsDisplaySystem >> displayOpenGLRectangle: aRect [ 
	| rAppWindowToTopLeftOfPanePixel clippingBounds clipExtent block aCamera newExtent mediumExtent aOpenGLBounds |
	rAppWindowToTopLeftOfPanePixel := displayPane appWindowToOriginOffset.
	pen nonScaledTranslation: rAppWindowToTopLeftOfPanePixel 
				+ self rDrawingOriginToTopLeftOfDisplayedAreaOfDrawingInPixels.
	pen nonScalingClippingRectangle: (aRect intersect: displayPane bounds).
	clippingBounds := pen clippingBounds.
	clipExtent := clippingBounds extent.
	clipExtent > 0 
		ifTrue: 
			[aOpenGLSemaphore critical: 
					[self 
						assert: 
							[block := 
									[:extent | 
									aOpenGLMedium := OpenGLRetainedMedium extent: extent.
									aOpenGLMedium setBackground: displayPane lookPreferences backgroundColor.
									aCamera := interface aParallelCameraWithBounds: clippingBounds.
									aOpenGLContext := aCamera aRenderingContextOn: aOpenGLMedium].
							aOpenGLMedium ifNil: 
									[newExtent := 800 @ 600.
									block value: newExtent].
							mediumExtent := aOpenGLMedium extent.
							(clipExtent x > mediumExtent x or: [clipExtent y > mediumExtent y]) 
								ifTrue: 
									[aOpenGLMedium releaseMedium.
									aOpenGLContext release.
									interface removeDisplayList.
									newExtent := (clipExtent x max: mediumExtent x) 
												@ (clipExtent y max: mediumExtent y).
									block value: newExtent].
							aOpenGLContext initializeContext.
							aOpenGLContext clear.
							aCamera := interface aParallelCameraWithBounds: clippingBounds.
							aCamera smoothShading.
							aOpenGLContext obeyParallelCamera: aCamera.
							aOpenGLContext viewport: (0 @ 0 extent: clipExtent)]
						do: 
							[interface renderOn: aOpenGLContext.
							aOpenGLContext flush]
						ensure: [aOpenGLContext deactivate].
					pen translateBy: clippingBounds origin.
					aOpenGLBounds := pen clippingBounds.
					aOpenGLMedium 
						displayOn: pen
						at: aOpenGLBounds origin
						bounds: aOpenGLBounds.
					pen translateBy: clippingBounds origin negated].
			interface showHandles]
]

{ #category : #calc }
CADDoubleBufferingGraphicsDisplaySystem >> displayViewRectangle: aRect [ 
	| hHandles adjustedRect |
	pen == nil
		ifTrue: 
			[displayPane initGraphics.
			self newScratchExtent: displayPane clippingBox extent].
	adjustedRect := aRect.
	hHandles := interface handlesToDisplayInRect: adjustedRect.
	self damageRegion: (displayPane pen unscaleRectangle: adjustedRect).
	self repairDamage.
	self displayHandles: hHandles
]

{ #category : #calc }
CADDoubleBufferingGraphicsDisplaySystem >> drawingRect [
	^interface drawingRect
]

{ #category : #'initialize-release' }
CADDoubleBufferingGraphicsDisplaySystem >> initialize [
	displayPane := CADDrawingPane new.
	displayPane displaySystem: self.
	damagedRegion := GFDamagedRegion origin: 0 @ 0 corner: 0 @ 0.
	mousePoint := 0 @ 0.
	hostActions := OrderedCollection new.
	minFactor := 1 @ 1.
	self newScratchExtent: 100 @ 100.
	isOpenGL := true.
	aOpenGLSemaphore := Semaphore forMutualExclusion
]

{ #category : #accessing }
CADDoubleBufferingGraphicsDisplaySystem >> interface: aInterface [ 
	interface := aInterface
]

{ #category : #accessing }
CADDoubleBufferingGraphicsDisplaySystem >> isOpenGL [
	^isOpenGL
]

{ #category : #accessing }
CADDoubleBufferingGraphicsDisplaySystem >> isOpenGL: anObject [
	isOpenGL := anObject
]

{ #category : #accessing }
CADDoubleBufferingGraphicsDisplaySystem >> mousePoint: rDpPx [ 
	mousePoint := rDpPx
]

{ #category : #calc }
CADDoubleBufferingGraphicsDisplaySystem >> projectAndAnimateFrame [
	isOpenGL 
		ifTrue: [self displayOpenGLRectangle: displayPane bounds]
		ifFalse: [self projectAndAnimateFrameBasic]
]

{ #category : #calc }
CADDoubleBufferingGraphicsDisplaySystem >> projectAndAnimateFrame1 [
	"Modified to accept arbitrary location of drawing coordinates origin."

	| sPen origin extent |
	displayPane topComponent == nil ifTrue: [^self].
	(sPen := scratch pen) nonScaledTranslation: interface drawing rSDPx - displayPane rSsliderPx.
	origin := displayPane rSsliderPx - interface drawing rSDPx.
	extent := displayPane clippingBox extent.
	sPen clippingRectangle: (origin extent: extent).
	sPen
		gfFillOrigin: origin
		extent: extent
		color: displayPane backColor.
	interface drawing projectOn: interface projectionFrame animateWith: sPen.
	self updateDisplayPaneOrigin: origin extent: extent.
	interface showHandles
]

{ #category : #calc }
CADDoubleBufferingGraphicsDisplaySystem >> projectAndAnimateFrameBasic [
	"Modified to accept arbitrary location of drawing coordinates 
	origin."

	| sPen clippingBox origin extent |
	displayPane topComponent == nil ifTrue: [^self].
	(sPen := scratch pen) nonScaledTranslation: self rDrawingOriginToTopLeftOfDisplayedAreaOfDrawingInPixels.
	clippingBox := displayPane clippingBox.
	origin := clippingBox origin.
	extent := clippingBox extent.
	sPen clippingRectangle: displayPane clippingBox.
	sPen
		gfFillOrigin: origin
		extent: extent
		color: displayPane backColor.
	interface drawing projectOn: interface projectionFrame animateWith: sPen.
	self updateDisplayPaneOrigin: origin extent: extent.
	interface showHandles
]

{ #category : #accessing }
CADDoubleBufferingGraphicsDisplaySystem >> rDcursorPx [
	^mousePoint
]

{ #category : #accessing }
CADDoubleBufferingGraphicsDisplaySystem >> rDcursorPx: rDpPx [ 
	mousePoint := rDpPx
]

{ #category : #accessing }
CADDoubleBufferingGraphicsDisplaySystem >> rDrawingOriginToTopLeftOfDisplayedAreaOfDrawingInPixels [
	"Displacement from Drawing origin to the top left corner of visible 
	window of drawing, in the usual pixel coordinates."

	^displayPane rDrawingOriginToTopLeftOfDisplayedAreaOfDrawingInPixels
]

{ #category : #accessing }
CADDoubleBufferingGraphicsDisplaySystem >> rTopLeftOfDrawingToDrawingOriginInPixels [
	^interface rTopLeftOfDrawingToDrawingOriginInPixels
]

{ #category : #calc }
CADDoubleBufferingGraphicsDisplaySystem >> repairDamage [
	"	Transcript show: thisContext printStack."

"	Transcript cr; show: Time millisecondClockValue printString."
	damagedRegion valid ifFalse: [^self].
"	Transcript show: damagedRegion printString."
	self display: damagedRegion.
	damagedRegion invalidate
]

{ #category : #calc }
CADDoubleBufferingGraphicsDisplaySystem >> sizingFrom: oldPoint to: newPoint [ 
	"Points are in Screen coordinates."

	| scrollX scrollY y x maxPoint |
	self updateVisibleArea.
	((visibleArea containsPoint: newPoint)
		or: [self drawingRect extent < newPoint])
		ifTrue: [^self].
	maxPoint := newPoint min: self drawingRect extent.
	scrollX := scrollY := 0.
	maxPoint y < (y := visibleArea top)
		ifTrue: [scrollY := maxPoint y - y]
		ifFalse: [maxPoint y > (y := visibleArea bottom) ifTrue: [scrollY := maxPoint y - y]].
	maxPoint x < (x := visibleArea left)
		ifTrue: [scrollX := maxPoint x - x]
		ifFalse: [maxPoint x > (x := visibleArea right) ifTrue: [scrollX := maxPoint x - x]].
	self scrollTopCorner: scrollX @ scrollY
]

{ #category : #calc }
CADDoubleBufferingGraphicsDisplaySystem >> trackMouse: trackBlock uponRelease: releaseBlock until: stopBlock scroll: scroll preScrollDo: preScrollBlock snapToGrid: snap limit1: limit [ 
	"The central mouse tracking routine. 
	
	Track the mouse point, evaluating the trackBlock for every point. 
	The mouse is tracked until the stopBlock evaluates true. Upon 
	release of the mouse button, the releaseBlock is evaluated. 
	The display is scrolled to accomidate the tracking if scroll is true. 
	If scrolling is enabled, the preScrollBlock is evaluated before 
	scrolling 
	the display with the previous point tracked as the argument. 
	The mouse point is snapped to the drawing grid if snap is true. 
	The mouse points tracked are limited to the extent of the drawing 
	if limit is true. 
	"

	| oldPoint redButtonWasDown |
	oldPoint := nil.
	redButtonWasDown := false.
	(displayPane controller) checkAndResetDoubleClick; deactivateControlLoop.
	interface hideHandlesWhile: [
		[| sensor pt |
		sensor := displayPane controller sensor.
		(pt := sensor mousePoint) ~= oldPoint
			ifTrue: 
				[scroll
					ifTrue: 
						[oldPoint == nil ifFalse: [preScrollBlock == nil ifFalse: [preScrollBlock value: oldPoint]].
						self sizingFrom: oldPoint to: pt].
				self
					transformPoint: pt
					snapToGrid: snap
					limit: limit.
				trackBlock value: mousePoint].
		(redButtonWasDown and: [sensor redButtonPressed not])
			ifTrue: [releaseBlock == nil ifFalse: [releaseBlock value]].
		oldPoint := mousePoint.
		redButtonWasDown := sensor redButtonPressed.
		stopBlock value] whileFalse].
	displayPane controller activateControlLoop
]

{ #category : #calc }
CADDoubleBufferingGraphicsDisplaySystem >> trackMouse: trackBlock uponRelease: releaseBlock until: stopBlock scroll: scroll preScrollDo: preScrollBlock snapToGrid: snap limit: limit [ 
	"The central mouse tracking routine. 
	
	Track the mouse point, evaluating the trackBlock for every point. 
	The mouse is tracked until the stopBlock evaluates true. Upon 
	release of the mouse button, the releaseBlock is evaluated. 
	The display is scrolled to accomidate the tracking if scroll is true. 
	If scrolling is enabled, the preScrollBlock is evaluated before 
	scrolling 
	the display with the previous point tracked as the argument. 
	The mouse point is snapped to the drawing grid if snap is true. 
	The mouse points tracked are limited to the extent of the drawing 
	if limit is true. 
	"

	| oldPoint redButtonWasDown |
	oldPoint := nil.
	redButtonWasDown := false.
	(displayPane controller) checkAndResetDoubleClick; deactivateControlLoop.
	interface repairDamage.	"
	This prevents moving some thing during selection."
	(Delay forMilliseconds: 400) wait.
	interface hideHandlesWhile: [[stopBlock value]
			whileFalse: 
				[| sensor pt |
				sensor := displayPane controller sensor.
				(pt := sensor mousePoint) ~= oldPoint
					ifTrue: 
						[scroll
							ifTrue: 
								[oldPoint == nil ifFalse: [preScrollBlock == nil ifFalse: [preScrollBlock value: oldPoint]].
								self sizingFrom: oldPoint to: pt].
						self
							transformPoint: pt
							snapToGrid: snap
							limit: limit.
						trackBlock value: mousePoint].
				(redButtonWasDown and: [sensor redButtonPressed not])
					ifTrue: [releaseBlock == nil ifFalse: [releaseBlock value]].
				oldPoint := mousePoint.
				redButtonWasDown := sensor redButtonPressed]].
	displayPane controller activateControlLoop
]

{ #category : #calc }
CADDoubleBufferingGraphicsDisplaySystem >> transformPoint: rDpPx snapToGrid: snap limit: limit [ 
	^interface
		snaprDpPx: rDpPx
		if: snap
		limit: limit
]

{ #category : #calc }
CADDoubleBufferingGraphicsDisplaySystem >> updateDisplayPaneOrigin2: origin extent: extent [ 
	"Modified to accept arbitrary location of drawing coordinates 
	origin."
	""

	| sPen damagedRect paneRect intersectRect |
	sPen := scratch pen.
	pen nonScaledTranslation: displayPane appWindowToOriginOffset + interface drawing rSDPx - displayPane rSsliderPx.
	paneRect := displayPane rSsliderPx - interface drawing rSDPx extent: displayPane clippingBox extent.
	pen nonScalingClippingRectangle: paneRect.
	damagedRect := origin extent: extent.
	intersectRect := damagedRect intersect: paneRect.
	pen
		fastCopyRectangularAreaOrigin: (sPen scalePoint: intersectRect origin)
		extent: (sPen scalePointFloor: intersectRect extent)
		from: sPen
]

{ #category : #calc }
CADDoubleBufferingGraphicsDisplaySystem >> updateDisplayPaneOrigin: origin extent1: extent [ 
	"Modified to accept arbitrary location of drawing coordinates origin."
	""

	| sPen damagedRect paneRect intersectRect |
	sPen := scratch pen.
	pen nonScaledTranslation: displayPane appWindowToOriginOffset + interface drawing rSDPx - displayPane rSsliderPx.
	pen nonScalingClippingRectangle: (displayPane bounds translatedBy: interface drawing rSDPx negated).
	damagedRect := origin extent: extent.
	paneRect := displayPane rSsliderPx - interface drawing rSDPx extent: displayPane clippingBox extent.
	intersectRect := damagedRect intersect: paneRect.
	pen
		fastCopyRectangularAreaOrigin: (sPen scalePoint: intersectRect origin)
		extent: (sPen scalePointFloor: intersectRect extent)
		from: sPen
]

{ #category : #calc }
CADDoubleBufferingGraphicsDisplaySystem >> updateDisplayPaneOrigin: origin extent: extent [ 
	"intersectRect should not be needed. But Linux does not clip 
	properly. So we do it ourselves."

	| damagedRect paneRect sPen rAppWindowToTopLeftOfPanePixel intersectRect |
	damagedRect := origin extent: extent.
	paneRect := displayPane bounds.
	sPen := scratch pen.
	rAppWindowToTopLeftOfPanePixel := displayPane appWindowToOriginOffset.
	pen nonScaledTranslation: rAppWindowToTopLeftOfPanePixel + self rDrawingOriginToTopLeftOfDisplayedAreaOfDrawingInPixels.
	pen nonScalingClippingRectangle: paneRect.
	intersectRect := damagedRect intersect: paneRect.
	pen
		fastCopyRectangularAreaOrigin: (sPen scalePoint: intersectRect origin)
		extent: (sPen scalePointFloor: intersectRect extent)
		from: sPen
]

{ #category : #calc }
CADDoubleBufferingGraphicsDisplaySystem >> workPen [
	scratch isNil ifTrue: [self newScratchExtent: 100 @ 100].
	^scratch pen
]
