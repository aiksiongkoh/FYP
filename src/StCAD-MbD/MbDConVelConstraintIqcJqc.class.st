Class {
	#name : #MbDConVelConstraintIqcJqc,
	#superclass : #MbDConVelConstraintIqcJc,
	#instVars : [
		'pGpEJ',
		'ppGpEIpEJ',
		'ppGpEJpEJ',
		'iqEJ'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #'VisualWorks metadata' }
MbDConVelConstraintIqcJqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDConVelConstraintIqcJqc class >> withFrmI: afrmI frmJ: afrmJ [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFrameqc)
		ifTrue: [self new withFrmI: afrmI frmJ: afrmJ]
		ifFalse: [nil]
]

{ #category : #accessing }
MbDConVelConstraintIqcJqc >> addToJointTorqueJ: col [ 
	| aBOJp lampGpE c2Torque |
	aBOJp := frmJ aBOp.
	lampGpE := pGpEJ transpose times: lam.
	c2Torque := aBOJp timesFullColumn: lampGpE.
	col equalSelfPlusFullColumn: c2Torque times: 0.5d
]

{ #category : #calc }
MbDConVelConstraintIqcJqc >> calcPostDynCorrectorIteration [
	| pA12IeJepEJ ppA12IeJepEIpEJ ppA12IeJepEJpEJ pA21IeJepEJ ppA21IeJepEIpEJ ppA21IeJepEJpEJ ppGpEIpEJi ppA12IeJepEIpEJi ppA21IeJepEIpEJi ppGpEIpEJij ppGpEJpEJi ppA12IeJepEJpEJi ppA21IeJepEJpEJi ppGpEJpEJij |
	super calcPostDynCorrectorIteration.
	pA12IeJepEJ := aA12IeJe pAijIeJepEJ.
	ppA12IeJepEIpEJ := aA12IeJe ppAijIeJepEIpEJ.
	ppA12IeJepEJpEJ := aA12IeJe ppAijIeJepEJpEJ.
	pA21IeJepEJ := aA21IeJe pAijIeJepEJ.
	ppA21IeJepEIpEJ := aA21IeJe ppAijIeJepEIpEJ.
	ppA21IeJepEJpEJ := aA21IeJe ppAijIeJepEJpEJ.
	1 to: 4 do: [:i | pGpEJ at: i put: (pA12IeJepEJ at: i) + (pA21IeJepEJ at: i)].
	1 to: 4 do: [:i | 
			ppGpEIpEJi := ppGpEIpEJ at: i.
			ppA12IeJepEIpEJi := ppA12IeJepEIpEJ at: i.
			ppA21IeJepEIpEJi := ppA21IeJepEIpEJ at: i.
			1 to: 4 do: [:j | 
					ppGpEIpEJij := (ppA12IeJepEIpEJi at: j) + (ppA21IeJepEIpEJi at: j).
					ppGpEIpEJi at: j put: ppGpEIpEJij]].
	1 to: 4 do: [:i | 
			ppGpEJpEJi := ppGpEJpEJ at: i.
			ppA12IeJepEJpEJi := ppA12IeJepEJpEJ at: i.
			ppA21IeJepEJpEJi := ppA21IeJepEJpEJ at: i.
			ppGpEJpEJi at: i put: (ppA12IeJepEJpEJi at: i) + (ppA21IeJepEJpEJi at: i).
			i + 1 to: 4 do: [:j | 
					ppGpEJpEJij := (ppA12IeJepEJpEJi at: j) + (ppA21IeJepEJpEJi at: j).
					ppGpEJpEJi at: j put: ppGpEJpEJij.
					ppGpEJpEJ at: j and: i put: ppGpEJpEJij]]
]

{ #category : #accIC }
MbDConVelConstraintIqcJqc >> fillAccICIterError: col [ 
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

{ #category : #posIC }
MbDConVelConstraintIqcJqc >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: iqEJ plusFullColumn: pGpEJ times: lam
]

{ #category : #posIC }
MbDConVelConstraintIqcJqc >> fillPosICJacob: mat [ 
	| ppGpEIpEJlam |
	super fillPosICJacob: mat.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose.
	mat at: iqEI and: iqEJ plusFullMatrix: (ppGpEIpEJlam := ppGpEIpEJ times: lam).
	mat at: iqEJ and: iqEI plusTransposeFullMatrix: ppGpEIpEJlam.
	mat at: iqEJ and: iqEJ plusFullMatrix: ppGpEJpEJ times: lam
]

{ #category : #posIC }
MbDConVelConstraintIqcJqc >> fillPosKineJacob: mat [ 
	super fillPosKineJacob: mat.
	mat at: iG and: iqEJ plusFullRow: pGpEJ
]

{ #category : #velIC }
MbDConVelConstraintIqcJqc >> fillVelICJacob: mat [ 
	super fillVelICJacob: mat.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose
]

{ #category : #dynamic }
MbDConVelConstraintIqcJqc >> fillpFpy: mat [ 
	| ppGpEIpEJlam |
	super fillpFpy: mat.
	mat at: iG and: iqEJ plusFullRow: pGpEJ.
	mat at: iqEI and: iqEJ plusFullMatrix: (ppGpEIpEJlam := ppGpEIpEJ times: lam).
	mat at: iqEJ and: iqEI plusTransposeFullMatrix: ppGpEIpEJlam.
	mat at: iqEJ and: iqEJ plusFullMatrix: ppGpEJpEJ times: lam
]

{ #category : #dynamic }
MbDConVelConstraintIqcJqc >> fillpFpydot: mat [ 
	super fillpFpydot: mat.
	mat at: iqEJ and: iG plusFullColumn: pGpEJ transpose
]

{ #category : #'initialize-release' }
MbDConVelConstraintIqcJqc >> initA12IeJe [
	aA12IeJe := MbDDirectionCosineIeqcJeqc new
]

{ #category : #'initialize-release' }
MbDConVelConstraintIqcJqc >> initA21IeJe [
	aA21IeJe := MbDDirectionCosineIeqcJeqc new
]

{ #category : #'initialize-release' }
MbDConVelConstraintIqcJqc >> initialize [
	super initialize.
	pGpEJ := FullRow new: 4.
	ppGpEIpEJ := FullMatrix new: 4 by: 4.
	ppGpEJpEJ := FullMatrix new: 4 by: 4
]

{ #category : #'initialize-release' }
MbDConVelConstraintIqcJqc >> useEquationNumbers [
	super useEquationNumbers.
	iqEJ := frmJ iqE
]
