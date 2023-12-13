Class {
	#name : #'CC_DESIGN_PERSON_AND_ORGANIZATION_ASSIGNMENT',
	#superclass : #Item,
	#instVars : [
		'aEntity',
		'a2Entity',
		'cEntity'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
CC_DESIGN_PERSON_AND_ORGANIZATION_ASSIGNMENT class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
CC_DESIGN_PERSON_AND_ORGANIZATION_ASSIGNMENT >> a2Entity [
	^a2Entity
]

{ #category : #accessing }
CC_DESIGN_PERSON_AND_ORGANIZATION_ASSIGNMENT >> a2Entity: anObject [
	a2Entity := anObject
]

{ #category : #accessing }
CC_DESIGN_PERSON_AND_ORGANIZATION_ASSIGNMENT >> aEntity [
	^aEntity
]

{ #category : #accessing }
CC_DESIGN_PERSON_AND_ORGANIZATION_ASSIGNMENT >> aEntity: anObject [
	aEntity := anObject
]

{ #category : #accessing }
CC_DESIGN_PERSON_AND_ORGANIZATION_ASSIGNMENT >> cEntity [
	^cEntity
]

{ #category : #accessing }
CC_DESIGN_PERSON_AND_ORGANIZATION_ASSIGNMENT >> cEntity: anObject [
	cEntity := anObject
]
