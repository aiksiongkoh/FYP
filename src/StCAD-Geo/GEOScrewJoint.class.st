Class {
	#name : #GEOScrewJoint,
	#superclass : #GEOJoint,
	#instVars : [
		'pitch',
		'aConstant'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOScrewJoint >> aConstant [
	^aConstant
]

{ #category : #accessing }
GEOScrewJoint >> aConstant: anObject [
	aConstant := anObject
]

{ #category : #DYN }
GEOScrewJoint >> createMbD [
	| mbdScrewJoint |
	super createMbD.
	mbdScrewJoint := self mbdObject.
	mbdScrewJoint pitch: pitch / self mbdUnits length.
	mbdScrewJoint aConstant: aConstant
]

{ #category : #'ops on self' }
GEOScrewJoint >> magnifySelf: aDouble [ 
	pitch := pitch * aDouble
]

{ #category : #accessing }
GEOScrewJoint >> pitch [
	^pitch
]

{ #category : #accessing }
GEOScrewJoint >> pitch: double [ 
	pitch := double
]

{ #category : #printing }
GEOScrewJoint >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	aStream
		storeLevel: level + 1
		title: 'pitch'
		object: pitch
]
