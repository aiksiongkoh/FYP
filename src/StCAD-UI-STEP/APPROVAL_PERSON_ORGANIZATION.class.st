Class {
	#name : #'APPROVAL_PERSON_ORGANIZATION',
	#superclass : #Item,
	#instVars : [
		'person_organization',
		'authorized_approval',
		'role'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
APPROVAL_PERSON_ORGANIZATION class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
APPROVAL_PERSON_ORGANIZATION >> authorized_approval [
	^authorized_approval
]

{ #category : #accessing }
APPROVAL_PERSON_ORGANIZATION >> authorized_approval: anObject [
	authorized_approval := anObject
]

{ #category : #accessing }
APPROVAL_PERSON_ORGANIZATION >> person_organization [
	^person_organization
]

{ #category : #accessing }
APPROVAL_PERSON_ORGANIZATION >> person_organization: anObject [
	person_organization := anObject
]

{ #category : #accessing }
APPROVAL_PERSON_ORGANIZATION >> role [
	^role
]

{ #category : #accessing }
APPROVAL_PERSON_ORGANIZATION >> role: anObject [
	role := anObject
]
