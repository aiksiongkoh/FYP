Class {
	#name : #MbDGearJoint,
	#superclass : #MbDJoint,
	#instVars : [
		'radiusI',
		'radiusJ',
		'aConstant'
	],
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #'VisualWorks metadata' }
MbDGearJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDGearJoint >> aConstant [
	^aConstant
]

{ #category : #accessing }
MbDGearJoint >> aConstant: anObject [
	aConstant := anObject
]

{ #category : #accessing }
MbDGearJoint >> classString [
	"Used to access the descriptive name of the joint."

	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Gear Joint '
]

{ #category : #'initialize-release' }
MbDGearJoint >> initializeGlobally [
	| constraint |
	constraints isEmpty 
		ifTrue: 
			[constraint := MbDGearConstraintIJ withFrmI: frmI frmJ: frmJ.
			constraint radiusI: radiusI.
			constraint radiusJ: radiusJ.
			constraint aConstant: aConstant.
			self owns: constraint.
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]

{ #category : #accessing }
MbDGearJoint >> radiusI [
	^radiusI
]

{ #category : #accessing }
MbDGearJoint >> radiusI: anObject [
	radiusI := anObject
]

{ #category : #accessing }
MbDGearJoint >> radiusJ [
	^radiusJ
]

{ #category : #accessing }
MbDGearJoint >> radiusJ: anObject [
	radiusJ := anObject
]
