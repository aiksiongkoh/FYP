Class {
	#name : #GEOSketchedFeature,
	#superclass : #GEOFeature,
	#instVars : [
		'sketch'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOSketchedFeature >> asTreeNode [
	| answer |
	answer := super asTreeNode.
	answer children add: sketch asTreeNode.
	^answer
]

{ #category : #testing }
GEOSketchedFeature >> hasSketch [
	^true
]

{ #category : #copying }
GEOSketchedFeature >> postCopy [
	super postCopy.
	self sketch: sketch copy
]

{ #category : #copying }
GEOSketchedFeature >> preSave [
	super preSave.
	sketch preSave
]

{ #category : #accessing }
GEOSketchedFeature >> refFrame [
	^sketch refFrame
]

{ #category : #accessing }
GEOSketchedFeature >> refFrame: aFrame [ 
	sketch refFrame: aFrame
]

{ #category : #'initialize-release' }
GEOSketchedFeature >> release [
	sketch release.
	super release
]

{ #category : #'initialize-release' }
GEOSketchedFeature >> removeGEO: aGEO [ 
	sketch removeGEO: aGEO
]

{ #category : #rendering }
GEOSketchedFeature >> renderOn: aRenderingContext [ 
	sketch renderOn: aRenderingContext
]

{ #category : #accessing }
GEOSketchedFeature >> sketch [
	^sketch
]

{ #category : #accessing }
GEOSketchedFeature >> sketch: aSketch [ 
	sketch := aSketch.
	sketch container: self
]

{ #category : #accessing }
GEOSketchedFeature >> sketchList: collection [ 
	collection add: sketch
]
