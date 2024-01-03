Class {
	#name : #MbDDirectionCosineConstraintIqcsJqc,
	#superclass : #MbDDirectionCosineConstraintIqcJqc,
	#instVars : [
		'pGpsI',
		'ppGpEIpsI',
		'ppGpEJpsI',
		'ppGpsIpsI',
		'isI'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #accessing }
MbDDirectionCosineConstraintIqcsJqc >> addpTIeiGOpsIto: mat [ 
	self halt: 'To be implemented.'
]

{ #category : #calc }
MbDDirectionCosineConstraintIqcsJqc >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	pGpsI := aAijIeJe pAijIeJepsI.
	ppGpEIpsI := aAijIeJe ppAijIeJepEIpsI.
	ppGpEJpsI := aAijIeJe ppAijIeJepEJpsI.
	ppGpsIpsI := aAijIeJe ppAijIeJepsIpsI
]

{ #category : #accessing }
MbDDirectionCosineConstraintIqcsJqc >> directionCosineClass [
	^MbDDirectionCosineIeqcsJeqc
]

{ #category : #accIC }
MbDDirectionCosineConstraintIqcsJqc >> fillAccICIterError: col [ 
	| qEdotI sdotI sum qEdotJ |
	super fillAccICIterError: col.
	col at: isI plusFullColumn: pGpsI times: lam.
	qEdotI := frmI qEdot.
	qEdotJ := frmJ qEdot.
	sdotI := frmI sdot.
	sum := 0.0d.
	sum := sum + (pGpsI timesFullColumn: frmI sddot).
	sum := sum + (2.0d * (qEdotI transposeTimesFullColumn: (ppGpEIpsI timesFullColumn: sdotI))).
	sum := sum + (2.0d * (qEdotJ transposeTimesFullColumn: (ppGpEJpsI timesFullColumn: sdotI))).
	sum := sum + (sdotI transposeTimesFullColumn: (ppGpsIpsI timesFullColumn: sdotI)).
	col at: iG plusNumber: sum
]

{ #category : #collision }
MbDDirectionCosineConstraintIqcsJqc >> fillCollisionError: col [ 
	"lamDeriv is now PlamDeriv."
	"qEddot is now qEdotDeriv."

	| sum |
	super fillCollisionError: col.
	col at: isI plusFullColumn: pGpsI times: lamDeriv.
	sum := 0.0d.
	sum := sum + (pGpsI timesFullColumn: frmI sddot).
	col at: iG plusNumber: sum
]

{ #category : #posIC }
MbDDirectionCosineConstraintIqcsJqc >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: isI plusFullColumn: pGpsI times: lam
]

{ #category : #posIC }
MbDDirectionCosineConstraintIqcsJqc >> fillPosICJacob: mat [ 
	| ppGpEIpsIlam ppGpEJpsIlam |
	super fillPosICJacob: mat.
	mat at: iG and: isI plusFullRow: pGpsI.
	mat at: isI and: iG plusFullColumn: pGpsI transpose.
	mat at: iqEI and: isI plusFullMatrix: (ppGpEIpsIlam := ppGpEIpsI times: lam).
	mat at: isI and: iqEI plusTransposeFullMatrix: ppGpEIpsIlam.
	mat at: iqEJ and: isI plusFullMatrix: (ppGpEJpsIlam := ppGpEJpsI times: lam).
	mat at: isI and: iqEJ plusTransposeFullMatrix: ppGpEJpsIlam.
	mat at: isI and: isI plusFullMatrix: ppGpsIpsI times: lam
]

{ #category : #posIC }
MbDDirectionCosineConstraintIqcsJqc >> fillPosKineJacob: mat [ 
	super fillPosKineJacob: mat.
	mat
		at: iG
		and: isI
		plusFullRow: pGpsI
]

{ #category : #velIC }
MbDDirectionCosineConstraintIqcsJqc >> fillVelICJacob: mat [ 
	super fillVelICJacob: mat.
	mat at: iG and: isI plusFullRow: pGpsI.
	mat at: isI and: iG plusFullColumn: pGpsI transpose
]

{ #category : #dynamic }
MbDDirectionCosineConstraintIqcsJqc >> fillpFpy: mat [ 
	| ppGpEIpsIlam ppGpEJpsIlam |
	super fillpFpy: mat.
	mat at: iG and: isI plusFullRow: pGpsI.
	mat at: iqEI and: isI plusFullMatrix: (ppGpEIpsIlam := ppGpEIpsI times: lam).
	mat at: isI and: iqEI plusTransposeFullMatrix: ppGpEIpsIlam.
	mat at: iqEJ and: isI plusFullMatrix: (ppGpEJpsIlam := ppGpEJpsI times: lam).
	mat at: isI and: iqEJ plusTransposeFullMatrix: ppGpEJpsIlam.
	mat at: isI and: isI plusFullMatrix: ppGpsIpsI times: lam
]

{ #category : #dynamic }
MbDDirectionCosineConstraintIqcsJqc >> fillpFpydot: mat [ 
	super fillpFpydot: mat.
	mat at: isI and: iG plusFullColumn: pGpsI transpose
]

{ #category : #accessing }
MbDDirectionCosineConstraintIqcsJqc >> type [
	^#essential
]

{ #category : #'initialize-release' }
MbDDirectionCosineConstraintIqcsJqc >> useEquationNumbers [
	super useEquationNumbers.
	isI := frmI is
]
