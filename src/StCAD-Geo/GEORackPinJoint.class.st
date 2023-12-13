Class {
	#name : #GEORackPinJoint,
	#superclass : #GEOJoint,
	#instVars : [
		'pitchRadius',
		'aConstant'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'binary storage' }
GEORackPinJoint class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [
	"Change 
	StCAD.Geo.GEORackPinJoint 
	('eventTable' 'container' 'constraints' 'markerI' 'markerJ' 'pitchRadius') 
	to 
	StCAD.Geo.GEORackPinJoint 
	('eventTable' 'container' 'constraints' 'markerI' 'markerJ' 'pitchRadius' aConstant)"
	oldVersion == nil
		ifTrue: 
			[| inst |
			inst := GEORackPinJoint basicNew.
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
GEORackPinJoint class >> binaryRepresentationVersion [
	^40
]

{ #category : #accessing }
GEORackPinJoint class >> mbdClass [
	^MbDRackPinJoint
]

{ #category : #accessing }
GEORackPinJoint class >> nameString [
	^'RackPinionJoint'
]

{ #category : #'VisualWorks metadata' }
GEORackPinJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

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
