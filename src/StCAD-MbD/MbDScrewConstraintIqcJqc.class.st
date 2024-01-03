Class {
	#name : #MbDScrewConstraintIqcJqc,
	#superclass : #MbDScrewConstraintIqcJc,
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
MbDScrewConstraintIqcJqc >> addToJointForceJ: col [ 
	col equalSelfPlusFullColumn: pGpXJ times: lam
]

{ #category : #accessing }
MbDScrewConstraintIqcJqc >> addToJointTorqueJ: col [ 
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
MbDScrewConstraintIqcJqc >> calcPostDynCorrectorIteration [
	| pzIeJeIepXJ pzIeJeIepEJ ppzIeJeIepEIpXJ ppzIeJeIepEIpEJ ppzIeJeIepEJpEJ pthezpEJ ppthezpEIpEJ ppthezpEJpEJ ppGpEIpXJi ppzIeJeIepEIpXJi ppGpEIpEJi ppzIeJeIepEIpEJi ppthezpEIpEJi ppGpEJpEJi ppzIeJeIepEJpEJi ppthezpEJpEJi ppGpEJpEJij |
	super calcPostDynCorrectorIteration.
	pzIeJeIepXJ := zIeJeIe pvaluepXJ.
	pzIeJeIepEJ := zIeJeIe pvaluepEJ.
	ppzIeJeIepEIpXJ := zIeJeIe ppvaluepXJpEK transpose.
	ppzIeJeIepEIpEJ := zIeJeIe ppvaluepEJpEK transpose.
	ppzIeJeIepEJpEJ := zIeJeIe ppvaluepEJpEJ.
	pthezpEJ := thezIeJe pthezpEJ.
	ppthezpEIpEJ := thezIeJe ppthezpEIpEJ.
	ppthezpEJpEJ := thezIeJe ppthezpEJpEJ.
	1 to: 3 do: [:i | pGpXJ at: i put: TwoPi * (pzIeJeIepXJ at: i)].
	1 to: 4 do: [:i | pGpEJ at: i put: TwoPi * (pzIeJeIepEJ at: i) - (pitch * (pthezpEJ at: i))].
	1 to: 4 do: [:i | 
			ppGpEIpXJi := ppGpEIpXJ at: i.
			ppzIeJeIepEIpXJi := ppzIeJeIepEIpXJ at: i.
			1 to: 3 do: [:j | ppGpEIpXJi at: j put: TwoPi * (ppzIeJeIepEIpXJi at: j)]].
	1 to: 4 do: [:i | 
			ppGpEIpEJi := ppGpEIpEJ at: i.
			ppzIeJeIepEIpEJi := ppzIeJeIepEIpEJ at: i.
			ppthezpEIpEJi := ppthezpEIpEJ at: i.
			1 to: 4 do: [:j | ppGpEIpEJi at: j put: TwoPi * (ppzIeJeIepEIpEJi at: j) - (pitch * (ppthezpEIpEJi at: j))]].
	1 to: 4 do: [:i | 
			ppGpEJpEJi := ppGpEJpEJ at: i.
			ppzIeJeIepEJpEJi := ppzIeJeIepEJpEJ at: i.
			ppthezpEJpEJi := ppthezpEJpEJ at: i.
			ppGpEJpEJi at: i put: TwoPi * (ppzIeJeIepEJpEJi at: i) - (pitch * (ppthezpEJpEJi at: i)).
			i + 1 to: 4 do: [:j | 
					ppGpEJpEJij := TwoPi * (ppzIeJeIepEJpEJi at: j) - (pitch * (ppthezpEJpEJi at: j)).
					ppGpEJpEJi at: j put: ppGpEJpEJij.
					ppGpEJpEJ at: j and: i put: ppGpEJpEJij]]
]

{ #category : #accIC }
MbDScrewConstraintIqcJqc >> fillAccICIterError: col [ 
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
MbDScrewConstraintIqcJqc >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: iqXJ plusFullColumn: pGpXJ times: lam.
	col at: iqEJ plusFullColumn: pGpEJ times: lam
]

{ #category : #posIC }
MbDScrewConstraintIqcJqc >> fillPosICJacob: mat [ 
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
MbDScrewConstraintIqcJqc >> fillPosKineJacob: mat [ 
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
MbDScrewConstraintIqcJqc >> fillVelICJacob: mat [ 
	super fillVelICJacob: mat.
	mat at: iG and: iqXJ plusFullRow: pGpXJ.
	mat at: iqXJ and: iG plusFullColumn: pGpXJ transpose.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose
]

{ #category : #dynamic }
MbDScrewConstraintIqcJqc >> fillpFpy: mat [ 
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
MbDScrewConstraintIqcJqc >> fillpFpydot: mat [ 
	super fillpFpydot: mat.
	mat at: iqXJ and: iG plusFullColumn: pGpXJ transpose.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose
]

{ #category : #'initialize-release' }
MbDScrewConstraintIqcJqc >> initialize [
	super initialize.
	pGpXJ := FullRow new: 3.
	pGpEJ := FullRow new: 4.
	ppGpEIpXJ := FullMatrix new: 4 by: 3.
	ppGpEIpEJ := FullMatrix new: 4 by: 4.
	ppGpEJpEJ := FullMatrix new: 4 by: 4
]

{ #category : #'initialize-release' }
MbDScrewConstraintIqcJqc >> initthezIeJe [
	thezIeJe := MbDAnglezIeqcJeqc new
]

{ #category : #'initialize-release' }
MbDScrewConstraintIqcJqc >> initziIeJeIe [
	zIeJeIe := MbDDispCompIeqcJeqcKeqc new
]

{ #category : #'initialize-release' }
MbDScrewConstraintIqcJqc >> useEquationNumbers [
	super useEquationNumbers.
	iqXJ := frmJ iqX.
	iqEJ := frmJ iqE
]
