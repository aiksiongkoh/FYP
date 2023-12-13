Class {
	#name : #CADPolylineGO,
	#superclass : #GFPolylineGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #'instance creation' }
CADPolylineGO class >> createNotifying: anInterface [ 
	| rDlastPx rDcurPx rDpointsPx aPen color rDpointsPxClean cadGO sketch sketchRefFrame rSpointsS aGEO |
	rDlastPx := rDcurPx := anInterface cursorPoint.
	rDpointsPx := OrderedCollection new.
	(aPen := anInterface pen)
		setForeColorTo: (color := self defaultLineColor);
		displayLineFrom: rDlastPx to: rDcurPx.
	rDpointsPx add: rDcurPx.
	anInterface trackMouseUntilLBDoubleClick: 
			[:rDnewPx | 
			anInterface drawing 
				damageRegion: ((rDlastPx rectangleWith: rDcurPx) expandedByPoint: 2 @ 2).
			anInterface repairDamage.
			aPen setForeColorTo: color.
			rDpointsPx size > 1 ifTrue: [aPen displayPolyline: rDpointsPx].
			aPen displayLineFrom: rDlastPx to: (rDcurPx := rDnewPx)]
		uponRelease: 
			[rDlastPx == rDcurPx ifFalse: [rDpointsPx add: rDcurPx copy].
			rDlastPx := rDcurPx].
	rDpointsPxClean := OrderedCollection new.
	rDpointsPxClean add: (rDpointsPx at: 1).
	2 to: rDpointsPx size
		do: 
			[:i | 
			(rDpointsPx at: i) ~= rDpointsPxClean last 
				ifTrue: [rDpointsPxClean add: (rDpointsPx at: i)]].
	rDpointsPxClean first ~= rDpointsPxClean last 
		ifTrue: 
			["Closed the polyline."

			rDpointsPxClean add: rDpointsPxClean first].
	cadGO := self withPoints: rDpointsPxClean.
	sketch := anInterface activeSketch.
	sketchRefFrame := sketch refFrame.
	rSpointsS := rDpointsPxClean collect: 
					[:rDpointPx | 
					sketchRefFrame xyPlaneIntersectLine: (anInterface projectorAt: rDpointPx)].
	aGEO := self metaClass new.
	aGEO rFpointsF: rSpointsS.
	sketch addGraphic: aGEO.
	cadGO geoObject: aGEO.
	cadGO damaged.
	^cadGO
]

{ #category : #'instance creation' }
CADPolylineGO class >> creationTool [
	^CADCreationTool
		icon: (GFTool stockIconFor: 'Polyline')
		cursor: self gfCursorClass crossHair
		class: self
		name: 'Polyline'
]

{ #category : #accessing }
CADPolylineGO class >> metaClass [
	^GEOPolyline
]

{ #category : #resources }
CADPolylineGO class >> standardMenu [
	"MenuEditor new openOnClass: self andSelector: #standardMenu"

	<resource: #menu>
	^#(#Menu #(
			#(#MenuItem 
				#rawLabel: 'Position/Angle' 
				#value: #posAngDialog ) ) #(1 ) nil ) decodeAsLiteralArray
]

{ #category : #resources }
CADPolylineGO class >> vertexMenu [
	"MenuEditor new openOnClass: self andSelector: #vertexMenu"

	<resource: #menu>
	^#(#Menu #(
			#(#MenuItem 
				#rawLabel: 'Insert After' 
				#value: 
				#insertPointAfter: ) 
			#(#MenuItem 
				#rawLabel: 'Delete' 
				#value: 
				#deletePoint: ) ) #(2 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADPolylineGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'Polymorphic'
	)

]

{ #category : #accessing }
CADPolylineGO >> aGraphicViewPopupMenu [
	| interface answerMenu drawingMenu |
	interface := self interface.
	answerMenu := Menu new.
	answerMenu addPart: self menu.
	drawingMenu := Menu new.
	drawingMenu addItemLabel: '&Undo' value: [interface undo].
	drawingMenu addItemLabel: 'Cu&t' value: [interface cut].
	answerMenu addItemGroup: (Array 
				with: ((MenuItem labeled: interface menuLabel) submenu: drawingMenu)).
	^answerMenu
]

{ #category : #calc }
CADPolylineGO >> basicUpdateProjection1: projectionFrame [ 
	| geoPolyline geoPoints cadPoints |
	geoPolyline := self metaObject.
	geoPoints := geoPolyline rOpointsO.
	cadPoints := geoPoints collect: [:geoPoint | projectionFrame rDpPxfromrOpO: geoPoint].
	points := cadPoints
]

{ #category : #calc }
CADPolylineGO >> basicUpdateProjection: projectionFrame [ 
	| geoPolyline geoPoints cadPoints |
	geoPolyline := self metaObject.
	(geoPolyline container isFace not or: [(geoPolyline refFrame
			axis: 3
			dotFrame: projectionFrame
			axis: 3)
			< 0.0d])
		ifTrue: 
			[geoPoints := geoPolyline rOpointsO.
			cadPoints := geoPoints collect: [:geoPoint | projectionFrame rDpPxfromrOpO: geoPoint].
			points := cadPoints]
		ifFalse: [points := nil]
]

{ #category : #calc }
CADPolylineGO >> checkClosed [
	points notNil ifTrue: [super checkClosed]
]

{ #category : #accessing }
CADPolylineGO >> defaultHandles [
	| n handles |
	n := closed
				ifTrue: [points size - 1]
				ifFalse: [points size].
	handles := Array new: n.
	handles at: 1 put: self pointHandleAt1.
	2 to: n do: [:i | handles at: i put: (self pointHandleAt: i)].
	^handles
]

{ #category : #accessing }
CADPolylineGO >> defaultHandles1 [
	| n handles |
	n := closed
				ifTrue: [points size - 1]
				ifFalse: [points size].
	handles := Array new: n.
	1 to: n do: [:i | handles at: i put: (self pointHandleAt: i)].
	^handles
]

{ #category : #accessing }
CADPolylineGO >> defaultPositionHandle [
	"Translate movingFrame relative to its refFrame in the xy plane of the inPlaneFrame."

	| posHandle |
	posHandle := CADSelectionTrackHandle on: self at: #center.
	posHandle hotSpot: [:handle | handle origin].
	posHandle setSense: nil
		change: 
			[:cadGO :frozenCadGO :rDoriginD :rDfirstD :rDoldD :rDnewD :selection | 
			| interface geo movingFrame inPlaneFrame riPoldiP riPnewiP roldnewF |
			interface := selection interface.
			geo := selection metaObject.
			movingFrame := geo movingFrame.
			inPlaneFrame := geo inPlaneFrame.
			riPoldiP := inPlaneFrame xyPlaneIntersectLine: (interface projectorAt: rDoldD).
			riPnewiP := inPlaneFrame xyPlaneIntersectLine: (interface projectorAt: rDnewD).
			roldnewF := movingFrame aAOF transpose timesFullColumn: (inPlaneFrame aAOf timesFullColumn: riPnewiP - riPoldiP).
			movingFrame translateSelfBy: roldnewF].
	posHandle mementoType: #positionMemento.
	posHandle description: 'move start position'.
	^posHandle
]

{ #category : #accessing }
CADPolylineGO >> defaultPositionHandle1 [
	"This is repeated for each CADGO for the time being."

	| posHandle |
	posHandle := CADSelectionTrackHandle on: self at: #center.
	posHandle hotSpot: [:handle | handle origin].
	posHandle setSense: nil
		change: 
			[:cadGO :frozenCadGO :rDoriginD :rDfirstD :rDoldD :rDnewD :selection | 
			| geo interface sketchRefFrame rSoldS rSnewS |
			geo := selection metaObject.
			interface := selection interface.
			sketchRefFrame := geo refFrame refFrame.
			rSoldS := sketchRefFrame xyPlaneIntersectLine: (interface projectorAt: rDoldD).
			rSnewS := sketchRefFrame xyPlaneIntersectLine: (interface projectorAt: rDnewD).
			geo translateSelfBy: rSnewS - rSoldS].
	posHandle mementoType: #positionMemento.
	posHandle description: 'move start position'.
	^posHandle
]

{ #category : #accessing }
CADPolylineGO >> defaultPositionHandle2 [
	"Translate movingFrame relative to its refFrame in the xy plane of the inPlaneFrame."

	| posHandle |
	posHandle := CADSelectionTrackHandle on: self at: #center.
	posHandle hotSpot: [:handle | handle origin].
	posHandle setSense: nil
		change: 
			[:cadGO :frozenCadGO :rDoriginD :rDfirstD :rDoldD :rDnewD :selection | 
			| interface geo movingFrame inPlaneFrame riPoldiP riPnewiP roldnewF |
			interface := selection interface.
			geo := selection metaObject.
			movingFrame := geo movingFrame.
			inPlaneFrame := geo inPlaneFrame.
			riPoldiP := inPlaneFrame xyPlaneIntersectLine: (interface projectorAt: rDoldD).
			riPnewiP := inPlaneFrame xyPlaneIntersectLine: (interface projectorAt: rDnewD).
			roldnewF := movingFrame aAOF transpose timesFullColumn: (inPlaneFrame aAOf timesFullColumn: riPnewiP - riPoldiP).
			movingFrame translateSelfBy: roldnewF].
	posHandle mementoType: #positionMemento.
	posHandle description: 'move start position'.
	^posHandle
]

{ #category : #accessing }
CADPolylineGO >> deletePoint: i [ 
	| geoPolyline rfpointsf |
	geoPolyline := self metaObject.
	rfpointsf := geoPolyline rfpointsf.
	i == 1
		ifTrue: [Dialog warn: 'Cannot delete the first point.']
		ifFalse: 
			[rfpointsf removeAtIndex: i.
			geoPolyline rfpointsf: rfpointsf.
			geoPolyline changed.
			geoPolyline interface soleSelection: geoPolyline]
]

{ #category : #accessing }
CADPolylineGO >> dimension [
	^2
]

{ #category : #display }
CADPolylineGO >> displayWith: aPen [ 
	points notNil ifTrue: [super displayWith: aPen]
]

{ #category : #accessing }
CADPolylineGO >> frozenCopy [
	"Used in handle tracking."

	| answer |
	answer := self shallowCopy.
	points := points deepCopy.
	origin := origin copy.
	extent := extent copy.
	^answer
]

{ #category : #accessing }
CADPolylineGO >> geoObject: geoObject [ 
	"Trigger #release to remove old cadGO from geoObject."

	| interface |
	geoObject triggerEvent: #release.
	interface := geoObject interface.
	interface bindGEO: geoObject toCAD: self.
	geoObject container cadObject add: self.
	self when: #damaged
		do: [self container visibleAreaMergeWith: self displayBox]
]

{ #category : #calc }
CADPolylineGO >> graphicsIntersecting: rDpD collectIn: set [ 
	((self displayBox containsPoint: rDpD)
		and: [self loopContainsPoint: rDpD])
		ifTrue: [set add: self]
]

{ #category : #'initialize-release' }
CADPolylineGO >> initialize [
	super initialize.
	self points: (Array with: 0 @ 0)
]

{ #category : #accessing }
CADPolylineGO >> insertPointAfter: i [ 
	| geoPolyline rfpointsf newPoint |
	geoPolyline := self metaObject.
	rfpointsf := geoPolyline rfpointsf.
	newPoint := i == rfpointsf size
				ifTrue: [(rfpointsf at: i)
						* 2.0d - (rfpointsf at: i - 1)]
				ifFalse: [(rfpointsf at: i)
						+ (rfpointsf at: i + 1) / 2.0d].
	rfpointsf add: newPoint beforeIndex: i + 1.
	geoPolyline rfpointsf: rfpointsf.
	geoPolyline changed.
	geoPolyline interface soleSelection: geoPolyline
]

{ #category : #calc }
CADPolylineGO >> loopContainsPoint: rDpD [ 
	"
	Point is inside when there are odd number of edge intersections with positive x infinite ray from 
	point. Loop is projected loop. Interval ij is [)."

	| isInside xDpD yDpD |
	isInside := false.
	xDpD := rDpD x.
	yDpD := rDpD y.
	1 to: points size - 1
		do: 
			[:i | 
			| xyi xyj xi yi xj yj |
			xyi := points at: i.
			xyj := points at: i + 1.
			xi := xyi x.
			yi := xyi y.
			xj := xyj x.
			yj := xyj y.
			(((yi <= yDpD and: [yDpD < yj])
				or: [yj <= yDpD and: [yDpD < yi]])
				and: [xDpD < (yDpD - yi * (xj - xi) / (yj - yi) + xi)])
				ifTrue: [isInside := isInside not]].
	^isInside
]

{ #category : #accessing }
CADPolylineGO >> metaClass [
	^self class metaClass
]

{ #category : #accessing }
CADPolylineGO >> pointAt: i [ 
	^points at: i
]

{ #category : #accessing }
CADPolylineGO >> pointHandleAt1 [
	| pointHandle |
	pointHandle := CADIndexedTrackHandle
				on: self
				at: #pointAt:
				with: 1.
	pointHandle index: 1.
	pointHandle hotSpot: [:handle | handle origin].
	pointHandle setSense: nil
		change: 
			[:cadPoly :frozenCadPoly :rDoriginD :rDfirstD :rDoldD :rDnewD :index | 
			| interface geoPoly movingFrame inPlaneFrame riPoldiP riPnewiP roldnewF |
			interface := cadPoly interface.
			geoPoly := cadPoly metaObject.
			movingFrame := geoPoly movingFrame.
			inPlaneFrame := geoPoly inPlaneFrame.
			riPoldiP := inPlaneFrame xyPlaneIntersectLine: (interface projectorAt: rDoldD).
			riPnewiP := inPlaneFrame xyPlaneIntersectLine: (interface projectorAt: rDnewD).
			roldnewF := movingFrame aAOF transpose timesFullColumn: (inPlaneFrame aAOf timesFullColumn: riPnewiP - riPoldiP).
			movingFrame translateSelfBy: roldnewF].
	pointHandle mementoType: #positionMemento.
	pointHandle description: 'move polyline'.
	^pointHandle
]

{ #category : #accessing }
CADPolylineGO >> pointHandleAt: i [ 
	| pointHandle |
	pointHandle := CADIndexedTrackHandle
				on: self
				at: #pointAt:
				with: i.
	pointHandle index: i.
	pointHandle hotSpot: [:handle | handle origin].
	pointHandle setSense: nil
		change: 
			[:cadPoly :frozenCadPoly :rDoriginD :rDfirstD :rDoldD :rDnewD :index | 
			| geoPoly interface rPendP |
			geoPoly := cadPoly metaObject.
			interface := cadPoly interface.
			rPendP := geoPoly refFrame xyPlaneIntersectLine: (interface projectorAt: rDnewD + rDoriginD - rDfirstD).
			geoPoly rfpointfAt: index put: rPendP].
	pointHandle mementoType: #positionMemento.
	pointHandle description: 'move point'.
	^pointHandle
]

{ #category : #accessing }
CADPolylineGO >> popupMenuIndexedTrackHandle: handle [ 
	self class vertexMenu startUp evaluateIfNoTarget: self with: handle index
]

{ #category : #accessing }
CADPolylineGO >> posAngDialog [
	self interface noSelections.
	CADPolylineDialog openOn: self metaObject
]

{ #category : #accessing }
CADPolylineGO >> positionMemento [
	| geoRefFrame aMemento |
	geoRefFrame := self metaObject refFrame.
	aMemento := GFMemento originator: self.
	aMemento
		addActionReceiver: geoRefFrame
		selector: #rFfF:aAFf:
		arguments: (Array with: geoRefFrame rFfF copy with: geoRefFrame aAFf copy).
	^aMemento
]

{ #category : #calc }
CADPolylineGO >> projectOn: projectionFrame animateWith: aPen [ 
	self basicUpdateProjection: projectionFrame.
	self displayWith: aPen
]

{ #category : #calc }
CADPolylineGO >> quietlyRecalculateBoundingBox [
	points isNil
		ifTrue: 
			[origin := 10000 @ 10000.
			extent := -20000 @ -20000]
		ifFalse: [super quietlyRecalculateBoundingBox]
]

{ #category : #calc }
CADPolylineGO >> quietlyRecalculateBoundingBox1 [
	points isNil
		ifTrue: 
			[origin := 0 @ 0.
			extent := 0 @ 0]
		ifFalse: [super quietlyRecalculateBoundingBox]
]

{ #category : #calc }
CADPolylineGO >> quietlyUpdateProjection: projectionFrame [ 
	self basicUpdateProjection: projectionFrame.
	self quietlyRecalculateBoundingBox.
	self checkClosed
]

{ #category : #accessing }
CADPolylineGO >> rDoriginPx [
	| geo |
	geo := self metaObject.
	^geo refFrame rDoriginPx
]

{ #category : #calc }
CADPolylineGO >> recalculateBoundingBox [
	self quietlyRecalculateBoundingBox.
	self triggerEvent: #damaged
]

{ #category : #'initialize-release' }
CADPolylineGO >> release [
	| interface |
	interface := self interface.
	interface unbindGEO: self metaObject fromCAD: self.
	container remove: self.
	interface removeAllActionsWithReceiver: self.
	container removeAllActionsWithReceiver: self.
	super release
]

{ #category : #accessing }
CADPolylineGO >> rotateHandle [
	| rotateHandle |
	rotateHandle := CADTrackHandle on: self at: #rDx1y0Px.
	rotateHandle hotSpot: [:handle | handle origin].
	rotateHandle setSense: nil
		change: 
			[:cadRect :frozenCadRect :rDx1y0Px :rDfirstPx :rDoldPx :rDnewPx | 
			| geoRect interface sketchRefFrame rSendS rSorgS rOrgEndS theta |
			geoRect := cadRect metaObject.
			interface := cadRect interface.
			sketchRefFrame := geoRect refFrame refFrame.
			rSendS := sketchRefFrame xyPlaneIntersectLine: (interface projectorAt: rDx1y0Px + rDnewPx - rDfirstPx).
			rSorgS := sketchRefFrame xyPlaneIntersectLine: (interface projectorAt: cadRect rDoriginPx).
			rOrgEndS := rSendS - rSorgS.
			theta := Double arcTan0to2piY: (rOrgEndS at: 2)
						overX: (rOrgEndS at: 1).
			geoRect theta: theta].
	rotateHandle mementoType: #positionMemento.
	rotateHandle description: 'move rotate position'.
	^rotateHandle
]

{ #category : #accessing }
CADPolylineGO >> rotateHandle1 [
	| rotateHandle |
	rotateHandle := CADTrackHandle on: self at: #rDoriginPx.
	rotateHandle hotSpot: [:handle | handle owner rDx1y0Px].
	rotateHandle setSense: nil
		change: 
			[:cadRect :frozenCadRect :rDoriginPx :rDfirstPx :rDoldPx :rDnewPx | 
			| geoRect interface sketchRefFrame rSendS rSminS rMinEndS theta |
			geoRect := cadRect metaObject.
			interface := cadRect interface.
			sketchRefFrame := geoRect refFrame refFrame.
			rSendS := sketchRefFrame xyPlaneIntersectLine: (interface projectorAt: frozenCadRect rDx1y0Px + rDnewPx - rDfirstPx).
			rSminS := sketchRefFrame xyPlaneIntersectLine: (interface projectorAt: rDoriginPx).
			rMinEndS := rSendS - rSminS.
			theta := Double arcTan0to2piY: (rMinEndS at: 2)
						overX: (rMinEndS at: 1).
			geoRect theta: theta].
	rotateHandle mementoType: #positionMemento.
	rotateHandle description: 'move rotate position'.
	^rotateHandle
]

{ #category : #accessing }
CADPolylineGO >> standardMenu [
	^self class standardMenu
]

{ #category : #calc }
CADPolylineGO >> updateFromGEO [
	self damageDuring: [self updateProjection: self interface projectionFrame]
]

{ #category : #calc }
CADPolylineGO >> updateProjection: projectionFrame [ 
	self basicUpdateProjection: projectionFrame.
	self recalculateBoundingBox.
	self checkClosed
]
