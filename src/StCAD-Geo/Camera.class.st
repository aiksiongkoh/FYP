"


Instance Variables:
	cLighting	<Collection of Lightings>	These lightings are defined relative to the camera.
	distance	<aNumber>	Distance from lens to point of focus or eyepoint to sightpoint.
	far	<Object>	description of far
	height	<Object>	description of height
	lineSmoothBoolean	<Object>	description of lineSmoothBoolean
	near	<Object>	description of near
	polygonSmoothBoolean	<Object>	description of polygonSmoothBoolean
	presentation	<Object>	description of presentation
	shading	<Object>	description of shading
	viewFactor	<Object>	description of viewFactor


"
Class {
	#name : #Camera,
	#superclass : #SpatialItem,
	#instVars : [
		'left',
		'right',
		'top',
		'bottom',
		'near',
		'far',
		'shading',
		'presentation',
		'lineSmoothBoolean',
		'polygonSmoothBoolean',
		'cLighting'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
Camera class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
Camera >> bottom [
	^bottom
]

{ #category : #accessing }
Camera >> bottom: anObject [
	bottom := anObject
]

{ #category : #calc }
Camera >> cItemWithBoundingBox [
	^(OrderedCollection new: cLighting size)
		addAll: cLighting;
		yourself
]

{ #category : #accessing }
Camera >> defaultDistance [
	^10.0d
]

{ #category : #accessing }
Camera >> defaultPresentation [
	^#solid
]

{ #category : #accessing }
Camera >> defaultShading [
	^#flatShading
]

{ #category : #accessing }
Camera >> defaultViewFactor [
	^10
]

{ #category : #accessing }
Camera >> distance [
]

{ #category : #accessing }
Camera >> eyePoint [
	^aRefFrame rOfO
]

{ #category : #accessing }
Camera >> eyePoint: eyePoint [ 
	| rFfF |
	rFfF := aRefFrame rFpFfromrOpO: eyePoint.
	aRefFrame rFfF: rFfF
]

{ #category : #accessing }
Camera >> far [
	^far
]

{ #category : #accessing }
Camera >> far: anObject [
	far := anObject
]

{ #category : #shading }
Camera >> flatShading [
	self shading: #flatShading
]

{ #category : #testing }
Camera >> isPerspective [
	^false
]

{ #category : #accessing }
Camera >> left [
	^left
]

{ #category : #accessing }
Camera >> left: anObject [
	left := anObject
]

{ #category : #accessing }
Camera >> lineSmooth [
	^lineSmoothBoolean = true
]

{ #category : #accessing }
Camera >> lineSmoothBoolean [
	^lineSmoothBoolean
]

{ #category : #accessing }
Camera >> lineSmoothBoolean: anObject [
	lineSmoothBoolean := anObject
]

{ #category : #accessing }
Camera >> near [
	^near
]

{ #category : #accessing }
Camera >> near: anObject [
	near := anObject
]

{ #category : #accessing }
Camera >> polygonSmooth [
	^polygonSmoothBoolean = true
]

{ #category : #accessing }
Camera >> polygonSmoothBoolean [
	^polygonSmoothBoolean
]

{ #category : #accessing }
Camera >> polygonSmoothBoolean: anObject [
	polygonSmoothBoolean := anObject
]

{ #category : #accessing }
Camera >> presentation [
	^presentation
]

{ #category : #accessing }
Camera >> presentation: anObject [
	presentation := anObject
]

{ #category : #projection }
Camera >> projectOn: aRenderingContext [ 
	presentation = #solidPresentation 
		ifTrue: [aRenderingContext solidPresentation].
	presentation = #wireframePresentation 
		ifTrue: [aRenderingContext wireframePresentation].
	presentation = #hiddenlinePresentation 
		ifTrue: [aRenderingContext hiddenlinePresentation].
	shading = #smoothShading ifTrue: [aRenderingContext smoothShading].
	shading = #flatShading ifTrue: [aRenderingContext flatShading].
	self lineSmooth 
		ifTrue: 
			[aRenderingContext lineSmoothNicest.
			aRenderingContext enableLineSmooth]
		ifFalse: [aRenderingContext disableLineSmooth].
	self polygonSmooth 
		ifTrue: 
			[aRenderingContext polygonSmoothFastest.
			aRenderingContext enablePolygonSmooth]
		ifFalse: [aRenderingContext disablePolygonSmooth]
]

{ #category : #accessing }
Camera >> ratio [
	"distance to height ratio."

	^10
]

{ #category : #accessing }
Camera >> removeSup [
	aSup ifNotNil: [:aaSup | aaSup removeCamera: self]
]

{ #category : #displaying }
Camera >> renderOn: aRenderingContext [ 
	"Do nothing."
]

{ #category : #accessing }
Camera >> right [
	^right
]

{ #category : #accessing }
Camera >> right: anObject [
	right := anObject
]

{ #category : #accessing }
Camera >> shading [
	^shading
]

{ #category : #accessing }
Camera >> shading: aSymbol [ 
	shading := aSymbol
]

{ #category : #shading }
Camera >> smoothShading [
	self shading: #smoothShading
]

{ #category : #accessing }
Camera >> top [
	^top
]

{ #category : #accessing }
Camera >> top: anObject [
	top := anObject
]

{ #category : #accessing }
Camera >> upVector [
	^aRefFrame aAOf column: 2
]
