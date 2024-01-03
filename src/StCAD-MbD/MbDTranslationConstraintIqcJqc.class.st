Class {
	#name : #MbDTranslationConstraintIqcJqc,
	#superclass : #MbDTranslationConstraintIqcJc,
	#instVars : [
		'pGpXJ',
		'pGpEJ',
		'ppGpEIpXJ',
		'ppGpEIpEJ',
		'ppGpEJpEJ',
		'iqXJ',
		'iqEJ'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #accessing }
MbDTranslationConstraintIqcJqc >> addToJointForceJ: col [ 
	col equalSelfPlusFullColumn: pGpXJ times: lam
]

{ #category : #accessing }
MbDTranslationConstraintIqcJqc >> addToJointTorqueJ: col [ 
	| cForceT rJpJeJp pAOJppEJ aBOJp fpAOJppEJrJpJeJp dum lampGpE c2Torque |
	cForceT := pGpXJ times: lam.
	rJpJeJp := frmJ rpep.
	pAOJppEJ := frmJ pAOppE.
	aBOJp := frmJ aBOp.
	fpAOJppEJrJpJeJp := (FullColumn zero: 4).
	1 to: 4 do:  [:i | 
			dum := cForceT timesFullColumn: ((pAOJppEJ at: i) timesFullColumn: rJpJeJp).
			fpAOJppEJrJpJeJp at: i put: dum].
	lampGpE := pGpEJ transpose times: lam.
	c2Torque := aBOJp timesFullColumn: lampGpE - fpAOJppEJrJpJeJp.
	col equalSelfPlusFullColumn: c2Torque times: 0.5d
]

{ #category : #accessing }
MbDTranslationConstraintIqcJqc >> addpTIeiGOpEJto: mat [ 
	"ppGpXIpEJ := zero. 
	term2 := zero."

	| aB term1 pTIeiGOpEJ |
	aB := frmI aBOp.
	term1 := ppGpEIpEJ times: lam / 2.0d.
	pTIeiGOpEJ := aB timesFullMatrix: term1.
	mat equalSelfPlusFullMatrix: pTIeiGOpEJ
]

{ #category : #accessing }
MbDTranslationConstraintIqcJqc >> addpTIeiGOpXJto: mat [ 
	"ppGpXIpXJ := zero. 
	term2 := zero."

	| aB term1 pTIeiGOpXJ |
	aB := frmI aBOp.
	term1 := ppGpEIpXJ times: lam / 2.0d.
	pTIeiGOpXJ := aB timesFullMatrix: term1.
	mat equalSelfPlusFullMatrix: pTIeiGOpXJ
]

{ #category : #calc }
MbDTranslationConstraintIqcJqc >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	pGpXJ := riIeJeIe pvaluepXJ.
	pGpEJ := riIeJeIe pvaluepEJ.
	ppGpEIpXJ := riIeJeIe ppvaluepXJpEK transpose.
	ppGpEIpEJ := riIeJeIe ppvaluepEJpEK transpose.
	ppGpEJpEJ := riIeJeIe ppvaluepEJpEJ
]

{ #category : #accessing }
MbDTranslationConstraintIqcJqc >> dispCompClass [
	^MbDDispCompIeqcJeqcKeqc
]

{ #category : #accIC }
MbDTranslationConstraintIqcJqc >> fillAccICIterError: col [ 
	| qEdotI qXdotJ qEdotJ sum |
	super fillAccICIterError: col.
	col at: iqXJ plusFullColumn: pGpXJ times: lam.
	col at: iqEJ plusFullColumn: pGpEJ times: lam.
	qEdotI := frmI qEdot.
	qXdotJ := frmJ qXdot.
	qEdotJ := frmJ qEdot.
	sum := 0.0d.
	sum := sum + (pGpXJ timesFullColumn: frmJ qXddot).
	sum := sum + (pGpEJ timesFullColumn: frmJ qEddot).
	sum := sum + (2.0d * (qEdotI transposeTimesFullColumn: (ppGpEIpXJ timesFullColumn: qXdotJ))).
	sum := sum + (2.0d * (qEdotI transposeTimesFullColumn: (ppGpEIpEJ timesFullColumn: qEdotJ))).
	sum := sum + (qEdotJ transposeTimesFullColumn: (ppGpEJpEJ timesFullColumn: qEdotJ)).
	col at: iG plusNumber: sum
]

{ #category : #collision }
MbDTranslationConstraintIqcJqc >> fillCollisionError: col [ 
	"lamDeriv is now PlamDeriv."
	"qEddot is now qEdotDeriv."

	| sum |
	super fillCollisionError: col.
	col at: iqXJ plusFullColumn: pGpXJ times: lamDeriv.
	col at: iqEJ plusFullColumn: pGpEJ times: lamDeriv.
	sum := 0.0d.
	sum := sum + (pGpXJ timesFullColumn: frmJ qXddot).
	sum := sum + (pGpEJ timesFullColumn: frmJ qEddot).
	col at: iG plusNumber: sum
]

{ #category : #posIC }
MbDTranslationConstraintIqcJqc >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: iqXJ plusFullColumn: pGpXJ times: lam.
	col at: iqEJ plusFullColumn: pGpEJ times: lam
]

{ #category : #posIC }
MbDTranslationConstraintIqcJqc >> fillPosICJacob: mat [ 
	| ppGpEIpXJlam ppGpEIpEJlam |
	super fillPosICJacob: mat.
	mat at: iG and: iqXJ plusFullRow: pGpXJ.
	mat at: iqXJ and: iG plusFullColumn: pGpXJ transpose.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose.
	mat at: iqEI and: iqXJ plusFullMatrix: (ppGpEIpXJlam := ppGpEIpXJ times: lam).
	mat at: iqXJ and: iqEI plusTransposeFullMatrix: ppGpEIpXJlam.
	mat at: iqEI and: iqEJ plusFullMatrix: (ppGpEIpEJlam := ppGpEIpEJ times: lam).
	mat at: iqEJ and: iqEI plusTransposeFullMatrix: ppGpEIpEJlam.
	mat at: iqEJ and: iqEJ plusFullMatrix: ppGpEJpEJ times: lam
]

{ #category : #posIC }
MbDTranslationConstraintIqcJqc >> fillPosKineJacob: mat [ 
	super fillPosKineJacob: mat.
	mat
		at: iG
		and: iqXJ
		plusFullRow: pGpXJ.
	mat
		at: iG
		and: iqEJ
		plusFullRow: pGpEJ
]

{ #category : #velIC }
MbDTranslationConstraintIqcJqc >> fillVelICJacob: mat [ 
	super fillVelICJacob: mat.
	mat at: iG and: iqXJ plusFullRow: pGpXJ.
	mat at: iqXJ and: iG plusFullColumn: pGpXJ transpose.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose
]

{ #category : #dynamic }
MbDTranslationConstraintIqcJqc >> fillpFpy: mat [ 
	| ppGpEIpXJlam ppGpEIpEJlam |
	super fillpFpy: mat.
	mat at: iG and: iqXJ plusFullRow: pGpXJ.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqEI and: iqXJ plusFullMatrix: (ppGpEIpXJlam := ppGpEIpXJ times: lam).
	mat at: iqXJ and: iqEI plusTransposeFullMatrix: ppGpEIpXJlam.
	mat at: iqEI and: iqEJ plusFullMatrix: (ppGpEIpEJlam := ppGpEIpEJ times: lam).
	mat at: iqEJ and: iqEI plusTransposeFullMatrix: ppGpEIpEJlam.
	mat at: iqEJ and: iqEJ plusFullMatrix: ppGpEJpEJ times: lam
]

{ #category : #dynamic }
MbDTranslationConstraintIqcJqc >> fillpFpydot: mat [ 
	super fillpFpydot: mat.
	mat at: iqXJ and: iG plusFullColumn: pGpXJ transpose.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose
]

{ #category : #'initialize-release' }
MbDTranslationConstraintIqcJqc >> useEquationNumbers [
	super useEquationNumbers.
	iqXJ := frmJ iqX.
	iqEJ := frmJ iqE
]
