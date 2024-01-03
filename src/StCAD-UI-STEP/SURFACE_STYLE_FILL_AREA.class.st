Class {
	#name : #'SURFACE_STYLE_FILL_AREA',
	#superclass : #Item,
	#instVars : [
		'fill_area'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
SURFACE_STYLE_FILL_AREA >> aColor [
	^fill_area aColor
]

{ #category : #accessing }
SURFACE_STYLE_FILL_AREA >> fill_area [
	^fill_area
]

{ #category : #accessing }
SURFACE_STYLE_FILL_AREA >> fill_area: anObject [
	fill_area := anObject
]
