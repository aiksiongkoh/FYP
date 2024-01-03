Class {
	#name : #'COORDINATED_UNIVERSAL_TIME_OFFSET',
	#superclass : #Item,
	#instVars : [
		'hour_offset',
		'minute_offset',
		'sense'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
COORDINATED_UNIVERSAL_TIME_OFFSET >> hour_offset [
	^hour_offset
]

{ #category : #accessing }
COORDINATED_UNIVERSAL_TIME_OFFSET >> hour_offset: anObject [
	hour_offset := anObject
]

{ #category : #accessing }
COORDINATED_UNIVERSAL_TIME_OFFSET >> minute_offset [
	^minute_offset
]

{ #category : #accessing }
COORDINATED_UNIVERSAL_TIME_OFFSET >> minute_offset: anObject [
	minute_offset := anObject
]

{ #category : #accessing }
COORDINATED_UNIVERSAL_TIME_OFFSET >> sense [
	^sense
]

{ #category : #accessing }
COORDINATED_UNIVERSAL_TIME_OFFSET >> sense: anObject [
	sense := anObject
]
