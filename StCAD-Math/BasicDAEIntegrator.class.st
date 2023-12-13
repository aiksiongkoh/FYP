"
Numerical Solutions of Initial Value Problems in Differential Algebraic Equations by K.E. Brenan et el.

Solves the DAE
	F(t,y,ydot) = 0
	y(t0) = y0
	ydot(t0) = ydot0

BDF formula
	ydot(t) = alp*y(t) + alp1*y(t - h) + ... = alp*y(t) + bet.

Substitute in DAE
	F(t,y,alp*y + bet) = 0

Use Newton-Raphson
	[pFpy + alp*pFpydot]dy = -F
	[G]dy = -F
	ynew = y + dy

Possible use:
aMbDSystem <> aStMDAEIntegrator <> aStMBasicDAEIntegrator
system := aStMDAEIntegrator.
aStMBasicDAEIntegrator assumes smooth DAE. Does pure integration of DAE.
aStMDAEIntegrator handles output, step size restrictions, discontinuity checking, restarting of aStMBasicDAEIntegrator.
aMbDSystem just provides the states and derived states upon request by aStMDAEIntegrator and aStMBasicDAEIntegrator.
'system' provides F, pFpy, pFpydot, y0, ydot0 upon request.
'system' updates with y and ydot when told to do so.
aStMBasicDAEIntegrator stores past y's. 'system' does not need to store past values.
aStMBasicDAEIntegrator will do predictor step. 'system' does not need to do that.
Make aStMBasicDAEIntegrator very general.


"
Class {
	#name : #BasicDAEIntegrator,
	#superclass : #BasicIntegrator,
	#instVars : [
		'y',
		'ydot',
		'dy',
		'ypast',
		'ydotpast',
		'aF',
		'pFpy',
		'pFpydot',
		'alp',
		'aG',
		'extrapolator',
		'newtonRaphson',
		'corAbsTol',
		'corRelTol',
		'corOK',
		'integAbsTol',
		'integRelTol',
		'truncError'
	],
	#category : #'StCAD-Math-StMathIntegrator'
}

{ #category : #'VisualWorks metadata' }
BasicDAEIntegrator class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #run }
BasicDAEIntegrator >> calcG [
	"It is ok to modify pFpydot since its values are not reused."

	system fillpFpy: pFpy zeroSelf.
	system fillpFpydot: pFpydot zeroSelf.
	alp := self correctorBDF pvdotpv.
	aG := pFpy plusSparseMatrix: (pFpydot magnifySelf: alp).
	^aG
]

{ #category : #run }
BasicDAEIntegrator >> calcOperatorMatrix [
	super calcOperatorMatrix.
	extrapolator calcOperatorMatrix
]

{ #category : #run }
BasicDAEIntegrator >> calcTruncError [
	"Calculate the leading term of truncation error in Taylor series."

	| const yndot yndotNorm hpower |
	const := 1.0d / (order + 1) factorial.
	yndot := self dyOrderPlusOnedt.
	yndotNorm := self integErrorNormFrom: yndot wrt: y.
	hpower := h raisedTo: order + 1.
	truncError := const * yndotNorm * hpower
]

{ #category : #run }
BasicDAEIntegrator >> changeTime [
	self order: orderNew.
	h := hnew.
	self tnew: (tpast at: 1)
			+ (direction * h).
	system changeTime: tnew.
	self calcOperatorMatrix
]

{ #category : #run }
BasicDAEIntegrator >> corErrorNormFrom: error wrt: ref [ 
	^self
		rms: error
		wrt: ref
		relativeTol: corRelTol
		absoluteTol: corAbsTol
]

{ #category : #run }
BasicDAEIntegrator >> correct [
	[
	[system preDAECorrector.
	self correctValuesAtNextStep.
	system postDAECorrector]
		on: SingularMatrixError do: [:ex | ex pass]]
		on: MaximumIterationError
		do: 
			[:ex | 
			corOK := false.
			truncError := 888888.0d.
			ex return]
]

{ #category : #run }
BasicDAEIntegrator >> correctFirstStep [
	| hout1000 ydotNorm hydot |
	[
	[system preDAECorrector.
	self correctValuesAtFirstStep.
	system postDAECorrector]
		on: SingularMatrixError
		do: 
			[:ex | 
			"Step size is probably too small, causing an ill 
			conditioned matrix."
			"Increase step size. Multiply by 4.0d to offset reduction in 
			selectFirstStepSize."
			corOK := false.
			truncError := 999999.0d.
			hout1000 := system hout / 1000.0d.
			ydotNorm := (self integErrorNormFrom: ydot wrt: y)
						max: 1.0d-15.
			hydot := 0.5d / ydotNorm.
			h := 4.0d * (hout1000 max: hydot).
			ex return]]
		on: MaximumIterationError
		do: 
			[:ex | 
			corOK := false.
			truncError := 888888.0d.
			ex return]
]

{ #category : #run }
BasicDAEIntegrator >> correctValuesAtFirstStep [
	newtonRaphson run
]

{ #category : #run }
BasicDAEIntegrator >> correctValuesAtNextStep [
	newtonRaphson run
]

{ #category : #run }
BasicDAEIntegrator >> fillF [
	system fillF: aF zeroSelf.
	^aF
]

{ #category : #run }
BasicDAEIntegrator >> firstStep [
	istep := 0.
	self preFirstStep.
	iTry := 1.
	orderNew := 1.
	self selectFirstStepSize.
	self incrementTime.
	self predictFirstStep.
	self correctFirstStep.
	self reportTrialStepStats.
	[self isRedoingFirstStep]
		whileTrue: 
			[self incrementTry.
			orderNew := 1.
			self selectFirstStepSize.
			self changeTime.
			self predictFirstStep.
			self correctFirstStep.
			self reportTrialStepStats].
	self postFirstStep.
	self reportStepStats
]

{ #category : #accessing }
BasicDAEIntegrator >> iStep: integer [ 
	super iStep: integer.
	extrapolator iStep: integer
]

{ #category : #run }
BasicDAEIntegrator >> incrementTime [
	super incrementTime.
	ypast addFirst: y.
	ydotpast addFirst: ydot.
	ypast size > (orderMax + 1)
		ifTrue: 
			[ypast removeLast.
			ydotpast removeLast]
]

{ #category : #'initialize-release' }
BasicDAEIntegrator >> initialize [
	super initialize.
	extrapolator := Extrapolator new.
	extrapolator timeNodes: tpast.
	newtonRaphson := DAECorrector new.
	newtonRaphson system: self.
	ypast := OrderedCollection new.
	ydotpast := OrderedCollection new
]

{ #category : #'initialize-release' }
BasicDAEIntegrator >> initializeGlobally [
	"Get info from system and prepare for start of simulation."
	"Integrator asks system for info. Not system setting integrator."

	| size |
	super initializeGlobally.
	integRelTol := system integrationRelativeTolerance.
	integAbsTol := system integrationAbsoluteTolerance.
	corRelTol := system correctorRelativeTolerance.
	corAbsTol := system correctorAbsoluteTolerance.
	size := system neqn.
	y := FullColumn new: size.
	system fillY: y.
	ydot := FullColumn new: size.
	system fillYdot: ydot.
	aF := FullColumn new: size.
	pFpy := SparseMatrix new: size by: size.
	pFpydot := SparseMatrix new: size by: size
]

{ #category : #run }
BasicDAEIntegrator >> integErrorNormFrom: error wrt: ref [ 
	^self
		rms: error
		wrt: ref
		relativeTol: integRelTol
		absoluteTol: integAbsTol
]

{ #category : #run }
BasicDAEIntegrator >> isConvergedFor: iterNo and1: dyNorms [ 
	| dyNormIterNo rho smallEnoughTol smallEnough |
	dyNormIterNo := dyNorms at: iterNo.
	smallEnoughTol := MachineAccuracy OfDoubleTimesFour / (corAbsTol at: 1).
	smallEnough := dyNormIterNo < smallEnoughTol.
	^iterNo = 1
		ifTrue: [smallEnough]
		ifFalse: 
			[rho := dyNormIterNo / (dyNorms at: iterNo - 1).
			smallEnough or: [rho < 1.0d and: [rho * dyNormIterNo / (1.0d - rho) < 0.33d]]]
]

{ #category : #run }
BasicDAEIntegrator >> isConvergedFor: iterNo and: dyNorms [ 
	| dyNormIterNo rho smallEnoughTol smallEnough |
	dyNormIterNo := dyNorms at: iterNo.
	smallEnoughTol := MachineAccuracy OfDoubleTimesFour / (corAbsTol at: 1).
	smallEnough := dyNormIterNo < smallEnoughTol.
	^iterNo = 1
		ifTrue: [smallEnough]
		ifFalse: 
			[rho := dyNormIterNo / (dyNorms at: iterNo - 1).
			smallEnough or: [rho < 1.0d and: [rho * dyNormIterNo / (1.0d - rho) < 0.33d]]]
]

{ #category : #run }
BasicDAEIntegrator >> isRedoingFirstStep [
	iTry > 100 ifTrue: [TooManyTriesError raiseSignal].
	^(corOK not or: [truncError > 1.0d])
		or: 
			["Look at the next step size."
			"Aim for first step size and second step size to be similar 
			in size."
			"Huge disparity causes poor accuracy for subsequent 
			steps."
			hnew := self selectBasicStepSize.
			hnew := system suggestSmallerOrAcceptFirstStepSize: hnew.
			hnew > (4.0d * h) and: [hnew < system hmax]]
]

{ #category : #run }
BasicDAEIntegrator >> isRedoingStep [
	iTry > 100 ifTrue: [TooManyTriesError raiseSignal].
	^corOK not or: [truncError > 1.0d]
]

{ #category : #accessing }
BasicDAEIntegrator >> iterMax [
	^system iterMax
]

{ #category : #run }
BasicDAEIntegrator >> nextStep [
	self preStep.
	iTry := 1.
	self selectOrder.
	self selectStepSize.
	self incrementTime.
	self predict.
	self correct.
	self reportTrialStepStats.
	[self isRedoingStep]
		whileTrue: 
			[self incrementTry.
			self selectOrder.
			self selectStepSize.
			self changeTime.
			self predict.
			self correct.
			self reportTrialStepStats].
	self postStep.
	self reportStepStats
]

{ #category : #accessing }
BasicDAEIntegrator >> order: integer [ 
	super order: integer.
	extrapolator order: integer - 1
]

{ #category : #run }
BasicDAEIntegrator >> postDAECorrector [
	corOK := true.
	self calcTruncError
]

{ #category : #run }
BasicDAEIntegrator >> postDAECorrectorIteration [
	ydot := self yDeriv: 1.
	system y: y.
	system ydot: ydot.
	system postDAECorrectorIteration
]

{ #category : #run }
BasicDAEIntegrator >> postFirstStep [
	t := tnew.
	system postDAEFirstStep
]

{ #category : #run }
BasicDAEIntegrator >> postStep [
	t := tnew.
	system postDAEStep
]

{ #category : #run }
BasicDAEIntegrator >> preDAECorrector [
	corOK := nil.
	truncError := nil
]

{ #category : #run }
BasicDAEIntegrator >> preDAECorrectorIteration [
	"It is ok to modify pFpydot since its values are not reused."

	system preDAECorrectorIteration.
	system fillF: aF zeroSelf.
	system fillpFpy: pFpy zeroSelf.
	system fillpFpydot: pFpydot zeroSelf.
	alp := self correctorBDF pvdotpv.
	aG := pFpy plusSparseMatrix: (pFpydot magnifySelf: alp)
]

{ #category : #run }
BasicDAEIntegrator >> preFirstStep [
	system preDAEFirstStep
]

{ #category : #run }
BasicDAEIntegrator >> preStep [
	system preDAEStep
]

{ #category : #run }
BasicDAEIntegrator >> predict [
	system preDAEPredictor.
	self predictValuesAtNextStep.
	system y: y.
	system ydot: ydot.
	system postDAEPredictor
]

{ #category : #run }
BasicDAEIntegrator >> predictFirstStep [
	system preDAEPredictor.
	self predictValuesAtFirstStep.
	system y: y.
	system ydot: ydot.
	system postDAEPredictor
]

{ #category : #run }
BasicDAEIntegrator >> predictValuesAtFirstStep [
	y := (ypast at: 1)
				plusFullColumn: (ydotpast at: 1)
				times: direction * h.
	ydot := (ydotpast at: 1) copy
]

{ #category : #run }
BasicDAEIntegrator >> predictValuesAtNextStep [
	"ydot := extrapolator valueWith: ydotpast."
	"Poor prediction. Extra iteration of the corrector is needed."

	y := extrapolator valueWith: ypast.
	ydot := self yDeriv: 1
]

{ #category : #run }
BasicDAEIntegrator >> reportStepStats [
	system useDAEStepStats: statistics
]

{ #category : #run }
BasicDAEIntegrator >> reportTrialStepStats [
	statistics at: #istep put: istep.
	statistics at: #t put: t.
	statistics at: #h put: direction * h.
	statistics at: #order put: order.
	statistics at: #truncError put: truncError.
	system useTrialStepStats: statistics
]

{ #category : #run }
BasicDAEIntegrator >> rms: vector wrt: baseVector relativeTol: relativeTol absoluteTol: absoluteTol [ 
	"Answer a weighted rms norm."
	"Elements with relativeTol == nil are not included in norm."
	"For m significant digits set relToli := 1.0d-m."
	"Set absToli to value where vectori abs is insignificant."

	| n count sumOfSquares relToli weighti vectori vectoriOverWeighti |
	n := baseVector size.
	count := 0.
	sumOfSquares := 0.0d.
	1 to: n
		do: 
			[:i | 
			relToli := relativeTol at: i.
			relToli == nil
				ifFalse: 
					[count := count + 1.
					weighti := relToli * (baseVector at: i) abs + (absoluteTol at: i).
					vectori := vector at: i.
					vectoriOverWeighti := vectori / weighti.
					sumOfSquares := sumOfSquares + (vectoriOverWeighti * vectoriOverWeighti)]].
	^(sumOfSquares / count asDouble) sqrt
]

{ #category : #run }
BasicDAEIntegrator >> selectBasicStepSize [
	"Shampine's book pp 337-8."
	"Brenan's book pp 128."
	"Using first term of Taylor series remainder."

	| conservativeFactor const yndot yndotNorm dum hdum |
	conservativeFactor := 0.5d.
	orderNew < order
		ifTrue: 
			[const := 1.0d / order factorial.
			yndot := self yDeriv: order.
			yndotNorm := (self integErrorNormFrom: yndot wrt: y)
						max: 1.0d-15.
			dum := conservativeFactor / (const * yndotNorm).
			hdum := dum raisedTo: 1.0d / order]
		ifFalse: 
			[const := 1.0d / (order + 1) factorial.
			yndot := self dyOrderPlusOnedt.
			yndotNorm := (self integErrorNormFrom: yndot wrt: y)
						max: 1.0d-15.
			dum := conservativeFactor / (const * yndotNorm).
			hdum := dum raisedTo: 1.0d / (order + 1)].
	^hdum
]

{ #category : #run }
BasicDAEIntegrator >> selectFirstStepSize [
	| hout1000 ydotNorm hydot |
	iTry == 1
		ifTrue: 
			[hout1000 := system hout / 1000.0d.
			ydotNorm := (self integErrorNormFrom: ydot wrt: y)
						max: 1.0d-15.
			hydot := 0.5d / ydotNorm.
			hnew := hout1000 min: hydot.
			hnew := hnew max: 1.0d-6]
		ifFalse: [corOK
				ifTrue: [hnew := self selectBasicStepSize]
				ifFalse: [hnew := 0.25d * h]].
	hnew := system suggestSmallerOrAcceptFirstStepSize: hnew
]

{ #category : #run }
BasicDAEIntegrator >> selectOrderNormal [
	"Brenan's book pp. 126-7"
	"Check last nterm of Taylor series plus first term of remainder."

	| errorTrunc nterm istart yndot yndotNorm hpower |
	errorTrunc := OrderedCollection new.
	nterm := 3.
	order > nterm
		ifTrue: [istart := order - nterm + 1]
		ifFalse: [istart := 1].
	istart to: order
		do: 
			[:i | 
			yndot := self yDeriv: i.
			yndotNorm := self integErrorNormFrom: yndot wrt: y.
			hpower := h raisedTo: i.
			errorTrunc add: yndotNorm * hpower].
	yndot := self dyOrderPlusOnedt.
	yndotNorm := self integErrorNormFrom: yndot wrt: y.
	hpower := h raisedTo: order + 1.
	errorTrunc add: yndotNorm * hpower.
	orderNew := order.
	errorTrunc isIncreasing ifTrue: ["Transcript cr; show: errorTrunc printString."
		order > 1 ifTrue: [orderNew := order - 1]].
	(errorTrunc isDecreasingIfExceptionsAreLessThan: 0.01d)
		ifTrue: [order < orderMax ifTrue: [orderNew := order + 1]]
]

{ #category : #run }
BasicDAEIntegrator >> selectStepSize [
	corOK
		ifTrue: [self selectStepSizeNormal]
		ifFalse: [hnew := 0.25d * h].
	hnew := system suggestSmallerOrAcceptStepSize: hnew
]

{ #category : #run }
BasicDAEIntegrator >> selectStepSizeNormal [
	"Shampine's book pp 337-8."
	"Brenan's book pp 128."
	"Using first term of Taylor series remainder."

	| hdum twoH pt9H pt5H pt25H |
	hdum := self selectBasicStepSize.
	iTry == 1
		ifTrue: [hdum >= h
				ifTrue: 
					[twoH := 2.0d * h.
					hdum > twoH
						ifTrue: [hnew := twoH]
						ifFalse: [hnew := h]]
				ifFalse: 
					[pt9H := 0.9d * h.
					hdum > pt9H
						ifTrue: [hnew := pt9H]
						ifFalse: 
							[pt5H := 0.5d * h.
							hdum < pt5H
								ifTrue: [hnew := pt5H]
								ifFalse: [hnew := hdum]]]]
		ifFalse: [iTry == 2
				ifTrue: 
					[pt9H := 0.9d * h.
					hdum := 0.9d * hdum.
					hdum > pt9H
						ifTrue: [hnew := pt9H]
						ifFalse: 
							[pt25H := 0.25d * h.
							hdum < pt25H
								ifTrue: [hnew := pt25H]
								ifFalse: [hnew := hdum]]]
				ifFalse: [hnew := 0.25d * h]]
]

{ #category : #accessing }
BasicDAEIntegrator >> time: double [ 
	super time: double.
	extrapolator time: double
]

{ #category : #run }
BasicDAEIntegrator >> updateForDAECorrector [
	ydot := self yDeriv: 1.
	system y: y.
	system ydot: ydot.
	system updateForDAECorrector
]

{ #category : #run }
BasicDAEIntegrator >> useDAECorrectorStats: stats [ 
	statistics at: #corIterNo put: (stats at: #iterNo)
]

{ #category : #run }
BasicDAEIntegrator >> useNewtonRaphsonStats: stats [ 
	statistics at: #corIterNo put: (stats at: #iterNo)
]

{ #category : #accessing }
BasicDAEIntegrator >> y [
	^y
]

{ #category : #accessing }
BasicDAEIntegrator >> y: col [ 
	y := col
]

{ #category : #accessing }
BasicDAEIntegrator >> ydot [
	^ydot
]
