Class {
	#name : #MbDRackPinJoint,
	#superclass : #MbDJoint,
	#instVars : [
		'pitchRadius',
		'aConstant'
	],
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #'VisualWorks metadata' }
MbDRackPinJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDRackPinJoint >> aConstant [
	^aConstant
]

{ #category : #accessing }
MbDRackPinJoint >> aConstant: anObject [
	aConstant := anObject
]

{ #category : #calc }
MbDRackPinJoint >> aTX [
	"aTX is torque on ADAMS marker I."

	^self jointTorqueJ
]

{ #category : #accessing }
MbDRackPinJoint >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Rack and Pinion Joint '
]

{ #category : #'initialize-release' }
MbDRackPinJoint >> connectsI: mkrII toJ: mkrJJ [ 
	"OODS J is on pinion. z axis is axis of pinion."
	"OODS I is on rack. x axis is axis of rack. z axis is parallel to axis of pinion."
	"Subsequent prescribed motions may make endFrameI , J become prescribed end frames."
	"Use newCopyEndFrameqc to prevent efrms from becoming EndFrameqct."

	frmI := mkrII newCopyEndFrameqc.
	frmJ := mkrJJ newCopyEndFrameqc
]

{ #category : #'initialize-release' }
MbDRackPinJoint >> initializeGlobally [
	| constraint |
	constraints isEmpty 
		ifTrue: 
			[constraint := MbDRackPinConstraintIJ withFrmI: frmI frmJ: frmJ.
			constraint pitchRadius: pitchRadius.
			constraint aConstant: aConstant.
			self owns: constraint.
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]

{ #category : #accessing }
MbDRackPinJoint >> pitchRadius: double [ 
	pitchRadius := double
]
