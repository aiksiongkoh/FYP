Class {
	#name : #MbDDistanceConstraintIqctJqc,
	#superclass : #MbDDistanceConstraintIqcJqc,
	#instVars : [
		'pGpt',
		'ppGpXIpt',
		'ppGpEIpt',
		'ppGpXJpt',
		'ppGpEJpt',
		'ppGptpt'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #'VisualWorks metadata' }
MbDDistanceConstraintIqctJqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDistanceConstraintIqctJqc class >> withFrmI: afrmI frmJ: afrmJ axis: aaxis [ 
	^(afrmI isMemberOf: MbDEndFrameqct) | (afrmI isMemberOf: MbD2EndFrameqct) 
		& (afrmJ isMemberOf: MbDEndFrameqc) 
			ifTrue: 
				[self new 
					withFrmI: afrmI
					frmJ: afrmJ
					axis: aaxis]
			ifFalse: [nil]
]

{ #category : #accIC }
MbDDistanceConstraintIqctJqc >> fillAccICIterError: col [ 
	| qEdotI sum qXdotI qXdotJ qEdotJ |
	super fillAccICIterError: col.
	qXdotI := frmI qXdot.
	qEdotI := frmI qEdot.
	qXdotJ := frmJ qXdot.
	qEdotJ := frmJ qEdot.
	sum := 0.0d.
	sum := sum + (2.0d * (ppGpXIpt timesFullColumn: qXdotI)).
	sum := sum + (2.0d * (ppGpEIpt timesFullColumn: qEdotI)).
	sum := sum + (2.0d * (ppGpXJpt timesFullColumn: qXdotJ)).
	sum := sum + (2.0d * (ppGpEJpt timesFullColumn: qEdotJ)).
	sum := sum + ppGptpt.
	col at: iG plusNumber: sum
]

{ #category : #velIC }
MbDDistanceConstraintIqctJqc >> fillVelICError: col [ 
	col at: iG minusNumber: pGpt
]

{ #category : #'initialize-release' }
MbDDistanceConstraintIqctJqc >> init_distIeJe [
	distIeJe := MbDDistIeqctJeqc new
]

{ #category : #accIC }
MbDDistanceConstraintIqctJqc >> preAccIC [
	super preAccIC.
	ppGpXIpt := distIeJe ppvaluepXIpt.
	ppGpEIpt := distIeJe ppvaluepEIpt.
	ppGpXJpt := distIeJe ppvaluepXJpt.
	ppGpEJpt := distIeJe ppvaluepEJpt.
	ppGptpt := distIeJe ppvalueptpt
]

{ #category : #velIC }
MbDDistanceConstraintIqctJqc >> preVelIC [
	super preVelIC.
	pGpt := distIeJe pvaluept
]

{ #category : #accessing }
MbDDistanceConstraintIqctJqc >> type [
	^#essential
]
