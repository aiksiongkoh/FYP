Class {
	#name : #MbDAtPointConstraintIqctJqc,
	#superclass : #MbDAtPointConstraintIqcJqc,
	#instVars : [
		'pGpt',
		'ppGpEIpt',
		'ppGptpt'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #'VisualWorks metadata' }
MbDAtPointConstraintIqctJqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDAtPointConstraintIqctJqc class >> withFrmI: afrmI frmJ: afrmJ axis: aaxis [ 
	^(afrmI isMemberOf: MbDEndFrameqct)
		& (afrmJ isMemberOf: MbDEndFrameqc)
		ifTrue: [self new withFrmI: afrmI frmJ: afrmJ axis: aaxis]
		ifFalse: [nil]
]

{ #category : #calc }
MbDAtPointConstraintIqctJqc >> calcPostDynCorrectorIteration [
	"ppGpEIpEI is no longer constant."

	ppGpEIpEI := riIeJeO ppriIeJeOpEIpEI.
	super calcPostDynCorrectorIteration
]

{ #category : #accessing }
MbDAtPointConstraintIqctJqc >> dispCompClass [
	^MbDDispCompIeqctJeqcO
]

{ #category : #accIC }
MbDAtPointConstraintIqctJqc >> fillAccICIterError: col [ 
	| sum qEdotI |
	super fillAccICIterError: col.
	qEdotI := frmI qEdot.
	sum := 0.0d.
	sum := sum + (2.0d * (ppGpEIpt timesFullColumn: qEdotI)).
	sum := sum + ppGptpt.
	col at: iG plusNumber: sum
]

{ #category : #velIC }
MbDAtPointConstraintIqctJqc >> fillVelICError: col [ 
	col at: iG minusNumber: pGpt
]

{ #category : #'initialize-release' }
MbDAtPointConstraintIqctJqc >> initializeGlobally [
	riIeJeO initializeGlobally.
	ppGpEJpEJ := riIeJeO ppriIeJeOpEJpEJ
]

{ #category : #accIC }
MbDAtPointConstraintIqctJqc >> preAccIC [
	super preAccIC.
	ppGpEIpt := riIeJeO ppriIeJeOpEIpt.
	ppGptpt := riIeJeO ppriIeJeOptpt
]

{ #category : #velIC }
MbDAtPointConstraintIqctJqc >> preVelIC [
	super preVelIC.
	pGpt := riIeJeO priIeJeOpt
]

{ #category : #accessing }
MbDAtPointConstraintIqctJqc >> type [
	^#essential
]
