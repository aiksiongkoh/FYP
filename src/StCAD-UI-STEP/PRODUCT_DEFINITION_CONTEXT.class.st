Class {
	#name : #'PRODUCT_DEFINITION_CONTEXT',
	#superclass : #'APPLICATION_CONTEXT_ELEMENT',
	#instVars : [
		'life_cycle_stage'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
PRODUCT_DEFINITION_CONTEXT >> life_cycle_stage [
	^life_cycle_stage
]

{ #category : #accessing }
PRODUCT_DEFINITION_CONTEXT >> life_cycle_stage: anObject [
	life_cycle_stage := anObject
]
