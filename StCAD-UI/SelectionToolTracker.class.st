Class {
	#name : #SelectionToolTracker,
	#superclass : #ToolTracker,
	#category : #'StCAD-UI-StCAD-UI-Basic'
}

{ #category : #'VisualWorks metadata' }
SelectionToolTracker class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
SelectionToolTracker >> aTool [
	^aTool
]

{ #category : #accessing }
SelectionToolTracker >> aTool: anObject [
	aTool := anObject
]

{ #category : #private }
SelectionToolTracker >> doSelectionTrackingOperationAt: rvSTpvST [ 
	| view rvGLpvGL |
	view := self controller view.
	rvGLpvGL := rvSTpvST x @ (view bounds extent y - 1 - rvSTpvST y).
	view displaySelectionTrackingFrom: rvFirstv to: rvGLpvGL
]

{ #category : #private }
SelectionToolTracker >> finishSelectionFor: aPoint [

	| rect face edge vertex |
	self halt.
	rect := Graphics_Rectangle origin: rvFirstv corner: aPoint. "VW_TRANSLATION:Graphics.Rectangle:Graphics_Rectangle"
	face := self pickFaceInRect: rect.
	edge := self pickEdgeInFace: face inRect: rect.
	vertex := self pickVertexInEdge: edge inRect: rect.
	super finishSelectionFor: aPoint
]
