Class {
	#name : #'MEASURE_WITH_UNIT',
	#superclass : #Item,
	#instVars : [
		'value_component',
		'unit_component'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
MEASURE_WITH_UNIT class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
MEASURE_WITH_UNIT >> unit_component [
	^unit_component
]

{ #category : #accessing }
MEASURE_WITH_UNIT >> unit_component: anObject [
	unit_component := anObject
]

{ #category : #accessing }
MEASURE_WITH_UNIT >> value_component [
	^value_component
]

{ #category : #accessing }
MEASURE_WITH_UNIT >> value_component: anObject [

	(anObject isKindOf: StCAD_UI_STEP_STEPParser) ifTrue: [ self halt ]. "VW_TRANSLATION:StCAD.UI.STEP.STEPParser:StCAD_UI_STEP_STEPParser"
	value_component := anObject
]
