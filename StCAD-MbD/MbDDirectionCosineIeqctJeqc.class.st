Class {
	#name : #MbDDirectionCosineIeqctJeqc,
	#superclass : #MbDDirectionCosineIeqcJeqc,
	#instVars : [
		'pAijIeJept',
		'ppAijIeJepEIpt',
		'ppAijIeJepEJpt',
		'ppAijIeJeptpt'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDDirectionCosineIeqctJeqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #calc }
MbDDirectionCosineIeqctJeqc >> calcPostDynCorrectorIteration [
	"ppAjOIepEIpEI is not longer constant and must be set before any calculation."

	ppAjOIepEIpEI := frmI ppAjOepEpE: axisI.
	super calcPostDynCorrectorIteration
]

{ #category : #'initialize-release' }
MbDDirectionCosineIeqctJeqc >> initialize [
	super initialize.
	ppAijIeJepEIpt := FullRow new: 4.
	ppAijIeJepEJpt := FullRow new: 4
]

{ #category : #'initialize-release' }
MbDDirectionCosineIeqctJeqc >> initializeGlobally [
	ppAjOJepEJpEJ := frmJ ppAjOepEpE: axisJ
]

{ #category : #accessing }
MbDDirectionCosineIeqctJeqc >> pAijIeJept [
	^pAijIeJept
]

{ #category : #accessing }
MbDDirectionCosineIeqctJeqc >> ppAijIeJepEIpt [
	^ppAijIeJepEIpt
]

{ #category : #accessing }
MbDDirectionCosineIeqctJeqc >> ppAijIeJepEJpt [
	^ppAijIeJepEJpt
]

{ #category : #accessing }
MbDDirectionCosineIeqctJeqc >> ppAijIeJeptpt [
	^ppAijIeJeptpt
]

{ #category : #accessing }
MbDDirectionCosineIeqctJeqc >> ppvaluepEIpt [
	^ppAijIeJepEIpt
]

{ #category : #accessing }
MbDDirectionCosineIeqctJeqc >> ppvaluepEJpt [
	^ppAijIeJepEJpt
]

{ #category : #accessing }
MbDDirectionCosineIeqctJeqc >> ppvalueptpt [
	^ppAijIeJeptpt
]

{ #category : #accIC }
MbDDirectionCosineIeqctJeqc >> preAccIC [
	| ppAjOIepEITpt ppAjOIeptpt ppAjOIepEITpti pAjOIept |
	super preAccIC.
	pAjOIept := frmI pAjOept: axisI.
	ppAjOIepEITpt := frmI ppAjOepETpt: axisI.
	ppAjOIeptpt := frmI ppAjOeptpt: axisI.
	1 to: 4 do: [:i | 
			ppAjOIepEITpti := ppAjOIepEITpt at: i.
			ppAijIeJepEIpt at: i put: (ppAjOIepEITpti dot: aAjOJe)].
	1 to: 4 do: [:i | ppAijIeJepEJpt at: i put: (pAjOIept dot: (pAjOJepEJT at: i))].
	ppAijIeJeptpt := ppAjOIeptpt dot: aAjOJe
]

{ #category : #velIC }
MbDDirectionCosineIeqctJeqc >> preVelIC [
	| pAjOIept |
	super preVelIC.
	pAjOIept := frmI pAjOept: axisI.
	pAijIeJept := pAjOIept dot: aAjOJe
]

{ #category : #accessing }
MbDDirectionCosineIeqctJeqc >> pvaluept [
	^pAijIeJept
]
