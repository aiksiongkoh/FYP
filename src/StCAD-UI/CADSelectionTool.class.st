"

	Description:

	CADSelectionTool is used to select, and manipulate graphic objects


"
Class {
	#name : #CADSelectionTool,
	#superclass : #GFTool,
	#category : #'StCAD-UI-CAD'
}

{ #category : #'GF/ST' }
CADSelectionTool class >> new [
"Copyright (C) 1993-1995 Polymorphic Software, Inc.  All Rights Reserved"

    ^self icon: (GFTool stockIconFor: 'Select') cursor: self gfCursorClass normal name: 'Selection'
]

{ #category : #'VisualWorks metadata' }
CADSelectionTool class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'Polymorphic'
	)

]

{ #category : #all }
CADSelectionTool >> button1DoubleClickGO: aGO [ 
	(aGO isActive and: [(interface isSelected: aGO) not])
		ifTrue: [^self button1DoubleClickHandle: aGO].
	aGO button1DoubleClick
]

{ #category : #all }
CADSelectionTool >> button1DoubleClickHandle: aHandle [ 
	interface handleInvoked: aHandle.
	aHandle button1DoubleClickInvoke: interface.
	interface noHandleInvoked
]

{ #category : #all }
CADSelectionTool >> button1DownBackground [
	interface selections: Array new.
	interface repairDamage
]

{ #category : #all }
CADSelectionTool >> button1DownGO: aGO [ 
	(aGO isActive and: [(interface isSelected: aGO) not])
		ifTrue: [^self button1DownHandle: aGO].
	interface soleSelection: aGO metaObject.
	interface shouldDoDragDrop ifTrue: [^interface doButton1DragDrop].
	self moveGO: aGO
]

{ #category : #all }
CADSelectionTool >> button1DownHandle: aHandle [ 
	interface handleInvoked: aHandle.
	aHandle invoke: interface.
	interface noHandleInvoked
]

{ #category : #all }
CADSelectionTool >> button2Down: aPoint [ 
	| handle |
	(handle := self handleAt: aPoint) notNil ifTrue: [^handle popupMenu].
	interface popupMenu
]

{ #category : #all }
CADSelectionTool >> graphicObjectAtPoint: aPoint [ 
	| aGO |
	(aGO := self handleAt: aPoint) isNil ifTrue: [aGO := super graphicObjectAtPoint: aPoint].
	^aGO
]

{ #category : #all }
CADSelectionTool >> moveGO: aGO [ 
	aGO generatePositionHandle ifNil: [interface repairDamage]
		ifNotNil: [:hndl | self button1DownHandle: hndl]
]

{ #category : #all }
CADSelectionTool >> rectangleFromUser [

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

{ #category : #all }
CADSelectionTool >> selectGO: aGO [ 
	interface shiftDown
		ifTrue: [interface toggleSelection: aGO]
		ifFalse: [(interface isSelected: aGO)
				ifFalse: [interface selection: aGO]]
]

{ #category : #all }
CADSelectionTool >> selectGroup [
	| rDrectPx aCollection |
	self halt: 'check this.'.
	interface noSelections.
	rDrectPx := self rectangleFromUser.
	Transcript cr; show: rDrectPx printString.
	aCollection := interface graphicObjectsIn: rDrectPx.
	interface shiftDown ifFalse: [interface selections: aCollection]
		ifTrue: [interface toggleSelections: aCollection]
]
