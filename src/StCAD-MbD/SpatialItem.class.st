Class {
	#name : #SpatialItem,
	#superclass : #SubItem,
	#instVars : [
		'name',
		'aRefFrame'
	],
	#category : #'StCAD-MbD-StCAD-MbD-Basic'
}

{ #category : #accessing }
SpatialItem class >> aRefFrameClass [
	self subclassResponsibility
]

{ #category : #'VisualWorks metadata' }
SpatialItem class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
SpatialItem >> aRefFrame [
	^aRefFrame
]

{ #category : #accessing }
SpatialItem >> aRefFrame: aaRefFrame [ 
	aRefFrame := aaRefFrame.
	aRefFrame body: self
]

{ #category : #accessing }
SpatialItem >> aRefFrameClass [
	^self class aRefFrameClass
]

{ #category : #accessing }
SpatialItem >> addRefFrame: argRefFrame [ 
	"Example usage:

	addSurface: aSurface 
		aSurface removeSup.
		super addRefFrame: aSurface aRefFrame.
		cSurface add: aSurface.
		aSurface aSup: self.
		^aSurface
	"

	aRefFrame addSub: argRefFrame
]

{ #category : #'ops on self' }
SpatialItem >> beSymbolic [
	"Do nothing."
]

{ #category : #'initialize-release' }
SpatialItem >> initialize [
	super initialize.
	self aRefFrame: self aRefFrameClass new
]

{ #category : #accessing }
SpatialItem >> name [
	^name notNil ifTrue: [name] ifFalse: [self class asString asSymbol]
]

{ #category : #accessing }
SpatialItem >> name: anObject [ 
	name := anObject ifNotNil: [anObject asSymbol]
]

{ #category : #copying }
SpatialItem >> postCopy [
	super postCopy.
	name := nil.
	self aRefFrame: aRefFrame copy
]
