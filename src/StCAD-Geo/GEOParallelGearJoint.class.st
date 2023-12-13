Class {
	#name : #GEOParallelGearJoint,
	#superclass : #GEOJoint,
	#instVars : [
		'ratio',
		'aConstant'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'binary storage' }
GEOParallelGearJoint class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [
	"Change 
	StCAD.Geo.GEOParallelGearJoint 
	('eventTable' 'container' 'constraints' 'markerI' 'markerJ' 'ratio') 
	to 
	StCAD.Geo.GEOParallelGearJoint 
	('eventTable' 'container' 'constraints' 'markerI' 'markerJ' 'ratio' aConstant)"
	oldVersion == nil
		ifTrue: 
			[| inst |
			inst := self basicNew.
			^
			[:oldObj |
			| new |
			new := Array new: 7.
			new
				replaceFrom: 1
				to: 6
				with: oldObj
				startingAt: 1.
			oldObj become: new.
			oldObj changeClassToThatOf: inst.
			oldObj aConstant: 0.0d.
			oldObj]].
	^super binaryReaderBlockForVersion: oldVersion format: oldFormat
]

{ #category : #'binary storage' }
GEOParallelGearJoint class >> binaryRepresentationVersion [
	^40
]

{ #category : #accessing }
GEOParallelGearJoint class >> mbdClass [
	^MbDParallelGearJoint
]

{ #category : #accessing }
GEOParallelGearJoint class >> nameString [
	^'ParallelGearJoint'
]

{ #category : #'VisualWorks metadata' }
GEOParallelGearJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

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
