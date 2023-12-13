Class {
	#name : #'REPRESENTATION_RELATIONSHIP',
	#superclass : #Item,
	#instVars : [
		'description',
		'rep_1',
		'rep_2'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
REPRESENTATION_RELATIONSHIP class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
REPRESENTATION_RELATIONSHIP >> description [
	^description
]

{ #category : #accessing }
REPRESENTATION_RELATIONSHIP >> description: anObject [
	description := anObject
]

{ #category : #accessing }
REPRESENTATION_RELATIONSHIP >> rep_1 [
	^rep_1
]

{ #category : #accessing }
REPRESENTATION_RELATIONSHIP >> rep_1: anObject [
	rep_1 := anObject
]

{ #category : #accessing }
REPRESENTATION_RELATIONSHIP >> rep_2 [
	^rep_2
]

{ #category : #accessing }
REPRESENTATION_RELATIONSHIP >> rep_2: anObject [
	rep_2 := anObject
]
