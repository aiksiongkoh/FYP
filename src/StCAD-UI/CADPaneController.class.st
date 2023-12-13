Class {
	#name : #CADPaneController,
	#superclass : #GFPaneController,
	#category : #'StCAD-UI-CADApp'
}

{ #category : #'VisualWorks metadata' }
CADPaneController class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'Polymorphic'
	)

]

{ #category : #control }
CADPaneController >> activate [

	self hasControl
]

{ #category : #control }
CADPaneController >> checkAndResetDoubleClick1 [
	| event s tc redButtonReleasedEvent |
"	Transcript cr; show: 'CADPaneController>checkAndResetDoubleClick '."
	(view notNil and: [(tc := view topComponent) isEventDriven])
		ifTrue: 
			[s := tc sensor.
"			Transcript cr; show: 'hasEvents: ' , s hasEvents printString."
			[s hasEvents]
				whileTrue: 
					[| ev |
					ev := s nextEvent.
"					Transcript cr; show: ev printString."
					ev class == DoubleClickEvent ifTrue: [doubleClickEvent := ev].
					ev class == RedButtonReleasedEvent ifTrue: [redButtonReleasedEvent := ev]]].
	redButtonReleasedEvent notNil ifTrue: [s addMetaInput: redButtonReleasedEvent].
	^doubleClickEvent == nil
		ifTrue: [nil]
		ifFalse: 
			[event := doubleClickEvent.
			doubleClickEvent := nil.
			event]
]

{ #category : #control }
CADPaneController >> deactivate [
]

{ #category : #control }
CADPaneController >> privateControlLoopBody [
	"Copyright (C) 1993-1996 Polymorphic Software, Inc. All Rights Reserved"
	"Reimplement the control loop 
	so that we can provide 
	mouse button transition information."

	| previousState state |
	state := self buttonPressed.
	state ifTrue: ["Signal start of control with button down. 
		Assume the button just went down."
		self doubleClickEventPeek
			ifTrue: 
				[| ev |
				ev := self checkAndResetDoubleClick.
				controlBlock value: ev value value: ev key.
				[self sensor anyButtonPressed]
					whileTrue: []]
			ifFalse: [controlBlock value: self sensor cursorPoint value: #down]].
	
	[previousState := state.
	self poll.
	state := self buttonPressed.
	controlBlock value: self sensor cursorPoint value: (state
			ifTrue: [previousState
					ifTrue: [#down]
					ifFalse: [#wentDown]]
			ifFalse: [previousState
					ifTrue: [#wentUp]
					ifFalse: [#up]]).
	self isControlActive] whileTrue.
	state ifTrue: ["Signal end of control with button down."
		controlBlock value: self sensor cursorPoint value: #up]
]

{ #category : #'event driven' }
CADPaneController >> redButtonPressedEvent: event [ 
	view keyboardProcessor notNil 
		ifTrue: [(view keyboardProcessor requestActivationFor: self) ifFalse: [^self]].
	super redButtonPressedEvent: event.
	"Below is a hack to overcome missed RedButtonReleasedEvent in VW7.1"
	event initiator ungrabMouseEventFor: self
]
