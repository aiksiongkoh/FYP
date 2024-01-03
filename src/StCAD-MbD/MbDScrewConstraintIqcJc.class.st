Class {
	#name : #MbDScrewConstraintIqcJc,
	#superclass : #MbDScrewConstraintIJ,
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
MbDScrewConstraintIqcJc >> addToJointForceI: col [ 
	col equalSelfPlusFullColumn: pGpXI times: lam
]

{ #category : #accessing }
MbDScrewConstraintIqcJc >> addToJointTorqueI: jointTorque [ 
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
MbDScrewConstraintIqcJc >> addpFIeiGOpEIto: mat [ 
	mat equalSelfPlusFullMatrix: ppGpXIpEI times: lam
]

{ #category : #accessing }
MbDScrewConstraintIqcJc >> addpFIeiGOplamto: mat [ 
	mat at: 1 and: iG plusFullColumn: pGpXI transpose
]

{ #category : #calc }
MbDScrewConstraintIqcJc >> calcPostDynCorrectorIteration [
	| pzIeJeIepXI pzIeJeIepEI ppzIeJeIepXIpEI ppzIeJeIepEIpEI pthezpEI ppthezpEIpEI ppGpXIpEIi ppzIeJeIepXIpEIi ppGpEIpEIi ppzIeJeIepEIpEIi ppthezpEIpEIi ppGpEIpEIij |
	super calcPostDynCorrectorIteration.
	pzIeJeIepXI := zIeJeIe pvaluepXI.
	pzIeJeIepEI := zIeJeIe pvaluepEI plusFullRow: zIeJeIe pvaluepEK.
	ppzIeJeIepXIpEI := zIeJeIe ppvaluepXIpEK.
	ppzIeJeIepEIpEI := (zIeJeIe ppvaluepEIpEI plusFullMatrix: zIeJeIe ppvaluepEIpEK)
				plusFullMatrix: (zIeJeIe ppvaluepEIpEK transpose plusFullMatrix: zIeJeIe ppvaluepEKpEK).
	pthezpEI := thezIeJe pthezpEI.
	ppthezpEIpEI := thezIeJe ppthezpEIpEI.
	1 to: 3 do: [:i | pGpXI at: i put: TwoPi * (pzIeJeIepXI at: i)].
	1 to: 4 do: [:i | pGpEI at: i put: TwoPi * (pzIeJeIepEI at: i) - (pitch * (pthezpEI at: i))].
	1 to: 3 do: [:i | 
			ppGpXIpEIi := ppGpXIpEI at: i.
			ppzIeJeIepXIpEIi := ppzIeJeIepXIpEI at: i.
			1 to: 4 do: [:j | ppGpXIpEIi at: j put: TwoPi * (ppzIeJeIepXIpEIi at: j)]].
	1 to: 4 do: [:i | 
			ppGpEIpEIi := ppGpEIpEI at: i.
			ppzIeJeIepEIpEIi := ppzIeJeIepEIpEI at: i.
			ppthezpEIpEIi := ppthezpEIpEI at: i.
			ppGpEIpEIi at: i put: TwoPi * (ppzIeJeIepEIpEIi at: i) - (pitch * (ppthezpEIpEIi at: i)).
			i + 1 to: 4 do: [:j | 
					ppGpEIpEIij := TwoPi * (ppzIeJeIepEIpEIi at: j) - (pitch * (ppthezpEIpEIi at: j)).
					ppGpEIpEIi at: j put: ppGpEIpEIij.
					ppGpEIpEI at: j and: i put: ppGpEIpEIij]]
]

{ #category : #accIC }
MbDScrewConstraintIqcJc >> fillAccICIterError: col [ 
	| qXdotI qEdotI sum |
	col at: iqXI plusFullColumn: pGpXI times: lam.
	col at: iqEI plusFullColumn: pGpEI times: lam.
	qXdotI := frmI qXdot.
	qEdotI := frmI qEdot.
	sum := 0.0d.
	sum := sum + (pGpXI timesFullColumn: frmI qXddot).
	sum := sum + (pGpEI timesFullColumn: frmI qEddot).
	sum := sum + (2.0d * (qXdotI transposeTimesFullColumn: (ppGpXIpEI timesFullColumn: qEdotI))).
	sum := sum + (qEdotI transposeTimesFullColumn: (ppGpEIpEI timesFullColumn: qEdotI)).
	col at: iG plusNumber: sum
]

{ #category : #posIC }
MbDScrewConstraintIqcJc >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: iqXI plusFullColumn: pGpXI times: lam.
	col at: iqEI plusFullColumn: pGpEI times: lam
]

{ #category : #posIC }
MbDScrewConstraintIqcJc >> fillPosICJacob: mat [ 
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
MbDScrewConstraintIqcJc >> fillPosKineJacob: mat [ 
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
MbDScrewConstraintIqcJc >> fillVelICJacob: mat [ 
	mat at: iG and: iqXI plusFullRow: pGpXI.
	mat at: iqXI and: iG plusFullColumn: pGpXI transpose.
	mat at: iG and: iqEI plusFullRow: pGpEI.
	mat at: iqEI and: iG plusFullColumn: pGpEI transpose
]

{ #category : #dynamic }
MbDScrewConstraintIqcJc >> fillpFpy: mat [ 
	| ppGpXIpEIlam |
	mat at: iG and: iqXI plusFullRow: pGpXI.
	mat at: iG and: iqEI plusFullRow: pGpEI.
	mat at: iqXI and: iqEI plusFullMatrix: (ppGpXIpEIlam := ppGpXIpEI times: lam).
	mat at: iqEI and: iqXI plusTransposeFullMatrix: ppGpXIpEIlam.
	mat at: iqEI and: iqEI plusFullMatrix: ppGpEIpEI times: lam
]

{ #category : #dynamic }
MbDScrewConstraintIqcJc >> fillpFpydot: mat [ 
	mat at: iqXI and: iG plusFullColumn: pGpXI transpose.
	mat at: iqEI and: iG plusFullColumn: pGpEI transpose
]

{ #category : #'initialize-release' }
MbDScrewConstraintIqcJc >> initialize [
	super initialize.
	pGpXI := FullRow new: 3.
	pGpEI := FullRow new: 4.
	ppGpXIpEI := FullMatrix new: 3 by: 4.
	ppGpEIpEI := FullMatrix new: 4 by: 4
]

{ #category : #'initialize-release' }
MbDScrewConstraintIqcJc >> initthezIeJe [
	thezIeJe := MbDAnglezIeqcJec new
]

{ #category : #'initialize-release' }
MbDScrewConstraintIqcJc >> initzIeJeIe [
	zIeJeIe := MbDDispCompIeqcJecKeqc new
]

{ #category : #'initialize-release' }
MbDScrewConstraintIqcJc >> useEquationNumbers [
	iqXI := frmI iqX.
	iqEI := frmI iqE
]
