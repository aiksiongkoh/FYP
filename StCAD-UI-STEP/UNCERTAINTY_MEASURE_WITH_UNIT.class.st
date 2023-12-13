Class {
	#name : #'UNCERTAINTY_MEASURE_WITH_UNIT',
	#superclass : #Item,
	#instVars : [
		'value_component',
		'unit_component',
		'description'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
UNCERTAINTY_MEASURE_WITH_UNIT class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
UNCERTAINTY_MEASURE_WITH_UNIT >> description [
	^description
]

{ #category : #accessing }
UNCERTAINTY_MEASURE_WITH_UNIT >> description: anObject [
	description := anObject
]

{ #category : #accessing }
UNCERTAINTY_MEASURE_WITH_UNIT >> unit_component [
	^unit_component
]

{ #category : #accessing }
UNCERTAINTY_MEASURE_WITH_UNIT >> unit_component: anObject [
	unit_component := anObject
]

{ #category : #accessing }
UNCERTAINTY_MEASURE_WITH_UNIT >> value_component [
	^value_component
]

{ #category : #accessing }
UNCERTAINTY_MEASURE_WITH_UNIT >> value_component: anObject [
	value_component := anObject
]
