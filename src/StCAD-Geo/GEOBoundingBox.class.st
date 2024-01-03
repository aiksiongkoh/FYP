"
This class is obselete. It is required to read *.asm created with freecad8 or CADSM1 or earlier versions.
"
Class {
	#name : #GEOBoundingBox,
	#superclass : #GEOItem,
	#instVars : [
		'minCorner',
		'maxCorner'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'initialize-release' }
GEOBoundingBox >> center [
	^minCorner + maxCorner / 2.0d
]

{ #category : #accessing }
GEOBoundingBox >> corner [
	^maxCorner
]

{ #category : #'initialize-release' }
GEOBoundingBox >> expandToBound: point [ 
	minCorner := minCorner min: point.
	maxCorner := maxCorner max: point
]

{ #category : #accessing }
GEOBoundingBox >> extent [
	^maxCorner - minCorner
]

{ #category : #'initialize-release' }
GEOBoundingBox >> initialize [
	minCorner := FullColumn new: 3.
	maxCorner := FullColumn new: 3
]

{ #category : #accessing }
GEOBoundingBox >> maxCorner [
	^maxCorner
]

{ #category : #accessing }
GEOBoundingBox >> minCorner [
	^minCorner
]

{ #category : #accessing }
GEOBoundingBox >> origin [
	^minCorner
]

{ #category : #copying }
GEOBoundingBox >> postCopy [
	minCorner := minCorner copy.
	maxCorner := maxCorner copy
]

{ #category : #printing }
GEOBoundingBox >> printOn: aStream [ 
	aStream print: self class.
	aStream nextPut: $(.
	aStream cr.
	aStream print: minCorner.
	aStream cr.
	aStream print: maxCorner.
	aStream cr.
	aStream nextPut: $)
]

{ #category : #'initialize-release' }
GEOBoundingBox >> zeroSelf [
	minCorner zeroSelf.
	maxCorner zeroSelf
]
