Class {
	#name : #GEOScrewJoint,
	#superclass : #GEOJoint,
	#instVars : [
		'pitch',
		'aConstant'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'binary storage' }
GEOScrewJoint class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [
	"Change 
	StCAD.Geo.GEOScrewJoint 
	('eventTable' 'container' 'constraints' 'markerI' 'markerJ' 'pitchRadius') 
	to 
	StCAD.Geo.GEOScrewJoint 
	('eventTable' 'container' 'constraints' 'markerI' 'markerJ' 'pitchRadius' aConstant)"

	oldVersion == nil
		ifTrue: 
			[| inst |
			inst := GEOScrewJoint basicNew.
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
GEOScrewJoint class >> binaryRepresentationVersion [
	^40
]

{ #category : #accessing }
GEOScrewJoint class >> mbdClass [
	^MbDScrewJoint
]

{ #category : #accessing }
GEOScrewJoint class >> nameString [
	^'ScrewJoint'
]

{ #category : #'VisualWorks metadata' }
GEOScrewJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

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
