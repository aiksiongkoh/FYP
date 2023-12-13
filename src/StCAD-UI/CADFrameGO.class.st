Class {
	#name : #CADFrameGO,
	#superclass : #CADGraphicObject,
	#instVars : [
		'axisLength',
		'lineWidth'
	],
	#classVars : [
		'UI'
	],
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADFrameGO class >> AxisLength [
	^AxisLength
]

{ #category : #accessing }
CADFrameGO class >> AxisLength: double [ 
	AxisLength := double
]

{ #category : #'VisualWorks metadata' }
CADFrameGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADFrameGO >> axisLength [
	^axisLength
]

{ #category : #accessing }
CADFrameGO >> axisLength: double [ 
	axisLength := double
]

{ #category : #calc }
CADFrameGO >> basicUpdateProjection: projectionFrame [ 
	| geoFrame rDfD rDxD rDyD rDzD axis xaxis yaxis zaxis |
	geoFrame := self geoRefFrame.
	rDfD := projectionFrame rDpPxfromrOpO: geoFrame rOfO.
	axis := (FullColumn zero: 3).
	xaxis := axis copy.
	xaxis at: 1 put: axisLength.
	yaxis := axis copy.
	yaxis at: 2 put: axisLength.
	zaxis := axis copy.
	zaxis at: 3 put: axisLength.
	rDxD := projectionFrame rDpPxfromrOpO: (geoFrame rOpOfromrfpf: xaxis).
	rDyD := projectionFrame rDpPxfromrOpO: (geoFrame rOpOfromrfpf: yaxis).
	rDzD := projectionFrame rDpPxfromrOpO: (geoFrame rOpOfromrfpf: zaxis).
	(graphicObjects at: 1)
		start: rDfD stop: rDxD.
	(graphicObjects at: 2)
		start: rDfD stop: rDyD.
	(graphicObjects at: 3)
		start: rDfD stop: rDzD
]

{ #category : #calc }
CADFrameGO >> cadPlot [
	self interface cadApp openPlotOn: self metaObject withSpec: #windowSpec
]

{ #category : #calc }
CADFrameGO >> dataAxesIntersect: rDpD [ 
	| interface geoFrame |
	interface := self interface.
	geoFrame := self geoRefFrame.
	^geoFrame
		dataAxesIntersectLine: (interface projectorAt: rDpD)
		axisLength: axisLength
		tolerance: self metrePerPixel * 4
]

{ #category : #accessing }
CADFrameGO >> dimension [
	"1D lines in three directions."

	^1.5
]

{ #category : #accessing }
CADFrameGO >> geoObject: geoMarker [
	"RGB is xyz axes."
	| block |
	super geoObject: geoMarker.
	block :=
			[:color |
			| lineGO |
			lineGO := CADLineGO start: 0 @ 0 stop: 0 @ 0.
			lineGO width: lineWidth.
			lineGO color: color.
			lineGO disableInteraction.
			lineGO.].
	self add: (block value: Color red).
	self add: (block value: Color green).
	self add: (block value: Color blue).
	self hideVisibleAreaIndicator.
	self enableDefaultInteraction.
]

{ #category : #accessing }
CADFrameGO >> geoRefFrame [
	^self metaObject refFrame
]

{ #category : #calc }
CADFrameGO >> graphicsIntersecting: rDpD collectIn: set [ 
	| data depth |
	(self displayBox containsPoint: rDpD)
		ifTrue: 
			[data := self dataAxesIntersect: rDpD.
			(data at: 1)
				ifTrue: 
					[depth := data at: 4.
					set add: self -> depth]]
]

{ #category : #'initialize-release' }
CADFrameGO >> initialize [
	super initialize.
	self axisLength: AxisLength.
	lineWidth := 2
]

{ #category : #calc }
CADFrameGO >> projectOn: projectionFrame animateWith: aPen [ 
	self basicUpdateProjection: projectionFrame.
	graphicObjects do: [:each | each displayWith: aPen]
]

{ #category : #calc }
CADFrameGO >> quietlyUpdateProjection: projectionFrame [ 
	self basicUpdateProjection: projectionFrame.
	self quietlyResetVisibleArea
]

{ #category : #accessing }
CADFrameGO >> rDoriginPx [
	| geo |
	geo := self metaObject.
	^geo refFrame rDoriginPx
]

{ #category : #calc }
CADFrameGO >> updateProjection: projectionFrame [ 
	self basicUpdateProjection: projectionFrame.
	self resetVisibleArea
]
