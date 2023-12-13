Class {
	#name : #MbDConstraint,
	#superclass : #MbDItem,
	#instVars : [
		'iG',
		'aG',
		'lam',
		'mu',
		'lamDeriv',
		'owner'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #'VisualWorks metadata' }
MbDConstraint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #posIC }
MbDConstraint >> activateConstraint [
	"Do nothing"
]

{ #category : #accessing }
MbDConstraint >> bePerturbed: delta fillqsulam: col [ 
	col at: iG put: lam
]

{ #category : #posIC }
MbDConstraint >> becomeRedundantConstraint [
	| newSelf |
	iG := nil.
	newSelf := MbDRedundantConstraint new.
	self become: newSelf.
	self constraint: newSelf
]

{ #category : #accIC }
MbDConstraint >> fillAccICIterJacob: mat [ 
	"Same as velIC."

	self fillVelICJacob: mat
]

{ #category : #collision }
MbDConstraint >> fillCollisionDerivativeICJacob: mat [ 
	"Same as velIC."

	self fillVelICJacob: mat
]

{ #category : #collision }
MbDConstraint >> fillCollisionpFpydot: mat [ 
	"Same as velIC."

	self fillVelICJacob: mat
]

{ #category : #accessing }
MbDConstraint >> fillConstraints: collection [ 
	collection add: self
]

{ #category : #accessing }
MbDConstraint >> fillDispConstraints: collection [ 
	self type == #displacement ifTrue: [collection add: self]
]

{ #category : #dynamic }
MbDConstraint >> fillDynError: col [ 
	"Same as fillPosICError: col."

	self fillPosICError: col
]

{ #category : #accessing }
MbDConstraint >> fillEssenConstraints: collection [ 
	self type == #essential ifTrue: [collection add: self]
]

{ #category : #accessing }
MbDConstraint >> fillPerpenConstraints: collection [ 
	self type == #perpendicular ifTrue: [collection add: self]
]

{ #category : #posIC }
MbDConstraint >> fillPosICError: col [ 
	col at: iG plusNumber: aG
]

{ #category : #posIC }
MbDConstraint >> fillPosKineError: col [ 
	col at: iG plusNumber: aG
]

{ #category : #accessing }
MbDConstraint >> fillRedundantConstraints: collection [ 
	"Do nothing."
]

{ #category : #static }
MbDConstraint >> fillStaticError: col [ 
	"Same as fillPosICError: col."

	self fillPosICError: col
]

{ #category : #static }
MbDConstraint >> fillStaticJacob: mat [ 
	"Same as fillPosICJacob: mat."

	self fillPosICJacob: mat
]

{ #category : #accessing }
MbDConstraint >> fillmu: col [ 
	col at: iG put: mu
]

{ #category : #accessing }
MbDConstraint >> fillpqsumu: col [ 
	col at: iG put: mu
]

{ #category : #accessing }
MbDConstraint >> fillpqsumudot: col [ 
	col at: iG put: lam
]

{ #category : #accessing }
MbDConstraint >> fillqsuddotlam: col [ 
	col at: iG put: lam
]

{ #category : #accessing }
MbDConstraint >> fillqsudotPlam: col [ 
	"lam is now Plam for collision."

	col at: iG put: lam
]

{ #category : #accessing }
MbDConstraint >> fillqsudotPlamDeriv: col [ 
	"lamDeriv is now PlamDeriv for collision."

	col at: iG put: lamDeriv
]

{ #category : #accessing }
MbDConstraint >> fillqsulam: col [ 
	col at: iG put: lam
]

{ #category : #accessing }
MbDConstraint >> iG [
	^iG
]

{ #category : #accessing }
MbDConstraint >> iG: integer [ 
	iG := integer
]

{ #category : #'initialize-release' }
MbDConstraint >> initialize [
	"Get unique name."

	name := self identityHash
]

{ #category : #posIC }
MbDConstraint >> isRedundant [
	^false
]

{ #category : #accessing }
MbDConstraint >> lam [
	^lam
]

{ #category : #accessing }
MbDConstraint >> owner: object [ 
	owner := object
]

{ #category : #'input-output' }
MbDConstraint >> postInput [
	lam := 0.0d.
	super postInput
]

{ #category : #accIC }
MbDConstraint >> preAccIC [
	"Set any friction to zero to start iteration."

	lam := 0.0d.
	super preAccIC
]

{ #category : #collision }
MbDConstraint >> preCollision [
	"lam is now Plam."

	lam := 0.0d
]

{ #category : #collision }
MbDConstraint >> preCollisionDerivativeIC [
	"lam is now impulse Plam."

	lam := 0.0d
]

{ #category : #dynamic }
MbDConstraint >> preDyn [
	mu := 0.0d
]

{ #category : #posIC }
MbDConstraint >> preICRestart [
	mu := 0.0d.
	lam := 0.0d
]

{ #category : #posIC }
MbDConstraint >> prePosIC [
	lam := 0.0d.
	iG := nil.
	super prePosIC
]

{ #category : #posIC }
MbDConstraint >> prePosKine [
	"Preserve lam calculated from AccIC for possible use by DynIntegrator if system is not kinematic."

	| lamOld |
	lamOld := lam.
	self prePosIC.
	lam := lamOld
]

{ #category : #static }
MbDConstraint >> preStatic [
	"The lambda's are not zeroed out since they are valid initial values in static solution."

	iG := nil.
	super preStatic
]

{ #category : #posIC }
MbDConstraint >> removeRedundantConstraints: redundantEqns [ 
	(redundantEqns includes: iG)
		ifTrue: [self becomeRedundantConstraint]
]

{ #category : #accessing }
MbDConstraint >> setmu: col [ 
	mu := col at: iG
]

{ #category : #accessing }
MbDConstraint >> setmuddot: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDConstraint >> setpqsumu: col [ 
	mu := col at: iG
]

{ #category : #accessing }
MbDConstraint >> setpqsumuddot: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDConstraint >> setpqsumudot: col [ 
	lam := col at: iG
]

{ #category : #accessing }
MbDConstraint >> setqsuddotlam: col [ 
	lam := col at: iG
]

{ #category : #accessing }
MbDConstraint >> setqsudotPlam: col [ 
	lam := col at: iG
]

{ #category : #accessing }
MbDConstraint >> setqsudotPlamDeriv: col [ 
	lamDeriv := col at: iG
]

{ #category : #accessing }
MbDConstraint >> setqsudotlam: col [ 
	lam := col at: iG
]

{ #category : #accessing }
MbDConstraint >> setqsulam: col [ 
	lam := col at: iG
]

{ #category : #accessing }
MbDConstraint >> type [
	^#essential
]
