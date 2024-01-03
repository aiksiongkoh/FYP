Class {
	#name : #GEOFeatureOrder,
	#superclass : #GEOAnyFeature,
	#instVars : [
		'features'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOFeatureOrder >> add: aFeature [ 
	aFeature container: self.
	aFeature refFrame refFrame: self refFrame.
	features add: aFeature
]

{ #category : #ops }
GEOFeatureOrder >> buildIn: solidModel [ 
	features do: [:feature | feature buildIn: solidModel]
]

{ #category : #accessing }
GEOFeatureOrder >> cFeature [
	^features
]

{ #category : #ops }
GEOFeatureOrder >> do: block [ 
	features do: block
]

{ #category : #accessing }
GEOFeatureOrder >> features [
	^features
]

{ #category : #'initialize-release' }
GEOFeatureOrder >> initialize [
	features := OrderedCollection new
]

{ #category : #testing }
GEOFeatureOrder >> isDone [
	^true
]

{ #category : #testing }
GEOFeatureOrder >> isEmpty [
	^features isEmpty
]

{ #category : #accessing }
GEOFeatureOrder >> magnifySelf: aDouble [ 
	self cFeature do: [:aFeature | aFeature magnifySelf: aDouble]
]

{ #category : #accessing }
GEOFeatureOrder >> part: part [ 
	container := part
]

{ #category : #copying }
GEOFeatureOrder >> postCopy [
	"Do not need super>postCopy because container is now valid."
	"container must be valid in order for self>add: to work properly."

	| originalFeatures |
	originalFeatures := features.
	features := originalFeatures class new.
	originalFeatures do: [:feature | self add: feature copy]
]

{ #category : #copying }
GEOFeatureOrder >> preSave [
	super preSave.
	features do: [:feature | feature preSave]
]

{ #category : #accessing }
GEOFeatureOrder >> refFrame [
	^container refFrame
]

{ #category : #'initialize-release' }
GEOFeatureOrder >> release [
	features do: [:feature | feature release].
	super release
]

{ #category : #'initialize-release' }
GEOFeatureOrder >> removeGEO: aGEO [ 
	features do: [:feature | feature removeGEO: aGEO]
]

{ #category : #accessing }
GEOFeatureOrder >> renderOn: aRenderingContext [ 
	features do: [:feature | feature renderOn: aRenderingContext]
]

{ #category : #accessing }
GEOFeatureOrder >> sketchList [
	^(features select: [:feature | feature hasSketch])
		asSortedCollection: [:a :b | a name <= b name]
]

{ #category : #accessing }
GEOFeatureOrder >> sketchList: collection [ 
	features do: [:feature | feature sketchList: collection]
]

{ #category : #printing }
GEOFeatureOrder >> storePOVOn: aStream level: level title: title [ 
	features 
		storePOVOn: aStream
		level: level
		title: title
]
