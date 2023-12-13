Class {
	#name : #ORGANIZATION,
	#superclass : #Item,
	#instVars : [
		'id',
		'description'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
ORGANIZATION class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
ORGANIZATION >> description [
	^description
]

{ #category : #accessing }
ORGANIZATION >> description: anObject [
	description := anObject
]

{ #category : #accessing }
ORGANIZATION >> id [
	^id
]

{ #category : #accessing }
ORGANIZATION >> id: anObject [
	id := anObject
]
