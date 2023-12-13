Class {
	#name : #'PRESENTATION_LAYER_ASSIGNMENT',
	#superclass : #Item,
	#instVars : [
		'description',
		'assigned_items'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
PRESENTATION_LAYER_ASSIGNMENT class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
PRESENTATION_LAYER_ASSIGNMENT >> assigned_items [
	^assigned_items
]

{ #category : #accessing }
PRESENTATION_LAYER_ASSIGNMENT >> assigned_items: anObject [
	assigned_items := anObject
]

{ #category : #accessing }
PRESENTATION_LAYER_ASSIGNMENT >> description [
	^description
]

{ #category : #accessing }
PRESENTATION_LAYER_ASSIGNMENT >> description: anObject [
	description := anObject
]
