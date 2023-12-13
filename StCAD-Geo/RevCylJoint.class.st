Class {
	#name : #RevCylJoint,
	#superclass : #Joint,
	#instVars : [
		'distanceIJ'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #accessing }
RevCylJoint class >> mbdClass [
	^MbDRevCylJoint
]

{ #category : #accessing }
RevCylJoint class >> nameString [
	^'RevCylJoint'
]

{ #category : #'VisualWorks metadata' }
RevCylJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
RevCylJoint >> distanceIJ [
	^distanceIJ
]

{ #category : #accessing }
RevCylJoint >> distanceIJ: anObject [
	distanceIJ := anObject
]

{ #category : #printing }
RevCylJoint >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	aStream 
		storeLevel: level + 1
		title: 'distanceIJ'
		object: distanceIJ
]
