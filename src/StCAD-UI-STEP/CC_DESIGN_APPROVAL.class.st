Class {
	#name : #'CC_DESIGN_APPROVAL',
	#superclass : #Item,
	#instVars : [
		'aEntity',
		'cEntity'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
CC_DESIGN_APPROVAL >> aEntity [
	^aEntity
]

{ #category : #accessing }
CC_DESIGN_APPROVAL >> aEntity: anObject [
	aEntity := anObject
]

{ #category : #accessing }
CC_DESIGN_APPROVAL >> cEntity [
	^cEntity
]

{ #category : #accessing }
CC_DESIGN_APPROVAL >> cEntity: anObject [
	cEntity := anObject
]
