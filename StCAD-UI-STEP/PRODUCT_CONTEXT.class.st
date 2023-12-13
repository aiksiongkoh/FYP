Class {
	#name : #'PRODUCT_CONTEXT',
	#superclass : #'APPLICATION_CONTEXT_ELEMENT',
	#instVars : [
		'discipline_type'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
PRODUCT_CONTEXT class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
PRODUCT_CONTEXT >> discipline_type [
	^discipline_type
]

{ #category : #accessing }
PRODUCT_CONTEXT >> discipline_type: anObject [
	discipline_type := anObject
]
