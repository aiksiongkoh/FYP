Class {
	#name : #MbDTranslationConstraintIqcsJqcs,
	#superclass : #MbDTranslationConstraintIqcsJqc,
	#instVars : [
		'isJ',
		'pGpsJ',
		'ppGpEIpsJ',
		'ppGpEJpsJ',
		'ppGpsIpsJ',
		'ppGpsJpsJ'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #'VisualWorks metadata' }
MbDTranslationConstraintIqcsJqcs class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDTranslationConstraintIqcsJqcs class >> withFrmI: afrmI frmJ: afrmJ axis: aaxis [ 
	^(afrmI isKindOf: MbDEndFrameqcs)
		& (afrmJ isKindOf: MbDEndFrameqcs)
		ifTrue: [self new withFrmI: afrmI frmJ: afrmJ axis: aaxis]
		ifFalse: [nil]
]

{ #category : #accessing }
MbDTranslationConstraintIqcsJqcs >> addpTIeiGOpsJto: mat [ 
	self halt: 'To be implemented.'
]

{ #category : #calc }
MbDTranslationConstraintIqcsJqcs >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	pGpsJ := riIeJeIe pvaluepsJ.
	ppGpEIpsJ := riIeJeIe ppvaluepsJpEK transpose.
	ppGpEJpsJ := riIeJeIe ppvaluepEJpsJ.
	ppGpsIpsJ := riIeJeIe ppvaluepsJpsK transpose.
	ppGpsJpsJ := riIeJeIe ppvaluepsJpsJ
]

{ #category : #accessing }
MbDTranslationConstraintIqcsJqcs >> dispCompClass [
	^MbDDispCompIeqcsJeqcsKeqcs
]

{ #category : #accIC }
MbDTranslationConstraintIqcsJqcs >> fillAccICIterError: col [ 
	| qEdotI sdotI sum qEdotJ sdotJ |
	super fillAccICIterError: col.
	col at: isJ plusFullColumn: pGpsJ times: lam.
	qEdotI := frmI qEdot.
	qEdotJ := frmJ qEdot.
	sdotI := frmI sdot.
	sdotJ := frmJ sdot.
	sum := 0.0d.
	sum := sum + (pGpsJ timesFullColumn: frmJ sddot).
	sum := sum + (2.0d * (qEdotI transposeTimesFullColumn: (ppGpEIpsJ timesFullColumn: sdotJ))).
	sum := sum + (2.0d * (qEdotJ transposeTimesFullColumn: (ppGpEJpsJ timesFullColumn: sdotJ))).
	sum := sum + (2.0d * (sdotI transposeTimesFullColumn: (ppGpsIpsJ timesFullColumn: sdotJ))).
	sum := sum + (sdotJ transposeTimesFullColumn: (ppGpsJpsJ timesFullColumn: sdotJ)).
	col at: iG plusNumber: sum
]

{ #category : #collision }
MbDTranslationConstraintIqcsJqcs >> fillCollisionError: col [ 
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
MbDTranslationConstraintIqcsJqcs >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: isJ plusFullColumn: pGpsJ times: lam
]

{ #category : #posIC }
MbDTranslationConstraintIqcsJqcs >> fillPosICJacob: mat [ 
	| ppGpEIpsJlam ppGpEJpsJlam ppGpsIpsJlam |
	super fillPosICJacob: mat.
	mat at: iG and: isJ plusFullRow: pGpsJ.
	mat at: isJ and: iG plusFullColumn: pGpsJ transpose.
	mat at: iqEI and: isJ plusFullMatrix: (ppGpEIpsJlam := ppGpEIpsJ times: lam).
	mat at: isJ and: iqEI plusTransposeFullMatrix: ppGpEIpsJlam.
	mat at: iqEJ and: isJ plusFullMatrix: (ppGpEJpsJlam := ppGpEJpsJ times: lam).
	mat at: isJ and: iqEJ plusTransposeFullMatrix: ppGpEJpsJlam.
	mat at: isI and: isJ plusFullMatrix: (ppGpsIpsJlam := ppGpsIpsJ times: lam).
	mat at: isJ and: isI plusTransposeFullMatrix: ppGpsIpsJlam.
	mat at: isJ and: isJ plusFullMatrix: ppGpsJpsJ times: lam
]

{ #category : #posIC }
MbDTranslationConstraintIqcsJqcs >> fillPosKineJacob: mat [ 
	super fillPosKineJacob: mat.
	mat
		at: iG
		and: isJ
		plusFullRow: pGpsJ
]

{ #category : #velIC }
MbDTranslationConstraintIqcsJqcs >> fillVelICJacob: mat [ 
	super fillVelICJacob: mat.
	mat at: iG and: isJ plusFullRow: pGpsJ.
	mat at: isJ and: iG plusFullColumn: pGpsJ transpose
]

{ #category : #dynamic }
MbDTranslationConstraintIqcsJqcs >> fillpFpy: mat [ 
	| ppGpEIpsJlam ppGpEJpsJlam ppGpsIpsJlam |
	super fillpFpy: mat.
	mat at: iG and: isJ plusFullRow: pGpsJ.
	mat at: iqEI and: isJ plusFullMatrix: (ppGpEIpsJlam := ppGpEIpsJ times: lam).
	mat at: isJ and: iqEI plusTransposeFullMatrix: ppGpEIpsJlam.
	mat at: iqEJ and: isJ plusFullMatrix: (ppGpEJpsJlam := ppGpEJpsJ times: lam).
	mat at: isJ and: iqEJ plusTransposeFullMatrix: ppGpEJpsJlam.
	mat at: isI and: isJ plusFullMatrix: (ppGpsIpsJlam := ppGpsIpsJ times: lam).
	mat at: isJ and: isI plusTransposeFullMatrix: ppGpsIpsJlam.
	mat at: isJ and: isJ plusFullMatrix: ppGpsJpsJ times: lam
]

{ #category : #dynamic }
MbDTranslationConstraintIqcsJqcs >> fillpFpydot: mat [ 
	super fillpFpydot: mat.
	mat at: isJ and: iG plusFullColumn: pGpsJ transpose
]

{ #category : #'initialize-release' }
MbDTranslationConstraintIqcsJqcs >> useEquationNumbers [
	super useEquationNumbers.
	isJ := frmJ is
]
