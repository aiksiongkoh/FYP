Class {
	#name : #MbDParallelGearConstraintIqcJc,
	#superclass : #MbDParallelGearConstraintIJ,
	#instVars : [
		'pGpXI',
		'pGpEI',
		'ppGpXIpEI',
		'ppGpEIpEI',
		'iqXI',
		'iqEI'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #accessing }
MbDParallelGearConstraintIqcJc >> addToJointForceI: col [ 
	col equalSelfPlusFullColumn: pGpXI times: lam
]

{ #category : #accessing }
MbDParallelGearConstraintIqcJc >> addToJointTorqueI: jointTorque [ 
	| cForceT rIpIeIp pAOIppEI aBOIp fpAOIppEIrIpIeIp dum lampGpE c2Torque |
	cForceT := pGpXI times: lam.
	rIpIeIp := frmI rpep.
	pAOIppEI := frmI pAOppE.
	aBOIp := frmI aBOp.
	fpAOIppEIrIpIeIp := (FullColumn zero: 4).
	1 to: 4 do:  [:i | 
			dum := cForceT timesFullColumn: ((pAOIppEI at: i) timesFullColumn: rIpIeIp).
			fpAOIppEIrIpIeIp at: i put: dum].
	lampGpE := pGpEI transpose times: lam.
	c2Torque := aBOIp timesFullColumn: lampGpE - fpAOIppEIrIpIeIp.
	jointTorque equalSelfPlusFullColumn: c2Torque times: 0.5d
]

{ #category : #accessing }
MbDParallelGearConstraintIqcJc >> addpFIeiGOpEIto: mat [ 
	mat equalSelfPlusFullMatrix: ppGpXIpEI times: lam
]

{ #category : #accessing }
MbDParallelGearConstraintIqcJc >> addpFIeiGOplamto: mat [ 
	mat at: 1 and: iG plusFullColumn: pGpXI transpose
]

{ #category : #calc }
MbDParallelGearConstraintIqcJc >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	self calc_pGpXI.
	self calc_pGpEI.
	self calc_ppGpXIpEI.
	self calc_ppGpEIpEI
]

{ #category : #calc }
MbDParallelGearConstraintIqcJc >> calc_pGpEI [
	pGpEI := thezIeJe pvaluepEI - (orbitIeJe pvaluepEI times: ratioPlusOne)
]

{ #category : #calc }
MbDParallelGearConstraintIqcJc >> calc_pGpXI [
	"thezIeJe pvaluepXI = 0"

	pGpXI := orbitIeJe pvaluepXI times: ratioPlusOne negated
]

{ #category : #calc }
MbDParallelGearConstraintIqcJc >> calc_ppGpEIpEI [
	ppGpEIpEI := thezIeJe ppvaluepEIpEI 
				- (orbitIeJe ppvaluepEIpEI times: ratioPlusOne)
]

{ #category : #calc }
MbDParallelGearConstraintIqcJc >> calc_ppGpXIpEI [
	"thezIeJe ppvaluepXIpEI = 0"

	ppGpXIpEI := orbitIeJe ppvaluepXIpEI times: ratioPlusOne negated
]

{ #category : #accIC }
MbDParallelGearConstraintIqcJc >> fillAccICIterError: col [ 
	| qXdotI qEdotI sum |
	col at: iqXI plusFullColumn: pGpXI times: lam.
	col at: iqEI plusFullColumn: pGpEI times: lam.
	qXdotI := frmI qXdot.
	qEdotI := frmI qEdot.
	sum := 0.0d.
	sum := sum + (pGpXI timesFullColumn: frmI qXddot).
	sum := sum + (pGpEI timesFullColumn: frmI qEddot).
	sum := sum + (2.0d 	* (qXdotI transposeTimesFullColumn: (ppGpXIpEI timesFullColumn: qEdotI))).
	sum := sum + (qEdotI transposeTimesFullColumn: (ppGpEIpEI timesFullColumn: qEdotI)).
	col at: iG plusNumber: sum
]

{ #category : #posIC }
MbDParallelGearConstraintIqcJc >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: iqXI plusFullColumn: pGpXI times: lam.
	col at: iqEI plusFullColumn: pGpEI times: lam
]

{ #category : #posIC }
MbDParallelGearConstraintIqcJc >> fillPosICJacob: mat [ 
	| ppGpXIpEIlam |
	mat at: iG and: iqXI plusFullRow: pGpXI.
	mat at: iqXI and: iG plusFullColumn: pGpXI transpose.
	mat at: iG and: iqEI plusFullRow: pGpEI.
	mat at: iqEI and: iG plusFullColumn: pGpEI transpose.
	mat at: iqXI and: iqEI plusFullMatrix: (ppGpXIpEIlam := ppGpXIpEI times: lam).
	mat at: iqEI and: iqXI plusTransposeFullMatrix: ppGpXIpEIlam.
	mat at: iqEI and: iqEI plusFullMatrix: ppGpEIpEI times: lam
]

{ #category : #posIC }
MbDParallelGearConstraintIqcJc >> fillPosKineJacob: mat [ 
	mat
		at: iG
		and: iqXI
		plusFullRow: pGpXI.
	mat
		at: iG
		and: iqEI
		plusFullRow: pGpEI
]

{ #category : #velIC }
MbDParallelGearConstraintIqcJc >> fillVelICJacob: mat [ 
	mat at: iG and: iqXI plusFullRow: pGpXI.
	mat at: iqXI and: iG plusFullColumn: pGpXI transpose.
	mat at: iG and: iqEI plusFullRow: pGpEI.
	mat at: iqEI and: iG plusFullColumn: pGpEI transpose
]

{ #category : #dynamic }
MbDParallelGearConstraintIqcJc >> fillpFpy: mat [ 
	| ppGpXIpEIlam |
	mat at: iG and: iqXI plusFullRow: pGpXI.
	mat at: iG and: iqEI plusFullRow: pGpEI.
	mat at: iqXI and: iqEI plusFullMatrix: (ppGpXIpEIlam := ppGpXIpEI times: lam).
	mat at: iqEI and: iqXI plusTransposeFullMatrix: ppGpXIpEIlam.
	mat at: iqEI and: iqEI plusFullMatrix: ppGpEIpEI times: lam.
]

{ #category : #dynamic }
MbDParallelGearConstraintIqcJc >> fillpFpydot: mat [ 
	mat at: iqXI and: iG plusFullColumn: pGpXI transpose.
	mat at: iqEI and: iG plusFullColumn: pGpEI transpose
]

{ #category : #'initialize-release' }
MbDParallelGearConstraintIqcJc >> useEquationNumbers [
	iqXI := frmI iqX.
	iqEI := frmI iqE
]
