Class {
	#name : #'DATE_AND_TIME',
	#superclass : #Item,
	#instVars : [
		'date_component',
		'time_component'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
DATE_AND_TIME >> date_component [
	^date_component
]

{ #category : #accessing }
DATE_AND_TIME >> date_component: anObject [
	date_component := anObject
]

{ #category : #accessing }
DATE_AND_TIME >> time_component [
	^time_component
]

{ #category : #accessing }
DATE_AND_TIME >> time_component: anObject [
	time_component := anObject
]
