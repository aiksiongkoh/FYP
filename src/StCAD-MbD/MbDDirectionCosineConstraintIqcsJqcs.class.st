Class {
	#name : #MbDDirectionCosineConstraintIqcsJqcs,
	#superclass : #MbDDirectionCosineConstraintIqcsJqc,
	#instVars : [
		'pGpsJ',
		'ppGpEIpsJ',
		'ppGpEJpsJ',
		'ppGpsIpsJ',
		'ppGpsJpsJ',
		'isJ'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #calc }
MbDDirectionCosineConstraintIqcsJqcs >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	pGpsJ := aAijIeJe pAijIeJepsJ.
	ppGpEIpsJ := aAijIeJe ppAijIeJepEIpsJ.
	ppGpEJpsJ := aAijIeJe ppAijIeJepEJpsJ.
	ppGpsIpsJ := aAijIeJe ppAijIeJepsIpsJ.
	ppGpsJpsJ := aAijIeJe ppAijIeJepsJpsJ
]

{ #category : #accessing }
MbDDirectionCosineConstraintIqcsJqcs >> directionCosineClass [
	^MbDDirectionCosineIeqcsJeqcs
]

{ #category : #accIC }
MbDDirectionCosineConstraintIqcsJqcs >> fillAccICIterError: col [ 
	| qEdotI sdotI qEdotJ sdotJ sum |
	super fillAccICIterError: col.
	col at: isJ plusFullColumn: pGpsJ times: lam.
	qEdotI := frmI qEdot.
	sdotI := frmI sdot.
	qEdotJ := frmJ qEdot.
	sdotJ := frmJ sdot.
	sum := 0.0d.
	sum := sum + (pGpsJ timesFullColumn: frmJ sddot).
	sum := sum + (2.0d * (qEdotI transposeTimesFullColumn: (ppGpEIpsJ timesFullColumn: sdotJ))).
	sum := sum + (2.0d * (sdotI transposeTimesFullColumn: (ppGpsIpsJ timesFullColumn: sdotJ))).
	sum := sum + (2.0d * (qEdotJ transposeTimesFullColumn: (ppGpEJpsJ timesFullColumn: sdotJ))).
	sum := sum + (sdotJ transposeTimesFullColumn: (ppGpsJpsJ timesFullColumn: sdotJ)).
	col at: iG plusNumber: sum
]

{ #category : #collision }
MbDDirectionCosineConstraintIqcsJqcs >> fillCollisionError: col [ 
	"lamDeriv is now PlamDeriv."
	"qEddot is now qEdotDeriv."

	| sum |
	super fillCollisionError: col.
	col at: isJ plusFullColumn: pGpsJ times: lamDeriv.
	sum := 0.0d.
	sum := sum + (pGpsJ timesFullColumn: frmJ sddot).
	col at: iG plusNumber: sum
]

{ #category : #posIC }
MbDDirectionCosineConstraintIqcsJqcs >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: isJ plusFullColumn: pGpsJ times: lam
]

{ #category : #posIC }
MbDDirectionCosineConstraintIqcsJqcs >> fillPosICJacob: mat [ 
	| ppGpEIpsJlam ppGpEJpsJlam ppGpsIpsJlam |
	super fillPosICJacob: mat.
	mat at: iG and: isJ plusFullRow: pGpsJ.
	mat at: isJ and: iG plusFullColumn: pGpsJ transpose.
	mat at: iqEI and: isJ plusFullMatrix: (ppGpEIpsJlam := ppGpEIpsJ times: lam).
	mat at: isJ and: iqEI plusTransposeFullMatrix: ppGpEIpsJlam.
	mat at: isI and: isJ plusFullMatrix: (ppGpsIpsJlam := ppGpsIpsJ times: lam).
	mat at: isJ and: isI plusTransposeFullMatrix: ppGpsIpsJlam.
	mat at: iqEJ and: isJ plusFullMatrix: (ppGpEJpsJlam := ppGpEJpsJ times: lam).
	mat at: isJ and: iqEJ plusTransposeFullMatrix: ppGpEJpsJlam.
	mat at: isJ and: isJ plusFullMatrix: ppGpsJpsJ times: lam
]

{ #category : #posIC }
MbDDirectionCosineConstraintIqcsJqcs >> fillPosKineJacob: mat [ 
	super fillPosKineJacob: mat.
	mat
		at: iG
		and: isJ
		plusFullRow: pGpsJ
]

{ #category : #velIC }
MbDDirectionCosineConstraintIqcsJqcs >> fillVelICJacob: mat [ 
	super fillVelICJacob: mat.
	mat at: iG and: isJ plusFullRow: pGpsJ.
	mat at: isJ and: iG plusFullColumn: pGpsJ transpose
]

{ #category : #dynamic }
MbDDirectionCosineConstraintIqcsJqcs >> fillpFpy: mat [ 
	| ppGpEIpsJlam ppGpsIpsJlam ppGpEJpsJlam |
	super fillpFpy: mat.
	mat at: iG and: isJ plusFullRow: pGpsJ.
	mat at: iqEI and: isJ plusFullMatrix: (ppGpEIpsJlam := ppGpEIpsJ times: lam).
	mat at: isJ and: iqEI plusTransposeFullMatrix: ppGpEIpsJlam.
	mat at: isI and: isJ plusFullMatrix: (ppGpsIpsJlam := ppGpsIpsJ times: lam).
	mat at: isJ and: isI plusTransposeFullMatrix: ppGpsIpsJlam.
	mat at: iqEJ and: isJ plusFullMatrix: (ppGpEJpsJlam := ppGpEJpsJ times: lam).
	mat at: isJ and: iqEJ plusTransposeFullMatrix: ppGpEJpsJlam.
	mat at: isJ and: isJ plusFullMatrix: ppGpsJpsJ times: lam
]

{ #category : #dynamic }
MbDDirectionCosineConstraintIqcsJqcs >> fillpFpydot: mat [ 
	super fillpFpydot: mat.
	mat at: isJ and: iG plusFullColumn: pGpsJ transpose
]

{ #category : #'initialize-release' }
MbDDirectionCosineConstraintIqcsJqcs >> useEquationNumbers [
	super useEquationNumbers.
	isJ := frmJ is
]
