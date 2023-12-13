Class {
	#name : #MbDGearConstraintIqcJqc,
	#superclass : #MbDGearConstraintIqcJc,
	#instVars : [
		'pGpXJ',
		'pGpEJ',
		'ppGpXIpXJ',
		'ppGpXIpEJ',
		'ppGpEIpXJ',
		'ppGpEIpEJ',
		'ppGpXJpXJ',
		'ppGpXJpEJ',
		'ppGpEJpEJ',
		'iqXJ',
		'iqEJ'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #'VisualWorks metadata' }
MbDGearConstraintIqcJqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDGearConstraintIqcJqc class >> withFrmI: afrmI frmJ: afrmJ [ 
	^(afrmI isMemberOf: MbDEndFrameqc) & (afrmJ isMemberOf: MbDEndFrameqc) 
		ifTrue: [self new withFrmI: afrmI frmJ: afrmJ]
		ifFalse: [nil]
]

{ #category : #accessing }
MbDGearConstraintIqcJqc >> addToJointForceJ: col [ 
	col equalSelfPlusFullColumn: pGpXJ times: lam
]

{ #category : #accessing }
MbDGearConstraintIqcJqc >> addToJointTorqueJ: col [ 
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
MbDGearConstraintIqcJqc >> addpFIeiGOpEJto: mat [ 
	mat equalSelfPlusFullMatrix: ppGpXIpEJ times: lam
]

{ #category : #accessing }
MbDGearConstraintIqcJqc >> addpFIeiGOpXJto: mat [ 
	mat equalSelfPlusFullMatrix: ppGpXIpXJ times: lam
]

{ #category : #accessing }
MbDGearConstraintIqcJqc >> addpTIeiGOpEJto: mat [ 
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
MbDGearConstraintIqcJqc >> addpTIeiGOpXJto: mat [ 
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
MbDGearConstraintIqcJqc >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	self calc_pGpXJ.
	self calc_pGpEJ.
	self calc_ppGpXIpXJ.
	self calc_ppGpXIpEJ.
	self calc_ppGpEIpXJ.
	self calc_ppGpEIpEJ.
	self calc_ppGpXJpXJ.
	self calc_ppGpXJpEJ.
	self calc_ppGpEJpEJ
]

{ #category : #calc }
MbDGearConstraintIqcJqc >> calc_pGpEJ [
	pGpEJ := orbitJeIe pvaluepEI + (orbitIeJe pvaluepEJ times: self ratio)
]

{ #category : #calc }
MbDGearConstraintIqcJqc >> calc_pGpXJ [
	pGpXJ := orbitJeIe pvaluepXI + (orbitIeJe pvaluepXJ times: self ratio)
]

{ #category : #calc }
MbDGearConstraintIqcJqc >> calc_ppGpEIpEJ [
	ppGpEIpEJ := orbitJeIe ppvaluepEIpEJ transpose 
				+ (orbitIeJe ppvaluepEIpEJ times: self ratio)
]

{ #category : #calc }
MbDGearConstraintIqcJqc >> calc_ppGpEIpXJ [
	ppGpEIpXJ := orbitJeIe ppvaluepXIpEJ transpose 
				+ (orbitIeJe ppvaluepEIpXJ times: self ratio)
]

{ #category : #calc }
MbDGearConstraintIqcJqc >> calc_ppGpEJpEJ [
	ppGpEJpEJ := orbitJeIe ppvaluepEIpEI 
				+ (orbitIeJe ppvaluepEJpEJ times: self ratio)
]

{ #category : #calc }
MbDGearConstraintIqcJqc >> calc_ppGpXIpEJ [
	ppGpXIpEJ := orbitJeIe ppvaluepEIpXJ transpose 
				+ (orbitIeJe ppvaluepXIpEJ times: self ratio)
]

{ #category : #calc }
MbDGearConstraintIqcJqc >> calc_ppGpXIpXJ [
	ppGpXIpXJ := orbitJeIe ppvaluepXIpXJ transpose 
				+ (orbitIeJe ppvaluepXIpXJ times: self ratio)
]

{ #category : #calc }
MbDGearConstraintIqcJqc >> calc_ppGpXJpEJ [
	ppGpXJpEJ := orbitJeIe ppvaluepXIpEI 
				+ (orbitIeJe ppvaluepXJpEJ times: self ratio)
]

{ #category : #calc }
MbDGearConstraintIqcJqc >> calc_ppGpXJpXJ [
	ppGpXJpXJ := orbitJeIe ppvaluepXIpXI 
				+ (orbitIeJe ppvaluepXJpXJ times: self ratio)
]

{ #category : #accIC }
MbDGearConstraintIqcJqc >> fillAccICIterError: col [ 
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
	sum := sum + (2.0d * (qXdotI transposeTimesFullColumn: (ppGpXIpEJ timesFullColumn: qEdotJ))).
	sum := sum + (2.0d * (qEdotI transposeTimesFullColumn: (ppGpEIpXJ timesFullColumn: qXdotJ))).
	sum := sum + (2.0d * (qEdotI transposeTimesFullColumn: (ppGpEIpEJ timesFullColumn: qEdotJ))).
	sum := sum + (qXdotJ transposeTimesFullColumn: (ppGpXJpXJ timesFullColumn: qXdotJ)).
	sum := sum + (2.0d * (qXdotJ transposeTimesFullColumn: (ppGpXJpEJ timesFullColumn: qEdotJ))).
	sum := sum + (qEdotJ transposeTimesFullColumn: (ppGpEJpEJ timesFullColumn: qEdotJ)).
	col at: iG plusNumber: sum
]

{ #category : #posIC }
MbDGearConstraintIqcJqc >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: iqXJ plusFullColumn: pGpXJ times: lam.
	col at: iqEJ plusFullColumn: pGpEJ times: lam
]

{ #category : #posIC }
MbDGearConstraintIqcJqc >> fillPosICJacob: mat [ 
	| ppGpXIpXJlam ppGpXIpEJlam ppGpEIpXJlam ppGpEIpEJlam ppGpXJpEJlam |
	super fillPosICJacob: mat.
	mat at: iG and: iqXJ plusFullRow: pGpXJ.
	mat at: iqXJ and: iG plusFullColumn: pGpXJ transpose.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose.
	mat at: iqXI and: iqXJ plusFullMatrix: (ppGpXIpXJlam := ppGpXIpXJ times: lam).
	mat at: iqXJ and: iqXI plusTransposeFullMatrix: ppGpXIpXJlam.
	mat at: iqXI and: iqEJ plusFullMatrix: (ppGpXIpEJlam := ppGpXIpEJ times: lam).
	mat at: iqEJ and: iqXI plusTransposeFullMatrix: ppGpXIpEJlam.
	mat at: iqEI and: iqXJ plusFullMatrix: (ppGpEIpXJlam := ppGpEIpXJ times: lam).
	mat at: iqXJ and: iqEI plusTransposeFullMatrix: ppGpEIpXJlam.
	mat at: iqEI and: iqEJ plusFullMatrix: (ppGpEIpEJlam := ppGpEIpEJ times: lam).
	mat at: iqEJ and: iqEI plusTransposeFullMatrix: ppGpEIpEJlam.
	mat at: iqXJ and: iqXJ plusFullMatrix: ppGpXJpXJ times: lam.
	mat at: iqXJ and: iqEJ plusFullMatrix: (ppGpXJpEJlam := ppGpXJpEJ times: lam).
	mat at: iqEJ and: iqXJ plusTransposeFullMatrix: ppGpXJpEJlam.
	mat at: iqEJ and: iqEJ plusFullMatrix: ppGpEJpEJ times: lam.
]

{ #category : #posIC }
MbDGearConstraintIqcJqc >> fillPosKineJacob: mat [ 
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
MbDGearConstraintIqcJqc >> fillVelICJacob: mat [ 
	super fillVelICJacob: mat.
	mat at: iG and: iqXJ plusFullRow: pGpXJ.
	mat at: iqXJ and: iG plusFullColumn: pGpXJ transpose.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose
]

{ #category : #dynamic }
MbDGearConstraintIqcJqc >> fillpFpy: mat [ 
	| ppGpXIpXJlam ppGpXIpEJlam ppGpEIpXJlam ppGpEIpEJlam ppGpXJpEJlam |
	super fillpFpy: mat.
	mat at: iG and: iqXJ plusFullRow: pGpXJ.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqXI and: iqXJ plusFullMatrix: (ppGpXIpXJlam := ppGpXIpXJ times: lam).
	mat at: iqXJ and: iqXI plusTransposeFullMatrix: ppGpXIpXJlam.
	mat at: iqXI and: iqEJ plusFullMatrix: (ppGpXIpEJlam := ppGpXIpEJ times: lam).
	mat at: iqEJ and: iqXI plusTransposeFullMatrix: ppGpXIpEJlam.
	mat at: iqEI and: iqXJ plusFullMatrix: (ppGpEIpXJlam := ppGpEIpXJ times: lam).
	mat at: iqXJ and: iqEI plusTransposeFullMatrix: ppGpEIpXJlam.
	mat at: iqEI and: iqEJ plusFullMatrix: (ppGpEIpEJlam := ppGpEIpEJ times: lam).
	mat at: iqEJ and: iqEI plusTransposeFullMatrix: ppGpEIpEJlam.
	mat at: iqXJ and: iqXJ plusFullMatrix: ppGpXJpXJ times: lam.
	mat at: iqXJ and: iqEJ plusFullMatrix: (ppGpXJpEJlam := ppGpXJpEJ times: lam).
	mat at: iqEJ and: iqXJ plusTransposeFullMatrix: ppGpXJpEJlam.
	mat at: iqEJ and: iqEJ plusFullMatrix: ppGpEJpEJ times: lam.
]

{ #category : #dynamic }
MbDGearConstraintIqcJqc >> fillpFpydot: mat [ 
	super fillpFpydot: mat.
	mat at: iqXJ and: iG plusFullColumn: pGpXJ transpose.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose
]

{ #category : #'initialize-release' }
MbDGearConstraintIqcJqc >> useEquationNumbers [
	super useEquationNumbers.
	iqXJ := frmJ iqX.
	iqEJ := frmJ iqE
]
