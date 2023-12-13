Class {
	#name : #SphSphJoint,
	#superclass : #Joint,
	#instVars : [
		'distanceIJ'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #accessing }
SphSphJoint class >> mbdClass [
	^MbDSphSphJoint
]

{ #category : #accessing }
SphSphJoint class >> nameString [
	^'SphSphJoint'
]

{ #category : #'VisualWorks metadata' }
SphSphJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
SphSphJoint >> distanceIJ [
	^distanceIJ
]

{ #category : #accessing }
SphSphJoint >> distanceIJ: anObject [
	distanceIJ := anObject
]

{ #category : #printing }
SphSphJoint >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	aStream 
		storeLevel: level + 1
		title: 'distanceIJ'
		object: distanceIJ
]
