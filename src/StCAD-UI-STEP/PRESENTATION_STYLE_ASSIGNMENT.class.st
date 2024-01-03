Class {
	#name : #'PRESENTATION_STYLE_ASSIGNMENT',
	#superclass : #Item,
	#instVars : [
		'styles'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
PRESENTATION_STYLE_ASSIGNMENT >> aColor [
	^styles first aColor
]

{ #category : #accessing }
PRESENTATION_STYLE_ASSIGNMENT >> styles [
	^styles
]

{ #category : #accessing }
PRESENTATION_STYLE_ASSIGNMENT >> styles: anObject [
	styles := anObject
]
