Class {
	#name : #'PRODUCT_DEFINITION_RELATIONSHIP',
	#superclass : #Item,
	#instVars : [
		'id',
		'description',
		'relating_product_definition',
		'related_product_definition'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
PRODUCT_DEFINITION_RELATIONSHIP class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
PRODUCT_DEFINITION_RELATIONSHIP >> description [
	^description
]

{ #category : #accessing }
PRODUCT_DEFINITION_RELATIONSHIP >> description: anObject [
	description := anObject
]

{ #category : #accessing }
PRODUCT_DEFINITION_RELATIONSHIP >> id [
	^id
]

{ #category : #accessing }
PRODUCT_DEFINITION_RELATIONSHIP >> id: anObject [
	id := anObject
]

{ #category : #accessing }
PRODUCT_DEFINITION_RELATIONSHIP >> related_product_definition [
	^related_product_definition
]

{ #category : #accessing }
PRODUCT_DEFINITION_RELATIONSHIP >> related_product_definition: anObject [
	related_product_definition := anObject
]

{ #category : #accessing }
PRODUCT_DEFINITION_RELATIONSHIP >> relating_product_definition [
	^relating_product_definition
]

{ #category : #accessing }
PRODUCT_DEFINITION_RELATIONSHIP >> relating_product_definition: anObject [
	relating_product_definition := anObject
]
