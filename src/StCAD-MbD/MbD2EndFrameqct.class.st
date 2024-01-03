Class {
	#name : #MbD2EndFrameqct,
	#superclass : #MbDEndFrameqc,
	#instVars : [
		'time',
		'rmemBlks',
		'prmemptBlks',
		'pprmemptptBlks',
		'phiThePsiBlks',
		'pPhiThePsiptBlks',
		'ppPhiThePsiptptBlks',
		'rmem',
		'prmempt',
		'pprmemptpt',
		'aAme',
		'pAmept',
		'ppAmeptpt',
		'prOeOpt',
		'pprOeOpEpt',
		'pprOeOptpt',
		'pAOept',
		'ppAOepEpt',
		'ppAOeptpt'
	],
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #accessing }
MbD2EndFrameqct >> aAme [
	^aAme
]

{ #category : #calc }
MbD2EndFrameqct >> calcPostDynCorrectorIteration [
	| rOmO aAOm prOmOpE pAOmpE prOmOpEi prOeOpEi prOeOpEij rpep aApe |
	rOmO := markerFrame rOmO.
	aAOm := markerFrame aAOm.
	rOeO := rOmO plusFullColumn: (aAOm timesFullColumn: rmem).
	prOmOpE := markerFrame prOmOpE.
	pAOmpE := markerFrame pAOmpE.
	1 to: 3 do: [:i | 
			prOmOpEi := prOmOpE at: i.
			prOeOpEi := prOeOpE at: i.
			1 to: 4 do: [:j | 
					prOeOpEij := (prOmOpEi at: j) + (((pAOmpE at: j) at: i) timesFullColumn: rmem).
					prOeOpEi at: j put: prOeOpEij]].
	rpep := markerFrame rpmp plusFullColumn: (markerFrame aApm timesFullColumn: rmem).
	pprOeOpEpE := MbDEulerParameters ppApEpEtimesColumn: rpep.
	aAOe := aAOm timesFullMatrix: aAme.
	1 to: 4 do: [:i | pAOepE at: i put: ((pAOmpE at: i) timesFullMatrix: aAme)].
	aApe := markerFrame aApm timesFullMatrix: aAme.
	ppAOepEpE := MbDEulerParameters ppApEpEtimesMatrix: aApe.
]

{ #category : #accessing }
MbD2EndFrameqct >> dAmedt [
	^pAmept
]

{ #category : #calc }
MbD2EndFrameqct >> evalAme [
	aAme := phiThePsiBlks
				calc;
				aA
]

{ #category : #calc }
MbD2EndFrameqct >> evalpAmept [
	pAmept := pPhiThePsiptBlks
				calc;
				aAdot
]

{ #category : #calc }
MbD2EndFrameqct >> evalppAmeptpt [
	ppAmeptpt := ppPhiThePsiptptBlks
				calc;
				aAddot
]

{ #category : #calc }
MbD2EndFrameqct >> evalpprmemptpt [
	| secondDerivative value |
	rmemBlks == nil ifFalse: [1 to: 3
			do: 
				[:i | 
				secondDerivative := pprmemptptBlks at: i.
				value := secondDerivative value.
				pprmemptpt at: i put: value]]
]

{ #category : #calc }
MbD2EndFrameqct >> evalprmempt [
	| derivative value |
	rmemBlks == nil ifFalse: [1 to: 3
			do: 
				[:i | 
				derivative := prmemptBlks at: i.
				value := derivative value.
				prmempt at: i put: value]]
]

{ #category : #calc }
MbD2EndFrameqct >> evalrmem [
	| expression value |
	rmemBlks == nil ifFalse: [1 to: 3
			do: 
				[:i | 
				expression := rmemBlks at: i.
				value := expression value.
				rmem at: i put: value]]
]

{ #category : #'initialize-release' }
MbD2EndFrameqct >> initialize [
	super initialize.
	rmem := FullColumn new: 3.
	prmempt := FullColumn new: 3.
	pprmemptpt := FullColumn new: 3.
	aAme := FullMatrix new: 3 by: 3.
	pAmept := FullMatrix new: 3 by: 3.
	ppAmeptpt := FullMatrix new: 3 by: 3.
	pprOeOpEpt := FullMatrix new: 3 by: 4.
	pprOeOptpt := FullColumn new: 3.
	ppAOepEpt := FullColumn new: 4.
	ppAOeptpt := FullMatrix new: 3 by: 3
]

{ #category : #'initialize-release' }
MbD2EndFrameqct >> initializeGlobally [
	rmemBlks == nil
		ifFalse: 
			[self initprmemptBlks.
			self initpprmemptptBlks].
	phiThePsiBlks == nil
		ifFalse: 
			[self initpPhiThePsiptBlks.
			self initppPhiThePsiptptBlks]
]

{ #category : #'initialize-release' }
MbD2EndFrameqct >> initializeLocally [
	rmemBlks == nil
		ifTrue: 
			[rmem zeroSelf.
			prmempt zeroSelf.
			pprmemptpt zeroSelf].
	phiThePsiBlks == nil
		ifTrue: 
			[aAme identity.
			pAmept zeroSelf.
			ppAmeptpt zeroSelf]
]

{ #category : #'initialize-release' }
MbD2EndFrameqct >> initpPhiThePsiptBlks [
	| mbdTime |
	mbdTime := TheMbDSystem mbdTime.
	pPhiThePsiptBlks := phiThePsiBlks differentiateWRT: mbdTime
]

{ #category : #'initialize-release' }
MbD2EndFrameqct >> initppPhiThePsiptptBlks [
	| mbdTime |
	mbdTime := TheMbDSystem mbdTime.
	ppPhiThePsiptptBlks := pPhiThePsiptBlks differentiateWRT: mbdTime
]

{ #category : #'initialize-release' }
MbD2EndFrameqct >> initpprmemptptBlks [
	| mbdTime vel acc |
	mbdTime := TheMbDSystem mbdTime.
	pprmemptptBlks := FullColumn new: 3.
	1 to: 3
		do: 
			[:i | 
			vel := prmemptBlks at: i.
			acc := (vel differentiateWRT: mbdTime) simplified.
			pprmemptptBlks at: i put: acc]
]

{ #category : #'initialize-release' }
MbD2EndFrameqct >> initprmemptBlks [
	| mbdTime disp vel |
	mbdTime := TheMbDSystem mbdTime.
	prmemptBlks := FullColumn new: 3.
	1 to: 3
		do: 
			[:i | 
			disp := rmemBlks at: i.
			vel := (disp differentiateWRT: mbdTime) simplified.
			prmemptBlks at: i put: vel]
]

{ #category : #accessing }
MbD2EndFrameqct >> pAOept [
	^pAOept
]

{ #category : #accessing }
MbD2EndFrameqct >> pAjOept: j [ 
	^pAOept column: j
]

{ #category : #accessing }
MbD2EndFrameqct >> pAmept [
	^pAmept
]

{ #category : #accessing }
MbD2EndFrameqct >> phiThePsiBlks: block [ 
	phiThePsiBlks := block
]

{ #category : #dynamic }
MbD2EndFrameqct >> postDynOutput [
	time := TheMbDSystem mbdTimeValue.
	self evalrmem.
	self evalAme.
	super postDynOutput
]

{ #category : #dynamic }
MbD2EndFrameqct >> postDynPredictor [
	time := TheMbDSystem mbdTimeValue.
	self evalrmem.
	self evalAme.
	super postDynPredictor
]

{ #category : #'input-output' }
MbD2EndFrameqct >> postInput [
	self evalrmem.
	self evalAme.
	super postInput
]

{ #category : #velIC }
MbD2EndFrameqct >> postVelIC [
	| pAOmpE pprOeOpEpti pprOeOpEptij |
	pAOmpE := markerFrame pAOmpE.
	1 to: 3 do: [:i | 
			pprOeOpEpti := pprOeOpEpt at: i.
			1 to: 4 do: [:j | 
					pprOeOpEptij := ((pAOmpE at: j) at: i) dot: prmempt.
					pprOeOpEpti at: j put: pprOeOpEptij]].
	1 to: 4 do: [:i | ppAOepEpt at: i put: ((pAOmpE at: i) timesFullMatrix: pAmept)]
]

{ #category : #accessing }
MbD2EndFrameqct >> ppAOepEpt [
	^ppAOepEpt
]

{ #category : #accessing }
MbD2EndFrameqct >> ppAOeptpt [
	^ppAOeptpt
]

{ #category : #accessing }
MbD2EndFrameqct >> ppAjOepETpt: jj [ 
	| answer answeri ppAOepEipt answerij |
	answer := FullMatrix new: 4 by: 3.
	1 to: 4 do: [:i | 
			answeri := answer at: i.
			ppAOepEipt := ppAOepEpt at: i.
			1 to: 3 do: [:j | 
					answerij := ppAOepEipt at: j and: jj.
					answeri at: j put: answerij]].
	^answer
]

{ #category : #accessing }
MbD2EndFrameqct >> ppAjOeptpt: j [ 
	^ppAOeptpt column: j
]

{ #category : #accessing }
MbD2EndFrameqct >> ppAmeptpt [
	^ppAmeptpt
]

{ #category : #accessing }
MbD2EndFrameqct >> pprOeOpEpt [
	^pprOeOpEpt
]

{ #category : #accessing }
MbD2EndFrameqct >> pprOeOptpt [
	^pprOeOptpt
]

{ #category : #accessing }
MbD2EndFrameqct >> ppriOeOpEpt: i [ 
	^pprOeOpEpt at: i
]

{ #category : #accessing }
MbD2EndFrameqct >> ppriOeOptpt: i [ 
	^pprOeOptpt at: i
]

{ #category : #accessing }
MbD2EndFrameqct >> pprmemptpt [
	^pprmemptpt
]

{ #category : #accessing }
MbD2EndFrameqct >> prOeOpt [
	^prOeOpt
]

{ #category : #accIC }
MbD2EndFrameqct >> preAccIC [
	| aAOm |
	time := TheMbDSystem mbdTimeValue.
	self evalrmem.
	self evalAme.
	super preVelIC.
	self evalprmempt.
	self evalpAmept.
	aAOm := markerFrame aAOm.
	prOeOpt := aAOm timesFullColumn: prmempt.
	pAOept := aAOm timesFullMatrix: pAmept.
	super preAccIC.
	self evalpprmemptpt.
	self evalppAmeptpt.
	aAOm := markerFrame aAOm.
	pprOeOptpt := aAOm timesFullColumn: pprmemptpt.
	ppAOeptpt := aAOm timesFullMatrix: ppAmeptpt
]

{ #category : #dynamic }
MbD2EndFrameqct >> preDynOutput [
	time := TheMbDSystem mbdTimeValue.
	self evalrmem.
	self evalAme.
	super preDynOutput
]

{ #category : #posIC }
MbD2EndFrameqct >> prePosIC [
	time := TheMbDSystem mbdTimeValue.
	self evalrmem.
	self evalAme.
	super prePosIC
]

{ #category : #static }
MbD2EndFrameqct >> preStatic [
	time := TheMbDSystem mbdTimeValue.
	self evalrmem.
	self evalAme.
	super preStatic
]

{ #category : #velIC }
MbD2EndFrameqct >> preVelIC [
	| aAOm |
	time := TheMbDSystem mbdTimeValue.
	self evalrmem.
	self evalAme.
	super preVelIC.
	self evalprmempt.
	self evalpAmept.
	aAOm := markerFrame aAOm.
	prOeOpt := aAOm timesFullColumn: prmempt.
	pAOept := aAOm timesFullMatrix: pAmept
]

{ #category : #accessing }
MbD2EndFrameqct >> priOeOpt: i [ 
	^prOeOpt at: i
]

{ #category : #accessing }
MbD2EndFrameqct >> prmempt [
	^prmempt
]

{ #category : #accessing }
MbD2EndFrameqct >> rmeO [
	^markerFrame aAOm timesFullColumn: rmem
]

{ #category : #accessing }
MbD2EndFrameqct >> rmem [
	^rmem
]

{ #category : #accessing }
MbD2EndFrameqct >> rmemBlks: block [ 
	rmemBlks := block
]

{ #category : #accessing }
MbD2EndFrameqct >> rpep [
	| rpmp aApm rpep |
	rpmp := markerFrame rpmp.
	aApm := markerFrame aApm.
	rpep := rpmp plusFullColumn: (aApm timesFullColumn: rmem).
	^rpep
]

{ #category : #dynamic }
MbD2EndFrameqct >> simUpdateAll [
	time := TheMbDSystem mbdTimeValue.
	self evalrmem.
	self evalAme.
	super simUpdateAll
]

{ #category : #accessing }
MbD2EndFrameqct >> time: double [ 
	self halt: 'check this.'.
	time := double
]
