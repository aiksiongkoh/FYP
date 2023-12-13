Class {
	#name : #CADCoordinateControl,
	#superclass : #GFCoordinateControl,
	#instVars : [
		'drawing'
	],
	#category : #'StCAD-UI-CAD'
}

{ #category : #'VisualWorks metadata' }
CADCoordinateControl class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'Polymorphic'
	)

]

{ #category : #accessing }
CADCoordinateControl >> drawing: aDrawing [ 
	drawing := aDrawing
]

{ #category : #snap }
CADCoordinateControl >> snapToGrid: aPoint [ 
	"Answer the grid point nearest to the grid of the receiver"

	| drawingRect |
	drawingRect := drawing drawingRect.
	^((aPoint snapToGrid: grid)
		max: drawingRect origin)
		min: drawingRect corner
]

{ #category : #snap }
CADCoordinateControl >> snapToGrid: aPoint if: snap limit: limit [ 
	"Copyright (C) 1993-1995 Polymorphic Software, Inc. All Rights Reserved"
	"Answer the grid point nearest to the grid of the receiver if snap is true, 
	and limit it to the extent of the receiver if limit is true"

	| p drawingRect |
	p := aPoint.
	useGrid & snap ifTrue: [p := aPoint snapToGrid: grid].
	limit
		ifTrue: 
			[drawingRect := drawing drawingRect.
			^(p max: drawingRect origin)
				min: drawingRect corner].
	^p
]
