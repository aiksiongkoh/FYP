Class {
	#name : #'PERSONAL_ADDRESS',
	#superclass : #Item,
	#instVars : [
		'internal_location',
		'street_number',
		'street',
		'postal_box',
		'town',
		'region',
		'postal_code',
		'country',
		'facsimile_number',
		'telephone_number',
		'electronic_mail_address',
		'telex_number',
		'people',
		'description'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
PERSONAL_ADDRESS >> country [
	^country
]

{ #category : #accessing }
PERSONAL_ADDRESS >> country: anObject [
	country := anObject
]

{ #category : #accessing }
PERSONAL_ADDRESS >> description [
	^description
]

{ #category : #accessing }
PERSONAL_ADDRESS >> description: anObject [
	description := anObject
]

{ #category : #accessing }
PERSONAL_ADDRESS >> electronic_mail_address [
	^electronic_mail_address
]

{ #category : #accessing }
PERSONAL_ADDRESS >> electronic_mail_address: anObject [
	electronic_mail_address := anObject
]

{ #category : #accessing }
PERSONAL_ADDRESS >> facsimile_number [
	^facsimile_number
]

{ #category : #accessing }
PERSONAL_ADDRESS >> facsimile_number: anObject [
	facsimile_number := anObject
]

{ #category : #accessing }
PERSONAL_ADDRESS >> internal_location [
	^internal_location
]

{ #category : #accessing }
PERSONAL_ADDRESS >> internal_location: anObject [
	internal_location := anObject
]

{ #category : #accessing }
PERSONAL_ADDRESS >> people [
	^people
]

{ #category : #accessing }
PERSONAL_ADDRESS >> people: anObject [
	people := anObject
]

{ #category : #accessing }
PERSONAL_ADDRESS >> postal_box [
	^postal_box
]

{ #category : #accessing }
PERSONAL_ADDRESS >> postal_box: anObject [
	postal_box := anObject
]

{ #category : #accessing }
PERSONAL_ADDRESS >> postal_code [
	^postal_code
]

{ #category : #accessing }
PERSONAL_ADDRESS >> postal_code: anObject [
	postal_code := anObject
]

{ #category : #accessing }
PERSONAL_ADDRESS >> region [
	^region
]

{ #category : #accessing }
PERSONAL_ADDRESS >> region: anObject [
	region := anObject
]

{ #category : #accessing }
PERSONAL_ADDRESS >> street [
	^street
]

{ #category : #accessing }
PERSONAL_ADDRESS >> street: anObject [
	street := anObject
]

{ #category : #accessing }
PERSONAL_ADDRESS >> street_number [
	^street_number
]

{ #category : #accessing }
PERSONAL_ADDRESS >> street_number: anObject [
	street_number := anObject
]

{ #category : #accessing }
PERSONAL_ADDRESS >> telephone_number [
	^telephone_number
]

{ #category : #accessing }
PERSONAL_ADDRESS >> telephone_number: anObject [
	telephone_number := anObject
]

{ #category : #accessing }
PERSONAL_ADDRESS >> telex_number [
	^telex_number
]

{ #category : #accessing }
PERSONAL_ADDRESS >> telex_number: anObject [
	telex_number := anObject
]

{ #category : #accessing }
PERSONAL_ADDRESS >> town [
	^town
]

{ #category : #accessing }
PERSONAL_ADDRESS >> town: anObject [
	town := anObject
]
