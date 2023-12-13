Class {
	#name : #'APPROVAL_DATE_TIME',
	#superclass : #Item,
	#instVars : [
		'date_time',
		'dated_approval'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
APPROVAL_DATE_TIME class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
APPROVAL_DATE_TIME >> date_time [
	^date_time
]

{ #category : #accessing }
APPROVAL_DATE_TIME >> date_time: anObject [
	date_time := anObject
]

{ #category : #accessing }
APPROVAL_DATE_TIME >> dated_approval [
	^dated_approval
]

{ #category : #accessing }
APPROVAL_DATE_TIME >> dated_approval: anObject [
	dated_approval := anObject
]
