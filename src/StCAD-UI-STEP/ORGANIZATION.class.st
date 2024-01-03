Class {
	#name : #ORGANIZATION,
	#superclass : #Item,
	#instVars : [
		'id',
		'description'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
ORGANIZATION >> description [
	^description
]

{ #category : #accessing }
ORGANIZATION >> description: anObject [
	description := anObject
]

{ #category : #accessing }
ORGANIZATION >> id [
	^id
]

{ #category : #accessing }
ORGANIZATION >> id: anObject [
	id := anObject
]
