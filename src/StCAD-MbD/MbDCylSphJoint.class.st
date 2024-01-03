Class {
	#name : #MbDCylSphJoint,
	#superclass : #MbDJoint,
	#instVars : [
		'distanceIJ'
	],
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #accessing }
MbDCylSphJoint >> classString [
	"Used to access the descriptive name of the joint."

	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Cylindrical-Spherical Joint '
]

{ #category : #accessing }
MbDCylSphJoint >> distanceIJ: double [ 
	distanceIJ := double
]

{ #category : #'initialize-release' }
MbDCylSphJoint >> initializeGlobally [
	| constraint |
	constraints isEmpty 
		ifTrue: 
			[constraint := MbDDistancexyConstraintIJ withFrmI: frmI frmJ: frmJ.
			constraint aConstant: distanceIJ.
			self owns: constraint.
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]
