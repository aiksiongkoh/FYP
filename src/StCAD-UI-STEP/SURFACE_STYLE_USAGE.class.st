Class {
	#name : #'SURFACE_STYLE_USAGE',
	#superclass : #Item,
	#instVars : [
		'side',
		'style'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
SURFACE_STYLE_USAGE >> aColor [
	^style aColor
]

{ #category : #accessing }
SURFACE_STYLE_USAGE >> side [
	^side
]

{ #category : #accessing }
SURFACE_STYLE_USAGE >> side: anObject [
	side := anObject
]

{ #category : #accessing }
SURFACE_STYLE_USAGE >> style [
	^style
]

{ #category : #accessing }
SURFACE_STYLE_USAGE >> style: anObject [
	style := anObject
]
