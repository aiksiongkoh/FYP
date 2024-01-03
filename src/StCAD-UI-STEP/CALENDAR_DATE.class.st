Class {
	#name : #'CALENDAR_DATE',
	#superclass : #Item,
	#instVars : [
		'year_component',
		'day_component',
		'month_component'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
CALENDAR_DATE >> day_component [
	^day_component
]

{ #category : #accessing }
CALENDAR_DATE >> day_component: anObject [
	day_component := anObject
]

{ #category : #accessing }
CALENDAR_DATE >> month_component [
	^month_component
]

{ #category : #accessing }
CALENDAR_DATE >> month_component: anObject [
	month_component := anObject
]

{ #category : #accessing }
CALENDAR_DATE >> year_component [
	^year_component
]

{ #category : #accessing }
CALENDAR_DATE >> year_component: anObject [
	year_component := anObject
]
