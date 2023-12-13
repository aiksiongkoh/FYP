Class {
	#name : #MbDPartFrame,
	#superclass : #MbDCartesianFrame,
	#instVars : [
		'part',
		'iqX',
		'iqE',
		'qX',
		'qE',
		'qXdot',
		'qEdot',
		'qXddot',
		'qEddot',
		'aGeu',
		'aGabs',
		'markerFrames'
	],
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #'VisualWorks metadata' }
MbDPartFrame class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDPartFrame >> aA [
	^qE aA
]

{ #category : #accessing }
MbDPartFrame >> aAOp [
	^qE aA
]

{ #category : #accessing }
MbDPartFrame >> aAddotOp [
	| aMbDEulerParametersDDot |
	aMbDEulerParametersDDot := MbDEulerParametersDDot fromqEdot: qEdot
				qEddot: qEddot.
	aMbDEulerParametersDDot calcAddotBddotCddot.
	^aMbDEulerParametersDDot aAddot
]

{ #category : #accessing }
MbDPartFrame >> aAdot [
	^qEdot aAdot
]

{ #category : #accessing }
MbDPartFrame >> aAdotOp [
	^qEdot aAdot
]

{ #category : #accessing }
MbDPartFrame >> aB [
	^qE aB
]

{ #category : #accessing }
MbDPartFrame >> aBOp [
	^qE aB
]

{ #category : #accessing }
MbDPartFrame >> aC [
	^qE aC
]

{ #category : #accessing }
MbDPartFrame >> aCdot [
	^qEdot aCdot
]

{ #category : #accessing }
MbDPartFrame >> aOpO [
	^qXddot
]

{ #category : #accessing }
MbDPartFrame >> alpOpO [
	| aB aBdot |
	aB := qE aB.
	aBdot := qEdot aBdot.
	^((aBdot timesFullColumn: qEdot)
		plusFullColumn: (aB timesFullColumn: qEddot))
		times: 2.0d
]

{ #category : #'initialize-release' }
MbDPartFrame >> asFixed [
	| con |
	1 to: 6 do: [:i | 
			con := (MbDAbsConstraint new) axis: i; owner: self.
			aGabs add: con]
]

{ #category : #posIC }
MbDPartFrame >> bePerturbed: delta fillqsulam: col [ 
	"Fill q, s and lam into col."

	| statei perturbedStatei |
	col at: iqX putFullColumn: qX.
	aGabs isEmpty ifFalse: [1 to: 3
			do: 
				[:i | 
				statei := qE at: i.
				perturbedStatei := statei >= 0
							ifTrue: [statei + delta]
							ifFalse: [statei - delta].
				qE at: i put: perturbedStatei]].
	qE conditionSelf.
	col at: iqE putFullColumn: qE.
	markerFrames do: [:mkr | mkr bePerturbed: delta fillqsulam: col].
	aGeu bePerturbed: delta fillqsulam: col.
	aGabs do: [:con | con bePerturbed: delta fillqsulam: col]
]

{ #category : #calc }
MbDPartFrame >> calcPostCollisionCorrectorIteration [
	qEdot calcAdotBdotCdot.
	qEdot calcpAdotpE
]

{ #category : #calc }
MbDPartFrame >> calcPostDynCorrectorIteration [
	qE calcABC.
	qE calcpApE.
	qEdot calcAdotBdotCdot.
	qEdot calcpAdotpE
]

{ #category : #calc }
MbDPartFrame >> calcPostPosICIteration [
	qE calcABC.
	qE calcpApE
]

{ #category : #accessing }
MbDPartFrame >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Part '
]

{ #category : #posIC }
MbDPartFrame >> constraintsReport [
	| dummy |
	dummy := aGabs select: [:con | con isRedundant].
	aGeu isRedundant ifTrue: [dummy add: aGeu].
	dummy size > 0
		ifTrue: 
			[self logString: #'MbD: \%1 %2  has the following constraint(s) removed: ' withArguments: (Array with: self classString with: part name).
			dummy do: [:con | con logString: #'MbD: \    %1' withArgument: con classString]]
]

{ #category : #accIC }
MbDPartFrame >> fillAccICIterError: col [ 
	markerFrames do: [:mkr | mkr fillAccICIterError: col].
	aGeu fillAccICIterError: col.
	aGabs do: [:con | con fillAccICIterError: col]
]

{ #category : #accIC }
MbDPartFrame >> fillAccICIterJacob: mat [ 
	markerFrames do: [:mkr | mkr fillAccICIterJacob: mat].
	aGeu fillAccICIterJacob: mat.
	aGabs do: [:con | con fillAccICIterJacob: mat]
]

{ #category : #collision }
MbDPartFrame >> fillCollisionError: col [ 
	markerFrames do: [:mkr | mkr fillCollisionError: col].
	aGeu fillCollisionError: col.
	aGabs do: [:con | con fillCollisionError: col]
]

{ #category : #collision }
MbDPartFrame >> fillCollisionpFpydot: mat [ 
	markerFrames do: [:mkr | mkr fillCollisionpFpydot: mat].
	aGeu fillCollisionpFpydot: mat.
	aGabs do: [:con | con fillCollisionpFpydot: mat]
]

{ #category : #accessing }
MbDPartFrame >> fillConstraints: collection [ 
	aGeu fillConstraints: collection.
	aGabs do: [:con | con fillConstraints: collection]
]

{ #category : #dynamic }
MbDPartFrame >> fillDynError: col [ 
	markerFrames do: [:mkr | mkr fillDynError: col].
	aGeu fillDynError: col.
	aGabs do: [:con | con fillDynError: col]
]

{ #category : #accessing }
MbDPartFrame >> fillEssenConstraints: collection [ 
	aGeu fillEssenConstraints: collection.
	aGabs do: [:con | con fillEssenConstraints: collection]
]

{ #category : #posIC }
MbDPartFrame >> fillPosICError: col [ 
	markerFrames do: [:mkr | mkr fillPosICError: col].
	aGeu fillPosICError: col.
	aGabs do: [:con | con fillPosICError: col]
]

{ #category : #posIC }
MbDPartFrame >> fillPosICJacob: mat [ 
	markerFrames do: [:mkr | mkr fillPosICJacob: mat].
	aGeu fillPosICJacob: mat.
	aGabs do: [:con | con fillPosICJacob: mat]
]

{ #category : #posIC }
MbDPartFrame >> fillPosKineError: col [ 
	markerFrames do: [:mkr | mkr fillPosKineError: col].
	aGeu fillPosKineError: col.
	aGabs do: [:con | con fillPosKineError: col]
]

{ #category : #posIC }
MbDPartFrame >> fillPosKineJacob: mat [ 
	markerFrames do: [:mkr | mkr fillPosKineJacob: mat].
	aGeu fillPosKineJacob: mat.
	aGabs do: [:con | con fillPosKineJacob: mat]
]

{ #category : #accessing }
MbDPartFrame >> fillRedundantConstraints: collection [ 
	aGeu fillRedundantConstraints: collection.
	aGabs do: [:con | con fillRedundantConstraints: collection]
]

{ #category : #static }
MbDPartFrame >> fillStaticError: col [ 
	markerFrames do: [:mkr | mkr fillStaticError: col].
	aGeu fillStaticError: col.
	aGabs do: [:con | con fillStaticError: col]
]

{ #category : #static }
MbDPartFrame >> fillStaticJacob: mat [ 
	markerFrames do: [:mkr | mkr fillStaticJacob: mat].
	aGeu fillStaticJacob: mat.
	aGabs do: [:con | con fillStaticJacob: mat]
]

{ #category : #velIC }
MbDPartFrame >> fillVelICError: col [ 
	markerFrames do: [:mkr | mkr fillVelICError: col].
	aGeu fillVelICError: col.
	aGabs do: [:con | con fillVelICError: col]
]

{ #category : #velIC }
MbDPartFrame >> fillVelICJacob: mat [ 
	markerFrames do: [:mkr | mkr fillVelICJacob: mat].
	aGeu fillVelICJacob: mat.
	aGabs do: [:con | con fillVelICJacob: mat]
]

{ #category : #dynamic }
MbDPartFrame >> fillpFpy: mat [ 
	markerFrames do: [:mkr | mkr fillpFpy: mat].
	aGeu fillpFpy: mat.
	aGabs do: [:con | con fillpFpy: mat]
]

{ #category : #dynamic }
MbDPartFrame >> fillpFpydot: mat [ 
	markerFrames do: [:mkr | mkr fillpFpydot: mat].
	aGeu fillpFpydot: mat.
	aGabs do: [:con | con fillpFpydot: mat]
]

{ #category : #accessing }
MbDPartFrame >> fillpqsumu: col [ 
	"Fill q, s and lam into col."

	col at: iqX putFullColumn: qX.
	col at: iqE putFullColumn: qE.
	markerFrames do: [:mkr | mkr fillpqsumu: col].
	aGeu fillpqsumu: col.
	aGabs do: [:con | con fillpqsumu: col]
]

{ #category : #accessing }
MbDPartFrame >> fillpqsumudot: col [ 
	col at: iqX putFullColumn: qXdot.
	col at: iqE putFullColumn: qEdot.
	markerFrames do: [:mkr | mkr fillpqsumudot: col].
	aGeu fillpqsumudot: col.
	aGabs do: [:con | con fillpqsumudot: col]
]

{ #category : #accessing }
MbDPartFrame >> fillqsu: col [ 
	col at: iqX putFullColumn: qX.
	col at: iqE putFullColumn: qE.
	markerFrames do: [:mkr | mkr fillqsu: col]
]

{ #category : #accessing }
MbDPartFrame >> fillqsuWeights: col [ 
	markerFrames do: [:mkr | mkr fillqsuWeights: col]
]

{ #category : #accessing }
MbDPartFrame >> fillqsuddotlam: col [ 
	col at: iqX putFullColumn: qXddot.
	col at: iqE putFullColumn: qEddot.
	markerFrames do: [:mkr | mkr fillqsuddotlam: col].
	aGeu fillqsuddotlam: col.
	aGabs do: [:con | con fillqsuddotlam: col]
]

{ #category : #accessing }
MbDPartFrame >> fillqsudot: col [ 
	col at: iqX putFullColumn: qXdot.
	col at: iqE putFullColumn: qEdot.
	markerFrames do: [:mkr | mkr fillqsudot: col]
]

{ #category : #accessing }
MbDPartFrame >> fillqsudotPlam: col [ 
	col at: iqX putFullColumn: qXdot.
	col at: iqE putFullColumn: qEdot.
	markerFrames do: [:mkr | mkr fillqsudotPlam: col].
	aGeu fillqsudotPlam: col.
	aGabs do: [:con | con fillqsudotPlam: col]
]

{ #category : #accessing }
MbDPartFrame >> fillqsudotPlamDeriv: col [ 
	"qXddot is now qXdotDeriv for collision."

	col at: iqX putFullColumn: qXddot.
	col at: iqE putFullColumn: qEddot.
	markerFrames do: [:mkr | mkr fillqsudotPlamDeriv: col].
	aGeu fillqsudotPlamDeriv: col.
	aGabs do: [:con | con fillqsudotPlamDeriv: col]
]

{ #category : #accessing }
MbDPartFrame >> fillqsudotWeights: col [ 
	markerFrames do: [:mkr | mkr fillqsudotWeights: col]
]

{ #category : #accessing }
MbDPartFrame >> fillqsulam: col [ 
	"Fill q, s and lam into col."

	col at: iqX putFullColumn: qX.
	col at: iqE putFullColumn: qE.
	markerFrames do: [:mkr | mkr fillqsulam: col].
	aGeu fillqsulam: col.
	aGabs do: [:con | con fillqsulam: col]
]

{ #category : #accessing }
MbDPartFrame >> iGabs: integer [ 
	| count |
	count := integer.
	aGabs do: [:con | count := con iG: count].
	^count
]

{ #category : #accessing }
MbDPartFrame >> iGeu: integer [ 
	^aGeu iG: integer
]

{ #category : #'initialize-release' }
MbDPartFrame >> initialize [
	markerFrames := OrderedCollection new.
	aGeu := MbDEulerConstraint new.
	aGeu owner: self.
	aGabs := OrderedCollection new
]

{ #category : #'initialize-release' }
MbDPartFrame >> initializeGlobally [
	markerFrames do: [:mkr | mkr initializeGlobally].
	aGeu initializeGlobally.
	aGabs do: [:con | con initializeGlobally]
]

{ #category : #'initialize-release' }
MbDPartFrame >> initializeLocally [
	markerFrames do: [:mkr | mkr initializeLocally].
	aGeu initializeLocally.
	aGabs do: [:con | con initializeLocally]
]

{ #category : #accessing }
MbDPartFrame >> iq: integer [ 
	| count |
	count := integer.
	iqX := count.
	count := count + 3.
	iqE := count.
	aGeu jqE: iqE.
	count := count + 4.
	^count
]

{ #category : #accessing }
MbDPartFrame >> iqE [
	^iqE
]

{ #category : #accessing }
MbDPartFrame >> iqE: aInteger [ 
	iqE := aInteger
]

{ #category : #accessing }
MbDPartFrame >> iqX [
	^iqX
]

{ #category : #accessing }
MbDPartFrame >> iqX: aInteger [ 
	iqX := aInteger
]

{ #category : #accessing }
MbDPartFrame >> markerFrames [
	^markerFrames
]

{ #category : #accessing }
MbDPartFrame >> omeOpO [
	^qEdot omeOpO
]

{ #category : #accessing }
MbDPartFrame >> omeOpO: omeOpO [ 
	qEdot := MbDEulerParametersDot fromqEOp: qE andOmegaOpO: omeOpO
]

{ #category : #accessing }
MbDPartFrame >> pAOppE [
	^qE pApE
]

{ #category : #accessing }
MbDPartFrame >> pAdotOppE [
	^qEdot pAdotpE
]

{ #category : #accessing }
MbDPartFrame >> pApE [
	^qE pApE
]

{ #category : #accessing }
MbDPartFrame >> pCpE [
	^qE pCpE
]

{ #category : #accessing }
MbDPartFrame >> part [
	^part
]

{ #category : #accessing }
MbDPartFrame >> part: aMbDPart [ 
	part := aMbDPart
]

{ #category : #accessing }
MbDPartFrame >> pomeOpOpE [
	^qEdot pomeOpOpE
]

{ #category : #accessing }
MbDPartFrame >> pomeOpOpEdot [
	^qEdot pomeOpOpEdot
]

{ #category : #collision }
MbDPartFrame >> postCollisionCorrectorIteration [
	self calcPostCollisionCorrectorIteration.
"	markerFrames do: [:mkr | mkr postCollisionCorrectorIteration].
	aGeu postCollisionCorrectorIteration.
	aGabs do: [:con | con postCollisionCorrectorIteration]"
]

{ #category : #collision }
MbDPartFrame >> postCollisionPredictor [
	self calcPostCollisionCorrectorIteration.
"	markerFrames do: [:mkr | mkr postCollisionPredictor].
	aGeu postCollisionPredictor.
	aGabs do: [:con | con postCollisionPredictor]"
]

{ #category : #dynamic }
MbDPartFrame >> postDynCorrectorIteration [
	super postDynCorrectorIteration.
	markerFrames do: [:mkr | mkr postDynCorrectorIteration].
	aGeu postDynCorrectorIteration.
	aGabs do: [:con | con postDynCorrectorIteration]
]

{ #category : #dynamic }
MbDPartFrame >> postDynOutput [
	super postDynOutput.
	markerFrames do: [:mkr | mkr postDynOutput].
	aGeu postDynOutput.
	aGabs do: [:con | con postDynOutput]
]

{ #category : #dynamic }
MbDPartFrame >> postDynPredictor [
	super postDynPredictor.
	markerFrames do: [:mkr | mkr postDynPredictor].
	aGeu postDynPredictor.
	aGabs do: [:con | con postDynPredictor]
]

{ #category : #dynamic }
MbDPartFrame >> postDynStep [
	markerFrames do: [:mkr | mkr postDynStep].
	aGeu postDynStep.
	aGabs do: [:con | con postDynStep]
]

{ #category : #'input-output' }
MbDPartFrame >> postInput [
	qXddot := (FullColumn zero: 3).
	qEddot := (FullColumn zero: 4).
	super postInput.
	markerFrames do: [:mkr | mkr postInput].
	aGeu postInput.
	aGabs do: [:con | con postInput]
]

{ #category : #posIC }
MbDPartFrame >> postPosIC [
	markerFrames do: [:mkr | mkr postPosIC].
	aGeu postPosIC.
	aGabs do: [:con | con postPosIC]
]

{ #category : #posIC }
MbDPartFrame >> postPosICIteration [
	super postPosICIteration.
	markerFrames do: [:mkr | mkr postPosICIteration].
	aGeu postPosICIteration.
	aGabs do: [:con | con postPosICIteration]
]

{ #category : #static }
MbDPartFrame >> postStaticIteration [
	super postStaticIteration.
	markerFrames do: [:mkr | mkr postStaticIteration].
	aGeu postStaticIteration.
	aGabs do: [:con | con postStaticIteration]
]

{ #category : #velIC }
MbDPartFrame >> postVelIC [
	qEdot calcAdotBdotCdot.
	qEdot calcpAdotpE.
	markerFrames do: [:mkr | mkr postVelIC].
	aGeu postVelIC.
	aGabs do: [:con | con postVelIC]
]

{ #category : #accIC }
MbDPartFrame >> preAccIC [
	qXddot := (FullColumn zero: 3).
	qEddot := (FullColumn zero: 4).
	super preAccIC.
	markerFrames do: [:mkr | mkr preAccIC].
	aGeu preAccIC.
	aGabs do: [:con | con preAccIC]
]

{ #category : #collision }
MbDPartFrame >> preCollision [
	markerFrames do: [:mkr | mkr preCollision].
	aGeu preCollision.
	aGabs do: [:con | con preCollision]
]

{ #category : #collision }
MbDPartFrame >> preCollisionDerivativeIC [
	markerFrames do: [:mkr | mkr preCollisionDerivativeIC].
	aGeu preCollisionDerivativeIC.
	aGabs do: [:con | con preCollisionDerivativeIC]
]

{ #category : #dynamic }
MbDPartFrame >> preDyn [
	markerFrames do: [:mkr | mkr preDyn].
	aGeu preDyn.
	aGabs do: [:con | con preDyn]
]

{ #category : #dynamic }
MbDPartFrame >> preDynOutput [
	super preDynOutput.
	markerFrames do: [:mkr | mkr preDynOutput].
	aGeu preDynOutput.
	aGabs do: [:con | con preDynOutput]
]

{ #category : #posIC }
MbDPartFrame >> preICRestart [
	markerFrames do: [:mkr | mkr preICRestart].
	aGeu preICRestart.
	aGabs do: [:con | con preICRestart]
]

{ #category : #posIC }
MbDPartFrame >> prePosIC [
	iqX := nil.
	iqE := nil.
	super prePosIC.
	markerFrames do: [:mkr | mkr prePosIC].
	aGeu prePosIC.
	aGabs do: [:con | con prePosIC]
]

{ #category : #posIC }
MbDPartFrame >> prePosKine [
	iqX := nil.
	iqE := nil.
	self calcPostDynCorrectorIteration.
	markerFrames do: [:mkr | mkr prePosKine].
	aGeu prePosKine.
	aGabs do: [:con | con prePosKine]
]

{ #category : #static }
MbDPartFrame >> preStatic [
	qXdot zeroSelf.
	qEdot zeroSelf.
	super preStatic.
	markerFrames do: [:mkr | mkr preStatic].
	aGeu preStatic.
	aGabs do: [:con | con preStatic]
]

{ #category : #velIC }
MbDPartFrame >> preVelIC [
	super preVelIC.
	markerFrames do: [:mkr | mkr preVelIC].
	aGeu preVelIC.
	aGabs do: [:con | con preVelIC]
]

{ #category : #accessing }
MbDPartFrame >> qE [
	^qE
]

{ #category : #accessing }
MbDPartFrame >> qE: vector [ 
	"qEdot must always point to current qE."

	qE := vector.
	qEdot notNil ifTrue: [qEdot qE: qE]
]

{ #category : #accessing }
MbDPartFrame >> qEddot [
	^qEddot
]

{ #category : #accessing }
MbDPartFrame >> qEddot: column [ 
	qEddot := column
]

{ #category : #accessing }
MbDPartFrame >> qEdot [
	^qEdot
]

{ #category : #accessing }
MbDPartFrame >> qEdot: column [ 
	self error: 'Should not use because qEdot must hold onto qE correctly.'
]

{ #category : #accessing }
MbDPartFrame >> qX [
	^qX
]

{ #category : #accessing }
MbDPartFrame >> qX: vector [ 
	qX := vector
]

{ #category : #accessing }
MbDPartFrame >> qXddot [
	^qXddot
]

{ #category : #accessing }
MbDPartFrame >> qXddot: column [ 
	qXddot := column
]

{ #category : #accessing }
MbDPartFrame >> qXdot [
	^qXdot
]

{ #category : #accessing }
MbDPartFrame >> qXdot: vector [ 
	qXdot := vector
]

{ #category : #accessing }
MbDPartFrame >> rOpO [
	^qX
]

{ #category : #posIC }
MbDPartFrame >> removeRedundantConstraints: redundantEqns [ 
	markerFrames do: [:mkr | mkr removeRedundantConstraints: redundantEqns].
	aGeu removeRedundantConstraints: redundantEqns.
	aGabs do: [:con | con removeRedundantConstraints: redundantEqns]
]

{ #category : #accessing }
MbDPartFrame >> setpqsumu: col [ 
	qX equalFullColumn: col at: iqX.
	qE equalFullColumn: col at: iqE.
	markerFrames do: [:mkr | mkr setpqsumu: col].
	aGeu setpqsumu: col.
	aGabs do: [:con | con setpqsumu: col]
]

{ #category : #accessing }
MbDPartFrame >> setpqsumuddot: col [ 
	qXddot equalFullColumn: col at: iqX.
	qEddot equalFullColumn: col at: iqE.
	markerFrames do: [:mkr | mkr setpqsumuddot: col].
	aGeu setpqsumuddot: col.
	aGabs do: [:con | con setpqsumuddot: col]
]

{ #category : #accessing }
MbDPartFrame >> setpqsumudot: col [ 
	qXdot equalFullColumn: col at: iqX.
	qEdot equalFullColumn: col at: iqE.
	markerFrames do: [:mkr | mkr setpqsumudot: col].
	aGeu setpqsumudot: col.
	aGabs do: [:con | con setpqsumudot: col]
]

{ #category : #accessing }
MbDPartFrame >> setqsu: col [ 
	qX equalFullColumn: col at: iqX.
	qE equalFullColumn: col at: iqE.
	markerFrames do: [:mkr | mkr setqsu: col]
]

{ #category : #accessing }
MbDPartFrame >> setqsuddotlam: col [ 
	qXddot equalFullColumn: col at: iqX.
	qEddot equalFullColumn: col at: iqE.
	markerFrames do: [:mkr | mkr setqsuddotlam: col].
	aGeu setqsuddotlam: col.
	aGabs do: [:con | con setqsuddotlam: col]
]

{ #category : #accessing }
MbDPartFrame >> setqsudot: col [ 
	qXdot equalFullColumn: col at: iqX.
	qEdot equalFullColumn: col at: iqE.
	markerFrames do: [:mkr | mkr setqsudot: col]
]

{ #category : #accessing }
MbDPartFrame >> setqsudotPlam: col [ 
	qXdot equalFullColumn: col at: iqX.
	qEdot equalFullColumn: col at: iqE.
	markerFrames do: [:mkr | mkr setqsudotPlam: col].
	aGeu setqsudotPlam: col.
	aGabs do: [:con | con setqsudotPlam: col]
]

{ #category : #accessing }
MbDPartFrame >> setqsudotPlamDeriv: col [ 
	"qXddot is now qXdotDeriv for collision."

	qXddot equalFullColumn: col at: iqX.
	qEddot equalFullColumn: col at: iqE.
	markerFrames do: [:mkr | mkr setqsudotPlamDeriv: col].
	aGeu setqsudotPlamDeriv: col.
	aGabs do: [:con | con setqsudotPlamDeriv: col]
]

{ #category : #accessing }
MbDPartFrame >> setqsudotlam: col [ 
	qXdot equalFullColumn: col at: iqX.
	qEdot equalFullColumn: col at: iqE.
	markerFrames do: [:mkr | mkr setqsudotlam: col].
	aGeu setqsudotlam: col.
	aGabs do: [:con | con setqsudotlam: col]
]

{ #category : #accessing }
MbDPartFrame >> setqsulam: col [ 
	qX equalFullColumn: col at: iqX.
	qE equalFullColumn: col at: iqE.
	markerFrames do: [:mkr | mkr setqsulam: col].
	aGeu setqsulam: col.
	aGabs do: [:con | con setqsulam: col]
]

{ #category : #dynamic }
MbDPartFrame >> simUpdateAll [
	super simUpdateAll.
	markerFrames do: [:mkr | mkr simUpdateAll].
	aGeu simUpdateAll.
	aGabs do: [:con | con simUpdateAll]
]

{ #category : #dynamic }
MbDPartFrame >> storeDynState [
	markerFrames do: [:mkr | mkr storeDynState].
	aGeu storeDynState.
	aGabs do: [:con | con storeDynState]
]

{ #category : #dynamic }
MbDPartFrame >> suggestSmallerOrAcceptDynStepSize: hnew [ 
	| speed htran omegaMagnitude hrot hnew2 |
	hnew2 := hnew.
	speed := qXdot length.
	htran := speed < 1.0d-15
				ifTrue: [1.0d99]
				ifFalse: [TheMbDSystem translationLimit / speed].
	hnew2 > htran
		ifTrue: 
			[self logString: #'MbD: \Time step limited by translation limit per step.'.
			hnew2 := htran].
	omegaMagnitude := qEdot omeOpO length.
	hrot := omegaMagnitude < 1.0d-15
				ifTrue: [1.0d99]
				ifFalse: [TheMbDSystem rotationLimit / omegaMagnitude].
	hnew2 > hrot
		ifTrue: 
			[self logString: #'MbD: \Time step limited by rotation limit per step.'.
			hnew2 := hrot].
	markerFrames do: [:mkr | hnew2 := mkr suggestSmallerOrAcceptDynStepSize: hnew2].
	hnew2 := aGeu suggestSmallerOrAcceptDynStepSize: hnew2.
	aGabs do: [:con | hnew2 := con suggestSmallerOrAcceptDynStepSize: hnew2].
	^hnew2
]

{ #category : #'initialize-release' }
MbDPartFrame >> useEquationNumbers [
	markerFrames do: [:mFrm | mFrm useEquationNumbers].
	aGeu useEquationNumbers.
	aGabs do: [:con | con useEquationNumbers]
]

{ #category : #accessing }
MbDPartFrame >> vOpO [
	^qXdot
]
