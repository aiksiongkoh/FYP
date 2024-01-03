Class {
	#name : #GEOParallelGearJoint,
	#superclass : #GEOJoint,
	#instVars : [
		'ratio',
		'aConstant'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOParallelGearJoint >> aConstant [
	^aConstant
]

{ #category : #accessing }
GEOParallelGearJoint >> aConstant: anObject [
	aConstant := anObject
]

{ #category : #DYN }
GEOParallelGearJoint >> createMbD [
	| mbdParallelGearJoint |
	super createMbD.
	mbdParallelGearJoint := self mbdObject.
	mbdParallelGearJoint ratio: ratio.
	mbdParallelGearJoint aConstant: aConstant
]

{ #category : #accessing }
GEOParallelGearJoint >> ratio [
	^ratio
]

{ #category : #accessing }
GEOParallelGearJoint >> ratio: anObject [
	ratio := anObject
]

{ #category : #printing }
GEOParallelGearJoint >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	aStream
		storeLevel: level + 1
		title: 'ratio'
		object: ratio
]
