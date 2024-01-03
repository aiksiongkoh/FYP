Class {
	#name : #'PRODUCT_DEFINITION_FORMATION',
	#superclass : #Item,
	#instVars : [
		'id',
		'description',
		'of_product'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'As yet unclassified' }
PRODUCT_DEFINITION_FORMATION >> aPRODUCT [
	^of_product aPRODUCT
]

{ #category : #'As yet unclassified' }
PRODUCT_DEFINITION_FORMATION >> cPartSTEP [
	^of_product cPartSTEP
]

{ #category : #accessing }
PRODUCT_DEFINITION_FORMATION >> description [
	^description
]

{ #category : #accessing }
PRODUCT_DEFINITION_FORMATION >> description: anObject [
	description := anObject
]

{ #category : #accessing }
PRODUCT_DEFINITION_FORMATION >> id [
	^id
]

{ #category : #accessing }
PRODUCT_DEFINITION_FORMATION >> id: anObject [
	id := anObject
]

{ #category : #accessing }
PRODUCT_DEFINITION_FORMATION >> of_product [
	^of_product
]

{ #category : #accessing }
PRODUCT_DEFINITION_FORMATION >> of_product: anObject [
	of_product := anObject
]

{ #category : #'As yet unclassified' }
PRODUCT_DEFINITION_FORMATION >> productName [
	^of_product name
]
