Class {
	#name : #'CC_DESIGN_DATE_AND_TIME_ASSIGNMENT',
	#superclass : #Item,
	#instVars : [
		'aEntity',
		'a2Entity',
		'cEntity'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
CC_DESIGN_DATE_AND_TIME_ASSIGNMENT class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
CC_DESIGN_DATE_AND_TIME_ASSIGNMENT >> a2Entity [
	^a2Entity
]

{ #category : #accessing }
CC_DESIGN_DATE_AND_TIME_ASSIGNMENT >> a2Entity: anObject [
	a2Entity := anObject
]

{ #category : #accessing }
CC_DESIGN_DATE_AND_TIME_ASSIGNMENT >> aEntity [
	^aEntity
]

{ #category : #accessing }
CC_DESIGN_DATE_AND_TIME_ASSIGNMENT >> aEntity: anObject [
	aEntity := anObject
]

{ #category : #accessing }
CC_DESIGN_DATE_AND_TIME_ASSIGNMENT >> cEntity [
	^cEntity
]

{ #category : #accessing }
CC_DESIGN_DATE_AND_TIME_ASSIGNMENT >> cEntity: anObject [
	cEntity := anObject
]
