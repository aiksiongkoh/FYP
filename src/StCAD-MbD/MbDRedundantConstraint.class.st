Class {
	#name : #MbDRedundantConstraint,
	#superclass : #MbDItem,
	#instVars : [
		'constraint'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #posIC }
MbDRedundantConstraint >> activateConstraint [
	| newSelf |
	newSelf := self constraint.
	self become: newSelf.
	^true
]

{ #category : #accessing }
MbDRedundantConstraint >> addToJointForceI: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> addToJointForceJ: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> addToJointTorqueI: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> addToJointTorqueJ: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> bePerturbed: delta fillqsulam: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> classString [
	^constraint classString
]

{ #category : #accessing }
MbDRedundantConstraint >> constraint [
	^constraint
]

{ #category : #accessing }
MbDRedundantConstraint >> constraint: con [ 
	constraint := con
]

{ #category : #dynamic }
MbDRedundantConstraint >> discontinuityAt: tstartNew addTypeTo: collection [ 
	"Reactivate all contraints."

	| newSelf |
	newSelf := self constraint.
	newSelf discontinuityAt: tstartNew addTypeTo: collection.
	self become: newSelf
]

{ #category : #accIC }
MbDRedundantConstraint >> fillAccICIterError: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> fillConstraints: collection [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> fillDispConstraints: collection [ 
	"Do nothing."
]

{ #category : #dynamic }
MbDRedundantConstraint >> fillDynError: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> fillEssenConstraints: collection [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> fillPerpenConstraints: collection [ 
	"Do nothing."
]

{ #category : #posIC }
MbDRedundantConstraint >> fillPosICError: col [ 
	"Do nothing."
]

{ #category : #posIC }
MbDRedundantConstraint >> fillPosICJacob: mat [ 
	"Do nothing."
]

{ #category : #posIC }
MbDRedundantConstraint >> fillPosKineError: col [ 
	"Do nothing."
]

{ #category : #posIC }
MbDRedundantConstraint >> fillPosKineJacob: mat [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> fillRedundantConstraints: collection [ 
	collection add: self
]

{ #category : #accessing }
MbDRedundantConstraint >> fillmu: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> fillmudot: col [ 
	"Do nothing."
]

{ #category : #dynamic }
MbDRedundantConstraint >> fillpFpy: mat [ 
	"Do nothing."
]

{ #category : #dynamic }
MbDRedundantConstraint >> fillpFpydot: mat [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> fillpqsumu: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> fillpqsumudot: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> fillqsuddotlam: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> fillqsudotPlam: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> fillqsudotPlamDeriv: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> fillqsulam: col [ 
	"Do nothing."
]

{ #category : #posIC }
MbDRedundantConstraint >> isRedundant [
	^true
]

{ #category : #dynamic }
MbDRedundantConstraint >> postDynCorrectorIteration [
	"Do nothing."
]

{ #category : #dynamic }
MbDRedundantConstraint >> postDynOutput [
	"Do nothing."
]

{ #category : #dynamic }
MbDRedundantConstraint >> postDynPredictor [
	"Do nothing."
]

{ #category : #'input-output' }
MbDRedundantConstraint >> postInput [
	"Do nothing."
]

{ #category : #posIC }
MbDRedundantConstraint >> postPosICIteration [
	"Do nothing."
]

{ #category : #static }
MbDRedundantConstraint >> postStaticIteration [
	"Do nothing."
]

{ #category : #accIC }
MbDRedundantConstraint >> preAccIC [
	"Do nothing."
]

{ #category : #dynamic }
MbDRedundantConstraint >> preDynOutput [
	"Do nothing."
]

{ #category : #posIC }
MbDRedundantConstraint >> preICRestart [
	"Reactivate all contraints."

	| newSelf |
	newSelf := self constraint.
	newSelf preICRestart.
	self become: newSelf
]

{ #category : #posIC }
MbDRedundantConstraint >> prePosIC [
	"Do nothing."
]

{ #category : #static }
MbDRedundantConstraint >> preStatic [
	"Do nothing."
]

{ #category : #velIC }
MbDRedundantConstraint >> preVelIC [
	"Do nothing."
]

{ #category : #posIC }
MbDRedundantConstraint >> removeRedundantConstraints: redundantEqns [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> setmu: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> setmuddot: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> setpqsumu: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> setpqsumuddot: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> setpqsumudot: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> setqsuddotlam: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> setqsudotPlam: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> setqsudotPlamDeriv: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> setqsudotlam: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDRedundantConstraint >> setqsulam: col [ 
	"Do nothing."
]

{ #category : #dynamic }
MbDRedundantConstraint >> simUpdateAll [
	"Do nothing."
]

{ #category : #'initialize-release' }
MbDRedundantConstraint >> useEquationNumbers [
	"Do nothing."
]
