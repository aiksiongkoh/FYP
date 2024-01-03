Class {
	#name : #GEOWEVertex,
	#superclass : #GEOSolidModelingItem,
	#instVars : [
		'point',
		'edge'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOWEVertex >> aPoint [
	^point
]

{ #category : #accessing }
GEOWEVertex >> edge [
	^edge
]

{ #category : #accessing }
GEOWEVertex >> edge: wingedEdge [ 
	edge := wingedEdge
]

{ #category : #accessing }
GEOWEVertex >> magnifySelf: aDouble [ 
	self aPoint magnifySelf: aDouble
]

{ #category : #accessing }
GEOWEVertex >> point [
	^point
]

{ #category : #accessing }
GEOWEVertex >> point: col [ 
	point := col
]

{ #category : #copying }
GEOWEVertex >> postCopy [
	"edge is updated in GEOSolidModel>postCopy."

	super postCopy.
	point := point copy
]
