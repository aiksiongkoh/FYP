Class {
	#name : #'REPRESENTATION_CONTEXT',
	#superclass : #Item,
	#instVars : [
		'context_identifier',
		'context_type'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
REPRESENTATION_CONTEXT >> context_identifier [
	^context_identifier
]

{ #category : #accessing }
REPRESENTATION_CONTEXT >> context_identifier: anObject [
	context_identifier := anObject
]

{ #category : #accessing }
REPRESENTATION_CONTEXT >> context_type [
	^context_type
]

{ #category : #accessing }
REPRESENTATION_CONTEXT >> context_type: anObject [
	context_type := anObject
]
