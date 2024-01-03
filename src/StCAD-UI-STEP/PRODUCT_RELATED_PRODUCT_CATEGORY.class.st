Class {
	#name : #'PRODUCT_RELATED_PRODUCT_CATEGORY',
	#superclass : #Item,
	#instVars : [
		'description',
		'products'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
PRODUCT_RELATED_PRODUCT_CATEGORY >> description [
	^description
]

{ #category : #accessing }
PRODUCT_RELATED_PRODUCT_CATEGORY >> description: anObject [
	description := anObject
]

{ #category : #accessing }
PRODUCT_RELATED_PRODUCT_CATEGORY >> products [
	^products
]

{ #category : #accessing }
PRODUCT_RELATED_PRODUCT_CATEGORY >> products: anObject [
	products := anObject
]
