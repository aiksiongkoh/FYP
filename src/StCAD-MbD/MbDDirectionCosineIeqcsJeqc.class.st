Class {
	#name : #MbDDirectionCosineIeqcsJeqc,
	#superclass : #MbDDirectionCosineIeqcJeqc,
	#instVars : [
		'sSizeI',
		'pAijIeJepsI',
		'ppAijIeJepEIpsI',
		'ppAijIeJepEJpsI',
		'ppAijIeJepsIpsI',
		'pAjOIepsIT',
		'ppAjOIepEIpsI',
		'ppAjOIepEJpsI',
		'ppAjOIepsIpsI'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDDirectionCosineIeqcsJeqc >> calcPostDynCorrectorIteration [
	"ppAjOIepEIpEI is not long constant and must be set before any calculation."

	| ppAijIeJepEIipsI ppAjOIepEIipsI ppAijIeJepsIipsI ppAjOIepsIipsI ppAijIeJepEJipsI |
	ppAjOIepEIpEI := frmI ppAjOepEpE: axisI.
	super calcPostDynCorrectorIteration.
	pAjOIepsIT := frmI pAjOepsT: axisI.
	ppAjOIepEIpsI := frmI ppAjOepEps: axisI.
	ppAjOIepsIpsI := frmI ppAjOepsps: axisI.
	1 to: sSizeI do: [:i | pAijIeJepsI at: i put: ((pAjOIepsIT at: i) dot: aAjOJe)].
	1 to: 4 do: [:i | 
			ppAijIeJepEIipsI := ppAijIeJepEIpsI at: i.
			ppAjOIepEIipsI := ppAjOIepEIpsI at: i.
			1 to: sSizeI do: [:j | ppAijIeJepEIipsI at: j put: ((ppAjOIepEIipsI at: j) dot: aAjOJe)]].
	1 to: 4 do:  [:i | 
			ppAijIeJepEJipsI := ppAijIeJepEJpsI at: i.
			1 to: sSizeI do: [:j | ppAijIeJepEJipsI at: j put: ((pAjOJepEJT at: i) dot: (pAjOIepsIT at: j))]].
	1 to: sSizeI do: [:i | 
			ppAijIeJepsIipsI := ppAijIeJepsIpsI at: i.
			ppAjOIepsIipsI := ppAjOIepsIpsI at: i.
			i to: sSizeI do: [:j | ppAijIeJepsIipsI at: j put: ((ppAjOIepsIipsI at: j) dot: aAjOJe)]].
	ppAijIeJepsIpsI symLowerWithUpper
]

{ #category : #'initialize-release' }
MbDDirectionCosineIeqcsJeqc >> initializeGlobally [
	ppAjOJepEJpEJ := frmJ ppAjOepEpE: axisJ
]

{ #category : #'initialize-release' }
MbDDirectionCosineIeqcsJeqc >> initializeLocally [
	sSizeI := frmI sSize.
	pAijIeJepsI := FullRow new: sSizeI.
	ppAijIeJepEIpsI := FullMatrix new: 4 by: sSizeI.
	ppAijIeJepEJpsI := FullMatrix new: 4 by: sSizeI.
	ppAijIeJepsIpsI := FullMatrix new: sSizeI by: sSizeI
]

{ #category : #accessing }
MbDDirectionCosineIeqcsJeqc >> pAijIeJepsI [
	^pAijIeJepsI
]

{ #category : #accessing }
MbDDirectionCosineIeqcsJeqc >> ppAijIeJepEIpsI [
	^ppAijIeJepEIpsI
]

{ #category : #accessing }
MbDDirectionCosineIeqcsJeqc >> ppAijIeJepEJpsI [
	^ppAijIeJepEJpsI
]

{ #category : #accessing }
MbDDirectionCosineIeqcsJeqc >> ppAijIeJepsIpsI [
	^ppAijIeJepsIpsI
]

{ #category : #accessing }
MbDDirectionCosineIeqcsJeqc >> ppvaluepEIpsI [
	^ppAijIeJepEIpsI
]

{ #category : #accessing }
MbDDirectionCosineIeqcsJeqc >> ppvaluepEJpsI [
	^ppAijIeJepEJpsI
]

{ #category : #accessing }
MbDDirectionCosineIeqcsJeqc >> ppvaluepsIpsI [
	^ppAijIeJepsIpsI
]

{ #category : #accessing }
MbDDirectionCosineIeqcsJeqc >> pvaluepsI [
	^pAijIeJepsI
]
