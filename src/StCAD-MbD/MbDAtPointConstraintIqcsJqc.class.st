Class {
	#name : #MbDAtPointConstraintIqcsJqc,
	#superclass : #MbDAtPointConstraintIqcJqc,
	#instVars : [
		'isI',
		'pGpsI',
		'ppGpEIpsI',
		'ppGpsIpsI'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #accessing }
MbDAtPointConstraintIqcsJqc >> addpTIeiGOpsIto: mat [ 
	self halt: 'To be implemented.'
]

{ #category : #calc }
MbDAtPointConstraintIqcsJqc >> calcPostDynCorrectorIteration [
	"ppGpEIpEI is no longer constant."

	ppGpEIpEI := riIeJeO ppriIeJeOpEIpEI.
	super calcPostDynCorrectorIteration.
	pGpsI := riIeJeO priIeJeOpsI.
	ppGpEIpsI := riIeJeO ppriIeJeOpEIpsI.
	ppGpsIpsI := riIeJeO ppriIeJeOpsIpsI
]

{ #category : #accessing }
MbDAtPointConstraintIqcsJqc >> dispCompClass [
	^MbDDispCompIeqcsJeqcO
]

{ #category : #accIC }
MbDAtPointConstraintIqcsJqc >> fillAccICIterError: col [ 
	| qEdotI sdotI sum |
	super fillAccICIterError: col.
	col at: isI plusFullColumn: pGpsI times: lam.
	qEdotI := frmI qEdot.
	sdotI := frmI sdot.
	sum := 0.0d.
	sum := sum + (pGpsI timesFullColumn: frmI sddot).
	sum := sum + (2.0d * (qEdotI transposeTimesFullColumn: (ppGpEIpsI timesFullColumn: sdotI))).
	sum := sum + (sdotI transposeTimesFullColumn: (ppGpsIpsI timesFullColumn: sdotI)).
	col at: iG plusNumber: sum
]

{ #category : #posIC }
MbDAtPointConstraintIqcsJqc >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: isI plusFullColumn: pGpsI times: lam
]

{ #category : #posIC }
MbDAtPointConstraintIqcsJqc >> fillPosICJacob: mat [ 
	| ppGpEIpsIlam |
	super fillPosICJacob: mat.
	mat at: iG and: isI plusFullRow: pGpsI.
	mat at: isI and: iG plusFullColumn: pGpsI transpose.
	mat at: iqEI and: isI plusFullMatrix: (ppGpEIpsIlam := ppGpEIpsI times: lam).
	mat at: isI and: iqEI plusTransposeFullMatrix: ppGpEIpsIlam.
	mat at: isI and: isI plusFullMatrix: ppGpsIpsI times: lam
]

{ #category : #posIC }
MbDAtPointConstraintIqcsJqc >> fillPosKineJacob: mat [ 
	super fillPosKineJacob: mat.
	mat at: iG and: isI plusFullRow: pGpsI
]

{ #category : #velIC }
MbDAtPointConstraintIqcsJqc >> fillVelICJacob: mat [ 
	super fillVelICJacob: mat.
	mat at: iG and: isI plusFullRow: pGpsI.
	mat at: isI and: iG plusFullColumn: pGpsI transpose
]

{ #category : #dynamic }
MbDAtPointConstraintIqcsJqc >> fillpFpy: mat [ 
	super fillpFpy: mat.
	mat at: iG and: isI plusFullRow: pGpsI.
	mat at: iqEI and: isI plusFullMatrix: ppGpEIpsI times: lam.
	mat at: isI and: isI plusFullMatrix: ppGpsIpsI times: lam
]

{ #category : #dynamic }
MbDAtPointConstraintIqcsJqc >> fillpFpydot: mat [ 
	super fillpFpydot: mat.
	mat at: isI and: iG plusFullColumn: pGpsI transpose
]

{ #category : #'initialize-release' }
MbDAtPointConstraintIqcsJqc >> initializeGlobally [
	riIeJeO initializeGlobally.
	ppGpEJpEJ := riIeJeO ppriIeJeOpEJpEJ
]

{ #category : #accessing }
MbDAtPointConstraintIqcsJqc >> type [
	^#essential
]

{ #category : #'initialize-release' }
MbDAtPointConstraintIqcsJqc >> useEquationNumbers [
	super useEquationNumbers.
	isI := frmI is
]
