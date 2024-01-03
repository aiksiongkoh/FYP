Class {
	#name : #MbDEulerConstraint,
	#superclass : #MbDConstraint,
	#instVars : [
		'pGpE',
		'iqE'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #calc }
MbDEulerConstraint >> calcPostDynCorrectorIteration [
	| qE |
	qE := owner qE.
	aG := qE sumOfSquares - 1.0d.
	1 to: 4 do: [:i | pGpE at: i put: 2.0d * (qE at: i)]
]

{ #category : #accessing }
MbDEulerConstraint >> classString [
	"Used to access the descriptive name of the constraint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Euler constraint '
]

{ #category : #accIC }
MbDEulerConstraint >> fillAccICIterError: col [ 
	"qdotT[ppGpqpq]*qdot."
	"qdotT[2 2 2 2 diag]*qdot."

	| sum |
	col at: iqE plusFullColumn: pGpE times: lam.
	sum := 0.0d.
	sum := sum + (pGpE timesFullColumn: owner qEddot).
	sum := sum + (2.0d * owner qEdot sumOfSquares).
	col at: iG plusNumber: sum
]

{ #category : #collision }
MbDEulerConstraint >> fillCollisionError: col [ 
	"lamDeriv is now PlamDeriv."
	"qEddot is now qEdotDeriv."

	| sum |
	col at: iqE plusFullColumn: pGpE times: lamDeriv.
	sum := 0.0d.
	sum := sum + (pGpE timesFullColumn: owner qEddot).
	col at: iG plusNumber: sum
]

{ #category : #posIC }
MbDEulerConstraint >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: iqE plusFullColumn: pGpE times: lam
]

{ #category : #posIC }
MbDEulerConstraint >> fillPosICJacob: mat [ 
	"ppGpEpE is a diag(2,2,2,2)."

	| ioffset twolam i |
	mat at: iG and: iqE plusFullRow: pGpE.
	mat at: iqE and: iG plusFullColumn: pGpE transpose.
	ioffset := iqE - 1.
	twolam := 2.0d * lam.
	1 to: 4 do: [:ii | 
			i := ioffset + ii.
			mat at: i and: i plusNumber: twolam]
]

{ #category : #posIC }
MbDEulerConstraint >> fillPosKineJacob: mat [ 
	mat
		at: iG
		and: iqE
		plusFullRow: pGpE
]

{ #category : #velIC }
MbDEulerConstraint >> fillVelICJacob: mat [ 
	mat at: iG and: iqE plusFullRow: pGpE.
	mat at: iqE and: iG plusFullColumn: pGpE transpose
]

{ #category : #dynamic }
MbDEulerConstraint >> fillpFpy: mat [ 
	"ppGpEpE is a diag(2,2,2,2)."

	| ioffset twolam i |
	mat at: iG and: iqE plusFullRow: pGpE.
	ioffset := iqE - 1.
	twolam := 2.0d * lam.
	1 to: 4 do: [:ii | 
			i := ioffset + ii.
			mat at: i and: i plusNumber: twolam]
]

{ #category : #dynamic }
MbDEulerConstraint >> fillpFpydot: mat [ 
	mat at: iqE and: iG plusFullColumn: pGpE transpose
]

{ #category : #'initialize-release' }
MbDEulerConstraint >> initialize [
	super initialize.
	pGpE := FullRow new: 4
]

{ #category : #accessing }
MbDEulerConstraint >> pGpE [
	^pGpE
]

{ #category : #'initialize-release' }
MbDEulerConstraint >> useEquationNumbers [
	iqE := owner iqE
]
