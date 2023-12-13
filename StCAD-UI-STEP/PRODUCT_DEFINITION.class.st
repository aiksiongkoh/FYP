Class {
	#name : #'PRODUCT_DEFINITION',
	#superclass : #Item,
	#instVars : [
		'id',
		'description',
		'formation',
		'frame_of_reference'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
PRODUCT_DEFINITION class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
PRODUCT_DEFINITION >> description [
	^description
]

{ #category : #accessing }
PRODUCT_DEFINITION >> description: anObject [
	description := anObject
]

{ #category : #accessing }
PRODUCT_DEFINITION >> formation [
	^formation
]

{ #category : #accessing }
PRODUCT_DEFINITION >> formation: anObject [
	formation := anObject
]

{ #category : #accessing }
PRODUCT_DEFINITION >> frame_of_reference [
	^frame_of_reference
]

{ #category : #accessing }
PRODUCT_DEFINITION >> frame_of_reference: anObject [
	frame_of_reference := anObject
]

{ #category : #accessing }
PRODUCT_DEFINITION >> id [
	^id
]

{ #category : #accessing }
PRODUCT_DEFINITION >> id: anObject [
	id := anObject
]
