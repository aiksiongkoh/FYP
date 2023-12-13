Class {
	#name : #ScrewJoint,
	#superclass : #Joint,
	#instVars : [
		'pitch'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #accessing }
ScrewJoint class >> mbdClass [
	^MbDScrewJoint
]

{ #category : #accessing }
ScrewJoint class >> nameString [
	^'ScrewJoint'
]

{ #category : #'VisualWorks metadata' }
ScrewJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #DYN }
ScrewJoint >> createMbD [
	| mbdScrewJoint |
	super createMbD.
	mbdScrewJoint := self mbdObject.
	mbdScrewJoint pitch: pitch / self mbdUnits length
]

{ #category : #accessing }
ScrewJoint >> pitch [
	^pitch
]

{ #category : #accessing }
ScrewJoint >> pitch: double [ 
	pitch := double
]

{ #category : #printing }
ScrewJoint >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	aStream
		storeLevel: level + 1
		title: 'pitch'
		object: pitch
]
