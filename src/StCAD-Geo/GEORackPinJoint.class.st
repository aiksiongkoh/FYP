Class {
	#name : #GEORackPinJoint,
	#superclass : #GEOJoint,
	#instVars : [
		'pitchRadius',
		'aConstant'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEORackPinJoint >> aConstant [
	^aConstant
]

{ #category : #accessing }
GEORackPinJoint >> aConstant: anObject [
	aConstant := anObject
]

{ #category : #DYN }
GEORackPinJoint >> createMbD [
	| mbdRackPinJoint |
	super createMbD.
	mbdRackPinJoint := self mbdObject.
	mbdRackPinJoint pitchRadius: pitchRadius / self mbdUnits length.
	mbdRackPinJoint aConstant: aConstant
]

{ #category : #'ops on self' }
GEORackPinJoint >> magnifySelf: aDouble [ 
	pitchRadius := pitchRadius * aDouble
]

{ #category : #accessing }
GEORackPinJoint >> pitchRadius [
	^pitchRadius
]

{ #category : #accessing }
GEORackPinJoint >> pitchRadius: double [ 
	pitchRadius := double
]

{ #category : #printing }
GEORackPinJoint >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	aStream
		storeLevel: level + 1
		title: 'pitchRadius'
		object: pitchRadius
]
