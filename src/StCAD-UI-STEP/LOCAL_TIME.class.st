Class {
	#name : #'LOCAL_TIME',
	#superclass : #Item,
	#instVars : [
		'hour_component',
		'minute_component',
		'second_component',
		'zone'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
LOCAL_TIME >> hour_component [
	^hour_component
]

{ #category : #accessing }
LOCAL_TIME >> hour_component: anObject [
	hour_component := anObject
]

{ #category : #accessing }
LOCAL_TIME >> minute_component [
	^minute_component
]

{ #category : #accessing }
LOCAL_TIME >> minute_component: anObject [
	minute_component := anObject
]

{ #category : #accessing }
LOCAL_TIME >> second_component [
	^second_component
]

{ #category : #accessing }
LOCAL_TIME >> second_component: anObject [
	second_component := anObject
]

{ #category : #accessing }
LOCAL_TIME >> zone [
	^zone
]

{ #category : #accessing }
LOCAL_TIME >> zone: anObject [
	zone := anObject
]
