Class {
	#name : #'SURFACE_SIDE_STYLE',
	#superclass : #Item,
	#instVars : [
		'styles'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
SURFACE_SIDE_STYLE >> aColor [
	^styles first aColor
]

{ #category : #accessing }
SURFACE_SIDE_STYLE >> styles [
	^styles
]

{ #category : #accessing }
SURFACE_SIDE_STYLE >> styles: anObject [
	styles := anObject
]
