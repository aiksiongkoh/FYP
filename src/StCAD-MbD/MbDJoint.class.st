Class {
	#name : #MbDJoint,
	#superclass : #MbDItem,
	#instVars : [
		'frmI',
		'frmJ',
		'constraints',
		'friction'
	],
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #calc }
MbDJoint >> aFIeJtIe [
	"aFIeJtIe is joint force on end frame Ie expresses in Ie components."

	^frmI aAeO timesFullColumn: self aFIeJtO
]

{ #category : #calc }
MbDJoint >> aFIeJtO [
	"aFIeJtO is joint force on end frame Ie expresses in O components."

	| aFIeJtO |
	aFIeJtO := (FullColumn zero: 3).
	constraints do: [:con | con addToJointForceI: aFIeJtO].
	^aFIeJtO
]

{ #category : #calc }
MbDJoint >> aFJeJtO [
	"aFJeJtO is joint force on end frame Je expresses in O components."

	| aFJeJtO |
	aFJeJtO := (FullColumn zero: 3).
	constraints do: [:con | con addToJointForceJ: aFJeJtO].
	^aFJeJtO
]

{ #category : #calc }
MbDJoint >> aFX [
	"aFX is force on ADAMS marker I."

	^self jointForceI
]

{ #category : #calc }
MbDJoint >> aTIeJtIe [
	"aTIeJtIe is torque on part containing end frame Ie expressed in Ie components."

	^frmI aAeO timesFullColumn: self aTIeJtO
]

{ #category : #calc }
MbDJoint >> aTIeJtO [
	"aTIeJtO is torque on part containing end frame Ie expressed in O components."

	| aTIeJtO |
	aTIeJtO := (FullColumn zero: 3).
	constraints do: [:con | con addToJointTorqueI: aTIeJtO].
	^aTIeJtO
]

{ #category : #calc }
MbDJoint >> aTJeJtO [
	"aTJeJtO is torque on part containing end frame Je expressed in O components."

	| aTJeJtO |
	aTJeJtO := (FullColumn zero: 3).
	constraints do: [:con | con addToJointTorqueJ: aTJeJtO].
	^aTJeJtO
]

{ #category : #calc }
MbDJoint >> aTX [
	"aTX is torque on ADAMS marker I."

	^self jointTorqueI
]

{ #category : #accessing }
MbDJoint >> bePerturbed: delta fillqsulam: col [ 
	constraints do: [:con | con bePerturbed: delta fillqsulam: col]
]

{ #category : #collision }
MbDJoint >> becomeSeparatedCVCVJoint [
	"Do nothing."
]

{ #category : #'initialize-release' }
MbDJoint >> connectsI: mkrII toJ: mkrJJ [ 
	frmI := mkrII.
	frmJ := mkrJJ
]

{ #category : #accessing }
MbDJoint >> constraint [
	^constraints at: 1
]

{ #category : #accessing }
MbDJoint >> constraints [
	^constraints
]

{ #category : #posIC }
MbDJoint >> constraintsReport [
	| dummy |
	dummy := constraints select: [:con | con isRedundant].
	dummy size > 0
		ifTrue: 
			[self logString: #'MbD: \%1 %2  has the following constraint(s) removed: ' withArguments: (Array with: self classString with: self name).
			dummy do: [:con | con logString: #'MbD: \    %1' withArgument: con classString]]
]

{ #category : #accessing }
MbDJoint >> endFrameI [
	^frmI
]

{ #category : #accessing }
MbDJoint >> endFrameJ [
	^frmJ
]

{ #category : #accIC }
MbDJoint >> fillAccICIterError: col [ 
	constraints do: [:con | con fillAccICIterError: col]
]

{ #category : #accIC }
MbDJoint >> fillAccICIterJacob: mat [ 
	constraints do: [:con | con fillAccICIterJacob: mat]
]

{ #category : #collision }
MbDJoint >> fillCollisionDerivativeICJacob: mat [ 
	constraints do: [:con | con fillCollisionDerivativeICJacob: mat]
]

{ #category : #collision }
MbDJoint >> fillCollisionError: col [ 
	constraints do: [:con | con fillCollisionError: col]
]

{ #category : #collision }
MbDJoint >> fillCollisionpFpydot: mat [ 
	constraints do: [:con | con fillCollisionpFpydot: mat]
]

{ #category : #accessing }
MbDJoint >> fillConstraints: collection [ 
	constraints do: [:con | con fillConstraints: collection]
]

{ #category : #accessing }
MbDJoint >> fillContactEndFrames: set [ 
	frmI fillContactEndFrames: set.
	frmJ fillContactEndFrames: set
]

{ #category : #accessing }
MbDJoint >> fillDispConstraints: collection [ 
	constraints do: [:con | con fillDispConstraints: collection]
]

{ #category : #dynamic }
MbDJoint >> fillDynError: col [ 
	constraints do: [:con | con fillDynError: col]
]

{ #category : #accessing }
MbDJoint >> fillEssenConstraints: collection [ 
	constraints do: [:con | con fillEssenConstraints: collection]
]

{ #category : #accessing }
MbDJoint >> fillPerpenConstraints: collection [ 
	constraints do: [:con | con fillPerpenConstraints: collection]
]

{ #category : #posIC }
MbDJoint >> fillPosICError: col [ 
	constraints do: [:con | con fillPosICError: col]
]

{ #category : #posIC }
MbDJoint >> fillPosICJacob: mat [ 
	constraints do: [:con | con fillPosICJacob: mat]
]

{ #category : #posIC }
MbDJoint >> fillPosKineError: col [ 
	constraints do: [:con | con fillPosKineError: col]
]

{ #category : #posIC }
MbDJoint >> fillPosKineJacob: mat [ 
	constraints do: [:con | con fillPosKineJacob: mat]
]

{ #category : #accessing }
MbDJoint >> fillRedundantConstraints: collection [ 
	constraints do: [:con | con fillRedundantConstraints: collection]
]

{ #category : #static }
MbDJoint >> fillStaticError: col [ 
	constraints do: [:con | con fillStaticError: col]
]

{ #category : #static }
MbDJoint >> fillStaticJacob: mat [ 
	constraints do: [:con | con fillStaticJacob: mat]
]

{ #category : #velIC }
MbDJoint >> fillVelICError: col [ 
	constraints do: [:con | con fillVelICError: col]
]

{ #category : #velIC }
MbDJoint >> fillVelICJacob: mat [ 
	constraints do: [:con | con fillVelICJacob: mat]
]

{ #category : #dynamic }
MbDJoint >> fillpFpy: mat [ 
	constraints do: [:con | con fillpFpy: mat]
]

{ #category : #dynamic }
MbDJoint >> fillpFpydot: mat [ 
	constraints do: [:con | con fillpFpydot: mat]
]

{ #category : #accessing }
MbDJoint >> fillpqsumu: col [ 
	constraints do: [:con | con fillpqsumu: col]
]

{ #category : #accessing }
MbDJoint >> fillpqsumudot: col [ 
	constraints do: [:con | con fillpqsumudot: col]
]

{ #category : #accessing }
MbDJoint >> fillqsu: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDJoint >> fillqsuWeights: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDJoint >> fillqsuddotlam: col [ 
	constraints do: [:con | con fillqsuddotlam: col]
]

{ #category : #accessing }
MbDJoint >> fillqsudot: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDJoint >> fillqsudotPlam: col [ 
	constraints do: [:con | con fillqsudotPlam: col]
]

{ #category : #accessing }
MbDJoint >> fillqsudotPlamDeriv: col [ 
	constraints do: [:con | con fillqsudotPlamDeriv: col]
]

{ #category : #accessing }
MbDJoint >> fillqsudotWeights: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDJoint >> fillqsulam: col [ 
	constraints do: [:con | con fillqsulam: col]
]

{ #category : #accessing }
MbDJoint >> fillu: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDJoint >> filluHolders: set [ 
	"Default is do nothing."
]

{ #category : #accessing }
MbDJoint >> filludot: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDJoint >> fillumu: col [ 
	constraints do: [:con | con fillmu: col]
]

{ #category : #accessing }
MbDJoint >> frmI [
	^frmI
]

{ #category : #accessing }
MbDJoint >> frmJ [
	^frmJ
]

{ #category : #'initialize-release' }
MbDJoint >> initialize [
	constraints := OrderedCollection new
]

{ #category : #'initialize-release' }
MbDJoint >> initializeGlobally [
	constraints do: [:con | con initializeGlobally]
]

{ #category : #'initialize-release' }
MbDJoint >> initializeLocally [
	constraints do: [:con | con initializeLocally]
]

{ #category : #calc }
MbDJoint >> jointForceI [
	"jointForceI is force on MbD marker I."

	| jointForce |
	jointForce := (FullColumn zero: 3).
	constraints do: [:con | con addToJointForceI: jointForce].
	^jointForce
]

{ #category : #calc }
MbDJoint >> jointForceJ [
	"jointForceJ is force on MbD marker J."

	| jointForce |
	jointForce := (FullColumn zero: 3).
	constraints do: [:con | con addToJointForceJ: jointForce].
	^jointForce
]

{ #category : #calc }
MbDJoint >> jointTorqueI [
	"jointTorqueI is torque on MbD marker I."

	| jointTorque |
	jointTorque := (FullColumn zero: 3).
	constraints do: [:con | con addToJointTorqueI: jointTorque].
	^jointTorque
]

{ #category : #calc }
MbDJoint >> jointTorqueJ [
	"jointTorqueJ is torque on MbD marker J."

	| jointTorque |
	jointTorque := (FullColumn zero: 3).
	constraints do: [:con | con addToJointTorqueJ: jointTorque].
	^jointTorque
]

{ #category : #'initialize-release' }
MbDJoint >> owns: aConstraint [ 
	constraints add: aConstraint.
	aConstraint owner: self
]

{ #category : #calc }
MbDJoint >> pFIeJtIepEI [
	| aAIeO pAIeOpEI aFIeJtO pFIeJtOpEI pFIeJtIepEI colj |
	aAIeO := frmI aAeO.
	pAIeOpEI := frmI pAeOpE.
	aFIeJtO := self aFIeJtO.
	pFIeJtOpEI := self pFIeJtOpEI.
	pFIeJtIepEI := FullMatrix new: 3 by: 4.
	1 to: 4 do: [:j | 
			colj := (pAIeOpEI at: j) timesFullColumn: aFIeJtO.
			pFIeJtIepEI at: 1 and: j fillWithFullColumn: colj].
	pFIeJtIepEI equalSelfPlus: (aAIeO timesFullMatrix: pFIeJtOpEI).
	^pFIeJtIepEI
]

{ #category : #calc }
MbDJoint >> pFIeJtIepEJ [
	"This may be always zero because ppGpXIpEJ is zero."

	^frmI aAeO timesFullMatrix: self pFIeJtOpEJ
]

{ #category : #calc }
MbDJoint >> pFIeJtIepXI [
	"This may be always zero because ppGpXIpXI is zero."

	^frmI aAeO timesFullMatrix: self pFIeJtOpXI
]

{ #category : #calc }
MbDJoint >> pFIeJtIepXJ [
	"This may be always zero because ppGpXIpXJ is zero."

	^frmI aAeO timesFullMatrix: self pFIeJtOpXJ
]

{ #category : #calc }
MbDJoint >> pFIeJtIeplam [
	^frmI aAeO timesSparseMatrix: self pFIeJtOplam
]

{ #category : #calc }
MbDJoint >> pFIeJtOpEI [
	| pFIeJtOpEI |
	pFIeJtOpEI := (FullMatrix zero: 3 by: 4).
	constraints do: [:con | con addpFIeiGOpEIto: pFIeJtOpEI].
	^pFIeJtOpEI
]

{ #category : #calc }
MbDJoint >> pFIeJtOpEJ [
	| pFIeJtOpEJ |
	pFIeJtOpEJ := (FullMatrix zero: 3 by: 4).
	constraints do: [:con | con addpFIeiGOpEJto: pFIeJtOpEJ].
	^pFIeJtOpEJ
]

{ #category : #calc }
MbDJoint >> pFIeJtOpXI [
	| pFIeJtOpXI |
	pFIeJtOpXI := (FullMatrix zero: 3 by: 3).
	constraints do: [:con | con addpFIeiGOpXIto: pFIeJtOpXI].
	^pFIeJtOpXI
]

{ #category : #calc }
MbDJoint >> pFIeJtOpXJ [
	| pFIeJtOpXJ |
	pFIeJtOpXJ := (FullMatrix zero: 3 by: 3).
	constraints do: [:con | con addpFIeiGOpXJto: pFIeJtOpXJ].
	^pFIeJtOpXJ
]

{ #category : #calc }
MbDJoint >> pFIeJtOplam [
	"The second dimension is not relevant."
	"7 is a good size to avoid reallocating for the SparseRows."

	| pFIeJtOplam |
	pFIeJtOplam := (SparseMatrix zero: 3 by: 7).
	constraints do: [:con | con addpFIeiGOplamto: pFIeJtOplam].
	^pFIeJtOplam
]

{ #category : #calc }
MbDJoint >> pTIeJtIepEI [
	| aAIeO pAIeOpEI aTIeJtO pTIeJtOpEI pTIeJtIepEI colj |
	aAIeO := frmI aAeO.
	pAIeOpEI := frmI pAeOpE.
	aTIeJtO := self aTIeJtO.
	pTIeJtOpEI := self pTIeJtOpEI.
	pTIeJtIepEI := FullMatrix new: 3 by: 4.
	1 to: 4 do: [:j | 
			colj := (pAIeOpEI at: j) timesFullColumn: aTIeJtO.
			pTIeJtIepEI at: 1 and: j fillWithFullColumn: colj].
	pTIeJtIepEI equalSelfPlus: (aAIeO timesFullMatrix: pTIeJtOpEI).
	^pTIeJtIepEI
]

{ #category : #calc }
MbDJoint >> pTIeJtIepEJ [
	^frmI aAeO timesFullMatrix: self pTIeJtOpEJ
]

{ #category : #calc }
MbDJoint >> pTIeJtIepXI [
	^frmI aAeO timesFullMatrix: self pTIeJtOpXI
]

{ #category : #calc }
MbDJoint >> pTIeJtIepXJ [
	^frmI aAeO timesFullMatrix: self pTIeJtOpXJ
]

{ #category : #calc }
MbDJoint >> pTIeJtIeplam [
	^frmI aAeO timesSparseMatrix: self pTIeJtOplam
]

{ #category : #calc }
MbDJoint >> pTIeJtOpEI [
	| pTIeJtOpEI |
	pTIeJtOpEI := (FullMatrix zero: 3 by: 4).
	constraints do: [:con | con addpTIeiGOpEIto: pTIeJtOpEI].
	^pTIeJtOpEI
]

{ #category : #calc }
MbDJoint >> pTIeJtOpEJ [
	| pTIeJtOpEJ |
	pTIeJtOpEJ := (FullMatrix zero: 3 by: 4).
	constraints do: [:con | con addpTIeiGOpEJto: pTIeJtOpEJ].
	^pTIeJtOpEJ
]

{ #category : #calc }
MbDJoint >> pTIeJtOpXI [
	| pTIeJtOpXI |
	pTIeJtOpXI := (FullMatrix zero: 3 by: 3).
	constraints do: [:con | con addpTIeiGOpXIto: pTIeJtOpXI].
	^pTIeJtOpXI
]

{ #category : #calc }
MbDJoint >> pTIeJtOpXJ [
	| pTIeJtOpXJ |
	pTIeJtOpXJ := (FullMatrix zero: 3 by: 3).
	constraints do: [:con | con addpTIeiGOpXJto: pTIeJtOpXJ].
	^pTIeJtOpXJ
]

{ #category : #calc }
MbDJoint >> pTIeJtOplam [
	"The second dimension is not relevant."
	"7 is a good size to avoid reallocating for the SparseRows."

	| pTIeJtOplam |
	pTIeJtOplam := (SparseMatrix zero: 3 by: 7).
	constraints do: [:con | con addpTIeiGOplamto: pTIeJtOplam].
	^pTIeJtOplam
]

{ #category : #accessing }
MbDJoint >> partFrameI [
	^frmI partFrame
]

{ #category : #accessing }
MbDJoint >> partFrameJ [
	^frmJ partFrame
]

{ #category : #dynamic }
MbDJoint >> postDynCorrectorIteration [
	constraints do: [:con | con postDynCorrectorIteration]
]

{ #category : #dynamic }
MbDJoint >> postDynOutput [
	constraints do: [:con | con postDynOutput]
]

{ #category : #dynamic }
MbDJoint >> postDynPredictor [
	constraints do: [:con | con postDynPredictor]
]

{ #category : #dynamic }
MbDJoint >> postDynStep [
	constraints do: [:con | con postDynStep]
]

{ #category : #'input-output' }
MbDJoint >> postInput [
	constraints do: [:con | con postInput]
]

{ #category : #posIC }
MbDJoint >> postPosIC [
	constraints do: [:con | con postPosIC]
]

{ #category : #posIC }
MbDJoint >> postPosICIteration [
	constraints do: [:con | con postPosICIteration]
]

{ #category : #static }
MbDJoint >> postStaticIteration [
	constraints do: [:con | con postStaticIteration]
]

{ #category : #accIC }
MbDJoint >> preAccIC [
	constraints do: [:con | con preAccIC]
]

{ #category : #collision }
MbDJoint >> preCollision [
	constraints do: [:con | con preCollision]
]

{ #category : #collision }
MbDJoint >> preCollisionDerivativeIC [
	constraints do: [:con | con preCollisionDerivativeIC]
]

{ #category : #dynamic }
MbDJoint >> preDyn [
	constraints do: [:con | con preDyn]
]

{ #category : #dynamic }
MbDJoint >> preDynOutput [
	constraints do: [:con | con preDynOutput]
]

{ #category : #dynamic }
MbDJoint >> preICRestart [
	constraints do: [:con | con preICRestart]
]

{ #category : #posIC }
MbDJoint >> prePosIC [
	constraints do: [:con | con prePosIC]
]

{ #category : #posIC }
MbDJoint >> prePosKine [
	constraints do: [:con | con prePosKine]
]

{ #category : #static }
MbDJoint >> preStatic [
	constraints do: [:con | con preStatic]
]

{ #category : #velIC }
MbDJoint >> preVelIC [
	constraints do: [:con | con preVelIC]
]

{ #category : #posIC }
MbDJoint >> removeRedundantConstraints: redundantEqns [ 
	constraints do: [:con | con removeRedundantConstraints: redundantEqns]
]

{ #category : #accessing }
MbDJoint >> setpqsumu: col [ 
	constraints do: [:con | con setpqsumu: col]
]

{ #category : #accessing }
MbDJoint >> setpqsumuddot: col [ 
	constraints do: [:con | con setpqsumuddot: col]
]

{ #category : #accessing }
MbDJoint >> setpqsumudot: col [ 
	constraints do: [:con | con setpqsumudot: col]
]

{ #category : #accessing }
MbDJoint >> setqsu: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDJoint >> setqsuddotlam: col [ 
	constraints do: [:con | con setqsuddotlam: col]
]

{ #category : #accessing }
MbDJoint >> setqsudot: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDJoint >> setqsudotPlam: col [ 
	constraints do: [:con | con setqsudotPlam: col]
]

{ #category : #accessing }
MbDJoint >> setqsudotPlamDeriv: col [ 
	constraints do: [:con | con setqsudotPlamDeriv: col]
]

{ #category : #accessing }
MbDJoint >> setqsudotlam: col [ 
	constraints do: [:con | con setqsudotlam: col]
]

{ #category : #accessing }
MbDJoint >> setqsulam: col [ 
	constraints do: [:con | con setqsulam: col]
]

{ #category : #accessing }
MbDJoint >> setu: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDJoint >> setumu: col [ 
	constraints do: [:con | con setmu: col]
]

{ #category : #accessing }
MbDJoint >> setumuddot: col [ 
	constraints do: [:con | con setmuddot: col]
]

{ #category : #dynamic }
MbDJoint >> simUpdateAll [
	constraints do: [:con | con simUpdateAll]
]

{ #category : #'initialize-release' }
MbDJoint >> submitToSystem [
	self registerName.
	TheMbDSystem jointsMotions add: self
]

{ #category : #'initialize-release' }
MbDJoint >> useEquationNumbers [
	constraints do: [:con | con useEquationNumbers]
]
