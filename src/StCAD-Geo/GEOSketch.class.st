Class {
	#name : #GEOSketch,
	#superclass : #GEOAnyGraphic,
	#instVars : [
		'graphics'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOSketch class >> nameString [
	^'Sketch'
]

{ #category : #'VisualWorks metadata' }
GEOSketch class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOSketch >> addGraphic: aGEOGraphic [ 
	aGEOGraphic container: self.
	aGEOGraphic refFrame refFrame: refFrame.
	graphics add: aGEOGraphic
]

{ #category : #accessing }
GEOSketch >> addGraphics: array [ 
	array do: [:graphic | self addGraphic: graphic]
]

{ #category : #accessing }
GEOSketch >> asPolylines [
	^graphics collect: [:graphic | graphic asPolyline]
]

{ #category : #accessing }
GEOSketch >> cGraphic [
	^graphics
]

{ #category : #accessing }
GEOSketch >> cutCurve: aGEOCurve [ 
	graphics remove: aGEOCurve
]

{ #category : #accessing }
GEOSketch >> cutGraphic: aGEOGraphic [ 
	graphics remove: aGEOGraphic
]

{ #category : #accessing }
GEOSketch >> graphics [
	^graphics
]

{ #category : #'initialize-release' }
GEOSketch >> initialize [

	super initialize.
	graphics := StCAD_Misc_OrderedSet new "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
]

{ #category : #testing }
GEOSketch >> isCutable [
	^false
]

{ #category : #testing }
GEOSketch >> isSketch [
	^true
]

{ #category : #accessing }
GEOSketch >> magnifySelf: aDouble [ 
	self aRefFrame magnifySelf: aDouble.
	self cGraphic do: [:aGraphic | aGraphic magnifySelf: aDouble]
]

{ #category : #copying }
GEOSketch >> postCopy [
	| originalGraphics |
	super postCopy.
	originalGraphics := graphics.
	graphics := originalGraphics class new.
	originalGraphics do: [:graphic | self addGraphic: graphic copy]
]

{ #category : #'initialize-release' }
GEOSketch >> preSave [
	super preSave.
	graphics do: [:graphic | graphic preSave]
]

{ #category : #'initialize-release' }
GEOSketch >> release [
	graphics do: [:graphic | graphic release].
	super release
]

{ #category : #'initialize-release' }
GEOSketch >> removeGEO: aGEO [ 
	graphics remove: aGEO
]

{ #category : #rendering }
GEOSketch >> renderOn: aRenderingContext [ 
	self interface activeSketch == self 
		ifTrue: 
			[aRenderingContext pushTransformation: refFrame aMFf
				while: [graphics do: [:graphic | graphic renderOn: aRenderingContext]]]
]

{ #category : #printing }
GEOSketch >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	aStream storeLevel: level + 1 title: 'Graphics'.
	self graphics do: [:item | item storeOn: aStream level: level + 2]
]
