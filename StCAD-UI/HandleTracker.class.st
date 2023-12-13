Class {
	#name : #HandleTracker,
	#superclass : #ScrollingTracker,
	#instVars : [
		'aHandle'
	],
	#category : #'StCAD-UI-StCAD-UI-Basic'
}

{ #category : #'instance-creation' }
HandleTracker class >> on: aHandle [ 
	| st |
	st := self new.
	st setController: aHandle aView controller.
	st aHandle: aHandle.
	^st
]

{ #category : #'VisualWorks metadata' }
HandleTracker class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'UI'
	)

]

{ #category : #accessing }
HandleTracker >> aHandle [
	^aHandle
]

{ #category : #accessing }
HandleTracker >> aHandle: anObject [
	aHandle := anObject
]
