Class {
	#name : #'GEOMETRIC_SET',
	#superclass : #'GEOMETRIC_REPRESENTATION_ITEM',
	#instVars : [
		'elements'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
GEOMETRIC_SET >> elements [
	^elements
]

{ #category : #accessing }
GEOMETRIC_SET >> elements: anObject [
	elements := anObject
]
