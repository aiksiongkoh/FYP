Class {
	#name : #'APPLICATION_CONTEXT_ELEMENT',
	#superclass : #Item,
	#instVars : [
		'frame_of_reference'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
APPLICATION_CONTEXT_ELEMENT class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
APPLICATION_CONTEXT_ELEMENT >> frame_of_reference [
	^frame_of_reference
]

{ #category : #accessing }
APPLICATION_CONTEXT_ELEMENT >> frame_of_reference: anObject [
	frame_of_reference := anObject
]
