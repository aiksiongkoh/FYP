Class {
	#name : #'CARTESIAN_POINT',
	#superclass : #POINT,
	#instVars : [
		'coordinates'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
CARTESIAN_POINT >> aPoint [
	^coordinates
]

{ #category : #accessing }
CARTESIAN_POINT >> coordinates [
	^coordinates
]

{ #category : #accessing }
CARTESIAN_POINT >> coordinates: anObject [
	coordinates := anObject
]

{ #category : #printing }
CARTESIAN_POINT >> printVerboseOn: aStream [ 
	aStream print: coordinates
]

{ #category : #accessing }
CARTESIAN_POINT >> xyzPoint [
	^coordinates
]
