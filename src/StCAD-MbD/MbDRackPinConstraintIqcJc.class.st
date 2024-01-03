Class {
	#name : #MbDRackPinConstraintIqcJc,
	#superclass : #MbDRackPinConstraintIJ,
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
MbDRackPinConstraintIqcJc >> addToJointForceI: col [ 
	col equalSelfPlusFullColumn: pGpXI times: lam
]

{ #category : #accessing }
MbDRackPinConstraintIqcJc >> addToJointTorqueI: jointTorque [ 
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
MbDRackPinConstraintIqcJc >> addpFIeiGOpEIto: mat [ 
	mat equalSelfPlusFullMatrix: ppGpXIpEI times: lam
]

{ #category : #accessing }
MbDRackPinConstraintIqcJc >> addpFIeiGOplamto: mat [ 
	mat at: 1 and: iG plusFullColumn: pGpXI transpose
]

{ #category : #calc }
MbDRackPinConstraintIqcJc >> calcPostDynCorrectorIteration [
	| pxIeJeIepXI pxIeJeIepEI ppxIeJeIepXIpEI ppxIeJeIepEIpEI pthezpEI ppthezpEIpEI ppGpEIpEIi ppxIeJeIepEIpEIi ppthezpEIpEIi ppGpEIpEIij |
	super calcPostDynCorrectorIteration.
	pxIeJeIepXI := xIeJeIe pvaluepXI.
	pxIeJeIepEI := xIeJeIe pvaluepEI plusFullRow: xIeJeIe pvaluepEK.
	ppxIeJeIepXIpEI := xIeJeIe ppvaluepXIpEK.
	ppxIeJeIepEIpEI := (xIeJeIe ppvaluepEIpEI plusFullMatrix: xIeJeIe ppvaluepEIpEK)
				plusFullMatrix: (xIeJeIe ppvaluepEIpEK transpose plusFullMatrix: xIeJeIe ppvaluepEKpEK).
	pthezpEI := thezIeJe pthezpEI.
	ppthezpEIpEI := thezIeJe ppthezpEIpEI.
	pGpXI := pxIeJeIepXI.
	1 to: 4 do: [:i | pGpEI at: i put: (pxIeJeIepEI at: i) + (pitchRadius * (pthezpEI at: i))].
	ppGpXIpEI := ppxIeJeIepXIpEI.
	1 to: 4 do: [:i | 
			ppGpEIpEIi := ppGpEIpEI at: i.
			ppxIeJeIepEIpEIi := ppxIeJeIepEIpEI at: i.
			ppthezpEIpEIi := ppthezpEIpEI at: i.
			ppGpEIpEIi at: i put: (ppxIeJeIepEIpEIi at: i) + (pitchRadius * (ppthezpEIpEIi at: i)).
			i + 1 to: 4 do: [:j | 
					ppGpEIpEIij := (ppxIeJeIepEIpEIi at: j) + (pitchRadius * (ppthezpEIpEIi at: j)).
					ppGpEIpEIi at: j put: ppGpEIpEIij.
					ppGpEIpEI at: j and: i put: ppGpEIpEIij]]
]

{ #category : #accIC }
MbDRackPinConstraintIqcJc >> fillAccICIterError: col [ 
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
MbDRackPinConstraintIqcJc >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: iqXI plusFullColumn: pGpXI times: lam.
	col at: iqEI plusFullColumn: pGpEI times: lam
]

{ #category : #posIC }
MbDRackPinConstraintIqcJc >> fillPosICJacob: mat [ 
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
MbDRackPinConstraintIqcJc >> fillPosKineJacob: mat [ 
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
MbDRackPinConstraintIqcJc >> fillVelICJacob: mat [ 
	mat at: iG and: iqXI plusFullRow: pGpXI.
	mat at: iqXI and: iG plusFullColumn: pGpXI transpose.
	mat at: iG and: iqEI plusFullRow: pGpEI.
	mat at: iqEI and: iG plusFullColumn: pGpEI transpose
]

{ #category : #dynamic }
MbDRackPinConstraintIqcJc >> fillpFpy: mat [ 
	| ppGpXIpEIlam |
	mat at: iG and: iqXI plusFullRow: pGpXI.
	mat at: iG and: iqEI plusFullRow: pGpEI.
	mat at: iqXI and: iqEI plusFullMatrix: (ppGpXIpEIlam := ppGpXIpEI times: lam).
	mat at: iqEI and: iqXI plusTransposeFullMatrix: ppGpXIpEIlam.
	mat at: iqEI and: iqEI plusFullMatrix: ppGpEIpEI times: lam
]

{ #category : #dynamic }
MbDRackPinConstraintIqcJc >> fillpFpydot: mat [ 
	mat at: iqXI and: iG plusFullColumn: pGpXI transpose.
	mat at: iqEI and: iG plusFullColumn: pGpEI transpose
]

{ #category : #'initialize-release' }
MbDRackPinConstraintIqcJc >> initialize [
	super initialize.
	pGpXI := FullRow new: 3.
	pGpEI := FullRow new: 4.
	ppGpXIpEI := FullMatrix new: 3 by: 4.
	ppGpEIpEI := FullMatrix new: 4 by: 4
]

{ #category : #'initialize-release' }
MbDRackPinConstraintIqcJc >> initthezIeJe [
	thezIeJe := MbDAnglezIeqcJec new
]

{ #category : #'initialize-release' }
MbDRackPinConstraintIqcJc >> initxIeJeIe [
	xIeJeIe := MbDDispCompIeqcJecKeqc new
]

{ #category : #'initialize-release' }
MbDRackPinConstraintIqcJc >> useEquationNumbers [
	iqXI := frmI iqX.
	iqEI := frmI iqE
]
