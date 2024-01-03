"
CADSelections stores the selections made by the user. It can intelligently answer the desired item from the selections.

Instance Variables: *Indexed*

"
Class {
	#name : #GEOSelections,
	#superclass : #OrderedCollection,
	#type : #variable,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOSelections >> emptySelf [
	self setIndices
]

{ #category : #accessing }
GEOSelections >> sketch [
	^self detect: [:selection | selection sketch notNil]
		ifNone: nil
]

{ #category : #accessing }
GEOSelections >> soleSelection [
	self size == 1
		ifTrue: [^self first]
		ifFalse: [^nil]
]

{ #category : #accessing }
GEOSelections >> soleSelection: aGEO [ 
	self setIndices.
	self add: aGEO
]
