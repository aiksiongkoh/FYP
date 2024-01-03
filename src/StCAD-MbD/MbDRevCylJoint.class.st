Class {
	#name : #MbDRevCylJoint,
	#superclass : #MbDJoint,
	#instVars : [
		'distanceIJ'
	],
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #accessing }
MbDRevCylJoint >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Revolute-Cyllindrical Joint '
]

{ #category : #accessing }
MbDRevCylJoint >> distanceIJ: double [ 
	distanceIJ := double
]

{ #category : #'initialize-release' }
MbDRevCylJoint >> initializeGlobally [
	| constraint |
	constraints isEmpty 
		ifTrue: 
			[constraint := MbDDistancexyConstraintIJ withFrmI: frmI frmJ: frmJ.
			constraint aConstant: distanceIJ.
			self owns: constraint.
			self owns: (MbDDirectionCosineConstraintIJ 
						withFrmI: frmI
						frmJ: frmJ
						axisI: 3
						axisJ: 1).
			self owns: (MbDDirectionCosineConstraintIJ 
						withFrmI: frmI
						frmJ: frmJ
						axisI: 3
						axisJ: 2).
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]
