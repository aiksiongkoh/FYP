Class {
	#name : #CADLineGO,
	#superclass : #GFLineGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #'instance creation' }
CADLineGO class >> createNotifying: anInterface [ 
	| rDstartD rDendD cadGO cursorLine sketch rSstartS rSendS aGEO |
	rDstartD := rDendD := anInterface cursorPoint.
	cadGO := self start: rDstartD stop: rDendD.
	cursorLine := anInterface projectorAt: rDstartD.
	sketch := anInterface activeSketch.
	rSstartS := rSendS := sketch refFrame xyPlaneIntersectLine: cursorLine.
	aGEO := GEOLine start: rSstartS end: rSendS.
	sketch addGraphic: aGEO.
	anInterface bindGEO: aGEO toCAD: cadGO.
	anInterface drawing add: cadGO.
	cadGO growNotifying: anInterface.
	anInterface drawing remove: cadGO.
	^cadGO
]

{ #category : #'VisualWorks metadata' }
CADLineGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'Polymorphic'
	)

]

{ #category : #handles }
CADLineGO >> defaultHandles [
	^Array with: self startHandle with: self stopHandle
]

{ #category : #handles }
CADLineGO >> defaultPositionHandle [
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

{ #category : #handles }
CADLineGO >> defaultPositionHandle1 [
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
			sketchRefFrame := geo refFrame container.
			rSoldS := sketchRefFrame xyPlaneIntersectLine: (interface projectorAt: rDoldD).
			rSnewS := sketchRefFrame xyPlaneIntersectLine: (interface projectorAt: rDnewD).
			geo translateSelfBy: rSnewS - rSoldS].
	posHandle mementoType: #positionMemento.
	posHandle description: 'move start position'.
	^posHandle
]

{ #category : #handles }
CADLineGO >> defaultPositionHandle2 [
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

{ #category : #copying }
CADLineGO >> frozenCopy [
	"Used in handle tracking."

	^self copy
]

{ #category : #calc }
CADLineGO >> growNotifying: anInterface [ 
	"Used in the creation of the receiver"

	| aHandle |
	aHandle := self stopHandle.
	aHandle mementoType: nil.
	anInterface addHandle: aHandle.
	self class gfCursorClass crossHair change.
	aHandle invoke: anInterface.
	self class gfCursorClass normal change.
	anInterface removeHandle: aHandle
]

{ #category : #calc }
CADLineGO >> positionMemento [
	| aMemento aGEOLine |
	aMemento := GFMemento originator: self.
	aGEOLine := self metaObject.
	aMemento
		addActionReceiver: aGEOLine
		selector: #start:end:
		with: aGEOLine startPoint copy
		with: aGEOLine endPoint copy.
	^aMemento
]

{ #category : #'initialize-release' }
CADLineGO >> release [
	| interface |
	interface := self interface.
	interface unbindGEO: self metaObject fromCAD: self.
	container remove: self.
	interface removeAllActionsWithReceiver: self.
	container removeAllActionsWithReceiver: self.
	super release
]

{ #category : #handles }
CADLineGO >> startHandle [
	| startHandle |
	startHandle := CADTrackHandle on: self at: #startPoint.
	startHandle hotSpot: [:handle | handle origin].
	startHandle setSense: nil
		change: 
			[:cadLine :frozenCadLine :rDoriginD :rDfirstD :rDoldD :rDnewD | 
			| geoLine interface sketchRefFrame rSstartS |
			geoLine := cadLine metaObject.
			interface := cadLine interface.
			sketchRefFrame := geoLine refFrame container.
			rSstartS := sketchRefFrame xyPlaneIntersectLine: (interface projectorAt: rDnewD).
			geoLine start: rSstartS].
	startHandle mementoType: #positionMemento.
	startHandle description: 'move start position'.
	^startHandle
]

{ #category : #handles }
CADLineGO >> stopHandle [
	| stopHandle |
	stopHandle := CADTrackHandle on: self at: #stopPoint.
	stopHandle hotSpot: [:handle | handle origin].
	stopHandle setSense: nil
		change: 
			[:cadLine :frozenCadLine :rDoriginD :rDfirstD :rDoldD :rDnewD | 
			| geoLine interface sketchRefFrame rSendS |
			geoLine := cadLine metaObject.
			interface := cadLine interface.
			sketchRefFrame := geoLine refFrame container.
			rSendS := sketchRefFrame xyPlaneIntersectLine: (interface projectorAt: rDnewD).
			geoLine end: rSendS].
	stopHandle mementoType: #positionMemento.
	stopHandle description: 'move stop position'.
	^stopHandle
]

{ #category : #calc }
CADLineGO >> updateFromGEO [
	self damageDuring: [self updateProjection: self interface projectionFrame]
]

{ #category : #calc }
CADLineGO >> updateProjection: projectionFrame [ 
	| geoLine rDstartD rDstopD |
	geoLine := self metaObject.
	rDstartD := projectionFrame rDpPxfromrOpO: geoLine rOstartO.
	rDstopD := projectionFrame rDpPxfromrOpO: geoLine rOendO.
	self start: rDstartD stop: rDstopD
]
