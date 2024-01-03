Class {
	#name : #'PERSON_AND_ORGANIZATION',
	#superclass : #Item,
	#instVars : [
		'the_person',
		'the_organization'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
PERSON_AND_ORGANIZATION >> the_organization [
	^the_organization
]

{ #category : #accessing }
PERSON_AND_ORGANIZATION >> the_organization: anObject [
	the_organization := anObject
]

{ #category : #accessing }
PERSON_AND_ORGANIZATION >> the_person [
	^the_person
]

{ #category : #accessing }
PERSON_AND_ORGANIZATION >> the_person: anObject [
	the_person := anObject
]
