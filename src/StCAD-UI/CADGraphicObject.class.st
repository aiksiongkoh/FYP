Class {
	#name : #CADGraphicObject,
	#superclass : #GFCompositeGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #resources }
CADGraphicObject class >> standardMenu [
	^nil
]

{ #category : #'VisualWorks metadata' }
CADGraphicObject class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'Polymorphic'
	)

]

{ #category : #accessing }
CADGraphicObject >> aGraphicViewPopupMenu [
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

{ #category : #accessing }
CADGraphicObject >> aTreeViewPopupMenu [
	| interface answerMenu drawingMenu |
	interface := self interface.
	answerMenu := Menu new.
	answerMenu addItemLabel: 'Rename'
		value: [interface treeView controller inplaceEdit].
	answerMenu addLine.
	answerMenu addPart: self menu.
	drawingMenu := Menu new.
	drawingMenu addItemLabel: '&Undo' value: [interface undo].
	drawingMenu addItemLabel: 'Cu&t' value: [interface cut].
	answerMenu addItemGroup: (Array 
				with: ((MenuItem labeled: interface menuLabel) submenu: drawingMenu)).
	^answerMenu
]

{ #category : #accessing }
CADGraphicObject >> defaultPositionHandle [
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
			riPoldiP := inPlaneFrame 
						xyPlaneIntersectLine: (interface projectorAt: rDoldD).
			riPnewiP := inPlaneFrame 
						xyPlaneIntersectLine: (interface projectorAt: rDnewD).
			roldnewF := movingFrame aAOF transpose 
						timesFullColumn: (inPlaneFrame aAOf timesFullColumn: riPnewiP - riPoldiP).
			movingFrame translateSelfBy: roldnewF.
			self interface shiftDown 
				ifTrue: [self interface followPart: self metaObject part]].
	posHandle mementoType: #positionMemento.
	posHandle description: 'move start position'.
	^posHandle
]

{ #category : #accessing }
CADGraphicObject >> defaultPositionHandle1 [
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
			riPoldiP := inPlaneFrame 
						xyPlaneIntersectLine: (interface projectorAt: rDoldD).
			riPnewiP := inPlaneFrame 
						xyPlaneIntersectLine: (interface projectorAt: rDnewD).
			roldnewF := movingFrame aAOF transpose 
						timesFullColumn: (inPlaneFrame aAOf timesFullColumn: riPnewiP - riPoldiP).
			movingFrame translateSelfBy: roldnewF].
	posHandle mementoType: #positionMemento.
	posHandle description: 'move start position'.
	^posHandle
]

{ #category : #accessing }
CADGraphicObject >> defaultPositionHandle3 [
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
			riPoldiP := inPlaneFrame 
						xyPlaneIntersectLine: (interface projectorAt: rDoldD).
			riPnewiP := inPlaneFrame 
						xyPlaneIntersectLine: (interface projectorAt: rDnewD).
			roldnewF := movingFrame aAOF transpose 
						timesFullColumn: (inPlaneFrame aAOf timesFullColumn: riPnewiP - riPoldiP).
			movingFrame translateSelfBy: roldnewF].
	posHandle mementoType: #positionMemento.
	posHandle description: 'move start position'.
	^posHandle
]

{ #category : #accessing }
CADGraphicObject >> dimension [
	^self subclassResponsibility
]

{ #category : #copying }
CADGraphicObject >> frozenCopy [
	"Used in handle tracking."

	^self copy
]

{ #category : #accessing }
CADGraphicObject >> geoObject1: geoObject [

	"Trigger #release to remove old cadGO from geoObject."

	| holder continue holderGO |
	geoObject triggerEvent: #release.
	self visibleArea: (Graphics_Rectangle origin: 0 @ 0 corner: 0 @ 0). "VW_TRANSLATION:Graphics.Rectangle:Graphics_Rectangle"
	geoObject interface bindGEO: geoObject toCAD: self.
	holder := geoObject container.
	continue := true.
	[ continue ] whileTrue: [ 
		holder isInterface
			ifTrue: [ 
				holder quietlyAddGO: self.
				continue := false ]
			ifFalse: [ 
				holderGO := holder cadObject.
				holderGO == nil
					ifTrue: [ holder := holder container ]
					ifFalse: [ 
						holderGO add: self.
						self
							when: #resetVisibleArea
							do: [ self container visibleAreaMergeWith: self displayBox ].
						continue := false ] ] ]. "	self disableInteraction"
	self hideVisibleAreaIndicator
]

{ #category : #accessing }
CADGraphicObject >> geoObject2: geoObject [

	"Trigger #release to remove old cadGO from geoObject."

	| holder continue holderGO |
	geoObject triggerEvent: #release.
	self visibleArea: (Graphics_Rectangle origin: 0 @ 0 corner: 0 @ 0). "VW_TRANSLATION:Graphics.Rectangle:Graphics_Rectangle"
	geoObject interface bindGEO: geoObject toCAD: self.
	holder := geoObject container.
	continue := true.
	[ continue ] whileTrue: [ 
		holder isInterface
			ifTrue: [ 
				holder quietlyAddGO: self.
				continue := false ]
			ifFalse: [ 
				holderGO := holder cadObject.
				holderGO == nil
					ifTrue: [ holder := holder container ]
					ifFalse: [ 
						holderGO add: self.
						self
							when: #resetVisibleArea
							do: [ self container visibleAreaMergeWith: self displayBox ].
						continue := false ] ] ]. "	self disableInteraction"
	self hideVisibleAreaIndicator
]

{ #category : #accessing }
CADGraphicObject >> geoObject: geoObject [

	"Trigger #release to remove old cadGO from geoObject."

	| rDfD holder continue holderGO |
	geoObject triggerEvent: #release.
	rDfD := geoObject rDfD.
	self visibleArea: (Graphics_Rectangle origin: rDfD corner: rDfD copy). "VW_TRANSLATION:Graphics.Rectangle:Graphics_Rectangle"
	geoObject interface bindGEO: geoObject toCAD: self.
	holder := geoObject container.
	continue := true.
	[ continue ] whileTrue: [ 
		holder isInterface
			ifTrue: [ 
				holder quietlyAddGO: self.
				continue := false ]
			ifFalse: [ 
				holderGO := holder cadObject.
				holderGO == nil
					ifTrue: [ holder := holder container ]
					ifFalse: [ 
						holderGO add: self.
						self
							when: #resetVisibleArea
							do: [ self container visibleAreaMergeWith: self displayBox ].
						continue := false ] ] ]. "	self disableInteraction"
	self hideVisibleAreaIndicator
]

{ #category : #calc }
CADGraphicObject >> graphicsIntersecting: rDpD collectIn: set [ 
	(self displayBox containsPoint: rDpD)
		ifTrue: [graphicObjects do: [:aGO | aGO graphicsIntersecting: rDpD collectIn: set]]
]

{ #category : #'initialize-release' }
CADGraphicObject >> initialize [
	graphicObjects := OrderedCollection new.
	showVisibleArea := false.
	visibleAreaLineColor := self class defaultLineColor
]

{ #category : #accessing }
CADGraphicObject >> isSolidModel [
	^false
]

{ #category : #accessing }
CADGraphicObject >> metrePerPixel [
	^self interface metrePerPixel
]

{ #category : #accessing }
CADGraphicObject >> positionHandleAt: symbol [ 
	"Translate movingFrame relative to its refFrame in the xy plane of the inPlaneFrame."

	| posHandle |
	posHandle := CADSelectionTrackHandle on: self at: symbol.
	posHandle hotSpot: [:handle | handle origin].
	posHandle setSense: nil
		change: 
			[:cadGO :frozenCadGO :rDoriginD :rDfirstD :rDoldD :rDnewD :selection | 
			| interface geo movingFrame inPlaneFrame riPoldiP riPnewiP roldnewF |
			interface := selection interface.
			geo := selection metaObject.
			movingFrame := geo movingFrame.
			inPlaneFrame := geo inPlaneFrame.
			riPoldiP := inPlaneFrame 
						xyPlaneIntersectLine: (interface projectorAt: rDoldD).
			riPnewiP := inPlaneFrame 
						xyPlaneIntersectLine: (interface projectorAt: rDnewD).
			roldnewF := movingFrame aAOF transpose 
						timesFullColumn: (inPlaneFrame aAOf timesFullColumn: riPnewiP - riPoldiP).
			movingFrame translateSelfBy: roldnewF.
			self interface shiftDown 
				ifTrue: [self interface followPart: self metaObject part]].
	posHandle mementoType: #positionMemento.
	posHandle description: 'move start position'.
	^posHandle
]

{ #category : #display }
CADGraphicObject >> projectOn: projectionFrame animateWith: aPen [ 
	graphicObjects do: [:each | each projectOn: projectionFrame animateWith: aPen]
]

{ #category : #calc }
CADGraphicObject >> quietlyResetVisibleArea [
	| newVisibleArea |
	self firstGO notNil
		ifTrue: 
			[newVisibleArea := self injectFigures: self firstGO displayBox deepCopy into: [:rect :each | rect mergeWith: each displayBox].
			self visibleArea: newVisibleArea]
]

{ #category : #calc }
CADGraphicObject >> quietlyUpdateProjection: projectionFrame [ 
	graphicObjects do: [:cadGO | cadGO quietlyUpdateProjection: projectionFrame].
	self quietlyResetVisibleArea
]

{ #category : #'initialize-release' }
CADGraphicObject >> release [
	| interface |
	graphicObjects notNil ifTrue: [self graphicObjectsDo: [:each | each release]].
	interface := self interface.
	interface unbindGEO: self metaObject fromCAD: self.
	container isGFDrawing
		ifTrue: [interface quietlyRemoveGO: self]
		ifFalse: [container remove: self].
	interface removeAllActionsWithReceiver: self.
	container removeAllActionsWithReceiver: self.
	super release
]

{ #category : #calc }
CADGraphicObject >> resetVisibleArea [
	| block aGO aRect |
	block := self firstGO ifNil: 
					[aGO := container graphicObjects detect: [:aaGO | aaGO ~= self]
								ifNone: [container].
					aRect := aGO displayBox center extent: 0 @ 0.
					[self visibleArea: aRect]]
				ifNotNil: 
					[
					[self visibleArea: (self injectFigures: self firstGO displayBox deepCopy
								into: [:rect :each | rect mergeWith: each displayBox])]].
	self damageDuring: block.
	self triggerEvent: #resetVisibleArea
]

{ #category : #calc }
CADGraphicObject >> resetVisibleArea1 [
	self firstGO == nil ifTrue: [^self].
	self damageDuring: [self visibleArea: (self injectFigures: self firstGO displayBox deepCopy into: [:rect :each | rect mergeWith: each displayBox])].
	self triggerEvent: #resetVisibleArea
]

{ #category : #accessing }
CADGraphicObject >> standardMenu [
	^self class standardMenu
]

{ #category : #calc }
CADGraphicObject >> updateFromGEO [
	self damageDuring: [self updateProjection: self interface projectionFrame]
]

{ #category : #calc }
CADGraphicObject >> updateProjection: projectionFrame [ 
	graphicObjects do: [:cadGO | cadGO updateProjection: projectionFrame].
	self resetVisibleArea
]

{ #category : #calc }
CADGraphicObject >> visibleAreaMergeWith: rect [ 
	(visibleArea contains: rect) not
		ifTrue: 
			[self damageDuring: [self visibleArea: (visibleArea extent isZero
						ifTrue: [rect copy]
						ifFalse: [visibleArea mergeWith: rect])].
			self triggerEvent: #resetVisibleArea]
]
