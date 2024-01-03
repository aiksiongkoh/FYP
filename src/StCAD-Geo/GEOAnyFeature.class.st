Class {
	#name : #GEOAnyFeature,
	#superclass : #GEOContainedItem,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #ops }
GEOAnyFeature >> becomeDormantFeature [
	| newSelf |
	newSelf := GEODormantFeature new.
	self become: newSelf.
	self feature: newSelf
]

{ #category : #ops }
GEOAnyFeature >> buildIn: solidModel [ 
	self subclassResponsibility
]

{ #category : #testing }
GEOAnyFeature >> hasSketch [
	^false
]

{ #category : #testing }
GEOAnyFeature >> isDone [
	^container isDone
]
