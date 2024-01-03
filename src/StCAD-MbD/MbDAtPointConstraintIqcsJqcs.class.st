Class {
	#name : #MbDAtPointConstraintIqcsJqcs,
	#superclass : #MbDAtPointConstraintIqcsJqc,
	#instVars : [
		'isJ',
		'pGpsJ',
		'ppGpEJpsJ',
		'ppGpsJpsJ'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #accessing }
MbDAtPointConstraintIqcsJqcs >> addpTIeiGOpsJto: mat [ 
	self halt: 'To be implemented.'
]

{ #category : #calc }
MbDAtPointConstraintIqcsJqcs >> calcPostDynCorrectorIteration [
	"ppGpEJpEJ is no longer constant."

	ppGpEJpEJ := riIeJeO ppriIeJeOpEJpEJ.
	super calcPostDynCorrectorIteration.
	pGpsJ := riIeJeO priIeJeOpsJ.
	ppGpEJpsJ := riIeJeO ppriIeJeOpEJpsJ.
	ppGpsJpsJ := riIeJeO ppriIeJeOpsJpsJ
]

{ #category : #accessing }
MbDAtPointConstraintIqcsJqcs >> dispCompClass [
	^MbDDispCompIeqcsJeqcsO
]

{ #category : #accIC }
MbDAtPointConstraintIqcsJqcs >> fillAccICIterError: col [ 
	| qEdotJ sdotJ sum |
	super fillAccICIterError: col.
	col at: isJ plusFullColumn: pGpsJ times: lam.
	qEdotJ := frmJ qEdot.
	sdotJ := frmJ sdot.
	sum := 0.0d.
	sum := sum + (pGpsJ timesFullColumn: frmJ sddot).
	sum := sum + (2.0d * (qEdotJ transposeTimesFullColumn: (ppGpEJpsJ timesFullColumn: sdotJ))).
	sum := sum + (sdotJ transposeTimesFullColumn: (ppGpsJpsJ timesFullColumn: sdotJ)).
	col at: iG plusNumber: sum
]

{ #category : #posIC }
MbDAtPointConstraintIqcsJqcs >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: isJ plusFullColumn: pGpsJ times: lam
]

{ #category : #posIC }
MbDAtPointConstraintIqcsJqcs >> fillPosICJacob: mat [ 
	| ppGpEJpsJlam |
	super fillPosICJacob: mat.
	mat at: iG and: isJ plusFullRow: pGpsJ.
	mat at: isJ and: iG plusFullColumn: pGpsJ transpose.
	mat at: iqEJ and: isJ plusFullMatrix: (ppGpEJpsJlam := ppGpEJpsJ times: lam).
	mat at: isJ and: iqEJ plusTransposeFullMatrix: ppGpEJpsJlam.
	mat at: isJ and: isJ plusFullMatrix: ppGpsJpsJ times: lam
]

{ #category : #posIC }
MbDAtPointConstraintIqcsJqcs >> fillPosKineJacob: mat [ 
	super fillPosKineJacob: mat.
	mat at: iG and: isJ plusFullRow: pGpsJ
]

{ #category : #velIC }
MbDAtPointConstraintIqcsJqcs >> fillVelICJacob: mat [ 
	super fillVelICJacob: mat.
	mat at: iG and: isJ plusFullRow: pGpsJ.
	mat at: isJ and: iG plusFullColumn: pGpsJ transpose
]

{ #category : #dynamic }
MbDAtPointConstraintIqcsJqcs >> fillpFpy: mat [ 
	super fillpFpy: mat.
	mat at: iG and: isJ plusFullRow: pGpsJ.
	mat at: iqEJ and: isJ plusFullMatrix: ppGpEJpsJ times: lam.
	mat at: isJ and: isJ plusFullMatrix: ppGpsJpsJ times: lam
]

{ #category : #dynamic }
MbDAtPointConstraintIqcsJqcs >> fillpFpydot: mat [ 
	super fillpFpydot: mat.
	mat at: isJ and: iG plusFullColumn: pGpsJ transpose
]

{ #category : #'initialize-release' }
MbDAtPointConstraintIqcsJqcs >> initializeGlobally [
	riIeJeO initializeGlobally
]

{ #category : #'initialize-release' }
MbDAtPointConstraintIqcsJqcs >> useEquationNumbers [
	super useEquationNumbers.
	isJ := frmJ is
]
