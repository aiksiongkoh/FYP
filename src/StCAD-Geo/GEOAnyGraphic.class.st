Class {
	#name : #GEOAnyGraphic,
	#superclass : #GEOContainedItem,
	#instVars : [
		'refFrame'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOAnyGraphic >> aBoundingBox [
	^self triggerEvent: #getBoundingBox
]

{ #category : #accessing }
GEOAnyGraphic >> aBoundingBox: aBoundingBox [ 
	self removeActionsForEvent: #getBoundingBox.
	aBoundingBox ifNotNil: 
			[self 
				when: #getBoundingBox
				ask: aBoundingBox
				perform: #yourself]
]

{ #category : #accessing }
GEOAnyGraphic >> aBoundingBoxF [
	"In refFrame components."

	^self aBoundingBox inRefFrame: refFrame
]

{ #category : #accessing }
GEOAnyGraphic >> aRefFrame [
	^refFrame
]

{ #category : #accessing }
GEOAnyGraphic >> addRefFrame: argRefFrame [ 
	"Example usage:

	addSurface: aSurface 
		aSurface removeSup.
		super addRefFrame: aSurface aRefFrame.
		cSurface add: aSurface.
		aSurface aSup: self.
		^aSurface
	"

	self aRefFrame addSub: argRefFrame
]

{ #category : #accessing }
GEOAnyGraphic >> boundingBoxF [
	"In refFrame components."

	^self boundingBox inRefFrame: refFrame
]

{ #category : #accessing }
GEOAnyGraphic >> bounds: bounds [ 
	self removeActionsForEvent: #getbounds.
	bounds notNil 
		ifTrue: 
			[self 
				when: #getbounds
				ask: bounds
				perform: #yourself]
]

{ #category : #'initialize-release' }
GEOAnyGraphic >> cut [
	refFrame cut.
	super cut
]

{ #category : #accessing }
GEOAnyGraphic >> flushBounds [
	self removeActionsForEvent: #getbounds
]

{ #category : #accessing }
GEOAnyGraphic >> guideFrame [
	^refFrame refFrame
]

{ #category : #accessing }
GEOAnyGraphic >> inPlaneFrame [
	^refFrame refFrame
]

{ #category : #'initialize-release' }
GEOAnyGraphic >> initialize [
	self refFrame: GEOCartesianFrame2 new.
	refFrame fixedAtRef
]

{ #category : #accessing }
GEOAnyGraphic >> movingFrame [
	^refFrame
]

{ #category : #accessing }
GEOAnyGraphic >> plane [
	^refFrame
]

{ #category : #accessing }
GEOAnyGraphic >> positionMemento [
	^refFrame positionMemento
]

{ #category : #copying }
GEOAnyGraphic >> postCopy [
	super postCopy.
	self refFrame: refFrame copy
]

{ #category : #copying }
GEOAnyGraphic >> preSave [
	super preSave.
	refFrame preSave
]

{ #category : #accessing }
GEOAnyGraphic >> rDfD [
	^self interface projectionFrame rDpPxfromrOpO: refFrame rOfO
]

{ #category : #accessing }
GEOAnyGraphic >> refFrame [
	^refFrame
]

{ #category : #accessing }
GEOAnyGraphic >> refFrame: aFrame [ 
	refFrame := aFrame.
	refFrame body: self
]

{ #category : #'initialize-release' }
GEOAnyGraphic >> release [
	refFrame release.
	super release
]

{ #category : #'initialize-release' }
GEOAnyGraphic >> releaseRefFrame [
	refFrame := nil
]

{ #category : #accessing }
GEOAnyGraphic >> setRefFrame: aFrame [ 
	refFrame := aFrame
]

{ #category : #accessing }
GEOAnyGraphic >> setrefFrame: aFrame [ 
	refFrame := aFrame
]

{ #category : #printing }
GEOAnyGraphic >> storeOn: aStream level: level [ 
	aStream storeLevel: level title: self nameString.
	aStream
		storeLevel: level + 1
		title: 'Name'
		object: self name.
	self refFrame storeOn: aStream level: level + 1
]

{ #category : #'ops on self' }
GEOAnyGraphic >> translateSelfBy: delta [ 
	refFrame translateSelfBy: delta.
	self changed
]

{ #category : #'initialize-release' }
GEOAnyGraphic >> uncut [
	refFrame uncut
]
