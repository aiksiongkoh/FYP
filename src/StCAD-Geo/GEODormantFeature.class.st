Class {
	#name : #GEODormantFeature,
	#superclass : #GEOFeatureDecorator,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEODormantFeature >> becomeActive [
	| newSelf |
	newSelf := self feature.
	self become: newSelf
]

{ #category : #accessing }
GEODormantFeature >> feature [
	^feature
]
