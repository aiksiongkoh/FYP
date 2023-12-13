Class {
	#name : #MbDDirectionCosineConstraintIqctJqc,
	#superclass : #MbDDirectionCosineConstraintIqcJqc,
	#instVars : [
		'pGpt',
		'ppGpEIpt',
		'ppGpEJpt',
		'ppGptpt'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #'VisualWorks metadata' }
MbDDirectionCosineConstraintIqctJqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDirectionCosineConstraintIqctJqc class >> withFrmI: afrmI frmJ: afrmJ axisI: aaxisI axisJ: aaxisJ [ 
	^(afrmI isMemberOf: MbDEndFrameqct) | (afrmI isMemberOf: MbD2EndFrameqct) 
		& (afrmJ isMemberOf: MbDEndFrameqc) 
			ifTrue: 
				[self new 
					withFrmI: afrmI
					frmJ: afrmJ
					axisI: aaxisI
					axisJ: aaxisJ]
			ifFalse: [nil]
]

{ #category : #accessing }
MbDDirectionCosineConstraintIqctJqc >> directionCosineClass [
	^MbDDirectionCosineIeqctJeqc
]

{ #category : #accIC }
MbDDirectionCosineConstraintIqctJqc >> fillAccICIterError: col [ 
	| qEdotI sum qEdotJ |
	super fillAccICIterError: col.
	qEdotI := frmI qEdot.
	qEdotJ := frmJ qEdot.
	sum := 0.0d.
	sum := sum + (2.0d * (ppGpEIpt timesFullColumn: qEdotI)).
	sum := sum + (2.0d * (ppGpEJpt timesFullColumn: qEdotJ)).
	sum := sum + ppGptpt.
	col at: iG plusNumber: sum
]

{ #category : #velIC }
MbDDirectionCosineConstraintIqctJqc >> fillVelICError: col [ 
	col at: iG minusNumber: pGpt
]

{ #category : #accIC }
MbDDirectionCosineConstraintIqctJqc >> preAccIC [
	super preAccIC.
	ppGpEIpt := aAijIeJe ppAijIeJepEIpt.
	ppGpEJpt := aAijIeJe ppAijIeJepEJpt.
	ppGptpt := aAijIeJe ppAijIeJeptpt
]

{ #category : #velIC }
MbDDirectionCosineConstraintIqctJqc >> preVelIC [
	super preVelIC.
	pGpt := aAijIeJe pAijIeJept
]

{ #category : #accessing }
MbDDirectionCosineConstraintIqctJqc >> type [
	^#essential
]
