Class {
	#name : #MbDPrescribedPathMotion,
	#superclass : #MbDJoint,
	#instVars : [
		'efrm',
		'pathDistBlks',
		'pathDistBlkt'
	],
	#category : #'StCAD-MbD-MbDMotion'
}

{ #category : #accessing }
MbDPrescribedPathMotion >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Prescribed Path Motion '
]

{ #category : #accessing }
MbDPrescribedPathMotion >> fillDispConstraints: collection [ 
	"Prescribed constraints are essential."
	"Do nothing."
]

{ #category : #accessing }
MbDPrescribedPathMotion >> fillEssenConstraints: collection [ 
	constraints do: [:con | con fillEssenConstraints: collection]
]

{ #category : #accessing }
MbDPrescribedPathMotion >> fillPerpenConstraints: collection [ 
	"Prescribed constraints are essential."
	"Do nothing."
]

{ #category : #'initialize-release' }
MbDPrescribedPathMotion >> initializeGlobally [
	constraints isEmpty
		ifTrue: 
			[self owns: ((MbDPathDistanceConstraint new) efrm: efrm; pathDistBlks: pathDistBlks; pathDistBlkt: pathDistBlkt).
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]

{ #category : #'initialize-release' }
MbDPrescribedPathMotion >> initializeLocally [
	efrm := frmI.
	super initializeLocally
]

{ #category : #accessing }
MbDPrescribedPathMotion >> pathDistBlks: block [ 
	pathDistBlks := block
]

{ #category : #accessing }
MbDPrescribedPathMotion >> pathDistBlkt: block [ 
	pathDistBlkt := block
]
