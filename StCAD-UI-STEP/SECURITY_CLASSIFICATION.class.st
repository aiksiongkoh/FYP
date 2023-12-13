Class {
	#name : #'SECURITY_CLASSIFICATION',
	#superclass : #Item,
	#instVars : [
		'purpose',
		'security_level'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
SECURITY_CLASSIFICATION class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
SECURITY_CLASSIFICATION >> purpose [
	^purpose
]

{ #category : #accessing }
SECURITY_CLASSIFICATION >> purpose: anObject [
	purpose := anObject
]

{ #category : #accessing }
SECURITY_CLASSIFICATION >> security_level [
	^security_level
]

{ #category : #accessing }
SECURITY_CLASSIFICATION >> security_level: anObject [
	security_level := anObject
]
