Class {
	#name : #GEOAngleJoint,
	#superclass : #GEOJoint,
	#instVars : [
		'theIzJz'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOAngleJoint class >> mbdClass [
	^MbDAngleJoint
]

{ #category : #accessing }
GEOAngleJoint class >> nameString [
	^'AngleJoint'
]

{ #category : #'VisualWorks metadata' }
GEOAngleJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #DYN }
GEOAngleJoint >> createMbD [
	| mbdScrewJoint |
	super createMbD.
	mbdScrewJoint := self mbdObject.
	mbdScrewJoint theIzJz: theIzJz
]

{ #category : #printing }
GEOAngleJoint >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	aStream
		storeLevel: level + 1
		title: 'theIzJz'
		object: theIzJz
]

{ #category : #accessing }
GEOAngleJoint >> theIzJz [
	^theIzJz
]

{ #category : #accessing }
GEOAngleJoint >> theIzJz: anObject [
	theIzJz := anObject
]
