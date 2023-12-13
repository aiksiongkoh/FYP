Class {
	#name : #CADEllipseGO,
	#superclass : #CADPolylineGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #'instance creation' }
CADEllipseGO class >> createNotifying1: anInterface [ 
	| points rDstartD cadGO cursorLine sketch rSstartS rSendS aGEO sketchGO |
	points := Array new: 5.
	rDstartD := anInterface cursorPoint.
	points atAllPut: rDstartD.
	cadGO := self withPoints: points.
	cursorLine := anInterface projectorAt: rDstartD.
	sketch := anInterface activeSketch.
	rSstartS := rSendS := sketch refFrame xyPlaneIntersectLine: cursorLine.
	aGEO := GEOEllipse
				origin: rSstartS
				xRadius: 0.0d
				yRadius: 0.0d.
	sketch addGraphic: aGEO.
	anInterface bindGEO: aGEO toCAD: cadGO.
	sketchGO := sketch cadObject.
	sketchGO add: cadGO.
	sketchGO resetVisibleArea.
	cadGO when: #damaged do: [cadGO container visibleAreaMergeWith: cadGO displayBox].
	cadGO growNotifying: anInterface.
	^cadGO
]

{ #category : #'instance creation' }
CADEllipseGO class >> createNotifying: anInterface [ 
	| points rDstartD cadGO cursorLine sketch rSstartS aGEO |
	points := Array new: 5.
	rDstartD := anInterface cursorPoint.
	points atAllPut: rDstartD.
	cadGO := self withPoints: points.
	cursorLine := anInterface projectorAt: rDstartD.
	sketch := anInterface activeSketch.
	rSstartS := sketch refFrame xyPlaneIntersectLine: cursorLine.
	aGEO := self geoClass
				origin: rSstartS
				xRadius: 0.0d
				yRadius: 0.0d.
	sketch addGraphic: aGEO.
	cadGO geoObject: aGEO.
	cadGO growNotifying: anInterface.
	^cadGO
]

{ #category : #'instance creation' }
CADEllipseGO class >> creationTool [
	^CADCreationTool
		icon: (GFTool stockIconFor: 'Ellipse')
		cursor: self gfCursorClass crossHair
		class: self
		name: 'Ellipse'
]

{ #category : #'instance creation' }
CADEllipseGO class >> geoClass [
	^GEOEllipse
]

{ #category : #'VisualWorks metadata' }
CADEllipseGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #all }
CADEllipseGO >> defaultHandles [
	^Array
		with: self rDoriginPxHandle
		with: self rDx1y1PxHandle
		with: self rotateHandle
]

{ #category : #all }
CADEllipseGO >> growHandle [
	^self rDx1y1PxHandle
]

{ #category : #all }
CADEllipseGO >> growNotifying: anInterface [ 
	"Used in the creation of the receiver"

	| aHandle |
	aHandle := self growHandle.
	aHandle mementoType: nil.
	anInterface addHandle: aHandle.
	self class gfCursorClass crossHair change.
	aHandle invoke: anInterface.
	self class gfCursorClass normal change.
	anInterface removeHandle: aHandle
]

{ #category : #all }
CADEllipseGO >> posAngDialog [
	CADEllipseDialog openOn: self metaObject
]

{ #category : #all }
CADEllipseGO >> rDoriginPxHandle [
	| rDoriginPxHandle |
	rDoriginPxHandle := CADTrackHandle on: self at: #rDoriginPx.
	rDoriginPxHandle hotSpot: [:handle | handle origin].
	rDoriginPxHandle setSense: nil
		change: 
			[:cadEllipse :frozenCadEllipse :rDoriginPx :rDfirstPx :rDoldPx :rDnewPx | 
			| geoEllipse interface sketchRefFrame rSendS |
			geoEllipse := cadEllipse metaObject.
			interface := cadEllipse interface.
			sketchRefFrame := geoEllipse refFrame refFrame.
			rSendS := sketchRefFrame xyPlaneIntersectLine: (interface projectorAt: rDoriginPx + rDnewPx - rDfirstPx).
			geoEllipse origin: rSendS].
	rDoriginPxHandle mementoType: #positionMemento.
	rDoriginPxHandle description: 'move origin position'.
	^rDoriginPxHandle
]

{ #category : #all }
CADEllipseGO >> rDx1y0Px [
	^points at: 1
]

{ #category : #all }
CADEllipseGO >> rDx1y1Px [
	| geoEllipse x1y1 rOx1y1O |
	geoEllipse := self metaObject.
	x1y1 := FullColumn
				with: geoEllipse xRadius
				with: geoEllipse yRadius
				with: 0.0d.
	rOx1y1O := geoEllipse refFrame rOpOfromrfpf: x1y1.
	^self interface projectionFrame rDpPxfromrOpO: rOx1y1O
]

{ #category : #all }
CADEllipseGO >> rDx1y1PxHandle [
	| rDx1y1PxHandle |
	rDx1y1PxHandle := CADTrackHandle on: self at: #rDx1y1Px.
	rDx1y1PxHandle hotSpot: [:handle | handle origin].
	rDx1y1PxHandle setSense: nil
		change: 
			[:cadEllipse :frozenCadEllipse :rDoriginPx :rDfirstPx :rDoldPx :rDnewPx | 
			| geoEllipse interface geoEllipseRefFrame rGendG |
			geoEllipse := cadEllipse metaObject.
			interface := cadEllipse interface.
			geoEllipseRefFrame := geoEllipse refFrame.
			rGendG := geoEllipseRefFrame xyPlaneIntersectLine: (interface projectorAt: rDoriginPx + rDnewPx - rDfirstPx).
			geoEllipse xRadius: (rGendG at: 1)
				yRadius: (rGendG at: 2)].
	rDx1y1PxHandle mementoType: #positionMemento.
	rDx1y1PxHandle description: 'move maxCorner position'.
	^rDx1y1PxHandle
]
