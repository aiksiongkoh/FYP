Class {
	#name : #MbDEndFrameqct,
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
MbDEndFrameqct >> aA [
	"Dummy method template.  This was installed by the debugger
	define method command."

	^self halt
]

{ #category : #accessing }
MbDEndFrameqct >> aAme [
	^aAme
]

{ #category : #calc }
MbDEndFrameqct >> calcPostDynCorrectorIteration [
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
MbDEndFrameqct >> dAmedt [
	^pAmept
]

{ #category : #calc }
MbDEndFrameqct >> evalAme [
	| phiThePsi expression value |
	phiThePsiBlks == nil
		ifFalse: 
			[phiThePsi := MbDEulerAngleszxz new.
			1 to: 3
				do: 
					[:i | 
					expression := phiThePsiBlks at: i.
					value := expression value.
					phiThePsi at: i put: value].
			phiThePsi calc.
			aAme := phiThePsi aA]
]

{ #category : #calc }
MbDEndFrameqct >> evalpAmept [
	| phiThePsi phiThePsiDot |
	phiThePsiBlks == nil
		ifFalse: 
			[phiThePsi := MbDEulerAngleszxz new.
			phiThePsiDot := MbDEulerAngleszxzDot new.
			phiThePsiDot phiThePsi: phiThePsi.
			1 to: phiThePsi size
				do: 
					[:i | 
					| expression derivative value valueDot |
					expression := phiThePsiBlks at: i.
					derivative := pPhiThePsiptBlks at: i.
					value := expression value.
					valueDot := derivative value.
					phiThePsi at: i put: value.
					phiThePsiDot at: i put: valueDot].
			phiThePsi calc.
			phiThePsiDot calc.
			pAmept := phiThePsiDot aAdot]
]

{ #category : #calc }
MbDEndFrameqct >> evalppAmeptpt [
	| phiThePsi phiThePsiDot phiThePsiDdot |
	phiThePsiBlks == nil
		ifFalse: 
			[phiThePsi := MbDEulerAngleszxz new.
			phiThePsiDot := MbDEulerAngleszxzDot new.
			phiThePsiDot phiThePsi: phiThePsi.
			phiThePsiDdot := MbDEulerAngleszxzDdot new.
			phiThePsiDdot phiThePsiDot: phiThePsiDot.
			1 to: phiThePsi size
				do: 
					[:i | 
					| expression derivative secondDerivative value valueDot valueDdot |
					expression := phiThePsiBlks at: i.
					derivative := pPhiThePsiptBlks at: i.
					secondDerivative := ppPhiThePsiptptBlks at: i.
					value := expression value.
					valueDot := derivative value.
					valueDdot := secondDerivative value.
					phiThePsi at: i put: value.
					phiThePsiDot at: i put: valueDot.
					phiThePsiDdot at: i put: valueDdot].
			phiThePsi calc.
			phiThePsiDot calc.
			phiThePsiDdot calc.
			ppAmeptpt := phiThePsiDdot aAddot]
]

{ #category : #calc }
MbDEndFrameqct >> evalpprmemptpt [
	| secondDerivative value |
	rmemBlks == nil ifFalse: [1 to: 3
			do: 
				[:i | 
				secondDerivative := pprmemptptBlks at: i.
				value := secondDerivative value.
				pprmemptpt at: i put: value]]
]

{ #category : #calc }
MbDEndFrameqct >> evalprmempt [
	| derivative value |
	rmemBlks == nil ifFalse: [1 to: 3
			do: 
				[:i | 
				derivative := prmemptBlks at: i.
				value := derivative value.
				prmempt at: i put: value]]
]

{ #category : #calc }
MbDEndFrameqct >> evalrmem [
	| expression value |
	rmemBlks == nil ifFalse: [1 to: 3
			do: 
				[:i | 
				expression := rmemBlks at: i.
				value := expression value.
				rmem at: i put: value]]
]

{ #category : #'initialize-release' }
MbDEndFrameqct >> initialize [
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
MbDEndFrameqct >> initializeGlobally [
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
MbDEndFrameqct >> initializeLocally [
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
MbDEndFrameqct >> initpPhiThePsiptBlks [
	| mbdTime angle angleVel |
	mbdTime := TheMbDSystem mbdTime.
	pPhiThePsiptBlks := FullColumn new: 3.
	1 to: 3
		do: 
			[:i | 
			angle := phiThePsiBlks at: i.
			angleVel := (angle differentiateWRT: mbdTime) simplified.
			pPhiThePsiptBlks at: i put: angleVel]
]

{ #category : #'initialize-release' }
MbDEndFrameqct >> initppPhiThePsiptptBlks [
	| mbdTime angleVel angleAcc |
	mbdTime := TheMbDSystem mbdTime.
	ppPhiThePsiptptBlks := FullColumn new: 3.
	1 to: 3
		do: 
			[:i | 
			angleVel := pPhiThePsiptBlks at: i.
			angleAcc := (angleVel differentiateWRT: mbdTime) simplified.
			ppPhiThePsiptptBlks at: i put: angleAcc]
]

{ #category : #'initialize-release' }
MbDEndFrameqct >> initpprmemptptBlks [
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
MbDEndFrameqct >> initprmemptBlks [
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
MbDEndFrameqct >> pAOept [
	^pAOept
]

{ #category : #accessing }
MbDEndFrameqct >> pAjOept: j [ 
	^pAOept column: j
]

{ #category : #accessing }
MbDEndFrameqct >> pAmept [
	^pAmept
]

{ #category : #accessing }
MbDEndFrameqct >> phiThePsiBlks [
	^phiThePsiBlks
]

{ #category : #accessing }
MbDEndFrameqct >> phiThePsiBlks: cFormula [ 
	phiThePsiBlks := phiThePsiBlks ifNil: [cFormula]
				ifNotNil: 
					[1 to: 3
						do: 
							[:i | 
							(cFormula at: i) isZero 
								ifFalse: [phiThePsiBlks at: i put: (cFormula at: i)]].
					phiThePsiBlks]
]

{ #category : #dynamic }
MbDEndFrameqct >> postDynOutput [
	time := TheMbDSystem mbdTimeValue.
	self evalrmem.
	self evalAme.
	super postDynOutput
]

{ #category : #dynamic }
MbDEndFrameqct >> postDynPredictor [
	time := TheMbDSystem mbdTimeValue.
	self evalrmem.
	self evalAme.
	super postDynPredictor
]

{ #category : #'input-output' }
MbDEndFrameqct >> postInput [
	self evalrmem.
	self evalAme.
	super postInput
]

{ #category : #velIC }
MbDEndFrameqct >> postVelIC [
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
MbDEndFrameqct >> ppAOepEpt [
	^ppAOepEpt
]

{ #category : #accessing }
MbDEndFrameqct >> ppAOeptpt [
	^ppAOeptpt
]

{ #category : #accessing }
MbDEndFrameqct >> ppAjOepETpt: jj [ 
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
MbDEndFrameqct >> ppAjOeptpt: j [ 
	^ppAOeptpt column: j
]

{ #category : #accessing }
MbDEndFrameqct >> ppAmeptpt [
	^ppAmeptpt
]

{ #category : #accessing }
MbDEndFrameqct >> pprOeOpEpt [
	^pprOeOpEpt
]

{ #category : #accessing }
MbDEndFrameqct >> pprOeOptpt [
	^pprOeOptpt
]

{ #category : #accessing }
MbDEndFrameqct >> ppriOeOpEpt: i [ 
	^pprOeOpEpt at: i
]

{ #category : #accessing }
MbDEndFrameqct >> ppriOeOptpt: i [ 
	^pprOeOptpt at: i
]

{ #category : #accessing }
MbDEndFrameqct >> pprmemptpt [
	^pprmemptpt
]

{ #category : #accessing }
MbDEndFrameqct >> prOeOpt [
	^prOeOpt
]

{ #category : #accIC }
MbDEndFrameqct >> preAccIC [
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
MbDEndFrameqct >> preDynOutput [
	time := TheMbDSystem mbdTimeValue.
	self evalrmem.
	self evalAme.
	super preDynOutput
]

{ #category : #posIC }
MbDEndFrameqct >> prePosIC [
	time := TheMbDSystem mbdTimeValue.
	self evalrmem.
	self evalAme.
	super prePosIC
]

{ #category : #static }
MbDEndFrameqct >> preStatic [
	time := TheMbDSystem mbdTimeValue.
	self evalrmem.
	self evalAme.
	super preStatic
]

{ #category : #velIC }
MbDEndFrameqct >> preVelIC [
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
MbDEndFrameqct >> priOeOpt: i [ 
	^prOeOpt at: i
]

{ #category : #accessing }
MbDEndFrameqct >> prmempt [
	^prmempt
]

{ #category : #accessing }
MbDEndFrameqct >> rmeO [
	^markerFrame aAOm timesFullColumn: rmem
]

{ #category : #accessing }
MbDEndFrameqct >> rmem [
	^rmem
]

{ #category : #accessing }
MbDEndFrameqct >> rmemBlks: cFormula [ 
	rmemBlks := rmemBlks ifNil: [cFormula]
				ifNotNil: 
					[1 to: 3
						do: [:i | (cFormula at: i) isZero ifFalse: [rmemBlks at: i put: (cFormula at: i)]].
					rmemBlks]
]

{ #category : #accessing }
MbDEndFrameqct >> rpep [
	| rpmp aApm rpep |
	rpmp := markerFrame rpmp.
	aApm := markerFrame aApm.
	rpep := rpmp plusFullColumn: (aApm timesFullColumn: rmem).
	^rpep
]

{ #category : #dynamic }
MbDEndFrameqct >> simUpdateAll [
	time := TheMbDSystem mbdTimeValue.
	self evalrmem.
	self evalAme.
	super simUpdateAll
]

{ #category : #accessing }
MbDEndFrameqct >> time: double [ 
	self halt: 'check this.'.
	time := double
]
