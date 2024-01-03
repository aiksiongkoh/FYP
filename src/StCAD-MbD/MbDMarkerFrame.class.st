Class {
	#name : #MbDMarkerFrame,
	#superclass : #MbDCartesianFrame,
	#instVars : [
		'partFrame',
		'rpmp',
		'aApm',
		'rOmO',
		'aAOm',
		'prOmOpE',
		'pAOmpE',
		'pprOmOpEpE',
		'ppAOmpEpE',
		'endFrames'
	],
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #accessing }
MbDMarkerFrame >> aAOm [
	^aAOm
]

{ #category : #accessing }
MbDMarkerFrame >> aAdotjOm: j [ 
	^partFrame aAdotOp timesFullColumn: (aApm column: j)
]

{ #category : #accessing }
MbDMarkerFrame >> aApm [
	^aApm
]

{ #category : #accessing }
MbDMarkerFrame >> aApm: aA [ 
	aApm := aA
]

{ #category : #accessing }
MbDMarkerFrame >> aBOp [
	^partFrame aBOp
]

{ #category : #accessing }
MbDMarkerFrame >> aOmO [
	^partFrame aOpO + (partFrame aAddotOp timesFullColumn: rpmp)
]

{ #category : #accessing }
MbDMarkerFrame >> bePerturbed: delta fillqsulam: col [ 
	endFrames do: [:eFrm | eFrm bePerturbed: delta fillqsulam: col]
]

{ #category : #calc }
MbDMarkerFrame >> calcPostDynCorrectorIteration [
	| rOpO aAOp pAOppE pAOppEi |
	rOpO := partFrame rOpO.
	aAOp := partFrame aAOp.
	rOmO := rOpO plusFullColumn: (aAOp timesFullColumn: rpmp).
	aAOm := aAOp timesFullMatrix: aApm.
	pAOppE := partFrame pAOppE.
	1 to: 4 do: [:i | 
			pAOppEi := pAOppE at: i.
			prOmOpE at: 1 and: i putFullColumn: (pAOppEi timesFullColumn: rpmp).
			pAOmpE at: i put: (pAOppEi timesFullMatrix: aApm)]
]

{ #category : #accessing }
MbDMarkerFrame >> endFrames [
	^endFrames
]

{ #category : #accessing }
MbDMarkerFrame >> fillpqsumu: col [ 
	endFrames do: [:eFrm | eFrm fillpqsumu: col]
]

{ #category : #accessing }
MbDMarkerFrame >> fillpqsumudot: col [ 
	endFrames do: [:eFrm | eFrm fillpqsumudot: col]
]

{ #category : #accessing }
MbDMarkerFrame >> fillqsu: col [ 
	endFrames do: [:eFrm | eFrm fillqsu: col]
]

{ #category : #accessing }
MbDMarkerFrame >> fillqsuWeights: col [ 
	endFrames do: [:eFrm | eFrm fillqsuWeights: col]
]

{ #category : #accessing }
MbDMarkerFrame >> fillqsuddotlam: col [ 
	endFrames do: [:eFrm | eFrm fillqsuddotlam: col]
]

{ #category : #accessing }
MbDMarkerFrame >> fillqsudot: col [ 
	endFrames do: [:eFrm | eFrm fillqsudot: col]
]

{ #category : #accessing }
MbDMarkerFrame >> fillqsudotPlam: col [ 
	endFrames do: [:eFrm | eFrm fillqsudotPlam: col]
]

{ #category : #accessing }
MbDMarkerFrame >> fillqsudotPlamDeriv: col [ 
	endFrames do: [:eFrm | eFrm fillqsudotPlamDeriv: col]
]

{ #category : #accessing }
MbDMarkerFrame >> fillqsudotWeights: col [ 
	endFrames do: [:eFrm | eFrm fillqsudotWeights: col]
]

{ #category : #accessing }
MbDMarkerFrame >> fillqsulam: col [ 
	endFrames do: [:eFrm | eFrm fillqsulam: col]
]

{ #category : #'initialize-release' }
MbDMarkerFrame >> initialize [
	prOmOpE := FullMatrix new: 3 by: 4.
	pAOmpE := FullColumn new: 4.
	endFrames := OrderedCollection new
]

{ #category : #'initialize-release' }
MbDMarkerFrame >> initializeGlobally [
	endFrames do: [:eFrm | eFrm initializeGlobally]
]

{ #category : #'initialize-release' }
MbDMarkerFrame >> initializeLocally [
	pprOmOpEpE := MbDEulerParameters ppApEpEtimesColumn: rpmp.
	ppAOmpEpE := MbDEulerParameters ppApEpEtimesMatrix: aApm.
	endFrames do: [:eFrm | eFrm initializeLocally]
]

{ #category : #accessing }
MbDMarkerFrame >> iqE [
	^partFrame iqE
]

{ #category : #accessing }
MbDMarkerFrame >> iqX [
	^partFrame iqX
]

{ #category : #accessing }
MbDMarkerFrame >> isOn: pFrm [ 
	partFrame := pFrm.
	partFrame markerFrames add: self
]

{ #category : #accessing }
MbDMarkerFrame >> omeOmO [
	^partFrame omeOpO
]

{ #category : #accessing }
MbDMarkerFrame >> pAOmpE [
	^pAOmpE
]

{ #category : #accessing }
MbDMarkerFrame >> pAOppE [
	^partFrame pAOppE
]

{ #category : #accessing }
MbDMarkerFrame >> pAdotjOmpE: jj [ 
	| pAdotOppE aAjjpm answer pAdotOppEj pAdotjjpmpEj |
	pAdotOppE := partFrame pAdotOppE.
	aAjjpm := aApm column: jj.
	answer := FullMatrix new: 3 by: 4.
	1 to: 4
		do: 
			[:j | 
			pAdotOppEj := pAdotOppE at: j.
			pAdotjjpmpEj := pAdotOppEj timesFullColumn: aAjjpm.
			answer
				at: 1
				and: j
				putFullColumn: pAdotjjpmpEj].
	^answer
]

{ #category : #accessing }
MbDMarkerFrame >> pAdotjOmpET: jj [ 
	| pAdotOppE aAjjpm answer answeri pAdotOppEi pAdotjjpmpEi |
	pAdotOppE := partFrame pAdotOppE.
	aAjjpm := aApm column: jj.
	answer := FullMatrix new: 4 by: 3.
	1 to: 4 do: [:i | 
			answeri := answer at: i.
			pAdotOppEi := pAdotOppE at: i.
			pAdotjjpmpEi := pAdotOppEi timesFullColumn: aAjjpm.
			1 to: 3 do: [:j | answeri at: j put: (pAdotjjpmpEi at: j)]].
	^answer
]

{ #category : #accessing }
MbDMarkerFrame >> partFrame [
	^partFrame
]

{ #category : #accessing }
MbDMarkerFrame >> partFrame: frame [ 
	partFrame := frame
]

{ #category : #accessing }
MbDMarkerFrame >> pomeOmOpE [
	^partFrame pomeOpOpE
]

{ #category : #accessing }
MbDMarkerFrame >> pomeOmOpEdot [
	^partFrame pomeOpOpEdot
]

{ #category : #dynamic }
MbDMarkerFrame >> postDynCorrectorIteration [
	super postDynCorrectorIteration.
	endFrames do: [:endFrm | endFrm postDynCorrectorIteration]
]

{ #category : #dynamic }
MbDMarkerFrame >> postDynOutput [
	super postDynOutput.
	endFrames do: [:endFrm | endFrm postDynOutput]
]

{ #category : #dynamic }
MbDMarkerFrame >> postDynPredictor [
	super postDynPredictor.
	endFrames do: [:endFrm | endFrm postDynPredictor]
]

{ #category : #dynamic }
MbDMarkerFrame >> postDynStep [
	endFrames do: [:endFrm | endFrm postDynStep]
]

{ #category : #'input-output' }
MbDMarkerFrame >> postInput [
	super postInput.
	endFrames do: [:endFrm | endFrm postInput]
]

{ #category : #posIC }
MbDMarkerFrame >> postPosIC [
	endFrames do: [:endFrm | endFrm postPosIC]
]

{ #category : #posIC }
MbDMarkerFrame >> postPosICIteration [
	super postPosICIteration.
	endFrames do: [:endFrm | endFrm postPosICIteration]
]

{ #category : #static }
MbDMarkerFrame >> postStaticIteration [
	super postStaticIteration.
	endFrames do: [:endFrm | endFrm postStaticIteration]
]

{ #category : #velIC }
MbDMarkerFrame >> postVelIC [
	endFrames do: [:endFrm | endFrm postVelIC]
]

{ #category : #accessing }
MbDMarkerFrame >> ppAOmpEpE [
	^ppAOmpEpE
]

{ #category : #accessing }
MbDMarkerFrame >> pprOmOpEpE [
	^pprOmOpEpE
]

{ #category : #accessing }
MbDMarkerFrame >> prOmOpE [
	^prOmOpE
]

{ #category : #accIC }
MbDMarkerFrame >> preAccIC [
	super preAccIC.
	endFrames do: [:endFrm | endFrm preAccIC]
]

{ #category : #dynamic }
MbDMarkerFrame >> preDyn [
	endFrames do: [:endFrm | endFrm preDyn]
]

{ #category : #dynamic }
MbDMarkerFrame >> preDynOutput [
	super preDynOutput.
	endFrames do: [:endFrm | endFrm preDynOutput]
]

{ #category : #posIC }
MbDMarkerFrame >> prePosIC [
	super prePosIC.
	endFrames do: [:endFrm | endFrm prePosIC]
]

{ #category : #static }
MbDMarkerFrame >> preStatic [
	super preStatic.
	endFrames do: [:endFrm | endFrm preStatic]
]

{ #category : #velIC }
MbDMarkerFrame >> preVelIC [
	super preVelIC.
	endFrames do: [:endFrm | endFrm preVelIC]
]

{ #category : #accessing }
MbDMarkerFrame >> pvOmOpE [
	| answer pAdotOppE answeri pAdotOpipEj |
	answer := FullMatrix new: 3 by: 4.
	pAdotOppE := partFrame pAdotOppE.
	1 to: 3 do: [:i | 
			answeri := answer at: i.
			1 to: 4 do: [:j | 
					pAdotOpipEj := (pAdotOppE at: j) at: i.
					answeri at: j put: (pAdotOpipEj dot: rpmp)]].
	^answer
]

{ #category : #accessing }
MbDMarkerFrame >> qEddot [
	^partFrame qEddot
]

{ #category : #accessing }
MbDMarkerFrame >> qEdot [
	^partFrame qEdot
]

{ #category : #accessing }
MbDMarkerFrame >> qX [
	^partFrame qX
]

{ #category : #accessing }
MbDMarkerFrame >> qXddot [
	^partFrame qXddot
]

{ #category : #accessing }
MbDMarkerFrame >> qXdot [
	^partFrame qXdot
]

{ #category : #calc }
MbDMarkerFrame >> rOeOOFrmem: rmemCol [ 
	^rOmO + (aAOm timesFullColumn: rmemCol)
]

{ #category : #accessing }
MbDMarkerFrame >> rOmO [
	^rOmO
]

{ #category : #accessing }
MbDMarkerFrame >> rOmO: aColumn [ 
	rOmO := aColumn
]

{ #category : #calc }
MbDMarkerFrame >> rmemOFrOeO: rOeOCol [ 
	^aAOm transposeTimesFullColumn: (rOeOCol minusFullColumn: rOmO)
]

{ #category : #accessing }
MbDMarkerFrame >> rpep [
	self halt: 'check if used.'.
	^rpmp
]

{ #category : #accessing }
MbDMarkerFrame >> rpmp [
	^rpmp
]

{ #category : #accessing }
MbDMarkerFrame >> rpmp: col [ 
	rpmp := col
]

{ #category : #accessing }
MbDMarkerFrame >> setpqsumu: col [ 
	endFrames do: [:eFrm | eFrm setpqsumu: col]
]

{ #category : #accessing }
MbDMarkerFrame >> setpqsumuddot: col [ 
	endFrames do: [:eFrm | eFrm setpqsumuddot: col]
]

{ #category : #accessing }
MbDMarkerFrame >> setpqsumudot: col [ 
	endFrames do: [:eFrm | eFrm setpqsumudot: col]
]

{ #category : #accessing }
MbDMarkerFrame >> setqsu: col [ 
	endFrames do: [:eFrm | eFrm setqsu: col]
]

{ #category : #accessing }
MbDMarkerFrame >> setqsuddotlam: col [ 
	endFrames do: [:eFrm | eFrm setqsuddotlam: col]
]

{ #category : #accessing }
MbDMarkerFrame >> setqsudot: col [ 
	endFrames do: [:eFrm | eFrm setqsudot: col]
]

{ #category : #accessing }
MbDMarkerFrame >> setqsudotPlam: col [ 
	endFrames do: [:eFrm | eFrm setqsudotPlam: col]
]

{ #category : #accessing }
MbDMarkerFrame >> setqsudotPlamDeriv: col [ 
	endFrames do: [:eFrm | eFrm setqsudotPlamDeriv: col]
]

{ #category : #accessing }
MbDMarkerFrame >> setqsudotlam: col [ 
	endFrames do: [:eFrm | eFrm setqsudotlam: col]
]

{ #category : #accessing }
MbDMarkerFrame >> setqsulam: col [ 
	endFrames do: [:eFrm | eFrm setqsulam: col]
]

{ #category : #dynamic }
MbDMarkerFrame >> simUpdateAll [
	super simUpdateAll.
	endFrames do: [:endFrm | endFrm simUpdateAll]
]

{ #category : #dynamic }
MbDMarkerFrame >> storeDynState [
	endFrames do: [:endFrm | endFrm storeDynState]
]

{ #category : #'initialize-release' }
MbDMarkerFrame >> swapXandZaxes [
	"Swap column 1 and 3 of aApm. Negate column 2."

	| rowi |
	1 to: 3
		do: 
			[:i | 
			rowi := aApm at: i.
			rowi swap: 1 with: 3.
			rowi at: 2 put: (rowi at: 2) negated]
]

{ #category : #accessing }
MbDMarkerFrame >> vOeO_of_rmem: rmem [
]

{ #category : #accessing }
MbDMarkerFrame >> vOmO [
	^partFrame vOpO + (partFrame aAdotOp timesFullColumn: rpmp)
]
