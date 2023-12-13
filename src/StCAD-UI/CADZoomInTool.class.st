Class {
	#name : #CADZoomInTool,
	#superclass : #GFTool,
	#category : #'StCAD-UI-CAD'
}

{ #category : #'VisualWorks metadata' }
CADZoomInTool class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'Polymorphic'
	)

]

{ #category : #control }
CADZoomInTool >> button1Down: aPoint [ 
	| rDrectPx projectionFrame rPcenterP rOcenterO paneRect ratio pixelPerMetre |
	rDrectPx := self rectangleFromUser.
	projectionFrame := interface projectionFrame.
	rPcenterP := projectionFrame xyPlaneIntersectLine: (interface projectorAt: rDrectPx center).
	rOcenterO := projectionFrame rOpOfromrfpf: rPcenterP.
	paneRect := interface paneBoundsInDrawingCoordinates.
	ratio := paneRect extent / rDrectPx extent.
	ratio := ratio x min: ratio y.
	ratio > 100
		ifTrue: [Dialog warn: 'Zoom magnification is greater than 100. \Choose a larger zoom area.' withCRs]
		ifFalse: 
			[pixelPerMetre := interface pixelPerMetre * (ratio * 0.9d).
			projectionFrame rFfF: rOcenterO pixelPerMetre: pixelPerMetre.
			interface centerPaneAtDrawingPoint: 0 @ 0.
			interface noSelections.
			interface setDefaultTool]
]

{ #category : #accessing }
CADZoomInTool >> rectangleFromUser [

	| originPoint gridPoint rect pane rDoriginPx |
	originPoint := InputState default mousePoint.
	gridPoint := 1 @ 1.
	self cursor showWhile: [ 
		rect := Screen default
			        resizeRectangle:
			        (Graphics_Rectangle origin: originPoint extent: gridPoint)
			        minimumExtent: gridPoint
			        resizeIncrement: gridPoint
			        boundedBy: nil
			        whileButton: 0
			        isDown: true "VW_TRANSLATION:Graphics.Rectangle:Graphics_Rectangle" ].
	pane := interface display displayPane.
	rDoriginPx := pane globalPointToLocal:
		              (rect origin translatedBy:
			               pane topComponent globalOrigin negated).
	^ rDoriginPx extent: rect extent
]
