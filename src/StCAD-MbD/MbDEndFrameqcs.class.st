"
s is a full column of dimension 1 or 2 for curve and surface respectively.
"
Class {
	#name : #MbDEndFrameqcs,
	#superclass : #MbDEndFrameqc,
	#instVars : [
		'onExterior',
		'is',
		'sSize',
		's',
		'sdot',
		'sddot',
		'rmemBlk',
		'rmem',
		'prmemps',
		'pprmempsps',
		'ppprmempspsps',
		'aAme',
		'pAmeps',
		'ppAmepsps',
		'prOeOps',
		'pprOeOpEps',
		'pprOeOpsps',
		'pAOeps',
		'ppAOepEps',
		'ppAOepsps',
		'tem1',
		'tem2',
		'te1',
		'te2',
		'utem1',
		'utem2',
		'iem',
		'jem',
		'kem',
		'ptem1ps',
		'ptem2ps',
		'pte1ps',
		'pte2ps',
		'putem1ps',
		'putem2ps',
		'piemps',
		'pjemps',
		'pkemps',
		'pptem1psps',
		'pptem2psps',
		'ppte1psps',
		'ppte2psps',
		'pputem1psps',
		'pputem2psps',
		'ppiempsps',
		'ppjempsps',
		'ppkempsps'
	],
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #'VisualWorks metadata' }
MbDEndFrameqcs class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDEndFrameqcs >> aOeO [
	"Material point acceleration"

	| partFrame |
	partFrame := self partFrame.
	^partFrame aOpO 
		plusFullColumn: (partFrame aAddotOp timesFullColumn: self rpep)
]

{ #category : #accessing }
MbDEndFrameqcs >> bePerturbed: delta fillqsulam: col [ 
	col at: is putFullColumn: s
]

{ #category : #'initialize-release' }
MbDEndFrameqcs >> becomeContactEndFrame [
	| newSelf |
	newSelf := MbDContactEndFrameqcs new.
	newSelf name: self name.
	newSelf markerFrame: self markerFrame.
	newSelf is: self is.
	newSelf sSize: self sSize.
	newSelf s: self s.
	newSelf sdot: self sdot.
	newSelf sddot: self sddot.
	newSelf rmemBlk: self rmemBlk.
	self become: newSelf
]

{ #category : #'initialize-release' }
MbDEndFrameqcs >> becomeNoContactEndFrame [
	| newSelf |
	newSelf := MbDNoContactEndFrameqcs new.
	newSelf name: self name.
	newSelf markerFrame: self markerFrame.
	newSelf is: self is.
	newSelf sSize: self sSize.
	newSelf s: self s.
	newSelf sdot: self sdot.
	newSelf sddot: self sddot.
	newSelf rmemBlk: self rmemBlk.
	self become: newSelf
]

{ #category : #calc }
MbDEndFrameqcs >> calcAme2D [
	| iem1 iem2 pAmeps1 ptem1ps1 pte1ps1 piemps1 piem1ps1 piem2ps1 ppAmeps1ps1 pptem1ps1ps1 ppte1ps1ps1 ppiemps1ps1 ppiem1ps1ps1 ppiem2ps1ps1 |
	tem1 := prmemps column: 1.
	te1 := tem1 length.
	iem := tem1 times: 1.0d / te1.
	iem1 := iem at: 1.
	iem2 := iem at: 2.
	kem at: 1 put: iem2; at: 2 put: iem1 negated; at: 3 put: 0.0d.
	(aAme at: 1) at: 1 put: iem1; at: 2 put: 0.0d; at: 3 put: iem2.
	(aAme at: 2) at: 1 put: iem2; at: 2 put: 0.0d; at: 3 put: iem1 negated.
	(aAme at: 3) at: 1 put: 0.0d; at: 2 put: 1.0d; at: 3 put: 0.0d.
	pAmeps1 := pAmeps at: 1.
	ptem1ps1 := pprmempsps at: 1 and: 1.
	pte1ps1 := ptem1ps1 dot: iem.
	piemps1 := ptem1ps1 - (iem times: pte1ps1) times: 1.0d / te1.
	piem1ps1 := piemps1 at: 1.
	piem2ps1 := piemps1 at: 2.
	(pAmeps1 at: 1) at: 1 put: piem1ps1; at: 2 put: 0.0d; at: 3 put: piem2ps1.
	(pAmeps1 at: 2) at: 1 put: piem2ps1; at: 2 put: 0.0d; at: 3 put: piem1ps1 negated.
	(pAmeps1 at: 3) at: 1 put: 0.0d; at: 2 put: 0.0d; at: 3 put: 0.0d.
	ppAmeps1ps1 := ppAmepsps at: 1 and: 1.
	pptem1ps1ps1 := ((ppprmempspsps at: 1) at: 1) at: 1.
	ppte1ps1ps1 := (pptem1ps1ps1 dot: tem1) + (ptem1ps1 dot: ptem1ps1) - (pte1ps1 * pte1ps1) / te1.
	ppiemps1ps1 := pptem1ps1ps1 times: 1.0d / te1.
	ppiemps1ps1 equalSelfPlusFullColumn: (tem1 times: 2.0d * pte1ps1 * pte1ps1 / (te1 * te1 * te1)).
	ppiemps1ps1 equalSelfMinusFullColumn: (ptem1ps1 times: pte1ps1 / (te1 * te1)).
	ppiemps1ps1 equalSelfMinusFullColumn: (ptem1ps1 times: pte1ps1 / (te1 * te1)).
	ppiemps1ps1 equalSelfMinusFullColumn: (tem1 times: ppte1ps1ps1 / (te1 * te1)).
	ppiem1ps1ps1 := ppiemps1ps1 at: 1.
	ppiem2ps1ps1 := ppiemps1ps1 at: 2.
	(ppAmeps1ps1 at: 1) at: 1 put: ppiem1ps1ps1; at: 2 put: 0.0d; at: 3 put: ppiem2ps1ps1.
	(ppAmeps1ps1 at: 2) at: 1 put: ppiem2ps1ps1; at: 2 put: 0.0d; at: 3 put: ppiem1ps1ps1 negated.
	(ppAmeps1ps1 at: 3) at: 1 put: 0.0d; at: 2 put: 0.0d; at: 3 put: 0.0d
]

{ #category : #calc }
MbDEndFrameqcs >> calcAme3D [
	| ptem1psj ptem2psj pte1psj pte2psj putem1psj putem2psj piempsj pkempsj pjempsj pAmepsj ptem1psi ptem2psi pte1psi pte2psi putem1psi putem2psi pptem1psips pptem2psips ppte1psips ppte2psips pputem1psips pputem2psips ppiempsips ppjempsips ppkempsips ppAmepsips pptem1psipsj pptem2psipsj ppte1psipsj ppte2psipsj pputem1psipsj pputem2psipsj ppiempsipsj ppkempsipsj ppjempsipsj pkempsi piempsi ppAmepsipsj |
	tem1 := prmemps column: 1.
	tem2 := prmemps column: 2.
	te1 := tem1 length.
	te2 := tem2 length.
	utem1 := tem1 times: 1.0d / te1.
	utem2 := tem2 times: 1.0d / te2.
	iem := utem1.
	kem := (utem1 cross: utem2) normalizeSelf.
self halt: 'Check kem and its derivatives.'.
	jem := kem cross: iem.
	(aAme at: 1) at: 1 put: (iem at: 1); at: 2 put: (jem at: 1); at: 3 put: (kem at: 1).
	(aAme at: 2) at: 1 put: (iem at: 2); at: 2 put: (jem at: 2); at: 3 put: (kem at: 2).
	(aAme at: 3) at: 1 put: (iem at: 3); at: 2 put: (jem at: 3); at: 3 put: (kem at: 3).
	1 to: sSize
		do: 
			[:j | 
			ptem1psj := pprmempsps at: 1 and: j.
			ptem2psj := pprmempsps at: 2 and: j.
			pte1psj := utem1 dot: ptem1psj.
			pte2psj := utem2 dot: ptem2psj.
			putem1psj := (ptem1psj minusFullMatrix: (utem1 timesFullRow: pte1psj)) magnifySelf: 1.0d / te1.
			putem2psj := (ptem2psj minusFullMatrix: (utem2 timesFullRow: pte2psj)) magnifySelf: 1.0d / te2.
			piempsj := putem1psj.
			pkempsj := (putem1psj cross: utem2) equalSelfPlusFullColumn: (utem1 cross: putem2psj).
			pjempsj := (pkempsj cross: iem) equalSelfPlusFullColumn: (kem cross: piempsj).
			ptem1ps at: 1 and: j putFullColumn: ptem1psj.
			ptem2ps at: 1 and: j putFullColumn: ptem2psj.
			piemps at: 1 and: j putFullColumn: piempsj.
			pjemps at: 1 and: j putFullColumn: pjempsj.
			pkemps at: 1 and: j putFullColumn: pkempsj.
			pAmepsj := pAmeps at: j.
			(pAmepsj at: 1) at: 1 put: (piempsj at: 1); at: 2 put: (pjempsj at: 1); at: 3 put: (pkempsj at: 1).
			(pAmepsj at: 2) at: 1 put: (piempsj at: 2); at: 2 put: (pjempsj at: 2); at: 3 put: (pkempsj at: 2).
			(pAmepsj at: 3) at: 1 put: (piempsj at: 3); at: 2 put: (pjempsj at: 3); at: 3 put: (pkempsj at: 3)].
	1 to: sSize
		do: 
			[:i | 
			ptem1psi := ptem1ps column: i.
			ptem2psi := ptem2ps column: i.
			pte1psi := pte1ps at: i.
			pte2psi := pte2ps at: i.
			putem1psi := putem1ps column: i.
			putem2psi := putem2ps column: i.
			piempsi := piemps column: i.
			pkempsi := pkemps column: i.
			pptem1psips := pptem1psps at: i.
			pptem2psips := pptem2psps at: i.
			ppte1psips := ppte1psps at: i.
			ppte2psips := ppte2psps at: i.
			pputem1psips := pputem1psps at: i.
			pputem2psips := pputem2psps at: i.
			ppiempsips := ppiempsps at: i.
			ppjempsips := ppjempsps at: i.
			ppkempsips := ppkempsps at: i.
			ppAmepsips := ppAmepsps at: i.
			i to: sSize
				do: 
					[:j | 
					i == j
						ifTrue: 
							[ptem1psj := ptem1psi.
							ptem2psj := ptem2psi.
							pte1psj := pte1psi.
							pte2psj := pte2psi.
							putem1psj := putem1psi.
							putem2psj := putem2psi.
							piempsj := piempsi.
							pkempsj := pkempsi]
						ifFalse: 
							[ptem1psj := ptem1ps column: j.
							ptem2psj := ptem2ps column: j.
							pte1psj := pte1ps at: j.
							pte2psj := pte2ps at: j.
							putem1psj := putem1ps column: j.
							putem2psj := putem2ps column: j.
							piempsj := piemps column: j.
							pkempsj := pkemps column: j].
					pptem1psipsj := ((ppprmempspsps at: 1) at: i) at: j.
					pptem2psipsj := ((ppprmempspsps at: 2) at: i) at: j.
					ppte1psipsj := (ptem1psi dot: ptem1psj)
								+ (pptem1psipsj dot: tem1) - (pte1psi * pte1psj) / te1.
					ppte2psipsj := (ptem2psi dot: ptem2psj)
								+ (pptem2psipsj dot: tem2) - (pte2psi * pte2psj) / te2.
					pputem1psipsj := pptem1psipsj times: te1.
					pputem1psipsj equalSelfPlusFullColumn: (tem1 times: 2.0d * pte1psi * pte1psj / te1).
					pputem1psipsj equalSelfMinusFullColumn: (ptem1psi times: pte1psj).
					pputem1psipsj equalSelfMinusFullColumn: (ptem1psj times: pte1psi).
					pputem1psipsj equalSelfMinusFullColumn: (tem1 times: ppte1psipsj).
					pputem1psipsj magnifySelf: 1.0d / (te1 * te1).
					pputem2psipsj := pptem2psipsj times: te2.
					pputem2psipsj equalSelfPlusFullColumn: (tem2 times: 2.0d * pte2psi * pte2psj / te2).
					pputem2psipsj equalSelfMinusFullColumn: (ptem2psi times: pte2psj).
					pputem2psipsj equalSelfMinusFullColumn: (ptem2psj times: pte2psi).
					pputem2psipsj equalSelfMinusFullColumn: (tem2 times: ppte2psipsj).
					pputem2psipsj magnifySelf: 1.0d / (te2 * te2).
					ppiempsipsj := pputem1psipsj.
					ppkempsipsj := pputem1psipsj cross: utem2.
					ppkempsipsj equalSelfPlusFullColumn: (putem1psi cross: putem2psj).
					ppkempsipsj equalSelfPlusFullColumn: (putem1psj cross: putem2psi).
					ppkempsipsj equalSelfPlusFullColumn: (utem1 cross: pputem2psipsj).
					ppjempsipsj := ppkempsipsj cross: iem.
					ppjempsipsj equalSelfPlusFullColumn: (pkempsi cross: piempsj).
					ppjempsipsj equalSelfPlusFullColumn: (pkempsj cross: piempsi).
					ppjempsipsj equalSelfPlusFullColumn: (kem cross: ppiempsipsj).
					pptem1psips at: i and: j put: pptem1psipsj.
					pptem2psips at: i and: j put: pptem2psipsj.
					ppte1psips at: i and: j put: ppte1psipsj.
					ppte2psips at: i and: j put: ppte2psipsj.
					pputem1psips at: i and: j put: pputem1psipsj.
					pputem2psips at: i and: j put: pputem2psipsj.
					ppiempsips at: i and: j put: ppiempsipsj.
					ppjempsips at: i and: j put: ppjempsipsj.
					ppkempsips at: i and: j put: ppkempsipsj.
					ppAmepsipsj := ppAmepsips at: j.
					(ppAmepsipsj at: 1) at: 1 put: (ppiempsipsj at: 1); at: 2 put: (ppjempsipsj at: 1); at: 3 put: (ppkempsipsj at: 1).
					(ppAmepsipsj at: 2) at: 1 put: (ppiempsipsj at: 2); at: 2 put: (ppjempsipsj at: 2); at: 3 put: (ppkempsipsj at: 2).
					(ppAmepsipsj at: 3) at: 1 put: (ppiempsipsj at: 3); at: 2 put: (ppjempsipsj at: 3); at: 3 put: (ppkempsipsj at: 3)]]
]

{ #category : #calc }
MbDEndFrameqcs >> calcPostDynCorrectorIteration [
	| prmempsT rOmO aAOm pAOmpE pAOppE rpmp aApm rpep prOeOpEi prOeOpEij pprOeOpEips pAOmpEi pprOeOpsips pprmempsips pprmempsipsj pAmepsi aApe ppAOepEips pAmepsj ppAmepsips ppAOepsips ppAmepsipsj |
	rmem := rmemBlk value: s.
	prmemps := rmemBlk pvalueps: s.
	prmempsT := prmemps transpose.
	pprmempsps := rmemBlk ppvaluepsps: s.
	ppprmempspsps := rmemBlk pppvaluepspsps: s.
	rOmO := markerFrame rOmO.
	aAOm := markerFrame aAOm.
	pAOmpE := markerFrame pAOmpE.
	pAOppE := markerFrame pAOppE.
	rpmp := markerFrame rpmp.
	aApm := markerFrame aApm.
	rpep := rpmp plusFullColumn: (aApm timesFullColumn: rmem).
	rOeO := rOmO plusFullColumn: (aAOm timesFullColumn: rmem).
	1 to: 3 do: [:i | 
			prOeOpEi := prOeOpE at: i.
			1 to: 4 do: [:j | 
					prOeOpEij := ((pAOppE at: j) at: i) timesFullColumn: rpep.
					prOeOpEi at: j put: prOeOpEij]].
	prOeOps := aAOm timesFullMatrix: prmemps.
	pprOeOpEpE := MbDEulerParameters ppApEpEtimesColumn: rpep.
	1 to: 4 do: [:i | 
			pprOeOpEips := pprOeOpEps at: i.
			pAOmpEi := pAOmpE at: i.
			1 to: sSize do: [:j | pprOeOpEips at: j put: (pAOmpEi timesFullColumn: (prmempsT at: j))]].
	1 to: sSize do: [:i | 
			pprOeOpsips := pprOeOpsps at: i.
			pprmempsips := pprmempsps at: i.
			1 to: sSize do: [:j | 
					pprmempsipsj := pprmempsips at: j.
					pprOeOpsips at: j put: (aAOm timesFullColumn: pprmempsipsj)]].
	sSize == 1
		ifTrue: [self calcAme2D]
		ifFalse: [self calcAme3D].
	aAOe := aAOm timesFullMatrix: aAme.
	1 to: 4 do: [:i | 
			pAOmpEi := pAOmpE at: i.
			pAOepE at: i put: (pAOmpEi timesFullMatrix: aAme)].
	1 to: sSize do: [:i | 
			pAmepsi := pAmeps at: i.
			pAOeps at: i put: (aAOm timesFullMatrix: pAmepsi)].
	aApe := markerFrame aApm timesFullMatrix: aAme.
	ppAOepEpE := MbDEulerParameters ppApEpEtimesMatrix: aApe.
	1 to: 4 do: [:i | 
			pAOmpEi := pAOmpE at: i.
			ppAOepEips := ppAOepEps at: i.
			1 to: sSize do: [:j | 
					pAmepsj := pAmeps at: j.
					ppAOepEips at: j put: (pAOmpEi timesFullMatrix: pAmepsj)]].
	1 to: sSize do: [:i | 
			ppAmepsips := ppAmepsps at: i.
			ppAOepsips := ppAOepsps at: i.
			i to: sSize do: [:j | 
					ppAmepsipsj := ppAmepsips at: j.
					ppAOepsips at: j put: (aAOm timesFullMatrix: ppAmepsipsj)]].
	ppAOepsps symLowerWithUpper
]

{ #category : #accessing }
MbDEndFrameqcs >> fillContactEndFrames: set [ 
	set add: self
]

{ #category : #accessing }
MbDEndFrameqcs >> fillpqsumu: col [ 
	col at: is putFullColumn: s
]

{ #category : #accessing }
MbDEndFrameqcs >> fillpqsumudot: col [ 
	col at: is putFullColumn: sdot
]

{ #category : #accessing }
MbDEndFrameqcs >> fillqsu: col [ 
	col at: is putFullColumn: s
]

{ #category : #accessing }
MbDEndFrameqcs >> fillqsuWeights: col [ 
	"Add a small weight just to prevent singularity from unconstrained s."

	| iOffset |
	iOffset := is - 1.
	1 to: sSize do: [:ii | col at: iOffset + ii put: 1.0d-6]
]

{ #category : #accessing }
MbDEndFrameqcs >> fillqsuddotlam: col [ 
	col at: is putFullColumn: sddot
]

{ #category : #accessing }
MbDEndFrameqcs >> fillqsudot: col [ 
	col at: is putFullColumn: sdot
]

{ #category : #accessing }
MbDEndFrameqcs >> fillqsudotPlam: col [ 
	col at: is putFullColumn: sdot
]

{ #category : #accessing }
MbDEndFrameqcs >> fillqsudotPlamDeriv: col [ 
	"sddot is now sdotDeriv for collision."

	col at: is putFullColumn: sddot
]

{ #category : #accessing }
MbDEndFrameqcs >> fillqsudotWeights: col [ 
	| iOffset |
	iOffset := is - 1.
	1 to: sSize do: [:ii | col at: iOffset + ii put: 0.0d]
]

{ #category : #accessing }
MbDEndFrameqcs >> fillqsulam: col [ 
	col at: is putFullColumn: s
]

{ #category : #'initialize-release' }
MbDEndFrameqcs >> initDefineSolid [
	"Curve defines a solid when angleSwept a non material point is zero."
	"Curve defines a hole when angleSwept is minus 2*pi."

	| rmems point1 point2 nonMaterialPoint answerArray angleSwept nPI |
	rmems := self rmems.
	point1 := rmems at: 1.
	point2 := rmems at: 2.
	nonMaterialPoint := point1 + (point2 - point1 cross: jem * 0.001d).
	answerArray := self roughSepDistFromrmem: nonMaterialPoint.
	angleSwept := answerArray at: 3.
	nPI := (angleSwept / Double pi) rounded.
	nPI = 0
		ifTrue: [onExterior := true]
		ifFalse: [nPI = -2
				ifTrue: [onExterior := false]
				ifFalse: [onExterior := nil]]
]

{ #category : #'initialize-release' }
MbDEndFrameqcs >> initializeGlobally [
	self initDefineSolid
]

{ #category : #'initialize-release' }
MbDEndFrameqcs >> initializeLocally [
	"jem is constant for constant cross section solid."

	pprOeOpEps := FullMatrix new: 4 by: sSize.
	pprOeOpsps := FullMatrix new: sSize by: sSize.
	pAOeps := FullColumn new: sSize.
	ppAOepEps := FullMatrix new: 4 by: sSize.
	ppAOepsps := FullMatrix new: sSize by: sSize.
	sSize == 1 ifTrue: [jem := FullColumn
					with: 0.0d
					with: 0.0d
					with: 1.0d].
	kem := FullColumn new: 3.
	aAme := FullMatrix new: 3 by: 3.
	pAmeps := FullColumn new: sSize.
	1 to: sSize do: [:i | pAmeps at: i put: (FullMatrix new: 3 by: 3)].
	ppAmepsps := FullMatrix new: sSize by: sSize.
	1 to: sSize do: [:i | 1 to: sSize do: [:j | ppAmepsps at: i and: j put: (FullMatrix new: 3 by: 3)]]
]

{ #category : #accessing }
MbDEndFrameqcs >> is [
	^is
]

{ #category : #accessing }
MbDEndFrameqcs >> is: integer [ 
	is := integer
]

{ #category : #accessing }
MbDEndFrameqcs >> isOnClosedCurve [
	^rmemBlk isCyclic
]

{ #category : #accessing }
MbDEndFrameqcs >> onExterior [
	"EndFrame is on exterior surface, if true."
	"Otherwise it is on an interior surface."

	^onExterior
]

{ #category : #accessing }
MbDEndFrameqcs >> pAdotjOeps: jj [ 
	| aAdotOm answer pAmepsj pAdotOejjpsj |
	aAdotOm := self partFrame aAdotOp timesFullMatrix: markerFrame aApm.
	answer := FullMatrix new: 3 by: sSize.
	1 to: sSize
		do: 
			[:j | 
			pAmepsj := pAmeps at: j.
			pAdotOejjpsj := aAdotOm timesFullColumn: (pAmepsj column: jj).
			answer
				at: 1
				and: j
				putFullColumn: pAdotOejjpsj].
	^answer
]

{ #category : #accessing }
MbDEndFrameqcs >> pAjOeps: jj [ 
	| answer pAOepsj col |
	answer := FullMatrix new: 3 by: sSize.
	1 to: sSize
		do: 
			[:j | 
			pAOepsj := pAOeps at: j.
			col := pAOepsj column: jj.
			answer
				at: 1
				and: j
				putFullColumn: col].
	^answer
]

{ #category : #accessing }
MbDEndFrameqcs >> pAjOepsT: jj [ 
	| answer answeri pAOepsi answerij |
	answer := FullMatrix new: sSize by: 3.
	1 to: sSize do: [:i | 
			answeri := answer at: i.
			pAOepsi := pAOeps at: i.
			1 to: 3 do: [:j | 
					answerij := pAOepsi at: j and: jj.
					answeri at: j put: answerij]].
	^answer
]

{ #category : #accessing }
MbDEndFrameqcs >> ppAjOepEps: jj [ 
	| answer answeri ppAOepEips |
	answer := FullMatrix new: 4 by: sSize.
	1 to: 4 do: [:i | 
			answeri := answer at: i.
			ppAOepEips := ppAOepEps at: i.
			1 to: sSize do: [:j | answeri at: j put: ((ppAOepEips at: j) column: jj)]].
	^answer
]

{ #category : #accessing }
MbDEndFrameqcs >> ppAjOepsps: jj [ 
	| answer answeri ppAOepsips |
	answer := FullMatrix new: sSize by: sSize.
	1 to: sSize do: [:i | 
			answeri := answer at: i.
			ppAOepsips := ppAOepsps at: i.
			i to: sSize do: [:j | answeri at: j put: ((ppAOepsips at: j) column: jj)]].
	^answer symLowerWithUpper
]

{ #category : #accessing }
MbDEndFrameqcs >> pprOeOpEps [
	^pprOeOpEps
]

{ #category : #accessing }
MbDEndFrameqcs >> pprOeOpsps [
	^pprOeOpsps
]

{ #category : #accessing }
MbDEndFrameqcs >> ppriOeOpEps: ii [ 
	| answer answeri pprOeOpEips |
	answer := FullMatrix new: 4 by: sSize.
	1 to: 4 do: [:i | 
			answeri := answer at: i.
			pprOeOpEips := pprOeOpEps at: i.
			1 to: sSize do: [:j | answeri at: j put: ((pprOeOpEips at: j) at: ii)]].
	^answer
]

{ #category : #accessing }
MbDEndFrameqcs >> ppriOeOpsps: ii [ 
	| answer answeri pprOeOpsips |
	answer := FullMatrix new: sSize by: sSize.
	1 to: sSize do: [:i | 
			answeri := answer at: i.
			pprOeOpsips := pprOeOpsps at: i.
			1 to: sSize do: [:j | answeri at: j put: ((pprOeOpsips at: j) at: ii)]].
	^answer
]

{ #category : #accessing }
MbDEndFrameqcs >> prOeOps [
	^prOeOps
]

{ #category : #accIC }
MbDEndFrameqcs >> preAccIC [
	super preAccIC.
	sddot := (FullColumn zero: sSize)
]

{ #category : #posIC }
MbDEndFrameqcs >> prePosIC [
	super prePosIC.
	is := nil
]

{ #category : #static }
MbDEndFrameqcs >> preStatic [
	sdot zeroSelf.
	super preStatic.
	is := nil
]

{ #category : #accessing }
MbDEndFrameqcs >> priOeOps: i [ 
	^prOeOps at: i
]

{ #category : #accessing }
MbDEndFrameqcs >> pvOeOpE [
	| answer pAdotOppE |
	answer := FullMatrix new: 3 by: 4.
	pAdotOppE := self partFrame pAdotOppE.
	1 to: 4 do: [:j | answer
			at: 1
			and: j
			putFullColumn: ((pAdotOppE at: j)
					timesFullColumn: self rpep)].
	^answer
]

{ #category : #accessing }
MbDEndFrameqcs >> pvOeOps [
	| answer aAdotOm |
	answer := FullMatrix new: 3 by: sSize.
	aAdotOm := self partFrame aAdotOp timesFullMatrix: markerFrame aApm.
	1 to: sSize do: [:j | answer
			at: 1
			and: j
			putFullColumn: (aAdotOm timesFullColumn: (prmemps at: j))].
	^answer
]

{ #category : #accessing }
MbDEndFrameqcs >> rmemBlk [
	^rmemBlk
]

{ #category : #accessing }
MbDEndFrameqcs >> rmemBlk: function [ 
	rmemBlk := function
]

{ #category : #accessing }
MbDEndFrameqcs >> rmems [
	^rmemBlk ys
]

{ #category : #calc }
MbDEndFrameqcs >> roughSepDistFromrOeO: col [ 
	| rmem2 |
	rmem2 := markerFrame rmemOFrOeO: col.
	^self roughSepDistFromrmem: rmem2
]

{ #category : #calc }
MbDEndFrameqcs >> roughSepDistFromrmem1: col [ 
	"Answer an array of the rough minimum distance to col, index of curve point, angleSwept 
	going round the curve."
	"Method is valid for curves only, not surfaces."

	| rmems size minusrmPtm minDistSq indexI angleSwept minusrmPtmNext distSq minusrmPtm1 minusrmPtm2 minusrmPtmNext1 minusrmPtmNext2 sinAngle cosAngle angle |
	rmems := self rmems.
	size := rmems size.
	minusrmPtm := (rmems at: 1) minusFullColumn: col.
	minDistSq := minusrmPtm sumOfSquares.
	indexI := 1.
	minusrmPtm normalizeSelf.
	angleSwept := 0.0d.
	2 to: size do: [:i | 
			minusrmPtmNext := (rmems at: i) minusFullColumn: col.
			distSq := minusrmPtmNext sumOfSquares.
			distSq < minDistSq
				ifTrue: 
					[minDistSq := distSq.
					indexI := i].
			minusrmPtmNext normalizeSelf.
			minusrmPtm1 := minusrmPtm at: 1.
			minusrmPtm2 := minusrmPtm at: 2.
			minusrmPtmNext1 := minusrmPtmNext at: 1.
			minusrmPtmNext2 := minusrmPtmNext at: 2.
			sinAngle := minusrmPtm1 * minusrmPtmNext2 - (minusrmPtm2 * minusrmPtmNext1).
			cosAngle := minusrmPtm1 * minusrmPtmNext1 + (minusrmPtm2 * minusrmPtmNext2).
			angle := Double arcTanMpiTOpiY: sinAngle overX: cosAngle.
			angleSwept := angleSwept + angle.
			minusrmPtm := minusrmPtmNext].
	^Array
		with: minDistSq sqrt
		with: indexI
		with: angleSwept
]

{ #category : #calc }
MbDEndFrameqcs >> roughSepDistFromrmem: col [ 
	"Answer an array of the rough minimum distance to col, index of 
	curve point, angleSwept 
	going round the curve."
	"Method is valid for curves only, not surfaces."

	| rmems size minusrmPtm minDistSq indexI angleSwept minusrmPtmNext distSq minusrmPtm1 minusrmPtm2 minusrmPtmNext1 minusrmPtmNext2 abSinAngle abCosAngle angle |
	rmems := self rmems.
	size := rmems size.
	minusrmPtm := (rmems at: 1)
				minusFullColumn: col.
	minusrmPtm1 := minusrmPtm at: 1.
	minusrmPtm2 := minusrmPtm at: 2.
	minDistSq := minusrmPtm1 squared + minusrmPtm2 squared.
	indexI := 1.
	angleSwept := 0.0d.
	2 to: size
		do: 
			[:i | 
			minusrmPtmNext := (rmems at: i)
						minusFullColumn: col.
			minusrmPtmNext1 := minusrmPtmNext at: 1.
			minusrmPtmNext2 := minusrmPtmNext at: 2.
			distSq := minusrmPtmNext1 squared + minusrmPtmNext2 squared.
			distSq < minDistSq
				ifTrue: 
					[minDistSq := distSq.
					indexI := i].
			abSinAngle := minusrmPtm1 * minusrmPtmNext2 - (minusrmPtm2 * minusrmPtmNext1).
			abCosAngle := minusrmPtm1 * minusrmPtmNext1 + (minusrmPtm2 * minusrmPtmNext2).
			angle := Double arcTanMpiTOpiY: abSinAngle overX: abCosAngle.
			angleSwept := angleSwept + angle.
			minusrmPtm1 := minusrmPtmNext1.
			minusrmPtm2 := minusrmPtmNext2].
	^Array
		with: minDistSq sqrt
		with: indexI
		with: angleSwept
]

{ #category : #accessing }
MbDEndFrameqcs >> rpep [
	| rpmp aApm rpep |
	rpmp := markerFrame rpmp.
	aApm := markerFrame aApm.
	rpep := rpmp plusFullColumn: (aApm timesFullColumn: rmem).
	^rpep
]

{ #category : #accessing }
MbDEndFrameqcs >> s [
	^s
]

{ #category : #accessing }
MbDEndFrameqcs >> s: col [ 
	s := col
]

{ #category : #accessing }
MbDEndFrameqcs >> sAt1 [
	^s at: 1
]

{ #category : #accessing }
MbDEndFrameqcs >> sNumber: double [ 
	s at: 1 put: double
]

{ #category : #accessing }
MbDEndFrameqcs >> sSize [
	^sSize
]

{ #category : #accessing }
MbDEndFrameqcs >> sSize: aInteger [ 
	sSize := aInteger
]

{ #category : #accessing }
MbDEndFrameqcs >> sddot [
	^sddot
]

{ #category : #accessing }
MbDEndFrameqcs >> sddot: col [ 
	sddot := col
]

{ #category : #accessing }
MbDEndFrameqcs >> sdot [
	^sdot
]

{ #category : #accessing }
MbDEndFrameqcs >> sdot: col [ 
	sdot := col
]

{ #category : #accessing }
MbDEndFrameqcs >> setpqsumu: col [ 
	s equalFullColumn: col at: is
]

{ #category : #accessing }
MbDEndFrameqcs >> setpqsumuddot: col [ 
	sddot equalFullColumn: col at: is
]

{ #category : #accessing }
MbDEndFrameqcs >> setpqsumudot: col [ 
	sdot equalFullColumn: col at: is
]

{ #category : #accessing }
MbDEndFrameqcs >> setqsu: col [ 
	s equalFullColumn: col at: is
]

{ #category : #accessing }
MbDEndFrameqcs >> setqsuddotlam: col [ 
	sddot equalFullColumn: col at: is
]

{ #category : #accessing }
MbDEndFrameqcs >> setqsudot: col [ 
	sdot equalFullColumn: col at: is
]

{ #category : #accessing }
MbDEndFrameqcs >> setqsudotPlam: col [ 
	sdot equalFullColumn: col at: is
]

{ #category : #accessing }
MbDEndFrameqcs >> setqsudotPlamDeriv: col [ 
	"sddot is now sdotDeriv for collision."

	sddot equalFullColumn: col at: is
]

{ #category : #accessing }
MbDEndFrameqcs >> setqsudotlam: col [ 
	sdot equalFullColumn: col at: is
]

{ #category : #accessing }
MbDEndFrameqcs >> setqsulam: col [ 
	s equalFullColumn: col at: is
]

{ #category : #accessing }
MbDEndFrameqcs >> ss [
	^rmemBlk xs
]

{ #category : #accessing }
MbDEndFrameqcs >> vOeO [
	"Material point velocity"

	| partFrame |
	partFrame := self partFrame.
	^partFrame vOpO 
		plusFullColumn: (partFrame aAdotOp timesFullColumn: self rpep)
]
