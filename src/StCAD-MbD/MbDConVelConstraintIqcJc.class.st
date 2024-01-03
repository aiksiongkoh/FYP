Class {
	#name : #MbDConVelConstraintIqcJc,
	#superclass : #MbDConVelConstraintIJ,
	#instVars : [
		'pGpEI',
		'ppGpEIpEI',
		'iqEI'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #accessing }
MbDConVelConstraintIqcJc >> addToJointTorqueI: jointTorque [ 
	| aBOIp lampGpE c2Torque |
	aBOIp := frmI aBOp.
	lampGpE := pGpEI transpose times: lam.
	c2Torque := aBOIp timesFullColumn: lampGpE.
	jointTorque equalSelfPlusFullColumn: c2Torque times: 0.5d
]

{ #category : #accessing }
MbDConVelConstraintIqcJc >> addpTIeiGOpEIto: mat [ 
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
MbDConVelConstraintIqcJc >> addpTIeiGOplamto: mat [ 
	"pGpXI is zero."
	"term2 is zero."

	| halfB term1 pTIeiGOplam |
	halfB := frmI aBOp times: 0.5d.
	term1 := pGpEI transpose.
	pTIeiGOplam := halfB timesFullColumn: term1.
	mat at: 1 and: iG plusFullColumn: pTIeiGOplam
]

{ #category : #calc }
MbDConVelConstraintIqcJc >> calcPostDynCorrectorIteration [
	| pA12IeJepEI ppA12IeJepEIpEI pA21IeJepEI ppA21IeJepEIpEI ppGpEIpEIi ppA12IeJepEIpEIi ppA21IeJepEIpEIi ppGpEIpEIij |
	super calcPostDynCorrectorIteration.
	pA12IeJepEI := aA12IeJe pAijIeJepEI.
	ppA12IeJepEIpEI := aA12IeJe ppAijIeJepEIpEI.
	pA21IeJepEI := aA21IeJe pAijIeJepEI.
	ppA21IeJepEIpEI := aA21IeJe ppAijIeJepEIpEI.
	1 to: 4 do: [:i | pGpEI at: i put: (pA12IeJepEI at: i) + (pA21IeJepEI at: i)].
	1 to: 4 do: [:i | 
			ppGpEIpEIi := ppGpEIpEI at: i.
			ppA12IeJepEIpEIi := ppA12IeJepEIpEI at: i.
			ppA21IeJepEIpEIi := ppA21IeJepEIpEI at: i.
			ppGpEIpEIi at: i put: (ppA12IeJepEIpEIi at: i) + (ppA21IeJepEIpEIi at: i).
			i + 1 to: 4 do: [:j | 
					ppGpEIpEIij := (ppA12IeJepEIpEIi at: j) + (ppA21IeJepEIpEIi at: j).
					ppGpEIpEIi at: j put: ppGpEIpEIij.
					ppGpEIpEI at: j and: i put: ppGpEIpEIij]]
]

{ #category : #accIC }
MbDConVelConstraintIqcJc >> fillAccICIterError: col [ 
	| qEdotI sum |
	col at: iqEI plusFullColumn: pGpEI times: lam.
	qEdotI := frmI qEdot.
	sum := 0.0d.
	sum := sum + (pGpEI timesFullColumn: frmI qEddot).
	sum := sum + (qEdotI transposeTimesFullColumn: (ppGpEIpEI timesFullColumn: qEdotI)).
	col at: iG plusNumber: sum
]

{ #category : #posIC }
MbDConVelConstraintIqcJc >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: iqEI plusFullColumn: pGpEI times: lam
]

{ #category : #posIC }
MbDConVelConstraintIqcJc >> fillPosICJacob: mat [ 
	mat at: iG and: iqEI plusFullRow: pGpEI.
	mat at: iqEI and: iG plusFullColumn: pGpEI transpose.
	mat at: iqEI and: iqEI plusFullMatrix: ppGpEIpEI times: lam
]

{ #category : #posIC }
MbDConVelConstraintIqcJc >> fillPosKineJacob: mat [ 
	mat at: iG and: iqEI plusFullRow: pGpEI
]

{ #category : #velIC }
MbDConVelConstraintIqcJc >> fillVelICJacob: mat [ 
	mat at: iG and: iqEI plusFullRow: pGpEI.
	mat at: iqEI and: iG plusFullColumn: pGpEI transpose
]

{ #category : #dynamic }
MbDConVelConstraintIqcJc >> fillpFpy: mat [ 
	mat at: iG and: iqEI plusFullRow: pGpEI.
	mat at: iqEI and: iqEI plusFullMatrix: ppGpEIpEI times: lam
]

{ #category : #dynamic }
MbDConVelConstraintIqcJc >> fillpFpydot: mat [ 
	mat at: iqEI and: iG plusFullColumn: pGpEI transpose
]

{ #category : #'initialize-release' }
MbDConVelConstraintIqcJc >> initA12IeJe [
	aA12IeJe := MbDDirectionCosineIeqcJec new
]

{ #category : #'initialize-release' }
MbDConVelConstraintIqcJc >> initA21IeJe [
	aA21IeJe := MbDDirectionCosineIeqcJec new
]

{ #category : #'initialize-release' }
MbDConVelConstraintIqcJc >> initialize [
	super initialize.
	pGpEI := FullRow new: 4.
	ppGpEIpEI := FullMatrix new: 4 by: 4
]

{ #category : #'initialize-release' }
MbDConVelConstraintIqcJc >> useEquationNumbers [
	iqEI := frmI iqE
]
