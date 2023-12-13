Class {
	#name : #MbDDistanceConstraintIqcJqc,
	#superclass : #MbDDistanceConstraintIqcJc,
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

{ #category : #'VisualWorks metadata' }
MbDDistanceConstraintIqcJqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDistanceConstraintIqcJqc class >> withFrmI: afrmI frmJ: afrmJ [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFrameqc)
		ifTrue: [self new withFrmI: afrmI frmJ: afrmJ]
		ifFalse: [nil]
]

{ #category : #accessing }
MbDDistanceConstraintIqcJqc >> addToJointForceJ: col [ 
	col equalSelfPlusFullColumn: pGpXJ times: lam
]

{ #category : #accessing }
MbDDistanceConstraintIqcJqc >> addToJointTorqueJ: col [ 
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
MbDDistanceConstraintIqcJqc >> addpFIeiGOpEJto: mat [ 
	mat equalSelfPlusFullMatrix: ppGpXIpEJ times: lam
]

{ #category : #accessing }
MbDDistanceConstraintIqcJqc >> addpFIeiGOpXJto: mat [ 
	mat equalSelfPlusFullMatrix: ppGpXIpXJ times: lam
]

{ #category : #accessing }
MbDDistanceConstraintIqcJqc >> addpTIeiGOpEJto: mat [ 
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
MbDDistanceConstraintIqcJqc >> addpTIeiGOpXJto: mat [ 
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
MbDDistanceConstraintIqcJqc >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	pGpXJ := distIeJe pvaluepXJ.
	pGpEJ := distIeJe pvaluepEJ.
	ppGpXIpXJ := distIeJe ppvaluepXIpXJ.
	ppGpEIpXJ := distIeJe ppvaluepEIpXJ.
	ppGpXJpXJ := distIeJe ppvaluepXJpXJ.
	ppGpXIpEJ := distIeJe ppvaluepXIpEJ.
	ppGpEIpEJ := distIeJe ppvaluepEIpEJ.
	ppGpXJpEJ := distIeJe ppvaluepXJpEJ.
	ppGpEJpEJ := distIeJe ppvaluepEJpEJ
]

{ #category : #accIC }
MbDDistanceConstraintIqcJqc >> fillAccICIterError: col [ 
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
MbDDistanceConstraintIqcJqc >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: iqXJ plusFullColumn: pGpXJ times: lam.
	col at: iqEJ plusFullColumn: pGpEJ times: lam
]

{ #category : #posIC }
MbDDistanceConstraintIqcJqc >> fillPosICJacob: mat [ 
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
MbDDistanceConstraintIqcJqc >> fillPosKineJacob: mat [ 
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
MbDDistanceConstraintIqcJqc >> fillVelICJacob: mat [ 
	super fillVelICJacob: mat.
	mat at: iG and: iqXJ plusFullRow: pGpXJ.
	mat at: iqXJ and: iG plusFullColumn: pGpXJ transpose.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose
]

{ #category : #dynamic }
MbDDistanceConstraintIqcJqc >> fillpFpy: mat [ 
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
MbDDistanceConstraintIqcJqc >> fillpFpydot: mat [ 
	super fillpFpydot: mat.
	mat at: iqXJ and: iG plusFullColumn: pGpXJ transpose.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose
]

{ #category : #'initialize-release' }
MbDDistanceConstraintIqcJqc >> init_distIeJe [
	distIeJe := MbDDistIeqcJeqc new
]

{ #category : #'initialize-release' }
MbDDistanceConstraintIqcJqc >> useEquationNumbers [
	super useEquationNumbers.
	iqXJ := frmJ iqX.
	iqEJ := frmJ iqE
]
