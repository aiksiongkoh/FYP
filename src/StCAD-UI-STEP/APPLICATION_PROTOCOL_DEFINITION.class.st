Class {
	#name : #'APPLICATION_PROTOCOL_DEFINITION',
	#superclass : #Item,
	#instVars : [
		'status',
		'application_interpreted_model_schema_name',
		'application_protocol_year',
		'application'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
APPLICATION_PROTOCOL_DEFINITION class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
APPLICATION_PROTOCOL_DEFINITION >> application [
	^application
]

{ #category : #accessing }
APPLICATION_PROTOCOL_DEFINITION >> application: anObject [
	application := anObject
]

{ #category : #accessing }
APPLICATION_PROTOCOL_DEFINITION >> application_interpreted_model_schema_name [
	^application_interpreted_model_schema_name
]

{ #category : #accessing }
APPLICATION_PROTOCOL_DEFINITION >> application_interpreted_model_schema_name: anObject [
	application_interpreted_model_schema_name := anObject
]

{ #category : #accessing }
APPLICATION_PROTOCOL_DEFINITION >> application_protocol_year [
	^application_protocol_year
]

{ #category : #accessing }
APPLICATION_PROTOCOL_DEFINITION >> application_protocol_year: anObject [
	application_protocol_year := anObject
]

{ #category : #accessing }
APPLICATION_PROTOCOL_DEFINITION >> status [
	^status
]

{ #category : #accessing }
APPLICATION_PROTOCOL_DEFINITION >> status: anObject [
	status := anObject
]
