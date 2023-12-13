Class {
	#name : #RackPinJoint,
	#superclass : #Joint,
	#instVars : [
		'pitchRadius'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #accessing }
RackPinJoint class >> mbdClass [
	^MbDRackPinJoint
]

{ #category : #accessing }
RackPinJoint class >> nameString [
	^'RackPinionJoint'
]

{ #category : #'VisualWorks metadata' }
RackPinJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #DYN }
RackPinJoint >> createMbD [
	| mbdRackPinJoint |
	super createMbD.
	mbdRackPinJoint := self mbdObject.
	mbdRackPinJoint pitchRadius: pitchRadius / self mbdUnits length
]

{ #category : #accessing }
RackPinJoint >> pitchRadius [
	^pitchRadius
]

{ #category : #accessing }
RackPinJoint >> pitchRadius: double [ 
	pitchRadius := double
]

{ #category : #printing }
RackPinJoint >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	aStream
		storeLevel: level + 1
		title: 'pitchRadius'
		object: pitchRadius
]
