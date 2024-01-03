Class {
	#name : #MbDRackPinConstraintIqcJqc,
	#superclass : #MbDRackPinConstraintIqcJc,
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
MbDRackPinConstraintIqcJqc >> addToJointForceJ: col [ 
	col equalSelfPlusFullColumn: pGpXJ times: lam
]

{ #category : #accessing }
MbDRackPinConstraintIqcJqc >> addToJointTorqueJ: col [ 
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
MbDRackPinConstraintIqcJqc >> calcPostDynCorrectorIteration [
	| pxIeJeIepXJ pxIeJeIepEJ ppxIeJeIepEIpXJ ppxIeJeIepEIpEJ ppxIeJeIepEJpEJ pthezpEJ ppthezpEIpEJ ppthezpEJpEJ ppGpEIpEJi ppxIeJeIepEIpEJi ppthezpEIpEJi ppGpEIpEJij ppGpEJpEJi ppxIeJeIepEJpEJi ppthezpEJpEJi ppGpEJpEJij |
	super calcPostDynCorrectorIteration.
	pxIeJeIepXJ := xIeJeIe pvaluepXJ.
	pxIeJeIepEJ := xIeJeIe pvaluepEJ.
	ppxIeJeIepEIpXJ := xIeJeIe ppvaluepXJpEK transpose.
	ppxIeJeIepEIpEJ := xIeJeIe ppvaluepEJpEK transpose.
	ppxIeJeIepEJpEJ := xIeJeIe ppvaluepEJpEJ.
	pthezpEJ := thezIeJe pthezpEJ.
	ppthezpEIpEJ := thezIeJe ppthezpEIpEJ.
	ppthezpEJpEJ := thezIeJe ppthezpEJpEJ.
	pGpXJ := pxIeJeIepXJ.
	1 to: 4 do: [:i | pGpEJ at: i put: (pxIeJeIepEJ at: i) + (pitchRadius * (pthezpEJ at: i))].
	ppGpEIpXJ := ppxIeJeIepEIpXJ.
	1 to: 4 do: [:i | 
			ppGpEIpEJi := ppGpEIpEJ at: i.
			ppxIeJeIepEIpEJi := ppxIeJeIepEIpEJ at: i.
			ppthezpEIpEJi := ppthezpEIpEJ at: i.
			1 to: 4 do: [:j | 
					ppGpEIpEJij := (ppxIeJeIepEIpEJi at: j) + (pitchRadius * (ppthezpEIpEJi at: j)).
					ppGpEIpEJi at: j put: ppGpEIpEJij]].
	1 to: 4 do: [:i | 
			ppGpEJpEJi := ppGpEJpEJ at: i.
			ppxIeJeIepEJpEJi := ppxIeJeIepEJpEJ at: i.
			ppthezpEJpEJi := ppthezpEJpEJ at: i.
			ppGpEJpEJi at: i put: (ppxIeJeIepEJpEJi at: i) + (pitchRadius * (ppthezpEJpEJi at: i)).
			i + 1 to: 4 do: [:j | 
					ppGpEJpEJij := (ppxIeJeIepEJpEJi at: j) + (pitchRadius * (ppthezpEJpEJi at: j)).
					ppGpEJpEJi at: j put: ppGpEJpEJij.
					ppGpEJpEJ at: j and: i put: ppGpEJpEJij]]
]

{ #category : #accIC }
MbDRackPinConstraintIqcJqc >> fillAccICIterError: col [ 
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

{ #category : #posIC }
MbDRackPinConstraintIqcJqc >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: iqXJ plusFullColumn: pGpXJ times: lam.
	col at: iqEJ plusFullColumn: pGpEJ times: lam
]

{ #category : #posIC }
MbDRackPinConstraintIqcJqc >> fillPosICJacob: mat [ 
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
MbDRackPinConstraintIqcJqc >> fillPosKineJacob: mat [ 
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
MbDRackPinConstraintIqcJqc >> fillVelICJacob: mat [ 
	super fillVelICJacob: mat.
	mat at: iG and: iqXJ plusFullRow: pGpXJ.
	mat at: iqXJ and: iG plusFullColumn: pGpXJ transpose.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose
]

{ #category : #dynamic }
MbDRackPinConstraintIqcJqc >> fillpFpy: mat [ 
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
MbDRackPinConstraintIqcJqc >> fillpFpydot: mat [ 
	super fillpFpydot: mat.
	mat at: iqXJ and: iG plusFullColumn: pGpXJ transpose.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose
]

{ #category : #'initialize-release' }
MbDRackPinConstraintIqcJqc >> initialize [
	super initialize.
	pGpXJ := FullRow new: 3.
	pGpEJ := FullRow new: 4.
	ppGpEIpXJ := FullMatrix new: 4 by: 3.
	ppGpEIpEJ := FullMatrix new: 4 by: 4.
	ppGpEJpEJ := FullMatrix new: 4 by: 4
]

{ #category : #'initialize-release' }
MbDRackPinConstraintIqcJqc >> initthezIeJe [
	thezIeJe := MbDAnglezIeqcJeqc new
]

{ #category : #'initialize-release' }
MbDRackPinConstraintIqcJqc >> initxIeJeIe [
	xIeJeIe := MbDDispCompIeqcJeqcKeqc new
]

{ #category : #'initialize-release' }
MbDRackPinConstraintIqcJqc >> useEquationNumbers [
	super useEquationNumbers.
	iqXJ := frmJ iqX.
	iqEJ := frmJ iqE
]
