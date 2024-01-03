Class {
	#name : #REPRESENTATION,
	#superclass : #Item,
	#instVars : [
		'items',
		'context_of_items'
	],
	#classVars : [
		'UI'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
REPRESENTATION >> context_of_items [
	^context_of_items
]

{ #category : #accessing }
REPRESENTATION >> context_of_items: anObject [
	context_of_items := anObject
]

{ #category : #accessing }
REPRESENTATION >> items [
	^items
]

{ #category : #accessing }
REPRESENTATION >> items: anObject [
	items := anObject
]

{ #category : #accessing }
REPRESENTATION >> lengthFactor [
	^(context_of_items 
		detect: [:a | a isMemberOf: GLOBAL_UNIT_ASSIGNED_CONTEXT]) lengthFactor
]
