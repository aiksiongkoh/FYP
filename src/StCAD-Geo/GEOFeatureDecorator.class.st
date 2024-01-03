Class {
	#name : #GEOFeatureDecorator,
	#superclass : #GEOAnyFeature,
	#instVars : [
		'feature'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOFeatureDecorator >> asTreeNode [
	| answer |
	answer := super asTreeNode.
	answer children add: feature asTreeNode.
	^answer
]

{ #category : #become }
GEOFeatureDecorator >> becomeFeature [
	| newSelf |
	newSelf := self feature.
	newSelf container: container.
	self become: newSelf
]

{ #category : #accessing }
GEOFeatureDecorator >> feature [
	^feature
]

{ #category : #accessing }
GEOFeatureDecorator >> feature: aFeature [ 
	aFeature container: self.
	feature := aFeature
]

{ #category : #testing }
GEOFeatureDecorator >> hasSketch [
	^feature hasSketch
]

{ #category : #copying }
GEOFeatureDecorator >> preSave [
	super preSave.
	feature preSave
]

{ #category : #accessing }
GEOFeatureDecorator >> refFrame [
	^feature refFrame
]

{ #category : #copying }
GEOFeatureDecorator >> release [
	feature release.
	super release
]

{ #category : #testing }
GEOFeatureDecorator >> sketch [
	^feature sketch
]

{ #category : #accessing }
GEOFeatureDecorator >> sketchList: collection [ 
	feature sketchList: collection
]
