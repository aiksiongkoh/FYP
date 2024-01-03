Class {
	#name : #GEOFeature,
	#superclass : #GEOAnyFeature,
	#instVars : [
		'isCut'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #become }
GEOFeature >> becomeFeature [
	^self
]

{ #category : #become }
GEOFeature >> becomeNotDoneFeature [
	| newSelf |
	newSelf := GEONotDoneFeature new.
	self become: newSelf.
	self feature: newSelf
]

{ #category : #accessing }
GEOFeature >> isCut: boolean [ 
	isCut := boolean
]
