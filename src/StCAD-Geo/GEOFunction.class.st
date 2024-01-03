Class {
	#name : #GEOFunction,
	#superclass : #CADFunction,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOFunction >> container [
	^container
]

{ #category : #accessing }
GEOFunction >> container: geoItem [ 
	container := geoItem
]

{ #category : #DYN }
GEOFunction >> createMbD [
	self subclassResponsibility
]

{ #category : #accessing }
GEOFunction >> geoTime [
	^container == nil
		ifTrue: [nil]
		ifFalse: [container geoTime]
]

{ #category : #accessing }
GEOFunction >> interface [
	container == nil ifTrue: [^nil].
	^container interface
]

{ #category : #accessing }
GEOFunction >> mbdUnits [
	^container == nil
		ifTrue: [nil]
		ifFalse: [container mbdUnits]
]
