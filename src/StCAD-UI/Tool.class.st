Class {
	#name : #Tool,
	#superclass : #Item,
	#instVars : [
		'aMediator',
		'name',
		'aIcon',
		'aCursor'
	],
	#category : #'StCAD-UI-StCAD-UI-Basic'
}

{ #category : #accessing }
Tool class >> stockIconFor: aString [ 
	self notYetImplemented.
	^nil
]

{ #category : #'VisualWorks metadata' }
Tool class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
Tool >> aMediator [
	^aMediator
]

{ #category : #accessing }
Tool >> aMediator: anObject [ 
	aMediator := anObject
]
