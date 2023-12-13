Class {
	#name : #MbDPart,
	#superclass : #MbDItem,
	#instVars : [
		'ipX',
		'ipE',
		'm',
		'aJ',
		'partFrame',
		'pX',
		'pXdot',
		'pE',
		'pEdot',
		'mX',
		'mE',
		'mEdot',
		'pTpE',
		'ppTpEpE',
		'ppTpEpEdot'
	],
	#classVars : [
		'MbD',
		'MbD'
	],
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #'class initialization' }
MbDPart class >> initialize [
	"MbDPart initialize."

	Identity3by3 := DiagonalMatrix new: 3 withAll: 1.0d.
	Identity4by4 := DiagonalMatrix new: 4 withAll: 1.0d
]

{ #category : #'VisualWorks metadata' }
MbDPart class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #patching }
MbDPart >> aA [
	^partFrame aA
]

{ #category : #accessing }
MbDPart >> aA: matrix [ 
	partFrame aA: matrix
]

{ #category : #patching }
MbDPart >> aAdot [
	^partFrame aAdot
]

{ #category : #patching }
MbDPart >> aB [
	^partFrame aB
]

{ #category : #accessing }
MbDPart >> aJ [
	^aJ
]

{ #category : #accessing }
MbDPart >> aJ: matrix [ 
	aJ := matrix
]

{ #category : #patching }
MbDPart >> alpOpO [
	^partFrame alpOpO
]

{ #category : #constraint }
MbDPart >> asFixed [
	partFrame asFixed
]

{ #category : #accessing }
MbDPart >> bePerturbed: delta fillqsulam: col [ 
	partFrame bePerturbed: delta fillqsulam: col
]

{ #category : #calc }
MbDPart >> calcPostDynCorrectorIteration [
	self calcmE.
	self calcmEdot.
	self calcpTpE.
	self calcppTpEpE.
	self calcppTpEpEdot
]

{ #category : #calc }
MbDPart >> calcmE [
	| aC |
	aC := partFrame aC.
	mE := (aC transposeTimesFullMatrix: (aJ timesFullMatrix: aC))
				times: 4.0d
]

{ #category : #calc }
MbDPart >> calcmEdot [
	| aC aCdot a4J term1 term2 |
	aC := partFrame aC.
	aCdot := partFrame aCdot.
	a4J := aJ times: 4.0d.
	term1 := aC transposeTimesFullMatrix: (a4J timesFullMatrix: aCdot).
	term2 := term1 transpose.
	mEdot := term1 plusFullMatrix: term2
]

{ #category : #calc }
MbDPart >> calcp [
	pX := mX timesFullColumn: partFrame qXdot.
	pE := mE timesFullColumn: partFrame qEdot
]

{ #category : #calc }
MbDPart >> calcpTpE [
	"pTpE is a column vector."

	| qEdot aC pCpEtimesqEdot |
	qEdot := partFrame qEdot.
	aC := partFrame aC.
	pCpEtimesqEdot := MbDEulerParameters pCpEtimesColumn: qEdot.
	pTpE := (pCpEtimesqEdot transposeTimesFullColumn: (aJ timesFullColumn: (aC timesFullColumn: qEdot)))
				times: 4.0d
]

{ #category : #calc }
MbDPart >> calcpdot [
	pXdot := mX timesFullColumn: partFrame qXddot.
	pEdot := (mEdot timesFullColumn: partFrame qEdot)
				plusFullColumn: (mE timesFullColumn: partFrame qEddot)
]

{ #category : #calc }
MbDPart >> calcppTpEpE [
	| qEdot pCpEtimesqEdot a4J |
	qEdot := partFrame qEdot.
	pCpEtimesqEdot := MbDEulerParameters pCpEtimesColumn: qEdot.
	a4J := aJ times: 4.0d.
	ppTpEpE := pCpEtimesqEdot transposeTimesFullMatrix: (a4J timesFullMatrix: pCpEtimesqEdot)
]

{ #category : #calc }
MbDPart >> calcppTpEpEdot [
	| qEdot aC a4J term1 pCpEtimesqEdot term2 |
	qEdot := partFrame qEdot.
	aC := partFrame aC.
	a4J := aJ times: 4.0d.
	term1 := MbDEulerParameters pCTpEtimesColumn: (a4J timesFullColumn: (aC timesFullColumn: qEdot)).
	pCpEtimesqEdot := MbDEulerParameters pCpEtimesColumn: qEdot.
	term2 := aC transposeTimesFullMatrix: (a4J timesFullMatrix: pCpEtimesqEdot).
	ppTpEpEdot := (term1 plusFullMatrix: term2) transpose
]

{ #category : #posIC }
MbDPart >> constraintsReport [
	partFrame constraintsReport
]

{ #category : #accIC }
MbDPart >> fillAccICIterError: col [ 
	| iqX iqE |
	iqX := partFrame iqX.
	iqE := partFrame iqE.
	col at: iqX minusFullColumn: (mX timesFullColumn: partFrame qXddot).
	col at: iqE minusFullColumn: (mEdot timesFullColumn: partFrame qEdot).
	col at: iqE minusFullColumn: (mE timesFullColumn: partFrame qEddot).
	col at: iqE plusFullColumn: pTpE.
	partFrame fillAccICIterError: col
]

{ #category : #accIC }
MbDPart >> fillAccICIterJacob: mat [ 
	| iqX iqE |
	iqX := partFrame iqX.
	iqE := partFrame iqE.
	mat at: iqX and: iqX minusDiagonalMatrix: mX.
	mat at: iqE and: iqE minusFullMatrix: mE.
	partFrame fillAccICIterJacob: mat
]

{ #category : #collision }
MbDPart >> fillCollisionDerivativeICJacob: mat [ 
	self fillAccICIterJacob: mat
]

{ #category : #collision }
MbDPart >> fillCollisionError: col [ 
	"qEddot is now qEdotDeriv."

	| iqX iqE |
	iqX := partFrame iqX.
	iqE := partFrame iqE.
	col at: iqX minusFullColumn: (mX timesFullColumn: partFrame qXddot).
	col at: iqE minusFullColumn: (mE timesFullColumn: partFrame qEddot).
	partFrame fillCollisionError: col
]

{ #category : #collision }
MbDPart >> fillCollisionpFpydot: mat [ 
	| iqX iqE |
	iqX := partFrame iqX.
	iqE := partFrame iqE.
	mat at: iqX and: iqX minusDiagonalMatrix: mX.
	mat at: iqE and: iqE minusFullMatrix: mE.
	partFrame fillCollisionpFpydot: mat
]

{ #category : #accessing }
MbDPart >> fillConstraints: collection [ 
	partFrame fillConstraints: collection
]

{ #category : #dynamic }
MbDPart >> fillDynError: col [ 
	partFrame fillDynError: col.
	col at: ipX plusFullColumn: (pX minusFullColumn: (mX timesFullColumn: partFrame qXdot)).
	col at: ipE plusFullColumn: (pE minusFullColumn: (mE timesFullColumn: partFrame qEdot)).
	col at: partFrame iqX minusFullColumn: pXdot.
	col at: partFrame iqE minusFullColumn: (pEdot minusFullColumn: pTpE)
]

{ #category : #accessing }
MbDPart >> fillEssenConstraints: collection [ 
	partFrame fillEssenConstraints: collection
]

{ #category : #posIC }
MbDPart >> fillPosICError: col [ 
	partFrame fillPosICError: col
]

{ #category : #posIC }
MbDPart >> fillPosICJacob: mat [ 
	partFrame fillPosICJacob: mat
]

{ #category : #posIC }
MbDPart >> fillPosKineError: col [ 
	partFrame fillPosKineError: col
]

{ #category : #posIC }
MbDPart >> fillPosKineJacob: mat [ 
	partFrame fillPosKineJacob: mat
]

{ #category : #accessing }
MbDPart >> fillRedundantConstraints: collection [ 
	partFrame fillRedundantConstraints: collection
]

{ #category : #static }
MbDPart >> fillStaticError: col [ 
	partFrame fillStaticError: col
]

{ #category : #static }
MbDPart >> fillStaticJacob: mat [ 
	partFrame fillStaticJacob: mat
]

{ #category : #velIC }
MbDPart >> fillVelICError: col [ 
	partFrame fillVelICError: col
]

{ #category : #velIC }
MbDPart >> fillVelICJacob: mat [ 
	partFrame fillVelICJacob: mat
]

{ #category : #accessing }
MbDPart >> fillp: col [ 
	col at: ipX put: pX.
	col at: ipE put: pE
]

{ #category : #dynamic }
MbDPart >> fillpFpy: matrix [ 
	| iqE |
	matrix at: ipX and: ipX plusDiagonalMatrix: Identity3by3.
	matrix at: ipE and: ipE plusDiagonalMatrix: Identity4by4.
	iqE := partFrame iqE.
	matrix at: ipE and: iqE minusTransposeFullMatrix: ppTpEpEdot.
	matrix at: iqE and: iqE plusFullMatrix: ppTpEpE.
	partFrame fillpFpy: matrix
]

{ #category : #dynamic }
MbDPart >> fillpFpydot: matrix [ 
	| iqX iqE |
	iqX := partFrame iqX.
	iqE := partFrame iqE.
	matrix at: ipX and: iqX minusDiagonalMatrix: mX.
	matrix at: ipE and: iqE minusFullMatrix: mE.
	matrix at: iqX and: ipX minusDiagonalMatrix: Identity3by3.
	matrix at: iqE and: ipE minusDiagonalMatrix: Identity4by4.
	matrix at: iqE and: iqE plusFullMatrix: ppTpEpEdot.
	partFrame fillpFpydot: matrix
]

{ #category : #accessing }
MbDPart >> fillpdot: col [ 
	col at: ipX put: pXdot.
	col at: ipE put: pEdot
]

{ #category : #accessing }
MbDPart >> fillpqsumu: col [ 
	col at: ipX putFullColumn: pX.
	col at: ipE putFullColumn: pE.
	partFrame fillpqsumu: col
]

{ #category : #accessing }
MbDPart >> fillpqsumudot: col [ 
	col at: ipX putFullColumn: pXdot.
	col at: ipE putFullColumn: pEdot.
	partFrame fillpqsumudot: col
]

{ #category : #accessing }
MbDPart >> fillqsu: col [ 
	partFrame fillqsu: col
]

{ #category : #accessing }
MbDPart >> fillqsuWeights: col [ 
	"Map wqX and wqE according to inertias. (0 to maximum inertia) map to (minw to maxw)"
	"When the inertias are zero, they are set to a small number for positive definiteness."
	"They are not set to zero because inertialess part may be underconstrained."
	"Avoid having two kinds of singularities to confuse redundant constraint removal."
	"Redundant constraint removal likes equal weights."
	"wqE(4) = 0.0d is ok because there is always the euler parameter constraint."

	| mMax aJiMax minw maxw wqX wqE aJi |
	mMax := TheMbDSystem maximumMass.
	aJiMax := TheMbDSystem maximumMomentOfInertia.
	minw := 1000.0d.
	maxw := 1.0d6.
	wqX := DiagonalMatrix new: 3.
	wqE := DiagonalMatrix new: 4.
	mMax = 0 ifTrue: [mMax := 1.0d].
	1 to: 3 do: [:i | wqX at: i put: maxw * m / mMax + minw].
	aJiMax = 0 ifTrue: [aJiMax := 1.0d].
	1 to: 3
		do: 
			[:i | 
			aJi := aJ at: i.
			wqE at: i put: maxw * aJi / aJiMax + minw].
	wqE at: 4 put: minw.
	col at: partFrame iqX putDiagonalMatrix: wqX.
	col at: partFrame iqE putDiagonalMatrix: wqE.
	partFrame fillqsuWeights: col
]

{ #category : #accessing }
MbDPart >> fillqsuWeightsBig: col [ 
	| minw maxw wqX wqE |
	minw := 1000.0d.
	maxw := 1.0d6.
	wqX := DiagonalMatrix new: 3.
	wqE := DiagonalMatrix new: 4.
	1 to: 3 do: [:i | wqX at: i put: maxw].
	1 to: 3 do: [:i | wqE at: i put: maxw].
	wqE at: 4 put: minw.
	col at: partFrame iqX putDiagonalMatrix: wqX.
	col at: partFrame iqE putDiagonalMatrix: wqE.
	partFrame fillqsuWeights: col
]

{ #category : #accessing }
MbDPart >> fillqsuWeightsSmall: col [ 
	| minw wqX wqE |
	minw := 1000.0d.
	wqX := DiagonalMatrix new: 3.
	wqE := DiagonalMatrix new: 4.
	1 to: 3 do: [:i | wqX at: i put: minw].
	1 to: 4 do: [:i | wqE at: i put: minw].
	col at: partFrame iqX putDiagonalMatrix: wqX.
	col at: partFrame iqE putDiagonalMatrix: wqE.
	partFrame fillqsuWeights: col
]

{ #category : #accessing }
MbDPart >> fillqsuddotlam: col [ 
	partFrame fillqsuddotlam: col
]

{ #category : #accessing }
MbDPart >> fillqsudot: col [ 
	partFrame fillqsudot: col
]

{ #category : #accessing }
MbDPart >> fillqsudotPlam: col [ 
	partFrame fillqsudotPlam: col
]

{ #category : #accessing }
MbDPart >> fillqsudotPlamDeriv: col [ 
	partFrame fillqsudotPlamDeriv: col
]

{ #category : #accessing }
MbDPart >> fillqsudotWeights: col [ 
	"wqXdot and wqEdot are set to their respective inertias."
	"When the inertias are zero, they are set to a small number for positive definiteness."
	"They are not set to zero because inertialess part may be underconstrained."
	"wqEdot(4) = 0.0d is ok because there is always the euler parameter constraint."

	| mMax aJiMax maxInertia minw maxw aJi wqXdot wqEdot |
	mMax := TheMbDSystem maximumMass.
	aJiMax := TheMbDSystem maximumMomentOfInertia.
	maxInertia := mMax max: aJiMax.
	maxInertia = 0 ifTrue: [maxInertia := 1.0d].
	minw := 1.0d-12 * maxInertia.
	maxw := maxInertia.
	wqXdot := DiagonalMatrix new: 3.
	wqEdot := DiagonalMatrix new: 4.
	1 to: 3
		do: 
			[:i | 
			wqXdot at: i put: maxw * m / maxInertia + minw.
			aJi := aJ at: i.
			wqEdot at: i put: maxw * aJi / maxInertia + minw].
	wqEdot at: 4 put: minw.
	col at: partFrame iqX putDiagonalMatrix: wqXdot.
	col at: partFrame iqE putDiagonalMatrix: wqEdot.
	partFrame fillqsudotWeights: col
]

{ #category : #accessing }
MbDPart >> fillqsulam: col [ 
	partFrame fillqsulam: col
]

{ #category : #accessing }
MbDPart >> iGabs: count [ 
	^partFrame iGabs: count
]

{ #category : #accessing }
MbDPart >> iGeu: count [ 
	^partFrame iGeu: count
]

{ #category : #'initialize-release' }
MbDPart >> initialize [
	partFrame := MbDPartFrame new.
	partFrame part: self.
	pTpE := FullColumn new: 4.
	ppTpEpE := FullMatrix new: 4 by: 4.
	ppTpEpEdot := FullMatrix new: 4 by: 4
]

{ #category : #'initialize-release' }
MbDPart >> initializeGlobally [
	partFrame initializeGlobally
]

{ #category : #'initialize-release' }
MbDPart >> initializeLocally [
	partFrame initializeLocally.
	mX := m > 0
				ifTrue: [DiagonalMatrix new: 3 withAll: m]
				ifFalse: [DiagonalMatrix new: 3 withAll: 0.0d]
]

{ #category : #accessing }
MbDPart >> ip: integer [ 
	| count |
	count := integer.
	ipX := count.
	count := count + 3.
	ipE := count.
	count := count + 4.
	^count
]

{ #category : #accessing }
MbDPart >> ipE: aInteger [ 
	ipE := aInteger
]

{ #category : #accessing }
MbDPart >> ipX: aInteger [ 
	ipX := aInteger
]

{ #category : #accessing }
MbDPart >> iq: count [ 
	^partFrame iq: count
]

{ #category : #accessing }
MbDPart >> iqE [
	^partFrame iqE
]

{ #category : #accessing }
MbDPart >> iqE: aInteger [ 
	partFrame iqE: aInteger
]

{ #category : #accessing }
MbDPart >> iqX [
	^partFrame iqX
]

{ #category : #accessing }
MbDPart >> iqX: aInteger [ 
	partFrame iqX: aInteger
]

{ #category : #accessing }
MbDPart >> m [
	^m
]

{ #category : #accessing }
MbDPart >> m: aDouble [ 
	m := aDouble
]

{ #category : #accessing }
MbDPart >> mEdot [
	^mEdot
]

{ #category : #patching }
MbDPart >> markers [
	^partFrame markers
]

{ #category : #accessing }
MbDPart >> mass [
	^m
]

{ #category : #accessing }
MbDPart >> mass: double [ 
	m := double
]

{ #category : #patching }
MbDPart >> omeOpO [
	^partFrame omeOpO
]

{ #category : #accessing }
MbDPart >> omeOpO: column [ 
	partFrame omeOpO: column
]

{ #category : #patching }
MbDPart >> pApE [
	^partFrame pApE
]

{ #category : #accessing }
MbDPart >> partFrame [
	^partFrame
]

{ #category : #patching }
MbDPart >> pomeOpOpE [
	^partFrame pomeOpOpE
]

{ #category : #patching }
MbDPart >> pomeOpOpEdot [
	^partFrame pomeOpOpEdot
]

{ #category : #accIC }
MbDPart >> postAccIC [
	self calcpdot
]

{ #category : #collision }
MbDPart >> postCollisionCorrectorIteration [
	partFrame postCollisionCorrectorIteration
]

{ #category : #collision }
MbDPart >> postCollisionPredictor [
	partFrame postCollisionPredictor
]

{ #category : #dynamic }
MbDPart >> postDynCorrectorIteration [
	partFrame postDynCorrectorIteration.
	super postDynCorrectorIteration
]

{ #category : #dynamic }
MbDPart >> postDynOutput [
	partFrame postDynOutput.
	super postDynOutput
]

{ #category : #dynamic }
MbDPart >> postDynPredictor [
	partFrame postDynPredictor.
	super postDynPredictor
]

{ #category : #dynamic }
MbDPart >> postDynStep [
	partFrame postDynStep
]

{ #category : #'input-output' }
MbDPart >> postInput [
	partFrame postInput.
	super postInput
]

{ #category : #posIC }
MbDPart >> postPosIC [
	partFrame postPosIC.
	self calcmE
]

{ #category : #posIC }
MbDPart >> postPosICIteration [
	partFrame postPosICIteration
]

{ #category : #static }
MbDPart >> postStaticIteration [
	partFrame postStaticIteration.
	super postStaticIteration
]

{ #category : #velIC }
MbDPart >> postVelIC [
	partFrame postVelIC.
	self calcp.
	self calcmEdot.
	self calcpTpE.
	self calcppTpEpE.
	self calcppTpEpEdot
]

{ #category : #accIC }
MbDPart >> preAccIC [
	partFrame preAccIC.
	super preAccIC
]

{ #category : #collision }
MbDPart >> preCollision [
	partFrame preCollision
]

{ #category : #collision }
MbDPart >> preCollisionDerivativeIC [
	partFrame preCollisionDerivativeIC
]

{ #category : #dynamic }
MbDPart >> preDyn [
	partFrame preDyn
]

{ #category : #dynamic }
MbDPart >> preDynOutput [
	partFrame preDynOutput.
	super preDynOutput
]

{ #category : #posIC }
MbDPart >> preICRestart [
	partFrame preICRestart
]

{ #category : #posIC }
MbDPart >> prePosIC [
	partFrame prePosIC
]

{ #category : #posIC }
MbDPart >> prePosKine [
	partFrame prePosKine
]

{ #category : #static }
MbDPart >> preStatic [
	partFrame preStatic.
	super preStatic
]

{ #category : #velIC }
MbDPart >> preVelIC [
	partFrame preVelIC
]

{ #category : #accessing }
MbDPart >> qE: column [ 
	partFrame qE: column
]

{ #category : #accessing }
MbDPart >> qEddot [
	^partFrame qEddot
]

{ #category : #accessing }
MbDPart >> qEddot: column [ 
	partFrame qEddot: column
]

{ #category : #accessing }
MbDPart >> qEdot [
	^partFrame qEdot
]

{ #category : #accessing }
MbDPart >> qEdot: column [ 
	partFrame qEdot: column
]

{ #category : #patching }
MbDPart >> qX [
	^partFrame qX
]

{ #category : #accessing }
MbDPart >> qX: column [ 
	partFrame qX: column
]

{ #category : #accessing }
MbDPart >> qXddot [
	^partFrame qXddot
]

{ #category : #accessing }
MbDPart >> qXddot: column [ 
	partFrame qXddot: column
]

{ #category : #accessing }
MbDPart >> qXdot [
	^partFrame qXdot
]

{ #category : #accessing }
MbDPart >> qXdot: column [ 
	partFrame qXdot: column
]

{ #category : #posIC }
MbDPart >> removeRedundantConstraints: redundantEqns [ 
	partFrame removeRedundantConstraints: redundantEqns
]

{ #category : #accessing }
MbDPart >> setpqsumu: col [ 
	pX equalFullColumn: col at: ipX.
	pE equalFullColumn: col at: ipE.
	partFrame setpqsumu: col
]

{ #category : #accessing }
MbDPart >> setpqsumuddot: col [ 
	partFrame setpqsumuddot: col
]

{ #category : #accessing }
MbDPart >> setpqsumudot: col [ 
	pXdot equalFullColumn: col at: ipX.
	pEdot equalFullColumn: col at: ipE.
	partFrame setpqsumudot: col
]

{ #category : #accessing }
MbDPart >> setqsu: col [ 
	partFrame setqsu: col
]

{ #category : #accessing }
MbDPart >> setqsuddotlam: col [ 
	partFrame setqsuddotlam: col
]

{ #category : #accessing }
MbDPart >> setqsudot: col [ 
	partFrame setqsudot: col
]

{ #category : #accessing }
MbDPart >> setqsudotPlam: col [ 
	partFrame setqsudotPlam: col
]

{ #category : #accessing }
MbDPart >> setqsudotPlamDeriv: col [ 
	partFrame setqsudotPlamDeriv: col
]

{ #category : #accessing }
MbDPart >> setqsudotlam: col [ 
	partFrame setqsudotlam: col
]

{ #category : #accessing }
MbDPart >> setqsulam: col [ 
	partFrame setqsulam: col
]

{ #category : #dynamic }
MbDPart >> simUpdateAll [
	partFrame simUpdateAll.
	super simUpdateAll
]

{ #category : #dynamic }
MbDPart >> storeDynState [
	partFrame storeDynState
]

{ #category : #'initialize-release' }
MbDPart >> submitToSystem [
	self registerName.
	TheMbDSystem parts add: self
]

{ #category : #dynamic }
MbDPart >> suggestSmallerOrAcceptDynStepSize: hnew [ 
	| hnew2 |
	hnew2 := hnew.
	hnew2 := partFrame suggestSmallerOrAcceptDynStepSize: hnew2.
	^hnew2
]

{ #category : #'initialize-release' }
MbDPart >> useEquationNumbers [
	partFrame useEquationNumbers
]
