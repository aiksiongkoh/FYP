Class {
	#name : #PERSON,
	#superclass : #Item,
	#instVars : [
		'id',
		'last_name',
		'first_name',
		'middle_names',
		'prefix_titles',
		'suffix_titles'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
PERSON class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
PERSON >> first_name [
	^first_name
]

{ #category : #accessing }
PERSON >> first_name: anObject [
	first_name := anObject
]

{ #category : #accessing }
PERSON >> id [
	^id
]

{ #category : #accessing }
PERSON >> id: anObject [
	id := anObject
]

{ #category : #accessing }
PERSON >> last_name [
	^last_name
]

{ #category : #accessing }
PERSON >> last_name: anObject [
	last_name := anObject
]

{ #category : #accessing }
PERSON >> middle_names [
	^middle_names
]

{ #category : #accessing }
PERSON >> middle_names: anObject [
	middle_names := anObject
]

{ #category : #accessing }
PERSON >> prefix_titles [
	^prefix_titles
]

{ #category : #accessing }
PERSON >> prefix_titles: anObject [
	prefix_titles := anObject
]

{ #category : #accessing }
PERSON >> suffix_titles [
	^suffix_titles
]

{ #category : #accessing }
PERSON >> suffix_titles: anObject [
	suffix_titles := anObject
]
