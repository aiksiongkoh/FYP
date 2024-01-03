Class {
	#name : #MbDDirectionCosineIeqcsJeqcs,
	#superclass : #MbDDirectionCosineIeqcsJeqc,
	#instVars : [
		'sSizeJ',
		'pAijIeJepsJ',
		'ppAijIeJepEIpsJ',
		'ppAijIeJepEJpsJ',
		'ppAijIeJepsIpsJ',
		'ppAijIeJepsJpsJ'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDDirectionCosineIeqcsJeqcs >> calcPostDynCorrectorIteration [
	"ppAjOJepEJpEJ is not long constant and must be set before any calculation."

	| pAjOJepsJT ppAijIeJepEIipsJ ppAijIeJepsIipsJ ppAijIeJepEJipsJ ppAjOJepEJipsJ ppAjOJepEJpsJ ppAijIeJepsJipsJ ppAjOJepsJipsJ ppAjOJepsJpsJ |
	ppAjOJepEJpEJ := frmJ ppAjOepEpE: axisJ.
	super calcPostDynCorrectorIteration.
	pAjOJepsJT := frmJ pAjOepsT: axisJ.
	ppAjOJepEJpsJ := frmJ ppAjOepEps: axisJ.
	ppAjOJepsJpsJ := frmJ ppAjOepsps: axisJ.
	1 to: sSizeJ do: [:i | pAijIeJepsJ at: i put: (aAjOIe dot: (pAjOJepsJT at: i))].
	1 to: 4 do: [:i | 
			ppAijIeJepEIipsJ := ppAijIeJepEIpsJ at: i.
			1 to: sSizeJ do: [:j | ppAijIeJepEIipsJ at: j put: ((pAjOIepEIT at: i) dot: (pAjOJepsJT at: j))]].
	1 to: 4 do: [:i | 
			ppAijIeJepEJipsJ := ppAijIeJepEJpsJ at: i.
			ppAjOJepEJipsJ := ppAjOJepEJpsJ at: i.
			1 to: sSizeJ do: [:j | ppAijIeJepEJipsJ at: j put: (aAjOIe dot: (ppAjOJepEJipsJ at: j))]].
	1 to: sSizeI do: [:i | 
			ppAijIeJepsIipsJ := ppAijIeJepsIpsJ at: i.
			1 to: sSizeJ do: [:j | ppAijIeJepsIipsJ at: j put: ((pAjOIepsIT at: i) dot: (pAjOJepsJT at: j))]].
	1 to: sSizeJ do: [:i | 
			ppAijIeJepsJipsJ := ppAijIeJepsJpsJ at: i.
			ppAjOJepsJipsJ := ppAjOJepsJpsJ at: i.
			i to: sSizeJ do: [:j | ppAijIeJepsJipsJ at: j put: (aAjOIe dot: (ppAjOJepsJipsJ at: j))]].
	ppAijIeJepsJpsJ symLowerWithUpper
]

{ #category : #'initialize-release' }
MbDDirectionCosineIeqcsJeqcs >> initializeGlobally [
	"Do nothing."
]

{ #category : #'initialize-release' }
MbDDirectionCosineIeqcsJeqcs >> initializeLocally [
	super initializeLocally.
	sSizeJ := frmJ sSize.
	pAijIeJepsJ := FullRow new: sSizeJ.
	ppAijIeJepEIpsJ := FullMatrix new: 4 by: sSizeJ.
	ppAijIeJepEJpsJ := FullMatrix new: 4 by: sSizeJ.
	ppAijIeJepsIpsJ := FullMatrix new: sSizeI by: sSizeJ.
	ppAijIeJepsJpsJ := FullMatrix new: sSizeJ by: sSizeJ
]

{ #category : #accessing }
MbDDirectionCosineIeqcsJeqcs >> pAijIeJepsJ [
	^pAijIeJepsJ
]

{ #category : #accessing }
MbDDirectionCosineIeqcsJeqcs >> ppAijIeJepEIpsJ [
	^ppAijIeJepEIpsJ
]

{ #category : #accessing }
MbDDirectionCosineIeqcsJeqcs >> ppAijIeJepEJpsJ [
	^ppAijIeJepEJpsJ
]

{ #category : #accessing }
MbDDirectionCosineIeqcsJeqcs >> ppAijIeJepsIpsJ [
	^ppAijIeJepsIpsJ
]

{ #category : #accessing }
MbDDirectionCosineIeqcsJeqcs >> ppAijIeJepsJpsJ [
	^ppAijIeJepsJpsJ
]

{ #category : #accessing }
MbDDirectionCosineIeqcsJeqcs >> ppvaluepEIpsJ [
	^ppAijIeJepEIpsJ
]

{ #category : #accessing }
MbDDirectionCosineIeqcsJeqcs >> ppvaluepEJpsJ [
	^ppAijIeJepEJpsJ
]

{ #category : #accessing }
MbDDirectionCosineIeqcsJeqcs >> ppvaluepsIpsJ [
	^ppAijIeJepsIpsJ
]

{ #category : #accessing }
MbDDirectionCosineIeqcsJeqcs >> ppvaluepsJpsJ [
	^ppAijIeJepsJpsJ
]

{ #category : #accessing }
MbDDirectionCosineIeqcsJeqcs >> pvaluepsJ [
	^pAijIeJepsJ
]
