Class {
	#name : #APPROVAL,
	#superclass : #Item,
	#instVars : [
		'status',
		'level'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
APPROVAL >> level [
	^level
]

{ #category : #accessing }
APPROVAL >> level: anObject [
	level := anObject
]

{ #category : #accessing }
APPROVAL >> status [
	^status
]

{ #category : #accessing }
APPROVAL >> status: anObject [
	status := anObject
]
