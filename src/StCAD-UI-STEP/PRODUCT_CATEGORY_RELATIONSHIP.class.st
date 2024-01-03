Class {
	#name : #'PRODUCT_CATEGORY_RELATIONSHIP',
	#superclass : #Item,
	#instVars : [
		'description',
		'category',
		'sub_category'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
PRODUCT_CATEGORY_RELATIONSHIP >> category [
	^category
]

{ #category : #accessing }
PRODUCT_CATEGORY_RELATIONSHIP >> category: anObject [
	category := anObject
]

{ #category : #accessing }
PRODUCT_CATEGORY_RELATIONSHIP >> description [
	^description
]

{ #category : #accessing }
PRODUCT_CATEGORY_RELATIONSHIP >> description: anObject [
	description := anObject
]

{ #category : #accessing }
PRODUCT_CATEGORY_RELATIONSHIP >> sub_category [
	^sub_category
]

{ #category : #accessing }
PRODUCT_CATEGORY_RELATIONSHIP >> sub_category: anObject [
	sub_category := anObject
]
