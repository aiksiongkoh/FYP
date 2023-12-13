Class {
	#name : #CADRectangleGO,
	#superclass : #CADPolylineGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #'instance creation' }
CADRectangleGO class >> createNotifying1: anInterface [ 
	| points rDstartD cadGO cursorLine sketch rSstartS rSendS aGEO sketchGO |
	points := Array new: 5.
	rDstartD := anInterface cursorPoint.
	points atAllPut: rDstartD.
	cadGO := self withPoints: points.
	cursorLine := anInterface projectorAt: rDstartD.
	sketch := anInterface activeSketch.
	rSstartS := rSendS := sketch refFrame xyPlaneIntersectLine: cursorLine.
	aGEO := GEORectangle minCorner: rSstartS maxCorner: rSendS.
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
CADRectangleGO class >> createNotifying: anInterface [ 
	| points rDstartD cadGO cursorLine sketch rSstartS rSendS aGEO |
	points := Array new: 5.
	rDstartD := anInterface cursorPoint.
	points atAllPut: rDstartD.
	cadGO := self withPoints: points.
	cursorLine := anInterface projectorAt: rDstartD.
	sketch := anInterface activeSketch.
	rSstartS := rSendS := sketch refFrame xyPlaneIntersectLine: cursorLine.
	aGEO := GEORectangle minCorner: rSstartS maxCorner: rSendS.
	sketch addGraphic: aGEO.
	cadGO geoObject: aGEO.
	cadGO growNotifying: anInterface.
	^cadGO
]

{ #category : #'instance creation' }
CADRectangleGO class >> creationTool [
	^CADCreationTool
		icon: (GFTool stockIconFor: 'Rectangle')
		cursor: self gfCursorClass crossHair
		class: self
		name: 'Rectangle'
]

{ #category : #'VisualWorks metadata' }
CADRectangleGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #all }
CADRectangleGO >> bottomRight [
	^points at: 2
]

{ #category : #handles }
CADRectangleGO >> defaultHandles [
	^Array
		with: self minCornerHandle
		with: self maxCornerHandle
		with: self rotateHandle
]

{ #category : #handles }
CADRectangleGO >> growHandle [
	^self maxCornerHandle
]

{ #category : #all }
CADRectangleGO >> growNotifying: anInterface [ 
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
CADRectangleGO >> maxCorner [
	^points at: 3
]

{ #category : #handles }
CADRectangleGO >> maxCornerHandle [
	| maxCornerHandle |
	maxCornerHandle := CADTrackHandle on: self at: #maxCorner.
	maxCornerHandle hotSpot: [:handle | handle origin].
	maxCornerHandle setSense: nil
		change: 
			[:cadRect :frozenCadRect :rDoriginD :rDfirstD :rDoldD :rDnewD | 
			| geoRect interface sketchRefFrame rSendS |
			geoRect := cadRect metaObject.
			interface := cadRect interface.
			sketchRefFrame := geoRect refFrame refFrame.
			rSendS := sketchRefFrame xyPlaneIntersectLine: (interface projectorAt: rDoriginD + rDnewD - rDfirstD).
			geoRect maxCorner: rSendS].
	maxCornerHandle mementoType: #positionMemento.
	maxCornerHandle description: 'move maxCorner position'.
	^maxCornerHandle
]

{ #category : #all }
CADRectangleGO >> minCorner [
	^points at: 1
]

{ #category : #handles }
CADRectangleGO >> minCornerHandle [
	| minCornerHandle |
	minCornerHandle := CADTrackHandle on: self at: #minCorner.
	minCornerHandle hotSpot: [:handle | handle origin].
	minCornerHandle setSense: nil
		change: 
			[:cadRect :frozenCadRect :rDoriginD :rDfirstD :rDoldD :rDnewD | 
			| geoRect interface sketchRefFrame rSendS |
			geoRect := cadRect metaObject.
			interface := cadRect interface.
			sketchRefFrame := geoRect refFrame refFrame.
			rSendS := sketchRefFrame xyPlaneIntersectLine: (interface projectorAt: rDoriginD + rDnewD - rDfirstD).
			geoRect minCorner: rSendS].
	minCornerHandle mementoType: #positionMemento.
	minCornerHandle description: 'move minCorner position'.
	^minCornerHandle
]

{ #category : #all }
CADRectangleGO >> posAngDialog [
	CADRectangleDialog openOn: self metaObject
]

{ #category : #all }
CADRectangleGO >> rDx1y0Px [
	^points at: 2
]
