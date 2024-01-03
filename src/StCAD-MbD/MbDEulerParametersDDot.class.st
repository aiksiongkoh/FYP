Class {
	#name : #MbDEulerParametersDDot,
	#superclass : #EulerParametersDDot,
	#type : #variable,
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #accessing }
MbDEulerParametersDDot >> aA [
	^qEdot aA
]

{ #category : #accessing }
MbDEulerParametersDDot >> aAddot [
	^aAddot
]

{ #category : #accessing }
MbDEulerParametersDDot >> aAdot [
	^qEdot aAdot
]

{ #category : #accessing }
MbDEulerParametersDDot >> aB [
	^qEdot aB
]

{ #category : #accessing }
MbDEulerParametersDDot >> aBddot [
	^aBddot
]

{ #category : #accessing }
MbDEulerParametersDDot >> aBdot [
	^qEdot aBdot
]

{ #category : #accessing }
MbDEulerParametersDDot >> aC [
	^qEdot aC
]

{ #category : #accessing }
MbDEulerParametersDDot >> aCddot [
	^aCddot
]

{ #category : #accessing }
MbDEulerParametersDDot >> aCdot [
	^qEdot aCdot
]

{ #category : #accessing }
MbDEulerParametersDDot >> alpOpO [
	^(self aBdot timesFullColumn: qEdot) + (self aB timesFullColumn: self) 
		times: 2.0d
]

{ #category : #calc }
MbDEulerParametersDDot >> calc [
	qEdot calc.
	self calcAddotBddotCddot
]

{ #category : #calc }
MbDEulerParametersDDot >> calcAddotBddotCddot [
	"aAddot, aBddot and aCddot are all calculated together and only here.

	aA := aB*aCT.
	aAdot := aBdot*aCT + aB*aCTdot
	Since  aBdot*aCT = aB*aCTdot (prove by direct evaluation).
	Therefore, aAdot := 2*aBdot*aCT := 2*aB*aCTdot.
	aAddot := 2*aBdot*aCTdot + 2*aB*aCTddot.
	"

	| aE1ddot aE2ddot aE3ddot aE4ddot mE1ddot mE2ddot mE3ddot |
	aE1ddot := self at: 1.
	aE2ddot := self at: 2.
	aE3ddot := self at: 3.
	aE4ddot := self at: 4.
	mE1ddot := 0.0d - aE1ddot.
	mE2ddot := 0.0d - aE2ddot.
	mE3ddot := 0.0d - aE3ddot.
	(aBddot at: 1)
		at: 1 put: aE4ddot;
		at: 2 put: mE3ddot;
		at: 3 put: aE2ddot;
		at: 4 put: mE1ddot.
	(aBddot at: 2)
		at: 1 put: aE3ddot;
		at: 2 put: aE4ddot;
		at: 3 put: mE1ddot;
		at: 4 put: mE2ddot.
	(aBddot at: 3)
		at: 1 put: mE2ddot;
		at: 2 put: aE1ddot;
		at: 3 put: aE4ddot;
		at: 4 put: mE3ddot.
	(aCddot at: 1)
		at: 1 put: aE4ddot;
		at: 2 put: aE3ddot;
		at: 3 put: mE2ddot;
		at: 4 put: mE1ddot.
	(aCddot at: 2)
		at: 1 put: mE3ddot;
		at: 2 put: aE4ddot;
		at: 3 put: aE1ddot;
		at: 4 put: mE2ddot.
	(aCddot at: 3)
		at: 1 put: aE2ddot;
		at: 2 put: mE1ddot;
		at: 3 put: aE4ddot;
		at: 4 put: mE3ddot.
	aAddot := (self aBdot timesTransposeFullMatrix: self aCdot) 
				+ (self aB timesTransposeFullMatrix: aCddot) times: 2.0d
]

{ #category : #accessing }
MbDEulerParametersDDot >> fromqEdot: aqEdot qEddot: qEddot [ 
	qEdot := aqEdot.
	1 to: 4 do: [:i | self at: i put: (qEddot at: i)]
]

{ #category : #'initialize-release' }
MbDEulerParametersDDot >> initialize [
	aAddot := FullMatrix new: 3 by: 3.
	aBddot := FullMatrix new: 3 by: 4.
	aCddot := FullMatrix new: 3 by: 4
]

{ #category : #accessing }
MbDEulerParametersDDot >> qEdot: aMbDEulerParametersDot [ 
	qEdot := aMbDEulerParametersDot
]

{ #category : #'ops on self' }
MbDEulerParametersDDot >> zeroSelf [
	super zeroSelf.
	self calc
]
