Class {
	#name : #'SWEPT_SURFACE',
	#superclass : #SURFACE,
	#instVars : [
		'swept_curve'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
SWEPT_SURFACE >> swept_curve [
	^swept_curve
]

{ #category : #accessing }
SWEPT_SURFACE >> swept_curve: anObject [
	swept_curve := anObject
]
