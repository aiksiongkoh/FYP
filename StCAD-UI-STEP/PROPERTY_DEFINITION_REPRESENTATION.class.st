Class {
	#name : #'PROPERTY_DEFINITION_REPRESENTATION',
	#superclass : #Item,
	#instVars : [
		'definition',
		'used_representation'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
PROPERTY_DEFINITION_REPRESENTATION class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
PROPERTY_DEFINITION_REPRESENTATION >> definition [
	^definition
]

{ #category : #accessing }
PROPERTY_DEFINITION_REPRESENTATION >> definition: anObject [
	definition := anObject
]

{ #category : #accessing }
PROPERTY_DEFINITION_REPRESENTATION >> used_representation [
	^used_representation
]

{ #category : #accessing }
PROPERTY_DEFINITION_REPRESENTATION >> used_representation: anObject [
	used_representation := anObject
]
