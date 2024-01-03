Class {
	#name : #'ELEMENTARY_SURFACE',
	#superclass : #SURFACE,
	#instVars : [
		'position'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
ELEMENTARY_SURFACE >> position [
	^position
]

{ #category : #accessing }
ELEMENTARY_SURFACE >> position: anObject [
	position := anObject
]
