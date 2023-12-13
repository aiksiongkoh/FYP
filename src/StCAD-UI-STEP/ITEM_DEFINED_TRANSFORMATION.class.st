Class {
	#name : #'ITEM_DEFINED_TRANSFORMATION',
	#superclass : #Item,
	#instVars : [
		'description',
		'transform_item_1',
		'transform_item_2'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
ITEM_DEFINED_TRANSFORMATION class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
ITEM_DEFINED_TRANSFORMATION >> aAFf [
	"
	aAFf1 := aAf1f2*aAFf2
	aAFf1*aAFf2T := aAf1f2
	"

	^transform_item_1 aAFf timesTransposeFullMatrix: transform_item_2 aAFf
]

{ #category : #accessing }
ITEM_DEFINED_TRANSFORMATION >> description [
	^description
]

{ #category : #accessing }
ITEM_DEFINED_TRANSFORMATION >> description: anObject [
	description := anObject
]

{ #category : #accessing }
ITEM_DEFINED_TRANSFORMATION >> rFfF [
	^transform_item_1 rFfF minusFullColumn: transform_item_2 rFfF
]

{ #category : #accessing }
ITEM_DEFINED_TRANSFORMATION >> rFfF1 [
	^transform_item_1 rFfF minusFullColumn: transform_item_2 rFfF
]

{ #category : #accessing }
ITEM_DEFINED_TRANSFORMATION >> rFfF2 [
	^transform_item_2 rFfF minusFullColumn: transform_item_1 rFfF
]

{ #category : #accessing }
ITEM_DEFINED_TRANSFORMATION >> transform_item_1 [
	^transform_item_1
]

{ #category : #accessing }
ITEM_DEFINED_TRANSFORMATION >> transform_item_1: anObject [
	transform_item_1 := anObject
]

{ #category : #accessing }
ITEM_DEFINED_TRANSFORMATION >> transform_item_2 [
	^transform_item_2
]

{ #category : #accessing }
ITEM_DEFINED_TRANSFORMATION >> transform_item_2: anObject [
	transform_item_2 := anObject
]
