Class {
	#name : #OpenGLDisplayController,
	#superclass : #JunOpenGLDisplayController,
	#category : #'StCAD-UI-StCAD-UI-App'
}

{ #category : #'VisualWorks metadata' }
OpenGLDisplayController class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'Jun'
	)

]

{ #category : #accessing }
OpenGLDisplayController >> aOpenGLPointFor: eventOrPoint [ 
	| rvSTpvST rvGLpvGL |
	rvSTpvST := (eventOrPoint isKindOf: MouseButtonEvent) 
				ifTrue: [self sensor mousePointFor: eventOrPoint]
				ifFalse: [eventOrPoint].
	rvGLpvGL := rvSTpvST x @ (view bounds extent y - 1 - rvSTpvST y).
	^rvGLpvGL
]

{ #category : #events }
OpenGLDisplayController >> redButtonPressedEvent1: event [ 
	| rvSTpvST rvGLpvGL pickedObject |
	rvSTpvST := self sensor mousePointFor: event.
	rvGLpvGL := rvSTpvST x @ (view bounds extent y - 1 - rvSTpvST y).
	pickedObject := view pickAt: rvGLpvGL.
	pickedObject ifNotNil: [pickedObject selectionTracker handleEvent: event].
	view keyboardProcessor 
		ifNotNil: [:keyboardProcessor | keyboardProcessor requestActivationFor: self]
]

{ #category : #events }
OpenGLDisplayController >> redButtonPressedEvent: event [ 
	| rvSTpvST rvGLpvGL |
	rvSTpvST := self sensor mousePointFor: event.
	rvGLpvGL := rvSTpvST x @ (view bounds extent y - 1 - rvSTpvST y).
	(((view pickHandleAt: rvGLpvGL) ifNil: [self model aTool]) 
		selectionTracker)
		setController: self;
		redButtonPressedEvent: event.
	view keyboardProcessor 
		ifNotNil: [:keyboardProcessor | keyboardProcessor requestActivationFor: self]
]
