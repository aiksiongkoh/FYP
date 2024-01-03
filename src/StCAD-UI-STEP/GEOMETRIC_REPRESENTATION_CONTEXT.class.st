Class {
	#name : #'GEOMETRIC_REPRESENTATION_CONTEXT',
	#superclass : #'REPRESENTATION_CONTEXT',
	#instVars : [
		'coordinate_space_dimension'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
GEOMETRIC_REPRESENTATION_CONTEXT >> coordinate_space_dimension [
	^coordinate_space_dimension
]

{ #category : #accessing }
GEOMETRIC_REPRESENTATION_CONTEXT >> coordinate_space_dimension: anObject [
	coordinate_space_dimension := anObject
]
