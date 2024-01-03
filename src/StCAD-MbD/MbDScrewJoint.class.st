Class {
	#name : #MbDScrewJoint,
	#superclass : #MbDJoint,
	#instVars : [
		'pitch',
		'aConstant'
	],
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #accessing }
MbDScrewJoint >> aConstant [
	^aConstant
]

{ #category : #accessing }
MbDScrewJoint >> aConstant: anObject [
	aConstant := anObject
]

{ #category : #calc }
MbDScrewJoint >> aTX [
	"aTX is torque on ADAMS marker I."

	^self jointTorqueJ
]

{ #category : #accessing }
MbDScrewJoint >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Screw Joint '
]

{ #category : #'initialize-release' }
MbDScrewJoint >> connectsI: mkrII toJ: mkrJJ [ 
	"Subsequent prescribed motions may make endFrameI , J become prescribed end frames."
	"Use newCopyEndFrameqc to prevent efrms from becoming EndFrameqct."

	frmI := mkrII newCopyEndFrameqc.
	frmJ := mkrJJ newCopyEndFrameqc
]

{ #category : #'initialize-release' }
MbDScrewJoint >> initializeGlobally [
	| constraint |
	constraints isEmpty 
		ifTrue: 
			[constraint := MbDScrewConstraintIJ withFrmI: frmI frmJ: frmJ.
			constraint pitch: pitch.
			constraint aConstant: aConstant.
			self owns: constraint.
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]

{ #category : #accessing }
MbDScrewJoint >> pitch: double [ 
	pitch := double
]
