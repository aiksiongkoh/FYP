Class {
	#name : #GEOCylSphJoint,
	#superclass : #GEOJoint,
	#instVars : [
		'distanceIJ'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOCylSphJoint class >> mbdClass [
	^MbDCylSphJoint
]

{ #category : #accessing }
GEOCylSphJoint class >> nameString [
	^'CylSphJoint'
]

{ #category : #'VisualWorks metadata' }
GEOCylSphJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #DYN }
GEOCylSphJoint >> createMbD [
	| mbdCylSphJoint |
	super createMbD.
	mbdCylSphJoint := self mbdObject.
	mbdCylSphJoint distanceIJ: distanceIJ / self mbdUnits length
]

{ #category : #accessing }
GEOCylSphJoint >> distanceIJ [
	^distanceIJ
]

{ #category : #accessing }
GEOCylSphJoint >> distanceIJ: anObject [
	distanceIJ := anObject
]

{ #category : #'ops on self' }
GEOCylSphJoint >> magnifySelf: aDouble [ 
	distanceIJ := distanceIJ * aDouble
]

{ #category : #printing }
GEOCylSphJoint >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	aStream 
		storeLevel: level + 1
		title: 'distanceIJ'
		object: distanceIJ
]
