Class {
	#name : #MbDTranslationConstraintIqcsJqc,
	#superclass : #MbDTranslationConstraintIqcJqc,
	#instVars : [
		'isI',
		'pGpsI',
		'ppGpXIpsI',
		'ppGpEIpsI',
		'ppGpXJpsI',
		'ppGpEJpsI',
		'ppGpsIpsI'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #accessing }
MbDTranslationConstraintIqcsJqc >> addpTIeiGOpsIto: mat [ 
	self halt: 'To be implemented.'
]

{ #category : #calc }
MbDTranslationConstraintIqcsJqc >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	pGpsI := riIeJeIe pvaluepsI plusFullRow: riIeJeIe pvaluepsK.
	ppGpXIpsI := riIeJeIe ppvaluepXIpsK.
	ppGpEIpsI := (riIeJeIe ppvaluepEIpsI plusFullMatrix: riIeJeIe ppvaluepEIpsK)
				plusFullMatrix: (riIeJeIe ppvaluepsIpEK transpose plusFullMatrix: riIeJeIe ppvaluepEKpsK).
	ppGpXJpsI := riIeJeIe ppvaluepXJpsK.
	ppGpEJpsI := riIeJeIe ppvaluepEJpsK.
	ppGpsIpsI := (riIeJeIe ppvaluepsIpsI plusFullMatrix: riIeJeIe ppvaluepsIpsK)
				plusFullMatrix: (riIeJeIe ppvaluepsIpsK transpose plusFullMatrix: riIeJeIe ppvaluepsKpsK)
]

{ #category : #accessing }
MbDTranslationConstraintIqcsJqc >> dispCompClass [
	^MbDDispCompIeqcsJeqcKeqcs
]

{ #category : #accIC }
MbDTranslationConstraintIqcsJqc >> fillAccICIterError: col [ 
	| qXdotI qEdotI sdotI sum qXdotJ qEdotJ |
	super fillAccICIterError: col.
	col at: isI plusFullColumn: pGpsI times: lam.
	qXdotI := frmI qXdot.
	qEdotI := frmI qEdot.
	qXdotJ := frmJ qXdot.
	qEdotJ := frmJ qEdot.
	sdotI := frmI sdot.
	sum := 0.0d.
	sum := sum + (pGpsI timesFullColumn: frmI sddot).
	sum := sum + (2.0d * (qXdotI transposeTimesFullColumn: (ppGpXIpsI timesFullColumn: sdotI))).
	sum := sum + (2.0d * (qEdotI transposeTimesFullColumn: (ppGpEIpsI timesFullColumn: sdotI))).
	sum := sum + (2.0d * (qXdotJ transposeTimesFullColumn: (ppGpXJpsI timesFullColumn: sdotI))).
	sum := sum + (2.0d * (qEdotJ transposeTimesFullColumn: (ppGpEJpsI timesFullColumn: sdotI))).
	sum := sum + (sdotI transposeTimesFullColumn: (ppGpsIpsI timesFullColumn: sdotI)).
	col at: iG plusNumber: sum
]

{ #category : #collision }
MbDTranslationConstraintIqcsJqc >> fillCollisionError: col [ 
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
MbDTranslationConstraintIqcsJqc >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: isI plusFullColumn: pGpsI times: lam
]

{ #category : #posIC }
MbDTranslationConstraintIqcsJqc >> fillPosICJacob: mat [ 
	| ppGpXIpsIlam ppGpEIpsIlam ppGpXJpsIlam ppGpEJpsIlam |
	super fillPosICJacob: mat.
	mat at: iG and: isI plusFullRow: pGpsI.
	mat at: isI and: iG plusFullColumn: pGpsI transpose.
	mat at: iqXI and: isI plusFullMatrix: (ppGpXIpsIlam := ppGpXIpsI times: lam).
	mat at: isI and: iqXI plusTransposeFullMatrix: ppGpXIpsIlam.
	mat at: iqEI and: isI plusFullMatrix: (ppGpEIpsIlam := ppGpEIpsI times: lam).
	mat at: isI and: iqEI plusTransposeFullMatrix: ppGpEIpsIlam.
	mat at: iqXJ and: isI plusFullMatrix: (ppGpXJpsIlam := ppGpXJpsI times: lam).
	mat at: isI and: iqXJ plusTransposeFullMatrix: ppGpXJpsIlam.
	mat at: iqEJ and: isI plusFullMatrix: (ppGpEJpsIlam := ppGpEJpsI times: lam).
	mat at: isI and: iqEJ plusTransposeFullMatrix: ppGpEJpsIlam.
	mat at: isI and: isI plusFullMatrix: ppGpsIpsI times: lam
]

{ #category : #posIC }
MbDTranslationConstraintIqcsJqc >> fillPosKineJacob: mat [ 
	super fillPosKineJacob: mat.
	mat
		at: iG
		and: isI
		plusFullRow: pGpsI
]

{ #category : #velIC }
MbDTranslationConstraintIqcsJqc >> fillVelICJacob: mat [ 
	super fillVelICJacob: mat.
	mat at: iG and: isI plusFullRow: pGpsI.
	mat at: isI and: iG plusFullColumn: pGpsI transpose
]

{ #category : #dynamic }
MbDTranslationConstraintIqcsJqc >> fillpFpy: mat [ 
	| ppGpXIpsIlam ppGpEIpsIlam ppGpXJpsIlam ppGpEJpsIlam |
	super fillpFpy: mat.
	mat at: iG and: isI plusFullRow: pGpsI.
	mat at: iqXI and: isI plusFullMatrix: (ppGpXIpsIlam := ppGpXIpsI times: lam).
	mat at: isI and: iqXI plusTransposeFullMatrix: ppGpXIpsIlam.
	mat at: iqEI and: isI plusFullMatrix: (ppGpEIpsIlam := ppGpEIpsI times: lam).
	mat at: isI and: iqEI plusTransposeFullMatrix: ppGpEIpsIlam.
	mat at: iqXJ and: isI plusFullMatrix: (ppGpXJpsIlam := ppGpXJpsI times: lam).
	mat at: isI and: iqXJ plusTransposeFullMatrix: ppGpXJpsIlam.
	mat at: iqEJ and: isI plusFullMatrix: (ppGpEJpsIlam := ppGpEJpsI times: lam).
	mat at: isI and: iqEJ plusTransposeFullMatrix: ppGpEJpsIlam.
	mat at: isI and: isI plusFullMatrix: ppGpsIpsI times: lam
]

{ #category : #dynamic }
MbDTranslationConstraintIqcsJqc >> fillpFpydot: mat [ 
	super fillpFpydot: mat.
	mat at: isI and: iG plusFullColumn: pGpsI transpose
]

{ #category : #accessing }
MbDTranslationConstraintIqcsJqc >> type [
	^#essential
]

{ #category : #'initialize-release' }
MbDTranslationConstraintIqcsJqc >> useEquationNumbers [
	super useEquationNumbers.
	isI := frmI is
]
