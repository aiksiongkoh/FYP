Class {
	#name : #'COLOUR_RGB',
	#superclass : #Item,
	#instVars : [
		'red',
		'green',
		'blue'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
COLOUR_RGB >> aColor [
	^ColorValue 
		red: red
		green: green
		blue: blue
]

{ #category : #accessing }
COLOUR_RGB >> blue [
	^blue
]

{ #category : #accessing }
COLOUR_RGB >> blue: anObject [
	blue := anObject
]

{ #category : #accessing }
COLOUR_RGB >> green [
	^green
]

{ #category : #accessing }
COLOUR_RGB >> green: anObject [
	green := anObject
]

{ #category : #accessing }
COLOUR_RGB >> red [
	^red
]

{ #category : #accessing }
COLOUR_RGB >> red: anObject [
	red := anObject
]
