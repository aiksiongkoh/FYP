Class {
	#name : #MbDAtPointConstraintIqcJqc,
	#superclass : #MbDAtPointConstraintIqcJc,
	#instVars : [
		'pGpEJ',
		'ppGpEJpEJ',
		'iqXJminusOnePlusAxis',
		'iqEJ'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #accessing }
MbDAtPointConstraintIqcJqc >> addToJointForceJ: col [ 
	col at: axis plusNumber: lam
]

{ #category : #accessing }
MbDAtPointConstraintIqcJqc >> addToJointTorqueJ: col [ 
	| cForceT rJpJeJp pAOJppEJ aBOJp fpAOJppEJrJpJeJp dum lampGpE c2Torque |
	cForceT := (FullRow zero: 3).
	cForceT at: axis put: lam.
	rJpJeJp := frmJ rpep.
	pAOJppEJ := frmJ pAOppE.
	aBOJp := frmJ aBOp.
	fpAOJppEJrJpJeJp := (FullColumn zero: 4).
	1 to: 4 do: [:i | 
			dum := cForceT timesFullColumn: ((pAOJppEJ at: i) timesFullColumn: rJpJeJp).
			fpAOJppEJrJpJeJp at: i put: dum].
	lampGpE := pGpEJ transpose times: lam.
	c2Torque := aBOJp timesFullColumn: lampGpE - fpAOJppEJrJpJeJp.
	col equalSelfPlusFullColumn: c2Torque times: 0.5d
]

{ #category : #accessing }
MbDAtPointConstraintIqcJqc >> addpTIeiGOpEJto: mat [ 
	"ppGpXIpEJ := zero."
	"ppGpEIpEJ := zero."
	"term2 := zero."
	"Do nothing."
]

{ #category : #calc }
MbDAtPointConstraintIqcJqc >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	pGpEJ := riIeJeO priIeJeOpEJ
]

{ #category : #accessing }
MbDAtPointConstraintIqcJqc >> dispCompClass [
	^MbDDispCompIeqcJeqcO
]

{ #category : #accIC }
MbDAtPointConstraintIqcJqc >> fillAccICIterError: col [ 
	| qEdotJ sum |
	super fillAccICIterError: col.
	col at: iqXJminusOnePlusAxis plusNumber: lam.
	col at: iqEJ plusFullColumn: pGpEJ times: lam.
	qEdotJ := frmJ qEdot.
	sum := 0.0d.
	sum := sum + (frmJ qXddot at: axis).
	sum := sum + (pGpEJ timesFullColumn: frmJ qEddot).
	sum := sum + (qEdotJ transposeTimesFullColumn: (ppGpEJpEJ timesFullColumn: qEdotJ)).
	col at: iG plusNumber: sum
]

{ #category : #collision }
MbDAtPointConstraintIqcJqc >> fillCollisionError: col [ 
	"lamDeriv is now PlamDeriv."
	"qEddot is now qEdotDeriv."

	| sum |
	super fillCollisionError: col.
	col at: iqXJminusOnePlusAxis plusNumber: lamDeriv.
	col at: iqEJ plusFullColumn: pGpEJ times: lamDeriv.
	sum := 0.0d.
	sum := sum + (frmJ qXddot at: axis).
	sum := sum + (pGpEJ timesFullColumn: frmJ qEddot).
	col at: iG plusNumber: sum
]

{ #category : #posIC }
MbDAtPointConstraintIqcJqc >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: iqXJminusOnePlusAxis plusNumber: lam.
	col at: iqEJ plusFullColumn: pGpEJ times: lam
]

{ #category : #posIC }
MbDAtPointConstraintIqcJqc >> fillPosICJacob: mat [ 
	super fillPosICJacob: mat.
	mat at: iG and: iqXJminusOnePlusAxis plusNumber: 1.0d.
	mat at: iqXJminusOnePlusAxis and: iG plusNumber: 1.0d.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose.
	mat at: iqEJ and: iqEJ plusFullMatrix: ppGpEJpEJ times: lam
]

{ #category : #posIC }
MbDAtPointConstraintIqcJqc >> fillPosKineJacob: mat [ 
	super fillPosKineJacob: mat.
	mat at: iG and: iqXJminusOnePlusAxis plusNumber: 1.0d.
	mat at: iG and: iqEJ plusFullRow: pGpEJ
]

{ #category : #velIC }
MbDAtPointConstraintIqcJqc >> fillVelICJacob: mat [ 
	super fillVelICJacob: mat.
	mat at: iG and: iqXJminusOnePlusAxis plusNumber: 1.0d.
	mat at: iqXJminusOnePlusAxis and: iG plusNumber: 1.0d.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose
]

{ #category : #dynamic }
MbDAtPointConstraintIqcJqc >> fillpFpy: mat [ 
	super fillpFpy: mat.
	mat at: iG and: iqXJminusOnePlusAxis plusNumber: 1.0d.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqEJ and: iqEJ plusFullMatrix: ppGpEJpEJ times: lam
]

{ #category : #dynamic }
MbDAtPointConstraintIqcJqc >> fillpFpydot: mat [ 
	super fillpFpydot: mat.
	mat at: iqXJminusOnePlusAxis and: iG plusNumber: 1.0d.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose
]

{ #category : #'initialize-release' }
MbDAtPointConstraintIqcJqc >> initializeGlobally [
	super initializeGlobally.
	ppGpEJpEJ := riIeJeO ppriIeJeOpEJpEJ
]

{ #category : #'initialize-release' }
MbDAtPointConstraintIqcJqc >> useEquationNumbers [
	super useEquationNumbers.
	iqXJminusOnePlusAxis := frmJ iqX - 1 + axis.
	iqEJ := frmJ iqE
]
