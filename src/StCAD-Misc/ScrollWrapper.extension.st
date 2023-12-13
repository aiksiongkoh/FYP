Extension { #name : #ScrollWrapper }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
ScrollWrapper >> scrollCADSM [
	| aGraphicsContext |
"	self topComponent ifNotNil: [:rcvr | rcvr sensor pseudoEvent]."
	aGraphicsContext := self graphicsContext.
	aGraphicsContext intersectClip: self compositionBounds.
	aGraphicsContext paint: self foregroundColor.
	self displayOn: aGraphicsContext.
	self updateControls.
	self updateSpot: #scroll
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
ScrollWrapper >> scrollOriginal: aPoint [
 	"Scroll the receiver by aPoint."

	| maximumAmount minimumAmount amount |
	maximumAmount := self scrollOffset + origin extraSpace origin max: 0@0. 
 	minimumAmount := self scrollOffset + self visibleExtent - self scrollableExtent min: 0@0.
	amount := (aPoint min: maximumAmount) max: minimumAmount.
 	amount ~= (0@0) ifTrue: 
		[self scrollBy: amount negated].
	^amount
]
