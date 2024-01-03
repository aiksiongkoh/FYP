Class {
	#name : #MbDDistancexyConstraintIqcJqc,
	#superclass : #MbDDistancexyConstraintIqcJc,
	#instVars : [
		'pGpXJ',
		'pGpEJ',
		'ppGpXIpXJ',
		'ppGpEIpXJ',
		'ppGpXJpXJ',
		'ppGpXIpEJ',
		'ppGpEIpEJ',
		'ppGpXJpEJ',
		'ppGpEJpEJ',
		'iqXJ',
		'iqEJ'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #accessing }
MbDDistancexyConstraintIqcJqc >> addToJointForceJ: col [ 
	col equalSelfPlusFullColumn: pGpXJ times: lam
]

{ #category : #accessing }
MbDDistancexyConstraintIqcJqc >> addToJointTorqueJ: col [ 
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
MbDDistancexyConstraintIqcJqc >> addpFIeiGOpEJto: mat [ 
	mat equalSelfPlusFullMatrix: ppGpXIpEJ times: lam
]

{ #category : #accessing }
MbDDistancexyConstraintIqcJqc >> addpFIeiGOpXJto: mat [ 
	mat equalSelfPlusFullMatrix: ppGpXIpXJ times: lam
]

{ #category : #accessing }
MbDDistancexyConstraintIqcJqc >> addpTIeiGOpEJto: mat [ 
	| aB term1 prOIeOpEIT pFIeiGOpEJover2 term2 pTIeiGOpEJ |
	aB := frmI aBOp.
	term1 := ppGpEIpEJ times: lam / 2.0d.
	prOIeOpEIT := frmI prOeOpE transpose.
	pFIeiGOpEJover2 := ppGpXIpEJ times: lam / 2.0d.
	term2 := prOIeOpEIT timesFullMatrix: pFIeiGOpEJover2.
	pTIeiGOpEJ := aB timesFullMatrix: (term1 minusFullMatrix: term2).
	mat equalSelfPlusFullMatrix: pTIeiGOpEJ
]

{ #category : #accessing }
MbDDistancexyConstraintIqcJqc >> addpTIeiGOpXJto: mat [ 
	| aB term1 prOIeOpEIT pFIeiGOpXJover2 term2 pTIeiGOpXJ |
	aB := frmI aBOp.
	term1 := ppGpEIpXJ times: lam / 2.0d.
	prOIeOpEIT := frmI prOeOpE transpose.
	pFIeiGOpXJover2 := ppGpXIpXJ times: lam / 2.0d.
	term2 := prOIeOpEIT timesFullMatrix: pFIeiGOpXJover2.
	pTIeiGOpXJ := aB timesFullMatrix: (term1 minusFullMatrix: term2).
	mat equalSelfPlusFullMatrix: pTIeiGOpXJ
]

{ #category : #calc }
MbDDistancexyConstraintIqcJqc >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	self calc_pGpXJ.
	self calc_pGpEJ.
	self calc_ppGpXIpXJ.
	self calc_ppGpEIpXJ.
	self calc_ppGpXJpXJ.
	self calc_ppGpXIpEJ.
	self calc_ppGpEIpEJ.
	self calc_ppGpXJpEJ.
	self calc_ppGpEJpEJ
]

{ #category : #calc }
MbDDistancexyConstraintIqcJqc >> calc_pGpEJ [
	pGpEJ := (xIeJeIe pvaluepEJ times: xIeJeIe value) 
				+ (yIeJeIe pvaluepEJ times: yIeJeIe value) magnifySelf: 2.0d
]

{ #category : #calc }
MbDDistancexyConstraintIqcJqc >> calc_pGpXJ [
	pGpXJ := (xIeJeIe pvaluepXJ times: xIeJeIe value) 
				+ (yIeJeIe pvaluepXJ times: yIeJeIe value) magnifySelf: 2.0d
]

{ #category : #calc }
MbDDistancexyConstraintIqcJqc >> calc_ppGpEIpEJ [
	ppGpEIpEJ := (xIeJeIe pvaluepEI transposeTimesFullRow: xIeJeIe pvaluepEJ) 
				+ (xIeJeIe ppvaluepEIpEJ times: xIeJeIe value) 
					+ (yIeJeIe pvaluepEI transposeTimesFullRow: yIeJeIe pvaluepEJ) 
					+ (yIeJeIe ppvaluepEIpEJ times: yIeJeIe value) magnifySelf: 2.0d
]

{ #category : #calc }
MbDDistancexyConstraintIqcJqc >> calc_ppGpEIpXJ [
	ppGpEIpXJ := (xIeJeIe pvaluepEI transposeTimesFullRow: xIeJeIe pvaluepXJ) 
				+ (xIeJeIe ppvaluepEIpXJ times: xIeJeIe value) 
					+ (yIeJeIe pvaluepEI transposeTimesFullRow: yIeJeIe pvaluepXJ) 
					+ (yIeJeIe ppvaluepEIpXJ times: yIeJeIe value) magnifySelf: 2.0d
]

{ #category : #calc }
MbDDistancexyConstraintIqcJqc >> calc_ppGpEJpEJ [
	ppGpEJpEJ := (xIeJeIe pvaluepEJ transposeTimesFullRow: xIeJeIe pvaluepEJ) 
				+ (xIeJeIe ppvaluepEJpEJ times: xIeJeIe value) 
					+ (yIeJeIe pvaluepEJ transposeTimesFullRow: yIeJeIe pvaluepEJ) 
					+ (yIeJeIe ppvaluepEJpEJ times: yIeJeIe value) magnifySelf: 2.0d
]

{ #category : #calc }
MbDDistancexyConstraintIqcJqc >> calc_ppGpXIpEJ [
	"xIeJeIe ppvaluepXIpEJ = 0
	yIeJeIe ppvaluepXIpEJ = 0"

	ppGpXIpEJ := (xIeJeIe pvaluepXI transposeTimesFullRow: xIeJeIe pvaluepEJ) 
				+ (yIeJeIe pvaluepXI transposeTimesFullRow: yIeJeIe pvaluepEJ) 
					magnifySelf: 2.0d
]

{ #category : #calc }
MbDDistancexyConstraintIqcJqc >> calc_ppGpXIpXJ [
	"xIeJeIe ppvaluepXIpXJ = 0
	yIeJeIe ppvaluepXIpXJ = 0"

	ppGpXIpXJ := (xIeJeIe pvaluepXI transposeTimesFullRow: xIeJeIe pvaluepXJ) 
				+ (yIeJeIe pvaluepXI transposeTimesFullRow: yIeJeIe pvaluepXJ) 
					magnifySelf: 2.0d
]

{ #category : #calc }
MbDDistancexyConstraintIqcJqc >> calc_ppGpXJpEJ [
	"xIeJeIe ppvaluepXJpEJ = 0
	yIeJeIe ppvaluepXJpEJ = 0"

	ppGpXJpEJ := (xIeJeIe pvaluepXJ transposeTimesFullRow: xIeJeIe pvaluepEJ) 
				+ (yIeJeIe pvaluepXJ transposeTimesFullRow: yIeJeIe pvaluepEJ) 
					magnifySelf: 2.0d
]

{ #category : #calc }
MbDDistancexyConstraintIqcJqc >> calc_ppGpXJpXJ [
	"xIeJeIe ppvaluepXJpXJ = 0
	yIeJeIe ppvaluepXJpXJ = 0"

	ppGpXJpXJ := (xIeJeIe pvaluepXJ transposeTimesFullRow: xIeJeIe pvaluepXJ) 
				+ (yIeJeIe pvaluepXJ transposeTimesFullRow: yIeJeIe pvaluepXJ) 
					magnifySelf: 2.0d
]

{ #category : #accIC }
MbDDistancexyConstraintIqcJqc >> fillAccICIterError: col [ 
	| qXdotI qEdotI qXdotJ qEdotJ sum |
	super fillAccICIterError: col.
	col at: iqXJ plusFullColumn: pGpXJ times: lam.
	col at: iqEJ plusFullColumn: pGpEJ times: lam.
	qXdotI := frmI qXdot.
	qEdotI := frmI qEdot.
	qXdotJ := frmJ qXdot.
	qEdotJ := frmJ qEdot.
	sum := 0.0d.
	sum := sum + (pGpXJ timesFullColumn: frmJ qXddot).
	sum := sum + (pGpEJ timesFullColumn: frmJ qEddot).
	sum := sum + (2.0d * (qXdotI transposeTimesFullColumn: (ppGpXIpXJ timesFullColumn: qXdotJ))).
	sum := sum + (2.0d * (qEdotI transposeTimesFullColumn: (ppGpEIpXJ timesFullColumn: qXdotJ))).
	sum := sum + (qXdotJ transposeTimesFullColumn: (ppGpXJpXJ timesFullColumn: qXdotJ)).
	sum := sum + (2.0d * (qXdotI transposeTimesFullColumn: (ppGpXIpEJ timesFullColumn: qEdotJ))).
	sum := sum + (2.0d * (qEdotI transposeTimesFullColumn: (ppGpEIpEJ timesFullColumn: qEdotJ))).
	sum := sum + (2.0d * (qXdotJ transposeTimesFullColumn: (ppGpXJpEJ timesFullColumn: qEdotJ))).
	sum := sum + (qEdotJ transposeTimesFullColumn: (ppGpEJpEJ timesFullColumn: qEdotJ)).
	col at: iG plusNumber: sum
]

{ #category : #posIC }
MbDDistancexyConstraintIqcJqc >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: iqXJ plusFullColumn: pGpXJ times: lam.
	col at: iqEJ plusFullColumn: pGpEJ times: lam
]

{ #category : #posIC }
MbDDistancexyConstraintIqcJqc >> fillPosICJacob: mat [ 
	| ppGpXIpXJlam ppGpEIpXJlam ppGpXIpEJlam ppGpEIpEJlam ppGpXJpEJlam |
	super fillPosICJacob: mat.
	mat at: iG and: iqXJ plusFullRow: pGpXJ.
	mat at: iqXJ and: iG plusFullColumn: pGpXJ transpose.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose.
	mat at: iqXI and: iqXJ plusFullMatrix: (ppGpXIpXJlam := ppGpXIpXJ times: lam).
	mat at: iqXJ and: iqXI plusTransposeFullMatrix: ppGpXIpXJlam.
	mat at: iqEI and: iqXJ plusFullMatrix: (ppGpEIpXJlam := ppGpEIpXJ times: lam).
	mat at: iqXJ and: iqEI plusTransposeFullMatrix: ppGpEIpXJlam.
	mat at: iqXJ and: iqXJ plusFullMatrix: ppGpXJpXJ times: lam.
	mat at: iqXI and: iqEJ plusFullMatrix: (ppGpXIpEJlam := ppGpXIpEJ times: lam).
	mat at: iqEJ and: iqXI plusTransposeFullMatrix: ppGpXIpEJlam.
	mat at: iqEI and: iqEJ plusFullMatrix: (ppGpEIpEJlam := ppGpEIpEJ times: lam).
	mat at: iqEJ and: iqEI plusTransposeFullMatrix: ppGpEIpEJlam.
	mat at: iqXJ and: iqEJ plusFullMatrix: (ppGpXJpEJlam := ppGpXJpEJ times: lam).
	mat at: iqEJ and: iqXJ plusTransposeFullMatrix: ppGpXJpEJlam.
	mat at: iqEJ and: iqEJ plusFullMatrix: ppGpEJpEJ times: lam.
]

{ #category : #posIC }
MbDDistancexyConstraintIqcJqc >> fillPosKineJacob: mat [ 
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
MbDDistancexyConstraintIqcJqc >> fillVelICJacob: mat [ 
	super fillVelICJacob: mat.
	mat at: iG and: iqXJ plusFullRow: pGpXJ.
	mat at: iqXJ and: iG plusFullColumn: pGpXJ transpose.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose
]

{ #category : #dynamic }
MbDDistancexyConstraintIqcJqc >> fillpFpy: mat [ 
	| ppGpXIpXJlam ppGpEIpXJlam ppGpXIpEJlam ppGpEIpEJlam ppGpXJpEJlam |
	super fillpFpy: mat.
	mat at: iG and: iqXJ plusFullRow: pGpXJ.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqXI and: iqXJ plusFullMatrix: (ppGpXIpXJlam := ppGpXIpXJ times: lam).
	mat at: iqXJ and: iqXI plusTransposeFullMatrix: ppGpXIpXJlam.
	mat at: iqEI and: iqXJ plusFullMatrix: (ppGpEIpXJlam := ppGpEIpXJ times: lam).
	mat at: iqXJ and: iqEI plusTransposeFullMatrix: ppGpEIpXJlam.
	mat at: iqXJ and: iqXJ plusFullMatrix: ppGpXJpXJ times: lam.
	mat at: iqXI and: iqEJ plusFullMatrix: (ppGpXIpEJlam := ppGpXIpEJ times: lam).
	mat at: iqEJ and: iqXI plusTransposeFullMatrix: ppGpXIpEJlam.
	mat at: iqEI and: iqEJ plusFullMatrix: (ppGpEIpEJlam := ppGpEIpEJ times: lam).
	mat at: iqEJ and: iqEI plusTransposeFullMatrix: ppGpEIpEJlam.
	mat at: iqXJ and: iqEJ plusFullMatrix: (ppGpXJpEJlam := ppGpXJpEJ times: lam).
	mat at: iqEJ and: iqXJ plusTransposeFullMatrix: ppGpXJpEJlam.
	mat at: iqEJ and: iqEJ plusFullMatrix: ppGpEJpEJ times: lam.
]

{ #category : #dynamic }
MbDDistancexyConstraintIqcJqc >> fillpFpydot: mat [ 
	super fillpFpydot: mat.
	mat at: iqXJ and: iG plusFullColumn: pGpXJ transpose.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose
]

{ #category : #'initialize-release' }
MbDDistancexyConstraintIqcJqc >> useEquationNumbers [
	super useEquationNumbers.
	iqXJ := frmJ iqX.
	iqEJ := frmJ iqE
]
