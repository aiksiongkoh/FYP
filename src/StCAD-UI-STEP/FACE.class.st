Class {
	#name : #FACE,
	#superclass : #'TOPOLOGICAL_REPRESENTATION_ITEM',
	#instVars : [
		'bounds'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
FACE >> bounds [
	^bounds
]

{ #category : #accessing }
FACE >> bounds: anObject [ 
	bounds := anObject
]
