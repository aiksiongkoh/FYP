Class {
	#name : #'APPLICATION_CONTEXT',
	#superclass : #Item,
	#instVars : [
		'application'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
APPLICATION_CONTEXT >> application [
	^application
]

{ #category : #accessing }
APPLICATION_CONTEXT >> application: anObject [
	application := anObject
]
