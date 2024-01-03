Class {
	#name : #'PRODUCT_DEFINITION_FORMATION_WITH_SPECIFIED_SOURCE',
	#superclass : #Item,
	#instVars : [
		'id',
		'description',
		'of_product',
		'make_or_buy'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
PRODUCT_DEFINITION_FORMATION_WITH_SPECIFIED_SOURCE >> description [
	^description
]

{ #category : #accessing }
PRODUCT_DEFINITION_FORMATION_WITH_SPECIFIED_SOURCE >> description: anObject [
	description := anObject
]

{ #category : #accessing }
PRODUCT_DEFINITION_FORMATION_WITH_SPECIFIED_SOURCE >> id [
	^id
]

{ #category : #accessing }
PRODUCT_DEFINITION_FORMATION_WITH_SPECIFIED_SOURCE >> id: anObject [
	id := anObject
]

{ #category : #accessing }
PRODUCT_DEFINITION_FORMATION_WITH_SPECIFIED_SOURCE >> make_or_buy [
	^make_or_buy
]

{ #category : #accessing }
PRODUCT_DEFINITION_FORMATION_WITH_SPECIFIED_SOURCE >> make_or_buy: anObject [
	make_or_buy := anObject
]

{ #category : #accessing }
PRODUCT_DEFINITION_FORMATION_WITH_SPECIFIED_SOURCE >> of_product [
	^of_product
]

{ #category : #accessing }
PRODUCT_DEFINITION_FORMATION_WITH_SPECIFIED_SOURCE >> of_product: anObject [
	of_product := anObject
]
