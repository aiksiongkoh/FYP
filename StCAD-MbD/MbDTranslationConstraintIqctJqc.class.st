Class {
	#name : #MbDTranslationConstraintIqctJqc,
	#superclass : #MbDTranslationConstraintIqcJqc,
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
MbDTranslationConstraintIqctJqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDTranslationConstraintIqctJqc class >> withFrmI: afrmI frmJ: afrmJ axis: aaxis [ 
	^(afrmI isMemberOf: MbDEndFrameqct) | (afrmI isMemberOf: MbD2EndFrameqct) 
		& (afrmJ isMemberOf: MbDEndFrameqc) 
			ifTrue: 
				[self new 
					withFrmI: afrmI
					frmJ: afrmJ
					axis: aaxis]
			ifFalse: [nil]
]

{ #category : #accessing }
MbDTranslationConstraintIqctJqc >> dispCompClass [
	^MbDDispCompIeqctJeqcKeqct
]

{ #category : #accIC }
MbDTranslationConstraintIqctJqc >> fillAccICIterError: col [ 
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
MbDTranslationConstraintIqctJqc >> fillVelICError: col [ 
	col at: iG minusNumber: pGpt
]

{ #category : #accIC }
MbDTranslationConstraintIqctJqc >> preAccIC [
	super preAccIC.
	ppGpXIpt := riIeJeIe ppvaluepXIpt.
	ppGpEIpt := riIeJeIe ppvaluepEIpt plusFullRow: riIeJeIe ppvaluepEKpt.
	ppGpXJpt := riIeJeIe ppvaluepXJpt.
	ppGpEJpt := riIeJeIe ppvaluepEJpt.
	ppGptpt := riIeJeIe ppvalueptpt
]

{ #category : #velIC }
MbDTranslationConstraintIqctJqc >> preVelIC [
	super preVelIC.
	pGpt := riIeJeIe pvaluept
]

{ #category : #accessing }
MbDTranslationConstraintIqctJqc >> type [
	^#essential
]
