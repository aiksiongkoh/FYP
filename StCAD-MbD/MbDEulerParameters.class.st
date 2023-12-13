Class {
	#name : #MbDEulerParameters,
	#superclass : #EulerParameters,
	#type : #variable,
	#instVars : [
		'pApE'
	],
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #'instance creation' }
MbDEulerParameters class >> from: vector [ 
	^(super from: vector) initialize
]

{ #category : #'instance creation' }
MbDEulerParameters class >> fromA: anObject [ 
	^anObject isIdentity
		ifTrue: [self
				with: 0.0d
				with: 0.0d
				with: 0.0d
				with: 1.0d]
		ifFalse: 
			[| aA |
			aA := self rotationMatrixClass from: anObject.
			aA mbdEulerParameters]
]

{ #category : #'instance creation' }
MbDEulerParameters class >> new [
	^(super new: 4) initialize
]

{ #category : #calc }
MbDEulerParameters class >> pBTpEtimesColumn: col [ 
	"col size = 3."

	| c1 c2 c3 mc1 mc2 mc3 answer row1 row2 row3 row4 |
	c1 := (col at: 1).
	c2 := (col at: 2).
	c3 := (col at: 3).
	mc1 := 0.0d - c1.
	mc2 := 0.0d - c2.
	mc3 := 0.0d - c3.
	answer := FullMatrix new: 4 by: 4.
	row1 := answer at: 1.
	row2 := answer at: 2.
	row3 := answer at: 3.
	row4 := answer at: 4.
	row1 at: 1 put: 0.0d; at: 2 put: mc3; at: 3 put: c2; at: 4 put: c1.
	row2 at: 1 put: c3; at: 2 put: 0.0d; at: 3 put: mc1; at: 4 put: c2.
	row3 at: 1 put: mc2; at: 2 put: c1; at: 3 put: 0.0d; at: 4 put: c3.
	row4 at: 1 put: mc1; at: 2 put: mc2; at: 3 put: mc3; at: 4 put: 0.0d.
	^answer
]

{ #category : #calc }
MbDEulerParameters class >> pBpEtimesColumn: col [ 
	"col size = 4."

	| c1 c2 c3 mc1 mc2 mc3 mc4 answer row1 row2 row3 |
	c1 := col at: 1.
	c2 := col at: 2.
	c3 := col at: 3.
	mc1 := 0.0d - c1.
	mc2 := 0.0d - c2.
	mc3 := 0.0d - c3.
	mc4 := 0.0d - (col at: 4).
	answer := FullMatrix new: 3 by: 4.
	row1 := answer at: 1.
	row2 := answer at: 2.
	row3 := answer at: 3.
	row1 at: 1 put: mc4; at: 2 put: c3; at: 3 put: mc2; at: 4 put: c1.
	row2 at: 1 put: mc3; at: 2 put: mc4; at: 3 put: c1; at: 4 put: c2.
	row3 at: 1 put: c2; at: 2 put: mc1; at: 3 put: mc4; at: 4 put: c3.
	^answer
]

{ #category : #calc }
MbDEulerParameters class >> pCTpEtimesColumn: col [ 
	"col size = 3."

	| c1 c2 c3 mc1 mc2 mc3 answer row1 row2 row3 row4 |
	c1 := col at: 1.
	c2 := col at: 2.
	c3 := col at: 3.
	mc1 := 0.0d - c1.
	mc2 := 0.0d - c2.
	mc3 := 0.0d - c3.
	answer := FullMatrix new: 4 by: 4.
	row1 := answer at: 1.
	row2 := answer at: 2.
	row3 := answer at: 3.
	row4 := answer at: 4.
	row1 at: 1 put: 0.0d; at: 2 put: c3; at: 3 put: mc2; at: 4 put: c1.
	row2 at: 1 put: mc3; at: 2 put: 0.0d; at: 3 put: c1; at: 4 put: c2.
	row3 at: 1 put: c2; at: 2 put: mc1; at: 3 put: 0.0d; at: 4 put: c3.
	row4 at: 1 put: mc1; at: 2 put: mc2; at: 3 put: mc3; at: 4 put: 0.0d.
	^answer
]

{ #category : #calc }
MbDEulerParameters class >> pCpEtimesColumn: col [ 
	"col size = 4."

	| c1 c2 c3 mc1 mc2 mc3 mc4 answer row1 row2 row3 |
	c1 := col at: 1.
	c2 := col at: 2.
	c3 := col at: 3.
	mc1 := 0.0d - c1.
	mc2 := 0.0d - c2.
	mc3 := 0.0d - c3.
	mc4 := 0.0d - (col at: 4).
	answer := FullMatrix new: 3 by: 4.
	row1 := answer at: 1.
	row2 := answer at: 2.
	row3 := answer at: 3.
	row1 at: 1 put: mc4; at: 2 put: mc3; at: 3 put: c2; at: 4 put: c1.
	row2 at: 1 put: c3; at: 2 put: mc4; at: 3 put: mc1; at: 4 put: c2.
	row3 at: 1 put: mc2; at: 2 put: c1; at: 3 put: mc4; at: 4 put: c3.
	^answer
]

{ #category : #calc }
MbDEulerParameters class >> ppApEpEtimesColumn: col [ 
	| a2c1 a2c2 a2c3 m2c1 m2c2 m2c3 answer col11 col12 col13 col14 col22 col23 col24 col33 col34 col44 |
	a2c1 := 2.0d * (col at: 1).
	a2c2 := 2.0d * (col at: 2).
	a2c3 := 2.0d * (col at: 3).
	m2c1 := 0.0d - a2c1.
	m2c2 := 0.0d - a2c2.
	m2c3 := 0.0d - a2c3.
	answer := FullMatrix new: 4 by: 4.
	col11 := FullColumn with: a2c1 with: m2c2 with: m2c3.
	col12 := FullColumn with: a2c2 with: a2c1 with: 0.0d.
	col13 := FullColumn with: a2c3 with: 0.0d with: a2c1.
	col14 := FullColumn with: 0.0d with: m2c3 with: a2c2.
	col22 := FullColumn with: m2c1 with: a2c2 with: m2c3.
	col23 := FullColumn with: 0.0d with: a2c3 with: a2c2.
	col24 := FullColumn with: a2c3 with: 0.0d with: m2c1.
	col33 := FullColumn with: m2c1 with: m2c2 with: a2c3.
	col34 := FullColumn with: m2c2 with: a2c1 with: 0.0d.
	col44 := FullColumn with: a2c1 with: a2c2 with: a2c3.
	(answer at: 1) at: 1 put: col11; at: 2 put: col12; at: 3 put: col13; at: 4 put: col14.
	(answer at: 2) at: 1 put: col12; at: 2 put: col22; at: 3 put: col23; at: 4 put: col24.
	(answer at: 3) at: 1 put: col13; at: 2 put: col23; at: 3 put: col33; at: 4 put: col34.
	(answer at: 4) at: 1 put: col14; at: 2 put: col24; at: 3 put: col34; at: 4 put: col44.
	^answer
]

{ #category : #calc }
MbDEulerParameters class >> ppApEpEtimesMatrix: mat [ 
	| a2m1 a2m2 a2m3 m2m1 m2m2 m2m3 answer mat11 mat12 mat13 mat14 mat22 mat23 mat24 mat33 mat34 mat44 zero |
	a2m1 := (mat at: 1) times: 2.0d.
	a2m2 := (mat at: 2) times: 2.0d.
	a2m3 := (mat at: 3) times: 2.0d.
	m2m1 := a2m1 negated.
	m2m2 := a2m2 negated.
	m2m3 := a2m3 negated.
	zero := (FullRow zero: 3).
	answer := FullMatrix new: 4 by: 4.
	mat11 := FullMatrix with: a2m1 with: m2m2 with: m2m3.
	mat12 := FullMatrix with: a2m2 with: a2m1 with: zero.
	mat13 := FullMatrix with: a2m3 with: zero with: a2m1.
	mat14 := FullMatrix with: zero with: m2m3 with: a2m2.
	mat22 := FullMatrix with: m2m1 with: a2m2 with: m2m3.
	mat23 := FullMatrix with: zero with: a2m3 with: a2m2.
	mat24 := FullMatrix with: a2m3 with: zero with: m2m1.
	mat33 := FullMatrix with: m2m1 with: m2m2 with: a2m3.
	mat34 := FullMatrix with: m2m2 with: a2m1 with: zero.
	mat44 := FullMatrix with: a2m1 with: a2m2 with: a2m3.
	(answer at: 1) at: 1 put: mat11; at: 2 put: mat12; at: 3 put: mat13; at: 4 put: mat14.
	(answer at: 2) at: 1 put: mat12; at: 2 put: mat22; at: 3 put: mat23; at: 4 put: mat24.
	(answer at: 3) at: 1 put: mat13; at: 2 put: mat23; at: 3 put: mat33; at: 4 put: mat34.
	(answer at: 4) at: 1 put: mat14; at: 2 put: mat24; at: 3 put: mat34; at: 4 put: mat44.
	^answer
]

{ #category : #calc }
MbDEulerParameters class >> ppArow1pEpEtimesColumn: col [ 
	| a2c1 a2c2 a2c3 m2c1 m2c2 answer |
	a2c1 := 2.0d * (col at: 1).
	a2c2 := 2.0d * (col at: 2).
	a2c3 := 2.0d * (col at: 3).
	m2c1 := 0.0d - a2c1.
	m2c2 := 0.0d - a2c2.
	answer := FullMatrix new: 4 by: 4.
	(answer at: 1) at: 1 put: a2c1; at: 2 put: a2c2; at: 3 put: a2c3; at: 4 put: 0.0d.
	(answer at: 2) at: 1 put: a2c2; at: 2 put: m2c1; at: 3 put: 0.0d; at: 4 put: a2c3.
	(answer at: 3) at: 1 put: a2c3; at: 2 put: 0.0d; at: 3 put: m2c1; at: 4 put: m2c2.
	(answer at: 4) at: 1 put: 0.0d; at: 2 put: a2c3; at: 3 put: m2c2; at: 4 put: a2c1.
	^answer
]

{ #category : #calc }
MbDEulerParameters class >> ppArow2pEpEtimesColumn: col [ 
	| a2c1 a2c2 a2c3 m2c2 m2c3 answer |
	a2c1 := 2.0d * (col at: 1).
	a2c2 := 2.0d * (col at: 2).
	a2c3 := 2.0d * (col at: 3).
	m2c2 := 0.0d - a2c2.
	m2c3 := 0.0d - a2c3.
	answer := FullMatrix new: 4 by: 4.
	(answer at: 1) at: 1 put: m2c2; at: 2 put: a2c1; at: 3 put: 0.0d; at: 4 put: m2c3.
	(answer at: 2) at: 1 put: a2c1; at: 2 put: a2c2; at: 3 put: a2c3; at: 4 put: 0.0d.
	(answer at: 3) at: 1 put: 0.0d; at: 2 put: a2c3; at: 3 put: m2c2; at: 4 put: a2c1.
	(answer at: 4) at: 1 put: m2c3; at: 2 put: 0.0d; at: 3 put: a2c1; at: 4 put: a2c2.
	^answer
]

{ #category : #calc }
MbDEulerParameters class >> ppArow3pEpEtimesColumn: col [ 
	| a2c1 a2c2 a2c3 m2c1 m2c3 answer |
	a2c1 := 2.0d * (col at: 1).
	a2c2 := 2.0d * (col at: 2).
	a2c3 := 2.0d * (col at: 3).
	m2c1 := 0.0d - a2c1.
	m2c3 := 0.0d - a2c3.
	answer := FullMatrix new: 4 by: 4.
	(answer at: 1) at: 1 put: m2c3; at: 2 put: 0.0d; at: 3 put: a2c1; at: 4 put: a2c2.
	(answer at: 2) at: 1 put: 0.0d; at: 2 put: m2c3; at: 3 put: a2c2; at: 4 put: m2c1.
	(answer at: 3) at: 1 put: a2c1; at: 2 put: a2c2; at: 3 put: a2c3; at: 4 put: 0.0.
	(answer at: 4) at: 1 put: a2c2; at: 2 put: m2c1; at: 3 put: 0.0d; at: 4 put: a2c3.
	^answer
]

{ #category : #'VisualWorks metadata' }
MbDEulerParameters class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
MbDEulerParameters class >> with: firstObject with: secondObject with: thirdObject with: fourthObject [ 
	^(super
		with: firstObject
		with: secondObject
		with: thirdObject
		with: fourthObject) initialize
]

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
