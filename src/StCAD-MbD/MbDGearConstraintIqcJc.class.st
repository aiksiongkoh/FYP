Class {
	#name : #MbDGearConstraintIqcJc,
	#superclass : #MbDGearConstraintIJ,
	#instVars : [
		'pGpXI',
		'pGpEI',
		'ppGpXIpXI',
		'ppGpXIpEI',
		'ppGpEIpEI',
		'iqXI',
		'iqEI'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #'VisualWorks metadata' }
MbDGearConstraintIqcJc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDGearConstraintIqcJc class >> withFrmI: afrmI frmJ: afrmJ [ 
	^(afrmI isMemberOf: MbDEndFrameqc) & (afrmJ isMemberOf: MbDEndFramec) 
		ifTrue: [self new withFrmI: afrmI frmJ: afrmJ]
		ifFalse: [nil]
]

{ #category : #accessing }
MbDGearConstraintIqcJc >> addToJointForceI: col [ 
	col equalSelfPlusFullColumn: pGpXI times: lam
]

{ #category : #accessing }
MbDGearConstraintIqcJc >> addToJointTorqueI: jointTorque [ 
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
MbDGearConstraintIqcJc >> addpFIeiGOpEIto: mat [ 
	mat equalSelfPlusFullMatrix: ppGpXIpEI times: lam
]

{ #category : #accessing }
MbDGearConstraintIqcJc >> addpFIeiGOpXIto: mat [ 
	mat equalSelfPlusFullMatrix: ppGpXIpXI times: lam
]

{ #category : #accessing }
MbDGearConstraintIqcJc >> addpFIeiGOplamto: mat [ 
	mat at: 1 and: iG plusFullColumn: pGpXI transpose
]

{ #category : #accessing }
MbDGearConstraintIqcJc >> addpTIeiGOpEIto: mat [ 
	| term11 prOIeOpEIT aFIeiGOover2 term12 term1 term21 pprOIeOpEIpEI term22 pprOIeOpEIipEI term22rowi pFIeiGOpEIover2 term23 aB term2 pTIeiGOpEI |
	term11 := pGpEI transpose times: lam / 2.0d.
	prOIeOpEIT := frmI prOeOpE transpose.
	aFIeiGOover2 := pGpXI transpose times: lam / 2.0d.
	term12 := prOIeOpEIT timesFullColumn: aFIeiGOover2.
	term1 := MbDEulerParameters pBpEtimesColumn: (term11 minusFullColumn: term12).
	term21 := ppGpEIpEI times: lam / 2.0d.
	pprOIeOpEIpEI := frmI pprOeOpEpE.
	term22 := FullMatrix new: 4 by: 4.
	1 to: 4
		do: 
			[:i | 
			pprOIeOpEIipEI := pprOIeOpEIpEI at: i.
			term22rowi := term22 at: i.
			1 to: 4 do: [:j | term22rowi at: j put: ((pprOIeOpEIipEI at: j)
						dot: aFIeiGOover2)]].
	pFIeiGOpEIover2 := ppGpXIpEI times: lam / 2.0d.
	term23 := prOIeOpEIT timesFullMatrix: pFIeiGOpEIover2.
	aB := frmI aBOp.
	term2 := aB timesFullMatrix: ((term21 minusFullMatrix: term22)
					minusFullMatrix: term23).
	pTIeiGOpEI := term1 plusFullMatrix: term2.
	mat equalSelfPlusFullMatrix: pTIeiGOpEI
]

{ #category : #accessing }
MbDGearConstraintIqcJc >> addpTIeiGOpXIto: mat [ 
	| aB term1 prOIeOpEIT pFIeiGOpXIover2 term2 pTIeiGOpXI |
	aB := frmI aBOp.
	term1 := ppGpXIpEI transposeTimes: lam / 2.0d.
	prOIeOpEIT := frmI prOeOpE transpose.
	pFIeiGOpXIover2 := ppGpXIpXI times: lam / 2.0d.
	term2 := prOIeOpEIT timesFullMatrix: pFIeiGOpXIover2.
	pTIeiGOpXI := aB timesFullMatrix: (term1 minusFullMatrix: term2).
	mat equalSelfPlusFullMatrix: pTIeiGOpXI
]

{ #category : #accessing }
MbDGearConstraintIqcJc >> addpTIeiGOplamto: mat [ 
	| halfB term1 prOIeOpEIT pFIeiGOplam term2 pTIeiGOplam |
	halfB := frmI aBOp times: 0.5d.
	term1 := pGpEI transpose.
	prOIeOpEIT := frmI prOeOpE transpose.
	pFIeiGOplam := pGpXI transpose.
	term2 := prOIeOpEIT timesFullColumn: pFIeiGOplam.
	pTIeiGOplam := halfB timesFullColumn: (term1 minusFullColumn: term2).
	mat at: 1 and: iG plusFullColumn: pTIeiGOplam
]

{ #category : #calc }
MbDGearConstraintIqcJc >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	self calc_pGpXI.
	self calc_pGpEI.
	self calc_ppGpXIpXI.
	self calc_ppGpXIpEI.
	self calc_ppGpEIpEI
]

{ #category : #calc }
MbDGearConstraintIqcJc >> calc_pGpEI [
	pGpEI := orbitJeIe pvaluepEJ + (orbitIeJe pvaluepEI times: self ratio)
]

{ #category : #calc }
MbDGearConstraintIqcJc >> calc_pGpXI [
	pGpXI := orbitJeIe pvaluepXJ + (orbitIeJe pvaluepXI times: self ratio)
]

{ #category : #calc }
MbDGearConstraintIqcJc >> calc_ppGpEIpEI [
	ppGpEIpEI := orbitJeIe ppvaluepEJpEJ 
				+ (orbitIeJe ppvaluepEIpEI times: self ratio)
]

{ #category : #calc }
MbDGearConstraintIqcJc >> calc_ppGpXIpEI [
	ppGpXIpEI := orbitJeIe ppvaluepXJpEJ 
				+ (orbitIeJe ppvaluepXIpEI times: self ratio)
]

{ #category : #calc }
MbDGearConstraintIqcJc >> calc_ppGpXIpXI [
	ppGpXIpXI := orbitJeIe ppvaluepXJpXJ 
				+ (orbitIeJe ppvaluepXIpXI times: self ratio)
]

{ #category : #accIC }
MbDGearConstraintIqcJc >> fillAccICIterError: col [ 
	| qXdotI qEdotI sum |
	col at: iqXI plusFullColumn: pGpXI times: lam.
	col at: iqEI plusFullColumn: pGpEI times: lam.
	qXdotI := frmI qXdot.
	qEdotI := frmI qEdot.
	sum := 0.0d.
	sum := sum + (pGpXI timesFullColumn: frmI qXddot).
	sum := sum + (pGpEI timesFullColumn: frmI qEddot).
	sum := sum + (qXdotI transposeTimesFullColumn: (ppGpXIpXI timesFullColumn: qXdotI)).
	sum := sum + (2.0d 	* (qXdotI transposeTimesFullColumn: (ppGpXIpEI timesFullColumn: qEdotI))).
	sum := sum + (qEdotI transposeTimesFullColumn: (ppGpEIpEI timesFullColumn: qEdotI)).
	col at: iG plusNumber: sum
]

{ #category : #posIC }
MbDGearConstraintIqcJc >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: iqXI plusFullColumn: pGpXI times: lam.
	col at: iqEI plusFullColumn: pGpEI times: lam
]

{ #category : #posIC }
MbDGearConstraintIqcJc >> fillPosICJacob: mat [ 
	| ppGpXIpEIlam |
	mat at: iG and: iqXI plusFullRow: pGpXI.
	mat at: iqXI and: iG plusFullColumn: pGpXI transpose.
	mat at: iG and: iqEI plusFullRow: pGpEI.
	mat at: iqEI and: iG plusFullColumn: pGpEI transpose.
	mat at: iqXI and: iqXI plusFullMatrix: ppGpXIpXI times: lam.
	mat at: iqXI and: iqEI plusFullMatrix: (ppGpXIpEIlam := ppGpXIpEI times: lam).
	mat at: iqEI and: iqXI plusTransposeFullMatrix: ppGpXIpEIlam.
	mat at: iqEI and: iqEI plusFullMatrix: ppGpEIpEI times: lam
]

{ #category : #posIC }
MbDGearConstraintIqcJc >> fillPosKineJacob: mat [ 
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
MbDGearConstraintIqcJc >> fillVelICJacob: mat [ 
	mat at: iG and: iqXI plusFullRow: pGpXI.
	mat at: iqXI and: iG plusFullColumn: pGpXI transpose.
	mat at: iG and: iqEI plusFullRow: pGpEI.
	mat at: iqEI and: iG plusFullColumn: pGpEI transpose
]

{ #category : #dynamic }
MbDGearConstraintIqcJc >> fillpFpy: mat [ 
	| ppGpXIpEIlam |
	mat at: iG and: iqXI plusFullRow: pGpXI.
	mat at: iG and: iqEI plusFullRow: pGpEI.
	mat at: iqXI and: iqXI plusFullMatrix: ppGpXIpXI times: lam.
	mat at: iqXI and: iqEI plusFullMatrix: (ppGpXIpEIlam := ppGpXIpEI times: lam).
	mat at: iqEI and: iqXI plusTransposeFullMatrix: ppGpXIpEIlam.
	mat at: iqEI and: iqEI plusFullMatrix: ppGpEIpEI times: lam.
]

{ #category : #dynamic }
MbDGearConstraintIqcJc >> fillpFpydot: mat [ 
	mat at: iqXI and: iG plusFullColumn: pGpXI transpose.
	mat at: iqEI and: iG plusFullColumn: pGpEI transpose
]

{ #category : #'initialize-release' }
MbDGearConstraintIqcJc >> useEquationNumbers [
	iqXI := frmI iqX.
	iqEI := frmI iqE
]
