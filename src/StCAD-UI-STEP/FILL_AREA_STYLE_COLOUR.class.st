Class {
	#name : #'FILL_AREA_STYLE_COLOUR',
	#superclass : #Item,
	#instVars : [
		'fill_colour'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
FILL_AREA_STYLE_COLOUR >> aColor [
	^fill_colour aColor
]

{ #category : #accessing }
FILL_AREA_STYLE_COLOUR >> fill_colour [
	^fill_colour
]

{ #category : #accessing }
FILL_AREA_STYLE_COLOUR >> fill_colour: anObject [
	fill_colour := anObject
]
