Class {
	#name : #'MECHANICAL_DESIGN_GEOMETRIC_PRESENTATION_REPRESENTATION',
	#superclass : #Item,
	#instVars : [
		'items',
		'context_of_items'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
MECHANICAL_DESIGN_GEOMETRIC_PRESENTATION_REPRESENTATION >> context_of_items [
	^context_of_items
]

{ #category : #accessing }
MECHANICAL_DESIGN_GEOMETRIC_PRESENTATION_REPRESENTATION >> context_of_items: anObject [
	context_of_items := anObject
]

{ #category : #accessing }
MECHANICAL_DESIGN_GEOMETRIC_PRESENTATION_REPRESENTATION >> items [
	^items
]

{ #category : #accessing }
MECHANICAL_DESIGN_GEOMETRIC_PRESENTATION_REPRESENTATION >> items: anObject [
	items := anObject
]
