Class {
	#name : #EulerParametersDot,
	#superclass : #EulerArray,
	#type : #variable,
	#instVars : [
		'qE',
		'aAdot',
		'aBdot',
		'aCdot'
	],
	#category : #'StCAD-Math-StMathArray'
}

{ #category : #accessing }
EulerParametersDot >> aA [
	^qE aA
]

{ #category : #accessing }
EulerParametersDot >> aAdot [
	^aAdot
]

{ #category : #accessing }
EulerParametersDot >> aB [
	^qE aB
]

{ #category : #accessing }
EulerParametersDot >> aBdot [
	^aBdot
]

{ #category : #accessing }
EulerParametersDot >> aC [
	^qE aC
]

{ #category : #accessing }
EulerParametersDot >> aCdot [
	^aCdot
]

{ #category : #calc }
EulerParametersDot >> calc [
	qE calc.
	self calcAdotBdotCdot
]

{ #category : #calc }
EulerParametersDot >> calcAdotBdotCdot [
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
EulerParametersDot >> calcSymbolic [
	qE calcSymbolic.
	self calcSymbolicAdotBdotCdot
]

{ #category : #calc }
EulerParametersDot >> calcSymbolicAdotBdotCdot [
	"aAdot, aBdot and aCdot are all calculated together and only here."

	| aE1dot aE2dot aE3dot aE4dot mE1dot mE2dot mE3dot |
	aE1dot := self at: 1.
	aE2dot := self at: 2.
	aE3dot := self at: 3.
	aE4dot := self at: 4.
	mE1dot := aE1dot negated.
	mE2dot := aE2dot negated.
	mE3dot := aE3dot negated.
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
	aAdot := (self aB timesFullMatrix: aCdot transpose) times: 2.0d
]

{ #category : #accessing }
EulerParametersDot >> dAdt [
	^aAdot
]

{ #category : #calc }
EulerParametersDot >> differentiateWRT: var [ 
	| answer |
	answer := EulerParametersDDot with: self.
	1 to: 4
		do: 
			[:i | 
			| angleVel angleAcc |
			angleVel := self at: i.
			angleAcc := (angleVel differentiateWRT: var) simplified.
			answer at: i put: angleAcc].
	^answer
]

{ #category : #'initialize-release' }
EulerParametersDot >> fromqEOp: qEOp andOmegaOpO: omeOpO [ 
	| aB |
	qEOp calcABC.
	aB := qEOp aB.
	self equalFullColumn: (aB transposeTimesFullColumn: (omeOpO times: 0.5d)).
	self qE: qEOp.
	self calc
]

{ #category : #'initialize-release' }
EulerParametersDot >> fromqEOp: qEOp andOmegaOpp: omeOpp [ 
	| aC |
	qEOp calcABC.
	aC := qEOp aC.
	self equalFullColumn: (aC transposeTimesFullColumn: (omeOpp times: 0.5d)).
	self qE: qEOp.
	self calc
]

{ #category : #'initialize-release' }
EulerParametersDot >> initialize [
	aAdot := FullMatrix new: 3 by: 3.
	aBdot := FullMatrix new: 3 by: 4.
	aCdot := FullMatrix new: 3 by: 4.
]

{ #category : #'initialize-release' }
EulerParametersDot >> initialize: aEulerParameters [ 
	self initialize.
	qE := aEulerParameters
]

{ #category : #accessing }
EulerParametersDot >> omeF [
	^(self aB timesFullColumn: self) times: 2.0d
]

{ #category : #accessing }
EulerParametersDot >> omeOpO [
	^(self aB timesFullColumn: self)
		times: 2.0d
]

{ #category : #accessing }
EulerParametersDot >> qE: eulerParameters [ 
	qE := eulerParameters
]

{ #category : #'basic ops' }
EulerParametersDot >> simplified [
	| answer |
	answer := super simplified.
	answer initialize: qE.
	^answer
]

{ #category : #'ops on self' }
EulerParametersDot >> zeroSelf [
	super zeroSelf.
	self calc
]
