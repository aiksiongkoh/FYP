Class {
	#name : #MbDEulerParameters,
	#superclass : #EulerParameters,
	#type : #variable,
	#instVars : [
		'pApE'
	],
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #calc }
MbDEulerParameters >> calc [
	self calcABC.
	self calcpApE
]

{ #category : #calc }
MbDEulerParameters >> calcpApE [
	"pApE is a StMFullColumn of Matrices."

	| a2E1 a2E2 a2E3 a2E4 m2E1 m2E2 m2E3 m2E4 matrix |
	a2E1 := 2.0d * (self at: 1).
	a2E2 := 2.0d * (self at: 2).
	a2E3 := 2.0d * (self at: 3).
	a2E4 := 2.0d * (self at: 4).
	m2E1 := 0.0d - a2E1.
	m2E2 := 0.0d - a2E2.
	m2E3 := 0.0d - a2E3.
	m2E4 := 0.0d - a2E4.
	matrix := pApE at: 1.
	(matrix at: 1) at: 1 put: a2E1; at: 2 put: a2E2; at: 3 put: a2E3.
	(matrix at: 2) at: 1 put: a2E2; at: 2 put: m2E1; at: 3 put: m2E4.
	(matrix at: 3) at: 1 put: a2E3; at: 2 put: a2E4; at: 3 put: m2E1.
	matrix := pApE at: 2.
	(matrix at: 1) at: 1 put: m2E2; at: 2 put: a2E1; at: 3 put: a2E4.
	(matrix at: 2) at: 1 put: a2E1; at: 2 put: a2E2; at: 3 put: a2E3.
	(matrix at: 3) at: 1 put: m2E4; at: 2 put: a2E3; at: 3 put: m2E2.
	matrix := pApE at: 3.
	(matrix at: 1) at: 1 put: m2E3; at: 2 put: m2E4; at: 3 put: a2E1.
	(matrix at: 2) at: 1 put: a2E4; at: 2 put: m2E3; at: 3 put: a2E2.
	(matrix at: 3) at: 1 put: a2E1; at: 2 put: a2E2; at: 3 put: a2E3.
	matrix := pApE at: 4.
	(matrix at: 1) at: 1 put: a2E4; at: 2 put: m2E3; at: 3 put: a2E2.
	(matrix at: 2) at: 1 put: a2E3; at: 2 put: a2E4; at: 3 put: m2E1.
	(matrix at: 3) at: 1 put: m2E2; at: 2 put: a2E1; at: 3 put: a2E4
]

{ #category : #'initialize-release' }
MbDEulerParameters >> initialize [
	aA := FullMatrix new: 3 by: 3.
	aB := FullMatrix new: 3 by: 4.
	aC := FullMatrix new: 3 by: 4.
	pApE := FullColumn new: 4.
	1 to: 4 do: [:i | pApE at: i put: (FullMatrix new: 3 by: 3)]
]

{ #category : #accessing }
MbDEulerParameters >> pApE [
	^pApE
]
