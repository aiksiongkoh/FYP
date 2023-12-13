Class {
	#name : #AngleJoint,
	#superclass : #Joint,
	#instVars : [
		'theIzJz'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #accessing }
AngleJoint class >> mbdClass [
	^MbDAngleJoint
]

{ #category : #accessing }
AngleJoint class >> nameString [
	^'AngleJoint'
]

{ #category : #'VisualWorks metadata' }
AngleJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #printing }
AngleJoint >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	aStream 
		storeLevel: level + 1
		title: 'theIzJz'
		object: theIzJz
]

{ #category : #accessing }
AngleJoint >> theIzJz [
	^theIzJz
]

{ #category : #accessing }
AngleJoint >> theIzJz: anObject [
	theIzJz := anObject
]
