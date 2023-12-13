Extension { #name : #Rectangle }

{ #category : #'*StCAD-UI-StCAD-UI' }
Rectangle >> enlargeLowerLeft [
	| extent |
	extent := self extent.
	origin := origin - (extent x @ 0).
	corner := corner + (0 @ extent y)
]

{ #category : #'*StCAD-UI-StCAD-UI' }
Rectangle >> enlargeLowerRight [
	| extent |
	extent := self extent.
	origin := origin copy.
	corner := corner + extent
]

{ #category : #'*StCAD-UI-StCAD-UI' }
Rectangle >> enlargeUpperLeft [
	| extent |
	extent := self extent.
	origin := origin - extent.
	corner := corner copy
]

{ #category : #'*StCAD-UI-StCAD-UI' }
Rectangle >> enlargeUpperRight [
	| extent |
	extent := self extent.
	origin := origin - (0 @ extent y).
	corner := corner + (extent x @ 0)
]

{ #category : #'*StCAD-UI-StCAD-UI' }
Rectangle >> expandToBound: aPointOrRect [ 
	aPointOrRect fitSelfInRect: self
]

{ #category : #'*StCAD-UI-StCAD-UI' }
Rectangle >> fitSelfInRect: aBoundingRect [ 
	self isDefined 
		ifTrue: 
			[aBoundingRect isDefined 
				ifTrue: 
					[aBoundingRect origin: (origin min: aBoundingRect origin)
						corner: (corner max: aBoundingRect corner)]
				ifFalse: [aBoundingRect origin: origin copy corner: corner copy]]
]

{ #category : #'*StCAD-UI-StCAD-UI' }
Rectangle >> isDefined [
	^origin x isReal
]

{ #category : #'*StCAD-UI-StCAD-UI' }
Rectangle >> quadrupleToContain: aRectangle [ 
	"Quadruple, if necessary, repeatedly, to contain aRectangle."

	| selfCenter rectCenter |
	(self contains: aRectangle)
		ifFalse: 
			[selfCenter := self center.
			rectCenter := aRectangle center.
			rectCenter x <= selfCenter x
				ifTrue: [rectCenter y <= selfCenter y
						ifTrue: [self enlargeUpperLeft]
						ifFalse: [self enlargeLowerLeft]]
				ifFalse: [rectCenter y <= selfCenter y
						ifTrue: [self enlargeUpperRight]
						ifFalse: [self enlargeLowerRight]].
			self quadrupleToContain: aRectangle]
]
