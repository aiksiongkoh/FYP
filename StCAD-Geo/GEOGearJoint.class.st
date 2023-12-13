Class {
	#name : #GEOGearJoint,
	#superclass : #GEOJoint,
	#instVars : [
		'radiusI',
		'radiusJ',
		'aConstant'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOGearJoint class >> mbdClass [
	^MbDGearJoint
]

{ #category : #accessing }
GEOGearJoint class >> nameString [
	^'GearJoint'
]

{ #category : #'VisualWorks metadata' }
GEOGearJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOGearJoint >> aConstant [
	^aConstant
]

{ #category : #accessing }
GEOGearJoint >> aConstant: anObject [
	aConstant := anObject
]

{ #category : #DYN }
GEOGearJoint >> createMbD [
	| mbdGearJoint |
	super createMbD.
	mbdGearJoint := self mbdObject.
	mbdGearJoint radiusI: radiusI / self mbdUnits length.
	mbdGearJoint radiusJ: radiusJ / self mbdUnits length.
	mbdGearJoint aConstant: aConstant
]

{ #category : #testing }
GEOGearJoint >> driveCADSMTest: aCADSMTest [ 
	| aJoint |
	aJoint := super driveCADSMTest: aCADSMTest.
	self halt.
	^aJoint
]

{ #category : #COM }
GEOGearJoint >> driveCOMJoint: aJointCtrl [ 
	super driveCOMJoint: aJointCtrl.
	aJointCtrl aConstant: aConstant.
	aJointCtrl aRadiusI: radiusI.
	aJointCtrl aRadiusJ: radiusJ
]

{ #category : #'initialize-release' }
GEOGearJoint >> initialize [
	super initialize.
	aConstant := nil
]

{ #category : #accessing }
GEOGearJoint >> radiusI [
	^radiusI
]

{ #category : #accessing }
GEOGearJoint >> radiusI: anObject [
	radiusI := anObject
]

{ #category : #accessing }
GEOGearJoint >> radiusJ [
	^radiusJ
]

{ #category : #accessing }
GEOGearJoint >> radiusJ: anObject [
	radiusJ := anObject
]

{ #category : #printing }
GEOGearJoint >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	aStream
		storeLevel: level + 1
			title: 'radiusI'
			object: radiusI;
		storeLevel: level + 1
			title: 'radiusJ'
			object: radiusJ
]
