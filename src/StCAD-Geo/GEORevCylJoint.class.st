Class {
	#name : #GEORevCylJoint,
	#superclass : #GEOJoint,
	#instVars : [
		'distanceIJ'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEORevCylJoint class >> mbdClass [
	^MbDRevCylJoint
]

{ #category : #accessing }
GEORevCylJoint class >> nameString [
	^'RevCylJoint'
]

{ #category : #'VisualWorks metadata' }
GEORevCylJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #DYN }
GEORevCylJoint >> createMbD [
	| mbdRevCylJoint |
	super createMbD.
	mbdRevCylJoint := self mbdObject.
	mbdRevCylJoint distanceIJ: distanceIJ / self mbdUnits length
]

{ #category : #accessing }
GEORevCylJoint >> distanceIJ [
	^distanceIJ
]

{ #category : #accessing }
GEORevCylJoint >> distanceIJ: anObject [
	distanceIJ := anObject
]

{ #category : #'ops on self' }
GEORevCylJoint >> magnifySelf: aDouble [ 
	distanceIJ := distanceIJ * aDouble
]

{ #category : #printing }
GEORevCylJoint >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	aStream
		storeLevel: level + 1
		title: 'distanceIJ'
		object: distanceIJ
]
