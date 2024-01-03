Class {
	#name : #MbDAtPointConstraintIqcJc,
	#superclass : #MbDAtPointConstraintIJ,
	#instVars : [
		'pGpEI',
		'ppGpEIpEI',
		'iqXIminusOnePlusAxis',
		'iqEI'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #accessing }
MbDAtPointConstraintIqcJc >> addToJointForceI: col [ 
	col at: axis minusNumber: lam
]

{ #category : #accessing }
MbDAtPointConstraintIqcJc >> addToJointTorqueI: jointTorque [ 
	| cForceT rIpIeIp pAOIppEI aBOIp fpAOIppEIrIpIeIp dum lampGpE c2Torque |
	cForceT := (FullRow zero: 3).
	cForceT at: axis put: lam negated.
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
MbDAtPointConstraintIqcJc >> addpFIeiGOplamto: mat [ 
	(mat at: axis)
		at: iG plusNumber: -1.0d
]

{ #category : #accessing }
MbDAtPointConstraintIqcJc >> addpTIeiGOpEIto: mat [ 
	"ppGpXIpEI := zero. 
	pFIeiGOpEIover4 := zero 
	term23 := zero"

	| term11 prOIeOpEIT aFIeiGOover2 term12 term1 term21 pprOIeOpEIpEI term22 pprOIeOpEIipEI term22rowi aB term2 pTIeiGOpEI |
	term11 := pGpEI transpose times: lam / 2.0d.
	prOIeOpEIT := frmI prOeOpE transpose.
	aFIeiGOover2 := (FullColumn zero: 3).
	aFIeiGOover2 at: axis put: lam / -2.0d.
	term12 := prOIeOpEIT timesFullColumn: aFIeiGOover2.
	term1 := MbDEulerParameters pBpEtimesColumn: (term11 minusFullColumn: term12).
	term21 := ppGpEIpEI times: lam / 2.0d.
	pprOIeOpEIpEI := frmI pprOeOpEpE.
	term22 := FullMatrix new: 4 by: 4.
	1 to: 4 do: [:i | 
			pprOIeOpEIipEI := pprOIeOpEIpEI at: i.
			term22rowi := term22 at: i.
			1 to: 4 do: [:j | term22rowi at: j put: ((pprOIeOpEIipEI at: j) dot: aFIeiGOover2)]].
	aB := frmI aBOp.
	term2 := aB timesFullMatrix: (term21 minusFullMatrix: term22).
	pTIeiGOpEI := term1 plusFullMatrix: term2.
	mat equalSelfPlusFullMatrix: pTIeiGOpEI
]

{ #category : #accessing }
MbDAtPointConstraintIqcJc >> addpTIeiGOplamto: mat [ 
	| halfB term1 prOIeOpEIT pFIeiGOplam term2 pTIeiGOplam |
	halfB := frmI aBOp times: 0.5d.
	term1 := pGpEI transpose.
	prOIeOpEIT := frmI prOeOpE transpose.
	pFIeiGOplam := (FullColumn zero: 3).
	pFIeiGOplam at: axis put: -1.0d.
	term2 := prOIeOpEIT timesFullColumn: pFIeiGOplam.
	pTIeiGOplam := halfB timesFullColumn: (term1 minusFullColumn: term2).
	mat at: 1 and: iG plusFullColumn: pTIeiGOplam
]

{ #category : #calc }
MbDAtPointConstraintIqcJc >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	pGpEI := riIeJeO priIeJeOpEI
]

{ #category : #accessing }
MbDAtPointConstraintIqcJc >> dispCompClass [
	^MbDDispCompIeqcJecO
]

{ #category : #accIC }
MbDAtPointConstraintIqcJc >> fillAccICIterError: col [ 
	| qEdotI sum |
	col at: iqXIminusOnePlusAxis minusNumber: lam.
	col at: iqEI plusFullColumn: pGpEI times: lam.
	qEdotI := frmI qEdot.
	sum := 0.0d.
	sum := sum - (frmI qXddot at: axis).
	sum := sum + (pGpEI timesFullColumn: frmI qEddot).
	sum := sum + (qEdotI transposeTimesFullColumn: (ppGpEIpEI timesFullColumn: qEdotI)).
	col at: iG plusNumber: sum
]

{ #category : #collision }
MbDAtPointConstraintIqcJc >> fillCollisionError: col [ 
	"lamDeriv is now PlamDeriv."
	"qEddot is now qEdotDeriv."

	| sum |
	col at: iqXIminusOnePlusAxis minusNumber: lamDeriv.
	col at: iqEI plusFullColumn: pGpEI times: lamDeriv.
	sum := 0.0d.
	sum := sum - (frmI qXddot at: axis).
	sum := sum + (pGpEI timesFullColumn: frmI qEddot).
	col at: iG plusNumber: sum
]

{ #category : #posIC }
MbDAtPointConstraintIqcJc >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: iqXIminusOnePlusAxis minusNumber: lam.
	col at: iqEI plusFullColumn: pGpEI times: lam
]

{ #category : #posIC }
MbDAtPointConstraintIqcJc >> fillPosICJacob: mat [ 
	mat at: iG and: iqXIminusOnePlusAxis plusNumber: -1.0d.
	mat at: iqXIminusOnePlusAxis and: iG plusNumber: -1.0d.
	mat at: iG and: iqEI plusFullRow: pGpEI.
	mat at: iqEI and: iG plusFullColumn: pGpEI transpose.
	mat at: iqEI and: iqEI plusFullMatrix: ppGpEIpEI times: lam
]

{ #category : #posIC }
MbDAtPointConstraintIqcJc >> fillPosKineJacob: mat [ 
	mat at: iG and: iqXIminusOnePlusAxis plusNumber: -1.0d.
	mat at: iG and: iqEI plusFullRow: pGpEI
]

{ #category : #velIC }
MbDAtPointConstraintIqcJc >> fillVelICJacob: mat [ 
	mat at: iG and: iqXIminusOnePlusAxis plusNumber: -1.0d.
	mat at: iqXIminusOnePlusAxis and: iG plusNumber: -1.0d.
	mat at: iG and: iqEI plusFullRow: pGpEI.
	mat at: iqEI and: iG plusFullColumn: pGpEI transpose
]

{ #category : #dynamic }
MbDAtPointConstraintIqcJc >> fillpFpy: mat [ 
	mat at: iG and: iqXIminusOnePlusAxis plusNumber: -1.0d.
	mat at: iG and: iqEI plusFullRow: pGpEI.
	mat at: iqEI and: iqEI plusFullMatrix: ppGpEIpEI times: lam
]

{ #category : #dynamic }
MbDAtPointConstraintIqcJc >> fillpFpydot: mat [ 
	mat at: iqXIminusOnePlusAxis and: iG plusNumber: -1.0d.
	mat at: iqEI and: iG plusFullColumn: pGpEI transpose
]

{ #category : #'initialize-release' }
MbDAtPointConstraintIqcJc >> initializeGlobally [
	super initializeGlobally.
	ppGpEIpEI := riIeJeO ppriIeJeOpEIpEI
]

{ #category : #'initialize-release' }
MbDAtPointConstraintIqcJc >> useEquationNumbers [
	iqXIminusOnePlusAxis := frmI iqX - 1 + axis.
	iqEI := frmI iqE
]
