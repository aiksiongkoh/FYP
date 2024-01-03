Class {
	#name : #'PRODUCT_CATEGORY',
	#superclass : #Item,
	#instVars : [
		'description'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
PRODUCT_CATEGORY >> description [
	^description
]

{ #category : #accessing }
PRODUCT_CATEGORY >> description: anObject [
	description := anObject
]
