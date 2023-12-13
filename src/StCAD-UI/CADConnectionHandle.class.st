"
My clarification

	locationGenerationAction - <Action> The action to be evaluated that produces a locator
		for the stop location of the connectionGO created by connectAction.  The action accepts two arguments, the graphic object, and the
		target point under the mouse point

"
Class {
	#name : #CADConnectionHandle,
	#superclass : #GFConnectionHandle,
	#instVars : [
		'cadConnection'
	],
	#category : #'StCAD-UI-CAD'
}

{ #category : #'VisualWorks metadata' }
CADConnectionHandle class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'Polymorphic'
	)

]

{ #category : #accessing }
CADConnectionHandle >> cadConnection [
	^cadConnection
]

{ #category : #trackmouse }
CADConnectionHandle >> connectTo: target in: anInterface [ 
	| aConnectionGO targetLocator |
	targetLocator := locatorGenerationAction evaluateWith: target key with: target value.
	aConnectionGO := connectAction evaluateWith: locator with: targetLocator.
	^aConnectionGO
]

{ #category : #'initialize-release' }
CADConnectionHandle >> initialize [
	super initialize.
	snapToGrid := false.
	description := 'connection'.
	findTargetAction := self class gfMessageClass receiver: self
				selector: #graphicObjectIn:at:.
	targetPositionAction := self class gfMessageClass receiver: self
				selector: #connectionPositionOf:.
	connectAction := self class gfMessageClass receiver: CADDependentLineGO
				selector: #startLocation:stopLocation:.
	locatorGenerationAction := self class gfMessageClass receiver: self
				selector: #locatorFor:at:.
]

{ #category : #trackmouse }
CADConnectionHandle >> trackMouse: anInterface [ 
	| target |
	target := self findTarget: anInterface.
	target isNil ifTrue: [^anInterface showHandles].
	cadConnection := self connectTo: target in: anInterface.
	cadConnection isNil ifTrue: [^anInterface showHandles].
	connectedAction isNil ifFalse: [connectedAction evaluateIfNoTarget: self owner withArguments: (Array with: cadConnection with: target key)]
]
