Class {
	#name : #MbDDispCompIeqcJecIe,
	#superclass : #MbDDispCompIecJecIe,
	#instVars : [
		'priIeJeIepXI',
		'priIeJeIepEI',
		'ppriIeJeIepXIpEI',
		'ppriIeJeIepEIpEI',
		'pAjOIepEIT',
		'ppAjOIepEIpEI'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDDispCompIeqcJecIe class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDispCompIeqcJecIe class >> withFrmI: afrmI frmJ: afrmJ axis: aaxis [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFramec)
		ifTrue: [self new withFrmI: afrmI frmJ: afrmJ axis: aaxis]
		ifFalse: [nil]
]

{ #category : #calc }
MbDDispCompIeqcJecIe >> calcPostDynCorrectorIteration [
	| ppriIeJeIepXIipEI mprIeJeOpEIT mpprIeJeOpEIpEI ppAjOIepEIipEI mpprIeJeOpEIipEI ppriIeJeIepEIipEI term1 mterm2 mterm3 mterm4 |
	super calcPostDynCorrectorIteration.
	pAjOIepEIT := frmI pAjOepET: axis.
	mprIeJeOpEIT := frmI prOeOpE transpose.
	mpprIeJeOpEIpEI := frmI pprOeOpEpE.
	1 to: 3 do: [:i | priIeJeIepXI at: i put: (aAjOIe at: i) negated].
	1 to: 4 do: [:i | priIeJeIepEI at: i put: ((pAjOIepEIT at: i) dot: rIeJeO) - (aAjOIe dot: (mprIeJeOpEIT at: i))].
	1 to: 3 do: [:i | 
			ppriIeJeIepXIipEI := ppriIeJeIepXIpEI at: i.
			1 to: 4 do: [:j | ppriIeJeIepXIipEI at: j put: (pAjOIepEIT at: j and: i) negated]].
	1 to: 4 do: [:i | 
			ppAjOIepEIipEI := ppAjOIepEIpEI at: i.
			mpprIeJeOpEIipEI := mpprIeJeOpEIpEI at: i.
			ppriIeJeIepEIipEI := ppriIeJeIepEIpEI at: i.
			i to: 4 do: [:j | 
					term1 := (ppAjOIepEIipEI at: j) dot: rIeJeO.
					mterm2 := (pAjOIepEIT at: i) dot: (mprIeJeOpEIT at: j).
					mterm3 := i = j
								ifTrue: [mterm2]
								ifFalse: [(pAjOIepEIT at: j) dot: (mprIeJeOpEIT at: i)].
					mterm4 := aAjOIe dot: (mpprIeJeOpEIipEI at: j).
					ppriIeJeIepEIipEI at: j put: term1 - mterm2 - mterm3 - mterm4]].
	ppriIeJeIepEIpEI symLowerWithUpper
]

{ #category : #'initialize-release' }
MbDDispCompIeqcJecIe >> initialize [
	super initialize.
	priIeJeIepXI := FullRow new: 3.
	priIeJeIepEI := FullRow new: 4.
	ppriIeJeIepXIpEI := FullMatrix new: 3 by: 4.
	ppriIeJeIepEIpEI := FullMatrix new: 4 by: 4
]

{ #category : #'initialize-release' }
MbDDispCompIeqcJecIe >> initializeGlobally [
	ppAjOIepEIpEI := frmI ppAjOepEpE: axis
]

{ #category : #accessing }
MbDDispCompIeqcJecIe >> ppriIeJeIepEIpEI [
	^ppriIeJeIepEIpEI
]

{ #category : #accessing }
MbDDispCompIeqcJecIe >> ppriIeJeIepXIpEI [
	^ppriIeJeIepXIpEI
]

{ #category : #accessing }
MbDDispCompIeqcJecIe >> ppvaluepEIpEI [
	^ppriIeJeIepEIpEI
]

{ #category : #accessing }
MbDDispCompIeqcJecIe >> ppvaluepXIpEI [
	^ppriIeJeIepXIpEI
]

{ #category : #accessing }
MbDDispCompIeqcJecIe >> priIeJeIepEI [
	^priIeJeIepEI
]

{ #category : #accessing }
MbDDispCompIeqcJecIe >> priIeJeIepXI [
	^priIeJeIepXI
]

{ #category : #accessing }
MbDDispCompIeqcJecIe >> pvaluepEI [
	^priIeJeIepEI
]

{ #category : #accessing }
MbDDispCompIeqcJecIe >> pvaluepXI [
	^priIeJeIepXI
]
