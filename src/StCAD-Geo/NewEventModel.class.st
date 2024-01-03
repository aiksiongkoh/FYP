"
Description: 
	
	NewEventModel tracks event handlers using its own event table instead of the class variable
in Object, as is done with standard Digitalk events.  In this way, we can depend on garbage
collection to clean up events when an object is no longer referenced by anyone.  Without
this approach, you would be forced to send the #release message to all object's when you were
done with them, and efficiency would be compromised.

	Instance Variables:

	eventTable - <IdentityDictionary with key: Symbol and value: KindOf: EvaluableAction>	
		Holds the equivalent of the class variable EventHandlers in Object.


"
Class {
	#name : #NewEventModel,
	#superclass : #Object,
	#instVars : [
		'eventTable'
	],
	#classInstVars : [
		'eventsTriggered'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
NewEventModel >> cadObject [
	^self triggerEvent: #getCADObject
]

{ #category : #accessing }
NewEventModel >> cadObject: cadObject [ 
	self removeActionsForEvent: #getCADObject.
	cadObject notNil ifTrue: [self
			when: #getCADObject
			ask: cadObject
			perform: #yourself]
]

{ #category : #events }
NewEventModel >> changed [
	self triggerEvent: #changed
]

{ #category : #events }
NewEventModel >> cut [
	"My domain has cut me and does not reference me. But it is ok for me to 
	reference the domain in case there is an undo."

	self triggerEvent: #release
]

{ #category : #accessing }
NewEventModel >> myEventTable [
	^eventTable
]

{ #category : #accessing }
NewEventModel >> myEventTable: anEventTable [ 
	eventTable := anEventTable
]

{ #category : #accessing }
NewEventModel >> name [
	^self triggerEvent: #getName
]

{ #category : #accessing }
NewEventModel >> name: name [ 
	| reversed shortName |
	reversed := name asString reverse.
	shortName := (reversed copyUpTo: $/) reverse.
	self removeActionsForEvent: #getName.
	name notNil ifTrue: [self
			when: #getName
			ask: shortName asSymbol
			perform: #yourself]
]

{ #category : #copying }
NewEventModel >> postCopy [
	super postCopy.
	eventTable := nil
]

{ #category : #accessing }
NewEventModel >> privateSetEventTable: dictionary [ 
	"private "

	eventTable := dictionary
]

{ #category : #events }
NewEventModel >> release [
	"Release myself from the domain and release all that I am holding to."

	self triggerEvent: #release.
	super release
]
