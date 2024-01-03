Class {
	#name : #GEOSphSphJoint,
	#superclass : #GEOJoint,
	#instVars : [
		'distanceIJ'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #DYN }
GEOSphSphJoint >> createMbD [
	| mbdSphSphJoint |
	super createMbD.
	mbdSphSphJoint := self mbdObject.
	mbdSphSphJoint distanceIJ: distanceIJ / self mbdUnits length
]

{ #category : #accessing }
GEOSphSphJoint >> distanceIJ [
	^distanceIJ
]

{ #category : #accessing }
GEOSphSphJoint >> distanceIJ: anObject [
	distanceIJ := anObject
]

{ #category : #'ops on self' }
GEOSphSphJoint >> magnifySelf: aDouble [ 
	distanceIJ := distanceIJ * aDouble
]

{ #category : #printing }
GEOSphSphJoint >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	aStream
		storeLevel: level + 1
		title: 'distanceIJ'
		object: distanceIJ
]
