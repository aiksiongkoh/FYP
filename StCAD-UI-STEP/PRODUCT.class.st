Class {
	#name : #PRODUCT,
	#superclass : #Item,
	#instVars : [
		'id',
		'description',
		'frame_of_reference'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
PRODUCT class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
PRODUCT >> description [
	^description
]

{ #category : #accessing }
PRODUCT >> description: anObject [
	description := anObject
]

{ #category : #accessing }
PRODUCT >> frame_of_reference [
	^frame_of_reference
]

{ #category : #accessing }
PRODUCT >> frame_of_reference: anObject [
	frame_of_reference := anObject
]

{ #category : #accessing }
PRODUCT >> id [
	^id
]

{ #category : #accessing }
PRODUCT >> id: anObject [
	id := anObject
]
