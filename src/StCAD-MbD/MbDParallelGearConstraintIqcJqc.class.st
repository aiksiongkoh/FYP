Class {
	#name : #MbDParallelGearConstraintIqcJqc,
	#superclass : #MbDParallelGearConstraintIqcJc,
	#instVars : [
		'pGpXJ',
		'pGpEJ',
		'ppGpEIpXJ',
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
MbDParallelGearConstraintIqcJqc >> addToJointForceJ: col [ 
	col equalSelfPlusFullColumn: pGpXJ times: lam
]

{ #category : #accessing }
MbDParallelGearConstraintIqcJqc >> addToJointTorqueJ: col [ 
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

{ #category : #calc }
MbDParallelGearConstraintIqcJqc >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	self calc_pGpXJ.
	self calc_pGpEJ.
	self calc_ppGpEIpXJ.
	self calc_ppGpXIpEJ.
	self calc_ppGpEIpEJ.
	self calc_ppGpXJpEJ.
	self calc_ppGpEJpEJ
]

{ #category : #calc }
MbDParallelGearConstraintIqcJqc >> calc_pGpEJ [
	pGpEJ := thezIeJe pvaluepEJ - (orbitIeJe pvaluepEJ times: ratioPlusOne)
]

{ #category : #calc }
MbDParallelGearConstraintIqcJqc >> calc_pGpXJ [
	"thezIeJe pvaluepXJ = 0"

	pGpXJ := orbitIeJe pvaluepXJ times: ratioPlusOne negated
]

{ #category : #calc }
MbDParallelGearConstraintIqcJqc >> calc_ppGpEIpEJ [
	ppGpEIpEJ := thezIeJe ppvaluepEIpEJ - (orbitIeJe ppvaluepEIpEJ times: ratioPlusOne)
]

{ #category : #calc }
MbDParallelGearConstraintIqcJqc >> calc_ppGpEIpXJ [
	"thezIeJe ppvaluepEIpXJ = 0"

	ppGpEIpXJ := orbitIeJe ppvaluepEIpXJ times: ratioPlusOne negated
]

{ #category : #calc }
MbDParallelGearConstraintIqcJqc >> calc_ppGpEJpEJ [
	ppGpEJpEJ := thezIeJe ppvaluepEJpEJ - (orbitIeJe ppvaluepEJpEJ times: ratioPlusOne)
]

{ #category : #calc }
MbDParallelGearConstraintIqcJqc >> calc_ppGpXIpEJ [
	"thezIeJe ppvaluepXIpEJ = 0"

	ppGpXIpEJ := orbitIeJe ppvaluepXIpEJ times: ratioPlusOne negated
]

{ #category : #calc }
MbDParallelGearConstraintIqcJqc >> calc_ppGpXJpEJ [
	"thezIeJe ppvaluepXJpEJ = 0"

	ppGpXJpEJ := orbitIeJe ppvaluepXJpEJ times: ratioPlusOne negated
]

{ #category : #accIC }
MbDParallelGearConstraintIqcJqc >> fillAccICIterError: col [ 
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
	sum := sum + (2.0d * (qEdotI transposeTimesFullColumn: (ppGpEIpXJ timesFullColumn: qXdotJ))).
	sum := sum + (2.0d * (qXdotI transposeTimesFullColumn: (ppGpXIpEJ timesFullColumn: qEdotJ))).
	sum := sum + (2.0d * (qEdotI transposeTimesFullColumn: (ppGpEIpEJ timesFullColumn: qEdotJ))).
	sum := sum + (2.0d * (qXdotJ transposeTimesFullColumn: (ppGpXJpEJ timesFullColumn: qEdotJ))).
	sum := sum + (qEdotJ transposeTimesFullColumn: (ppGpEJpEJ timesFullColumn: qEdotJ)).
	col at: iG plusNumber: sum
]

{ #category : #posIC }
MbDParallelGearConstraintIqcJqc >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: iqXJ plusFullColumn: pGpXJ times: lam.
	col at: iqEJ plusFullColumn: pGpEJ times: lam
]

{ #category : #posIC }
MbDParallelGearConstraintIqcJqc >> fillPosICJacob: mat [ 
	| ppGpEIpXJlam ppGpXIpEJlam ppGpEIpEJlam ppGpXJpEJlam |
	super fillPosICJacob: mat.
	mat at: iG and: iqXJ plusFullRow: pGpXJ.
	mat at: iqXJ and: iG plusFullColumn: pGpXJ transpose.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose.
	mat at: iqEI and: iqXJ plusFullMatrix: (ppGpEIpXJlam := ppGpEIpXJ times: lam).
	mat at: iqXJ and: iqEI plusTransposeFullMatrix: ppGpEIpXJlam.
	mat at: iqXI and: iqEJ plusFullMatrix: (ppGpXIpEJlam := ppGpXIpEJ times: lam).
	mat at: iqEJ and: iqXI plusTransposeFullMatrix: ppGpXIpEJlam.
	mat at: iqEI and: iqEJ plusFullMatrix: (ppGpEIpEJlam := ppGpEIpEJ times: lam).
	mat at: iqEJ and: iqEI plusTransposeFullMatrix: ppGpEIpEJlam.
	mat at: iqXJ and: iqEJ plusFullMatrix: (ppGpXJpEJlam := ppGpXJpEJ times: lam).
	mat at: iqEJ and: iqXJ plusTransposeFullMatrix: ppGpXJpEJlam.
	mat at: iqEJ and: iqEJ plusFullMatrix: ppGpEJpEJ times: lam.
]

{ #category : #posIC }
MbDParallelGearConstraintIqcJqc >> fillPosKineJacob: mat [ 
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
MbDParallelGearConstraintIqcJqc >> fillVelICJacob: mat [ 
	super fillVelICJacob: mat.
	mat at: iG and: iqXJ plusFullRow: pGpXJ.
	mat at: iqXJ and: iG plusFullColumn: pGpXJ transpose.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose
]

{ #category : #dynamic }
MbDParallelGearConstraintIqcJqc >> fillpFpy: mat [ 
	| ppGpEIpXJlam ppGpXIpEJlam ppGpEIpEJlam ppGpXJpEJlam |
	super fillpFpy: mat.
	mat at: iG and: iqXJ plusFullRow: pGpXJ.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqEI and: iqXJ plusFullMatrix: (ppGpEIpXJlam := ppGpEIpXJ times: lam).
	mat at: iqXJ and: iqEI plusTransposeFullMatrix: ppGpEIpXJlam.
	mat at: iqXI and: iqEJ plusFullMatrix: (ppGpXIpEJlam := ppGpXIpEJ times: lam).
	mat at: iqEJ and: iqXI plusTransposeFullMatrix: ppGpXIpEJlam.
	mat at: iqEI and: iqEJ plusFullMatrix: (ppGpEIpEJlam := ppGpEIpEJ times: lam).
	mat at: iqEJ and: iqEI plusTransposeFullMatrix: ppGpEIpEJlam.
	mat at: iqXJ and: iqEJ plusFullMatrix: (ppGpXJpEJlam := ppGpXJpEJ times: lam).
	mat at: iqEJ and: iqXJ plusTransposeFullMatrix: ppGpXJpEJlam.
	mat at: iqEJ and: iqEJ plusFullMatrix: ppGpEJpEJ times: lam.
]

{ #category : #dynamic }
MbDParallelGearConstraintIqcJqc >> fillpFpydot: mat [ 
	super fillpFpydot: mat.
	mat at: iqXJ and: iG plusFullColumn: pGpXJ transpose.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose
]

{ #category : #'initialize-release' }
MbDParallelGearConstraintIqcJqc >> useEquationNumbers [
	super useEquationNumbers.
	iqXJ := frmJ iqX.
	iqEJ := frmJ iqE
]
