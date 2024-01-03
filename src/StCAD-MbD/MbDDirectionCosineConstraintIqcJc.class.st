Class {
	#name : #MbDDirectionCosineConstraintIqcJc,
	#superclass : #MbDDirectionCosineConstraintIJ,
	#instVars : [
		'pGpEI',
		'ppGpEIpEI',
		'iqEI'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #accessing }
MbDDirectionCosineConstraintIqcJc >> addToJointTorqueI: jointTorque [ 
	| aBOIp lampGpE c2Torque |
	aBOIp := frmI aBOp.
	lampGpE := pGpEI transpose times: lam.
	c2Torque := aBOIp timesFullColumn: lampGpE.
	jointTorque equalSelfPlusFullColumn: c2Torque times: 0.5d
]

{ #category : #accessing }
MbDDirectionCosineConstraintIqcJc >> addpTIeiGOpEIto: mat [ 
	"pGpXI := zero. 
	aFIeiGOover2 := zero. 
	term12 := zero. 
	term22 := zero. 
	ppGpXIpEI := zero. 
	pFIeiGOpEIover2 := zero 
	term23 := zero"

	| term11 term1 term21 aB term2 pTIeiGOpEI |
	term11 := pGpEI transpose times: lam / 2.0d.
	term1 := MbDEulerParameters pBpEtimesColumn: term11.
	term21 := ppGpEIpEI times: lam / 2.0d.
	aB := frmI aBOp.
	term2 := aB timesFullMatrix: term21.
	pTIeiGOpEI := term1 plusFullMatrix: term2.
	mat equalSelfPlusFullMatrix: pTIeiGOpEI
]

{ #category : #accessing }
MbDDirectionCosineConstraintIqcJc >> addpTIeiGOplamto: mat [ 
	"pGpXI is zero."
	"term2 is zero."

	| halfB term1 pTIeiGOplam |
	halfB := frmI aBOp times: 0.5d.
	term1 := pGpEI transpose.
	pTIeiGOplam := halfB timesFullColumn: term1.
	mat at: 1 and: iG plusFullColumn: pTIeiGOplam
]

{ #category : #calc }
MbDDirectionCosineConstraintIqcJc >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	pGpEI := aAijIeJe pAijIeJepEI.
	ppGpEIpEI := aAijIeJe ppAijIeJepEIpEI
]

{ #category : #accessing }
MbDDirectionCosineConstraintIqcJc >> directionCosineClass [
	^MbDDirectionCosineIeqcJec
]

{ #category : #accIC }
MbDDirectionCosineConstraintIqcJc >> fillAccICIterError: col [ 
	| qEdotI sum |
	col at: iqEI plusFullColumn: pGpEI times: lam.
	qEdotI := frmI qEdot.
	sum := 0.0d.
	sum := sum + (pGpEI timesFullColumn: frmI qEddot).
	sum := sum + (qEdotI transposeTimesFullColumn: (ppGpEIpEI timesFullColumn: qEdotI)).
	col at: iG plusNumber: sum
]

{ #category : #collision }
MbDDirectionCosineConstraintIqcJc >> fillCollisionError: col [ 
	"lamDeriv is now PlamDeriv."
	"qEddot is now qEdotDeriv."

	| sum |
	col at: iqEI plusFullColumn: pGpEI times: lamDeriv.
	sum := 0.0d.
	sum := sum + (pGpEI timesFullColumn: frmI qEddot).
	col at: iG plusNumber: sum
]

{ #category : #posIC }
MbDDirectionCosineConstraintIqcJc >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: iqEI plusFullColumn: pGpEI times: lam
]

{ #category : #posIC }
MbDDirectionCosineConstraintIqcJc >> fillPosICJacob: mat [ 
	mat at: iG and: iqEI plusFullRow: pGpEI.
	mat at: iqEI and: iG plusFullColumn: pGpEI transpose.
	mat at: iqEI and: iqEI plusFullMatrix: ppGpEIpEI times: lam
]

{ #category : #posIC }
MbDDirectionCosineConstraintIqcJc >> fillPosKineJacob: mat [ 
	mat
		at: iG
		and: iqEI
		plusFullRow: pGpEI
]

{ #category : #velIC }
MbDDirectionCosineConstraintIqcJc >> fillVelICJacob: mat [ 
	mat at: iG and: iqEI plusFullRow: pGpEI.
	mat at: iqEI and: iG plusFullColumn: pGpEI transpose
]

{ #category : #dynamic }
MbDDirectionCosineConstraintIqcJc >> fillpFpy: mat [ 
	mat at: iG and: iqEI plusFullRow: pGpEI.
	mat at: iqEI and: iqEI plusFullMatrix: ppGpEIpEI times: lam
]

{ #category : #dynamic }
MbDDirectionCosineConstraintIqcJc >> fillpFpydot: mat [ 
	mat at: iqEI and: iG plusFullColumn: pGpEI transpose
]

{ #category : #'initialize-release' }
MbDDirectionCosineConstraintIqcJc >> useEquationNumbers [
	iqEI := frmI iqE
]
