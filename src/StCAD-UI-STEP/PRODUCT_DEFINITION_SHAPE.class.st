Class {
	#name : #'PRODUCT_DEFINITION_SHAPE',
	#superclass : #Item,
	#instVars : [
		'description',
		'definition'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
PRODUCT_DEFINITION_SHAPE class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
PRODUCT_DEFINITION_SHAPE >> definition [
	^definition
]

{ #category : #accessing }
PRODUCT_DEFINITION_SHAPE >> definition: anObject [
	definition := anObject
]

{ #category : #accessing }
PRODUCT_DEFINITION_SHAPE >> description [
	^description
]

{ #category : #accessing }
PRODUCT_DEFINITION_SHAPE >> description: anObject [
	description := anObject
]
