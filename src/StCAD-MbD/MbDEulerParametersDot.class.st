Class {
	#name : #MbDEulerParametersDot,
	#superclass : #EulerParametersDot,
	#type : #variable,
	#instVars : [
		'pAdotpE'
	],
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #accessing }
MbDEulerParametersDot >> aA [
	^qE aA
]

{ #category : #accessing }
MbDEulerParametersDot >> aAdot [
	^aAdot
]

{ #category : #accessing }
MbDEulerParametersDot >> aB [
	^qE aB
]

{ #category : #accessing }
MbDEulerParametersDot >> aBdot [
	^aBdot
]

{ #category : #accessing }
MbDEulerParametersDot >> aC [
	^qE aC
]

{ #category : #accessing }
MbDEulerParametersDot >> aCdot [
	^aCdot
]

{ #category : #calc }
MbDEulerParametersDot >> calc [
	super calc.
	self calcpAdotpE
]

{ #category : #calc }
MbDEulerParametersDot >> calcAdotBdotCdot [
	"aAdot, aBdot and aCdot are all calculated together and only here."

	| aE1dot aE2dot aE3dot aE4dot mE1dot mE2dot mE3dot |
	aE1dot := self at: 1.
	aE2dot := self at: 2.
	aE3dot := self at: 3.
	aE4dot := self at: 4.
	mE1dot := 0.0d - aE1dot.
	mE2dot := 0.0d - aE2dot.
	mE3dot := 0.0d - aE3dot.
	(aBdot at: 1)
		at: 1 put: aE4dot;
		at: 2 put: mE3dot;
		at: 3 put: aE2dot;
		at: 4 put: mE1dot.
	(aBdot at: 2)
		at: 1 put: aE3dot;
		at: 2 put: aE4dot;
		at: 3 put: mE1dot;
		at: 4 put: mE2dot.
	(aBdot at: 3)
		at: 1 put: mE2dot;
		at: 2 put: aE1dot;
		at: 3 put: aE4dot;
		at: 4 put: mE3dot.
	(aCdot at: 1)
		at: 1 put: aE4dot;
		at: 2 put: aE3dot;
		at: 3 put: mE2dot;
		at: 4 put: mE1dot.
	(aCdot at: 2)
		at: 1 put: mE3dot;
		at: 2 put: aE4dot;
		at: 3 put: aE1dot;
		at: 4 put: mE2dot.
	(aCdot at: 3)
		at: 1 put: aE2dot;
		at: 2 put: mE1dot;
		at: 3 put: aE4dot;
		at: 4 put: mE3dot.
	aAdot := (self aB timesTransposeFullMatrix: aCdot) times: 2.0d
]

{ #category : #calc }
MbDEulerParametersDot >> calcpAdotpE [
	"pAdotpE is a StMFull1DArray of Matrices."
	"All aE's are actually aEdot's."

	| a2E1 a2E2 a2E3 a2E4 m2E1 m2E2 m2E3 m2E4 mat |
	a2E1 := 2.0d * (self at: 1).
	a2E2 := 2.0d * (self at: 2).
	a2E3 := 2.0d * (self at: 3).
	a2E4 := 2.0d * (self at: 4).
	m2E1 := 0.0d - a2E1.
	m2E2 := 0.0d - a2E2.
	m2E3 := 0.0d - a2E3.
	m2E4 := 0.0d - a2E4.
	mat := pAdotpE at: 1.
	(mat at: 1) at: 1 put: a2E1; at: 2 put: a2E2; at: 3 put: a2E3.
	(mat at: 2) at: 1 put: a2E2; at: 2 put: m2E1; at: 3 put: m2E4.
	(mat at: 3) at: 1 put: a2E3; at: 2 put: a2E4; at: 3 put: m2E1.
	mat := pAdotpE at: 2.
	(mat at: 1) at: 1 put: m2E2; at: 2 put: a2E1; at: 3 put: a2E4.
	(mat at: 2) at: 1 put: a2E1; at: 2 put: a2E2; at: 3 put: a2E3.
	(mat at: 3) at: 1 put: m2E4; at: 2 put: a2E3; at: 3 put: m2E2.
	mat := pAdotpE at: 3.
	(mat at: 1) at: 1 put: m2E3; at: 2 put: m2E4; at: 3 put: a2E1.
	(mat at: 2) at: 1 put: a2E4; at: 2 put: m2E3; at: 3 put: a2E2.
	(mat at: 3) at: 1 put: a2E1; at: 2 put: a2E2; at: 3 put: a2E3.
	mat := pAdotpE at: 4.
	(mat at: 1) at: 1 put: a2E4; at: 2 put: m2E3; at: 3 put: a2E2.
	(mat at: 2) at: 1 put: a2E3; at: 2 put: a2E4; at: 3 put: m2E1.
	(mat at: 3) at: 1 put: m2E2; at: 2 put: a2E1; at: 3 put: a2E4
]

{ #category : #accessing }
MbDEulerParametersDot >> dAdt [
	^aAdot
]

{ #category : #'initialize-release' }
MbDEulerParametersDot >> fromqEOp: qEOp andOmegaOpO: omeOpO [ 
	| aB |
	qEOp calcABC.
	aB := qEOp aB.
	self equalFullColumn: (aB transposeTimesFullColumn: (omeOpO times: 0.5d)).
	self qE: qEOp.
	self calc
]

{ #category : #'initialize-release' }
MbDEulerParametersDot >> fromqEOp: qEOp andOmegaOpp: omeOpp [ 
	| aC |
	qEOp calcABC.
	aC := qEOp aC.
	self equalFullColumn: (aC transposeTimesFullColumn: (omeOpp times: 0.5d)).
	self qE: qEOp.
	self calc
]

{ #category : #'initialize-release' }
MbDEulerParametersDot >> initialize [
	super initialize.
	pAdotpE := FullColumn new: 4.
	1 to: 4 do: [:i | pAdotpE at: i put: (FullMatrix new: 3 by: 3)]
]

{ #category : #accessing }
MbDEulerParametersDot >> omeOpO [
	^(self aB timesFullColumn: self)
		times: 2.0d
]

{ #category : #accessing }
MbDEulerParametersDot >> pAdotpE [
	^pAdotpE
]

{ #category : #accessing }
MbDEulerParametersDot >> pomeOpOpE [
	^(MbDEulerParameters pBpEtimesColumn: self)
		times: 2.0d
]

{ #category : #accessing }
MbDEulerParametersDot >> pomeOpOpEdot [
	^self aB times: 2.0d
]

{ #category : #accessing }
MbDEulerParametersDot >> qE: eulerParameters [ 
	qE := eulerParameters
]

{ #category : #'ops on self' }
MbDEulerParametersDot >> zeroSelf [
	super zeroSelf.
	self calc
]
