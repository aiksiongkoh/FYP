Class {
	#name : #MbDPathDistanceConstraint,
	#superclass : #MbDConstraint,
	#instVars : [
		'efrm',
		'pathDistBlks',
		'pathDistBlkt',
		'pGps',
		'ppGpsps',
		'is',
		'pGpt',
		'ppGptpt'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #accessing }
MbDPathDistanceConstraint >> addToJointForceI: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDPathDistanceConstraint >> addToJointForceJ: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDPathDistanceConstraint >> addToJointTorqueI: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDPathDistanceConstraint >> addToJointTorqueJ: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDPathDistanceConstraint >> addpFIeiGOplamto: mat [ 
	"pGpXI is zero."
	"Do nothing."
]

{ #category : #calc }
MbDPathDistanceConstraint >> calcPostDynCorrectorIteration [
	| s |
	s := efrm s at: 1.
	aG := (pathDistBlks y: s)
				- pathDistBlkt value.
	pGps := pathDistBlks dydx: s.
	ppGpsps := pathDistBlks d2ydx2: s
]

{ #category : #accessing }
MbDPathDistanceConstraint >> classString [
	"Used to access the descriptive name of the constraint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: one path distance constraint '
]

{ #category : #accessing }
MbDPathDistanceConstraint >> efrm: frm [ 
	efrm := frm
]

{ #category : #accIC }
MbDPathDistanceConstraint >> fillAccICIterError: col [ 
	| sdot sddot sum |
	col at: is plusNumber: pGps * lam.
	sdot := efrm sdot at: 1.
	sddot := efrm sddot at: 1.
	sum := 0.0d.
	sum := sum + (pGps * sddot).
	sum := sum + (sdot * ppGpsps * sdot).
	sum := sum + ppGptpt.
	col at: iG plusNumber: sum
]

{ #category : #posIC }
MbDPathDistanceConstraint >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: is plusNumber: pGps * lam
]

{ #category : #posIC }
MbDPathDistanceConstraint >> fillPosICJacob: mat [ 
	mat at: iG and: is plusNumber: pGps.
	mat at: is and: iG plusNumber: pGps.
	mat at: is and: is plusNumber: ppGpsps * lam
]

{ #category : #posIC }
MbDPathDistanceConstraint >> fillPosKineJacob: mat [ 
	mat
		at: iG
		and: is
		plusNumber: pGps
]

{ #category : #velIC }
MbDPathDistanceConstraint >> fillVelICError: col [ 
	col at: iG minusNumber: pGpt
]

{ #category : #velIC }
MbDPathDistanceConstraint >> fillVelICJacob: mat [ 
	mat at: iG and: is plusNumber: pGps.
	mat at: is and: iG plusNumber: pGps
]

{ #category : #dynamic }
MbDPathDistanceConstraint >> fillpFpy: mat [ 
	mat at: iG and: is plusNumber: pGps.
	mat at: is and: is plusNumber: ppGpsps * lam
]

{ #category : #dynamic }
MbDPathDistanceConstraint >> fillpFpydot: mat [ 
	mat at: is and: iG plusNumber: pGps
]

{ #category : #'initialize-release' }
MbDPathDistanceConstraint >> initializeGlobally [
	pathDistBlks initializeGlobally.
	pathDistBlkt initializeGlobally
]

{ #category : #'initialize-release' }
MbDPathDistanceConstraint >> initializeLocally [
	pathDistBlks initializeLocally.
	pathDistBlkt initializeLocally
]

{ #category : #accessing }
MbDPathDistanceConstraint >> pathDistBlks: block [ 
	pathDistBlks := block
]

{ #category : #accessing }
MbDPathDistanceConstraint >> pathDistBlkt: block [ 
	pathDistBlkt := block
]

{ #category : #accIC }
MbDPathDistanceConstraint >> preAccIC [
	| derivative secondDerivative mbdTime |
	super preAccIC.
	mbdTime := TheMbDSystem mbdTime.
	derivative := (pathDistBlkt differentiateWRT: mbdTime) simplified.
	secondDerivative := (derivative differentiateWRT: mbdTime) simplified.
	ppGptpt := secondDerivative value negated
]

{ #category : #velIC }
MbDPathDistanceConstraint >> preVelIC [
	| derivative mbdTime |
	super preVelIC.
	mbdTime := TheMbDSystem mbdTime.
	derivative := (pathDistBlkt differentiateWRT: mbdTime) simplified.
	pGpt := derivative value negated
]

{ #category : #'initialize-release' }
MbDPathDistanceConstraint >> useEquationNumbers [
	is := efrm is
]
