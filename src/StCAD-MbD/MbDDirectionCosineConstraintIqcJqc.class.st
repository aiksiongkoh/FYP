Class {
	#name : #MbDDirectionCosineConstraintIqcJqc,
	#superclass : #MbDDirectionCosineConstraintIqcJc,
	#instVars : [
		'pGpEJ',
		'ppGpEIpEJ',
		'ppGpEJpEJ',
		'iqEJ'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #'VisualWorks metadata' }
MbDDirectionCosineConstraintIqcJqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDirectionCosineConstraintIqcJqc class >> withFrmI: afrmI frmJ: afrmJ axisI: aaxisI axisJ: aaxisJ [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFrameqc)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				axisI: aaxisI
				axisJ: aaxisJ]
		ifFalse: [nil]
]

{ #category : #accessing }
MbDDirectionCosineConstraintIqcJqc >> addToJointTorqueJ: col [ 
	| aBOJp lampGpE c2Torque |
	aBOJp := frmJ aBOp.
	lampGpE := pGpEJ transpose times: lam.
	c2Torque := aBOJp timesFullColumn: lampGpE.
	col equalSelfPlusFullColumn: c2Torque times: 0.5d
]

{ #category : #accessing }
MbDDirectionCosineConstraintIqcJqc >> addpTIeiGOpEJto: mat [ 
	"ppGpXIpEJ := zero. 
	term2 := zero."

	| aB term1 pTIeiGOpEJ |
	aB := frmI aBOp.
	term1 := ppGpEIpEJ times: lam / 2.0d.
	pTIeiGOpEJ := aB timesFullMatrix: term1.
	mat equalSelfPlusFullMatrix: pTIeiGOpEJ
]

{ #category : #calc }
MbDDirectionCosineConstraintIqcJqc >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	pGpEJ := aAijIeJe pAijIeJepEJ.
	ppGpEIpEJ := aAijIeJe ppAijIeJepEIpEJ.
	ppGpEJpEJ := aAijIeJe ppAijIeJepEJpEJ
]

{ #category : #accessing }
MbDDirectionCosineConstraintIqcJqc >> directionCosineClass [
	^MbDDirectionCosineIeqcJeqc
]

{ #category : #accIC }
MbDDirectionCosineConstraintIqcJqc >> fillAccICIterError: col [ 
	| qEdotI qEdotJ sum |
	super fillAccICIterError: col.
	col at: iqEJ plusFullColumn: pGpEJ times: lam.
	qEdotI := frmI qEdot.
	qEdotJ := frmJ qEdot.
	sum := 0.0d.
	sum := sum + (pGpEJ timesFullColumn: frmJ qEddot).
	sum := sum + (2.0d * (qEdotI transposeTimesFullColumn: (ppGpEIpEJ timesFullColumn: qEdotJ))).
	sum := sum + (qEdotJ transposeTimesFullColumn: (ppGpEJpEJ timesFullColumn: qEdotJ)).
	col at: iG plusNumber: sum
]

{ #category : #collision }
MbDDirectionCosineConstraintIqcJqc >> fillCollisionError: col [ 
	"lamDeriv is now PlamDeriv."
	"qEddot is now qEdotDeriv."

	| sum |
	super fillCollisionError: col.
	col at: iqEJ plusFullColumn: pGpEJ times: lamDeriv.
	sum := 0.0d.
	sum := sum + (pGpEJ timesFullColumn: frmJ qEddot).
	col at: iG plusNumber: sum
]

{ #category : #posIC }
MbDDirectionCosineConstraintIqcJqc >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: iqEJ plusFullColumn: pGpEJ times: lam
]

{ #category : #posIC }
MbDDirectionCosineConstraintIqcJqc >> fillPosICJacob: mat [ 
	| ppGpEIpEJlam |
	super fillPosICJacob: mat.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose.
	mat at: iqEI and: iqEJ plusFullMatrix: (ppGpEIpEJlam := ppGpEIpEJ times: lam).
	mat at: iqEJ and: iqEI plusTransposeFullMatrix: ppGpEIpEJlam.
	mat at: iqEJ and: iqEJ plusFullMatrix: ppGpEJpEJ times: lam
]

{ #category : #posIC }
MbDDirectionCosineConstraintIqcJqc >> fillPosKineJacob: mat [ 
	super fillPosKineJacob: mat.
	mat
		at: iG
		and: iqEJ
		plusFullRow: pGpEJ
]

{ #category : #velIC }
MbDDirectionCosineConstraintIqcJqc >> fillVelICJacob: mat [ 
	super fillVelICJacob: mat.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose
]

{ #category : #dynamic }
MbDDirectionCosineConstraintIqcJqc >> fillpFpy: mat [ 
	| ppGpEIpEJlam |
	super fillpFpy: mat.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqEI and: iqEJ plusFullMatrix: (ppGpEIpEJlam := ppGpEIpEJ times: lam).
	mat at: iqEJ and: iqEI plusTransposeFullMatrix: ppGpEIpEJlam.
	mat at: iqEJ and: iqEJ plusFullMatrix: ppGpEJpEJ times: lam
]

{ #category : #dynamic }
MbDDirectionCosineConstraintIqcJqc >> fillpFpydot: mat [ 
	super fillpFpydot: mat.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose
]

{ #category : #'initialize-release' }
MbDDirectionCosineConstraintIqcJqc >> useEquationNumbers [
	super useEquationNumbers.
	iqEJ := frmJ iqE
]
