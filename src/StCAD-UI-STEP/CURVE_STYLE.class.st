Class {
	#name : #'CURVE_STYLE',
	#superclass : #Item,
	#instVars : [
		'curve_font',
		'curve_width',
		'curve_colour'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
CURVE_STYLE >> curve_colour [
	^curve_colour
]

{ #category : #accessing }
CURVE_STYLE >> curve_colour: anObject [
	curve_colour := anObject
]

{ #category : #accessing }
CURVE_STYLE >> curve_font [
	^curve_font
]

{ #category : #accessing }
CURVE_STYLE >> curve_font: anObject [
	curve_font := anObject
]

{ #category : #accessing }
CURVE_STYLE >> curve_width [
	^curve_width
]

{ #category : #accessing }
CURVE_STYLE >> curve_width: anObject [
	curve_width := anObject
]
