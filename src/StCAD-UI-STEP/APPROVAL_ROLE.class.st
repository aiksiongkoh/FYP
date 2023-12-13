Class {
	#name : #'APPROVAL_ROLE',
	#superclass : #Item,
	#instVars : [
		'role'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
APPROVAL_ROLE class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
APPROVAL_ROLE >> role [
	^role
]

{ #category : #accessing }
APPROVAL_ROLE >> role: anObject [
	role := anObject
]
