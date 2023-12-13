"
Refer: Edward Haug's book and 91moment.doc

Define
rIJK = displacement from I to J in K components.

If a body is defined in the frame O.
rOpO := [xOpO yOpO zOpO]T
rOpOTilde := 	|	0 	-z	y	|
				|	z	0	-x	|
				|	-y	x	0	|OpO
Center of mass
rOcmO := integral(rOpO*dmass) / mass
Moment of inertia about the origin O and the frame O axes
aJOO := -integral(rOpOTilde*rOpOTilde*dmass)

New frame o
rOpO := rOoO + aAOo*ropo.
rocmO := rOcmO - rOoO := displacement from o frame origin to center of mass in O components.

From definition
aJOO := aAOo*aJoo*aAOoT - mass*(rOoOTilde*rOoOTilde + rOoOTilde*rocmOTilde + rocmOTilde*rOoOTilde)
Therefore
aJoo := aAOoT*[aJOO + mass*(rOoOTilde*rOoOTilde + rOoOTilde*rocmOTilde + rocmOTilde*rOoOTilde)]*aAOo

aJcmO is the aJ about the cm and the O axes.
This matrix is not valid after the calculation of aJpp.

aJpp is the aJ about the cm and the principal axes.
{IJK}O := [aAOp]{ijk}p

"
Class {
	#name : #GEOInertiaMatrixSolver,
	#superclass : #GEOItem,
	#instVars : [
		'm',
		'aJPP',
		'aJoo',
		'rPoP',
		'aAPo',
		'aJcmP',
		'aJcmPcopy',
		'rPcmP',
		'aJpp',
		'aAPp',
		'colOrder'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #examples }
GEOInertiaMatrixSolver class >> example1 [
	"GEOInertiaMatrixSolver example1."
	| aJpp rpPp axis aApP solver aJPP |
	self halt.
	aJpp := FullMatrix
				newWithElements: #(#(1.0d 0.0d 0.0d) #(0.0d 2.0d 0.0d) #(0.0d 0.0d 3.0d)).
	rpPp := FullColumn newWithElements: #(0.0d 0.0d 1.0d).
	axis := FullColumn newWithElements: #(0.0d 0.0d 1.0d).
	aApP := (GEOEulerParameters withAxis: axis normalizeSelf
				theta: 10.0d degreesToRadians) aA.
	solver := self new.
	solver m: 4.0d.
	solver aJPP: aJpp.
	solver rPoP: rpPp.
	solver aAPo: aApP.
	solver rPcmP: (FullColumn newWithElements: #(0.0d 0.0d 0.0d)).
	solver calc.
	aJPP := solver aJoo.
	Transcript
		cr;
		show: solver aJoo printString.
	Transcript
		cr;
		show: solver aJpp printString.
	Transcript
		cr;
		show: solver aAPp printString.
	Transcript
		cr;
		cr.
	solver m: 4.0d.
	solver aJPP: aJPP.
	solver rPoP: (aApP transpose timesFullColumn: rpPp negated).
	solver aAPo: aApP transpose.
	solver rPcmP: (aApP transpose timesFullColumn: rpPp negated).
	solver calc.
	Transcript
		cr;
		show: solver aJoo printString.
	Transcript
		cr;
		show: solver aJpp printString.
	Transcript
		cr;
		show: solver aAPp printString.
	Transcript
		cr;
		cr.
]

{ #category : #examples }
GEOInertiaMatrixSolver class >> example2 [
	"GEOInertiaMatrixSolver example2."
	| aJpp axis aAPp aJPP solver |
	self halt.
	aJpp := FullMatrix
				newWithElements: #(#(1.0d 0.0d 0.0d) #(0.0d 1.0d 0.0d) #(0.0d 0.0d 3.0d)).
	axis := FullColumn newWithElements: #(0.0d 1.0d 1.0d).
	aAPp := (GEOEulerParameters withAxis: axis normalizeSelf
				theta: 10.0d degreesToRadians) aA.
	aJPP := aAPp timesFullMatrix: (aJpp timesTransposeFullMatrix: aAPp).
	Transcript
		cr;
		show: aJpp printString.
	Transcript
		cr;
		show: aAPp printString.
	Transcript
		cr;
		show: aJPP printString.
	Transcript
		cr;
		cr.
	solver := self new.
	solver m: 4.0d.
	solver aJPP: aJPP.
	solver rPcmP: (FullColumn newWithElements: #(0.0d 0.0d 0.0d)).
	solver calc.
	Transcript
		cr;
		show: solver aJoo printString.
	Transcript
		cr;
		show: solver aJpp printString.
	Transcript
		cr;
		show: solver aAPp printString.
	Transcript
		cr;
		cr.
]

{ #category : #examples }
GEOInertiaMatrixSolver class >> example3 [
	"GEOInertiaMatrixSolver example3."
	| aJpp axis aAPp aJPP solver |
	self halt.
	aJpp := FullMatrix
				newWithElements: #(#(1.0d 0.0d 0.0d) #(0.0d 2.0d 0.0d) #(0.0d 0.0d 3.0d)).
	axis := FullColumn newWithElements: #(1.0d 1.0d 1.0d).
	aAPp := (GEOEulerParameters withAxis: axis normalizeSelf
				theta: 10.0d degreesToRadians) aA.
	aJPP := aAPp timesFullMatrix: (aJpp timesTransposeFullMatrix: aAPp).
	Transcript
		cr;
		show: aJpp printString.
	Transcript
		cr;
		show: aAPp printString.
	Transcript
		cr;
		show: aJPP printString.
	Transcript
		cr;
		cr.
	solver := self new.
	solver m: 4.0d.
	solver aJPP: aJPP.
	solver rPcmP: (FullColumn newWithElements: #(0.0d 0.0d 0.0d)).
	solver calc.
	Transcript
		cr;
		show: solver aJoo printString.
	Transcript
		cr;
		show: solver aJpp printString.
	Transcript
		cr;
		show: solver aAPp printString.
	Transcript
		cr;
		cr.
]

{ #category : #examples }
GEOInertiaMatrixSolver class >> example4 [
	"GEOInertiaMatrixSolver example4."

	| m rPcmP aJPP11 aJPP22 aJPP33 aJPP12 aJPP13 aJPP23 aJPP solver |
	m := 2713.531d.
	rPcmP := FullColumn newWithElements: #(0.0d 0.0d 0.0d).
	aJPP11 := 1389797.0d.
	aJPP22 := 1490705.0d.
	aJPP33 := 619300.5d.
	aJPP12 := -4.260535d negated.
	aJPP13 := 13373.71d negated.
	aJPP23 := -1702.788d negated.
	aJPP := FullMatrix new: 3 by: 3.
	aJPP at: 1 and: 1 put: aJPP11.
	aJPP at: 2 and: 2 put: aJPP22.
	aJPP at: 3 and: 3 put: aJPP33.
	aJPP at: 1 and: 2 put: aJPP12.
	aJPP at: 1 and: 3 put: aJPP13.
	aJPP at: 2 and: 3 put: aJPP23.
	aJPP symLowerWithUpper.
	solver := self new.
	solver m: m.
	solver aJPP: aJPP.
	solver rPcmP: rPcmP.
	solver calc.
	Transcript cr.
	Transcript cr; show: solver aJoo printString.
	Transcript cr; show: solver aJpp printString.
	Transcript cr; show: solver aAPp printString
]

{ #category : #examples }
GEOInertiaMatrixSolver class >> example5 [
	"GEOInertiaMatrixSolver example5."

	| m rPcmP aJPP solver |
	m := 457.05379d.
	rPcmP := FullColumn newWithElements: #(0.0d 0.0d 0.0d).
	aJPP := FullMatrix 
				newWithElements: #(#(1128329.43969d 16882.44555d -158980.98945d) #(16882.44555d 734228.30079d 29890.07784d) #(-158980.98945d 29890.07784d 1077924.0558d)).
	solver := self new.
	solver m: m.
	solver aJPP: aJPP.
	solver rPcmP: rPcmP.
	solver calc.
	Transcript cr; show: solver aJoo printString.
	Transcript cr; show: solver aJpp printString.
	Transcript cr; show: solver aAPp printString.
]

{ #category : #examples }
GEOInertiaMatrixSolver class >> example6 [
	"GEOInertiaMatrixSolver example6."

	"
	Point mass1:
		mass := 1 kg.
		rPpP := (2,1,0).
	Point mass2:
		mass := 1 kg.
		rPpP := (-2,-1,0).
	"

	| m rPcmP aJPP solver |
	m := 2.0d.
	rPcmP := FullColumn newWithElements: #(0.0d 0.0d 0.0d).
	aJPP := FullMatrix 
				newWithElements: #(#(2.0d -4.0d 0.0d) #(-4.0d 8.0d 0.0d) #(0.0d 0.0d 10.0d)).
	solver := self new.
	solver m: m.
	solver aJPP: aJPP.
	solver rPcmP: rPcmP.
	solver calc.
	Transcript
		cr;
		show: solver aJoo printString.
	Transcript
		cr;
		show: solver aJpp printString.
	Transcript
		cr;
		show: solver aAPp printString
]

{ #category : #'VisualWorks metadata' }
GEOInertiaMatrixSolver class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOInertiaMatrixSolver >> aAPo: mat [ 
	aAPo := mat
]

{ #category : #accessing }
GEOInertiaMatrixSolver >> aAPp [
	^aAPp
]

{ #category : #accessing }
GEOInertiaMatrixSolver >> aJPP: mat [ 
	aJPP := mat
]

{ #category : #accessing }
GEOInertiaMatrixSolver >> aJoo [
	^aJoo
]

{ #category : #accessing }
GEOInertiaMatrixSolver >> aJpp [
	^aJpp
]

{ #category : #calc }
GEOInertiaMatrixSolver >> calc [
	self calcJoo.
	self calcJpp.
	self calcAPp
]

{ #category : #calc }
GEOInertiaMatrixSolver >> calcAPp [
	| lam1 lam2 lam3 eigenvector2 eigenvector3 eigenvector1 |
	lam1 := aJpp at: 1.
	lam2 := aJpp at: 2.
	lam3 := aJpp at: 3.
	lam1 = lam2
		ifTrue: [lam2 = lam3
				ifTrue: [^aAPp := (FullMatrix identity: 3)]
				ifFalse: 
					[eigenvector2 := self eigenvectorFor: lam2.
					eigenvector3 := self eigenvectorFor: lam3.
					eigenvector2 normalizeSelf.
					eigenvector3 normalizeSelf.
					(eigenvector2 at: 2)
						< 0.0d ifTrue: [eigenvector2 negateSelf].
					(eigenvector3 at: 3)
						< 0.0d ifTrue: [eigenvector3 negateSelf].
					eigenvector1 := eigenvector2 cross: eigenvector3]]
		ifFalse: 
			[eigenvector1 := self eigenvectorFor: lam1.
			eigenvector2 := self eigenvectorFor: lam2.
			eigenvector1 normalizeSelf.
			eigenvector2 normalizeSelf.
			(eigenvector1 at: 1)
				< 0.0d ifTrue: [eigenvector1 negateSelf].
			(eigenvector2 at: 2)
				< 0.0d ifTrue: [eigenvector2 negateSelf].
			eigenvector3 := eigenvector1 cross: eigenvector2].
	aAPp := FullMatrix new: 3 by: 3.
	aAPp
		at: 1
		and: 1
		putFullColumn: eigenvector1.
	aAPp
		at: 1
		and: 2
		putFullColumn: eigenvector2.
	aAPp
		at: 1
		and: 3
		putFullColumn: eigenvector3
]

{ #category : #calc }
GEOInertiaMatrixSolver >> calcJoo [
	"aJoo := aAPoT*[aJPP + mass*(rPoPTilde*rPoPTilde + rPoPTilde*rocmPTilde + 
	rocmPTilde*rPoPTilde)]*aAPo"

	| rocmPtilde rPoPtilde term1 term21 term22 term23 term2 |
	rPoP isNil
		ifTrue: 
			[rPoP := rPcmP.
			aAPo := (FullMatrix identity: 3)].
	rocmPtilde := (rPcmP - rPoP) tildeMatrix.
	rPoPtilde := rPoP tildeMatrix.
	term1 := aJPP.
	term21 := rPoPtilde timesFullMatrix: rPoPtilde.
	term22 := rPoPtilde timesFullMatrix: rocmPtilde.
	term23 := term22 transpose.
	term2 := term21 + term22 + term23 times: m.
	aJoo := (aAPo transpose timesFullMatrix: (term1 plusFullMatrix: term2))
				timesFullMatrix: aAPo.
	aJoo symLowerWithUpper.
	aJoo conditionSelfWithTol: aJoo maxElement * 1.0d-6
]

{ #category : #calc }
GEOInertiaMatrixSolver >> calcJpp [
	"aJcmP := aJPP + mass*(rPcmPTilde*rPcmPTilde)"

	| rPcmPtilde |
	rPcmPtilde := rPcmP tildeMatrix.
	aJcmP := aJPP + ((rPcmPtilde timesFullMatrix: rPcmPtilde)
					times: m).
	aJcmP symLowerWithUpper.
	aJcmP conditionSelfWithTol: aJcmP maxElement * 1.0d-6.
	aJcmP isDiagonal
		ifTrue: [self calcJppFromDiagJcmP]
		ifFalse: [self calcJppFromFullJcmP]
]

{ #category : #calc }
GEOInertiaMatrixSolver >> calcJppFromDiagJcmP [
	"Eigenvalues are orders from smallest to largest."

	| sortedJ lam1 lam2 lam3 average |
	sortedJ := SortedCollection new.
	sortedJ add: (aJcmP at: 1 and: 1).
	sortedJ add: (aJcmP at: 2 and: 2).
	sortedJ add: (aJcmP at: 3 and: 3).
	lam1 := sortedJ at: 1.
	lam2 := sortedJ at: 2.
	lam3 := sortedJ at: 3.
	(lam2 = 0 or: [(lam1 / lam2 - 1.0d) abs < 1.0d-6])
		ifTrue: [(lam3 = 0 or: [(lam2 / lam3 - 1.0d) abs < 1.0d-6])
				ifTrue: 
					["All are equal."
					average := lam1 + lam2 + lam3 / 3.0d.
					lam1 := average.
					lam2 := average.
					lam3 := average]
				ifFalse: 
					["lam1 = lam2"
					average := lam1 + lam2 / 2.0d.
					lam1 := average.
					lam2 := average]]
		ifFalse: [(lam2 / lam3 - 1.0d) abs < 1.0d-6
				ifTrue: 
					["lam2 = lam3"
					average := lam2 + lam3 / 2.0d.
					lam2 := average.
					lam3 := average]].
	aJpp := DiagonalMatrix
				with: lam1
				with: lam2
				with: lam3
]

{ #category : #calc }
GEOInertiaMatrixSolver >> calcJppFromFullJcmP [
	"Eigenvalues are orders from smallest to largest."
	"Rounding error can be significant."
	"e.g. (diag 100.0d 100.0d 1.0d) gives only 8 digit accuracy."

	| a11 a12 a13 a22 a23 a33 a b c aDiv3 p q phiDiv3 twoSqrtMinusp piDiv3 sortedJ lam1 lam2 lam3 average |
	a11 := aJcmP at: 1 and: 1.
	a12 := aJcmP at: 1 and: 2.
	a13 := aJcmP at: 1 and: 3.
	a22 := aJcmP at: 2 and: 2.
	a23 := aJcmP at: 2 and: 3.
	a33 := aJcmP at: 3 and: 3.
	a := (a11 + a22 + a33) negated.
	b := a11 * a22 + (a11 * a33) + (a22 * a33) - (a12 * a12) - (a13 * a13) - (a23 * a23).
	c := a11 * a23 * a23 + (a22 * a13 * a13) + (a33 * a12 * a12) - (a11 * a22 * a33) - (2.0d * a12 * a13 * a23).
	aDiv3 := a / 3.0d.
	p := b / 3.0d - (aDiv3 * aDiv3).
	q := c + (2.0d * aDiv3 * aDiv3 * aDiv3) - (aDiv3 * b) / 2.0d.
	phiDiv3 := (q negated / (p * p * p) negated sqrt) modifiedArcCos / 3.0d.
	twoSqrtMinusp := 2.0d * p negated sqrt.
	piDiv3 := Double pi / 3.0d.
	sortedJ := SortedCollection new.
	sortedJ add: twoSqrtMinusp * phiDiv3 cos.
	sortedJ add: twoSqrtMinusp * (phiDiv3 + piDiv3) cos negated.
	sortedJ add: twoSqrtMinusp * (phiDiv3 - piDiv3) cos negated.
	lam1 := (sortedJ at: 1)
				- aDiv3.
	lam2 := (sortedJ at: 2)
				- aDiv3.
	lam3 := (sortedJ at: 3)
				- aDiv3.
	(lam2 = 0 or: [(lam1 / lam2 - 1.0d) abs < 1.0d-6])
		ifTrue: [(lam3 = 0 or: [(lam2 / lam3 - 1.0d) abs < 1.0d-6])
				ifTrue: 
					["All are equal."
					average := lam1 + lam2 + lam3 / 3.0d.
					lam1 := average.
					lam2 := average.
					lam3 := average]
				ifFalse: 
					["lam1 = lam2"
					average := lam1 + lam2 / 2.0d.
					lam1 := average.
					lam2 := average]]
		ifFalse: [(lam2 / lam3 - 1.0d) abs < 1.0d-6
				ifTrue: 
					["lam2 = lam3"
					average := lam2 + lam3 / 2.0d.
					lam2 := average.
					lam3 := average]].
	aJpp := DiagonalMatrix
				with: lam1
				with: lam2
				with: lam3
]

{ #category : #calc }
GEOInertiaMatrixSolver >> doFullPivoting: p [ 
	| max pivotRow pivotCol rowi aij mag |
	max := 0.
	pivotRow := p.
	pivotCol := p.
	p to: 3
		do: 
			[:i | 
			rowi := aJcmPcopy at: i.
			p to: 3
				do: 
					[:j | 
					aij := rowi at: j.
					aij = 0
						ifFalse: 
							[mag := aij.
							mag < 0 ifTrue: [mag := mag negated].
							mag > max
								ifTrue: 
									[max := mag.
									pivotRow := i.
									pivotCol := j]]]].
	p == pivotRow ifFalse: [aJcmPcopy swap: p with: pivotRow].
	p == pivotCol
		ifFalse: 
			[aJcmPcopy do: [:row | row swap: p with: pivotCol].
			colOrder swap: p with: pivotCol]
]

{ #category : #calc }
GEOInertiaMatrixSolver >> eigenvectorFor: lam [ 
	"[aJcmP] - lam[I]."

	| eigenvector row1 row2 row3 norm1 e3 e2 e1 dum |
	aJcmPcopy := aJcmP copy.
	colOrder := FullColumn new: 3.
	eigenvector := FullColumn new: 3.
	1 to: 3
		do: 
			[:i | 
			colOrder at: i put: i.
			aJcmPcopy
				at: i
				and: i
				minusNumber: lam].
	1 to: 3
		do: 
			[:p | 
			self doFullPivoting: p.
			self forwardEliminateWithPivot: p].
	row1 := aJcmPcopy at: 1.
	row2 := aJcmPcopy at: 2.
	row3 := aJcmPcopy at: 3.
	norm1 := row1 length.
	row3 length / norm1 > 1.0d-5 ifTrue: [self error: '3rd row should be very small.'].
	row2 length / norm1 > 1.0d-5
		ifTrue: 
			[e3 := 1.0d.
			e2 := e3 * (row2 at: 3) negated / (row2 at: 2).
			e1 := (e2 * (row1 at: 2) + (e3 * (row1 at: 3))) negated / (row1 at: 1)]
		ifFalse: 
			["Repeated roots."
			e3 := 1.0d.
			e2 := 0.0d.
			e1 := (e2 * (row1 at: 2) + (e3 * (row1 at: 3))) negated / (row1 at: 1)].
	dum := FullColumn
				with: e1
				with: e2
				with: e3.
	1 to: 3 do: [:i | eigenvector at: (colOrder at: i)
			put: (dum at: i)].
	^eigenvector
]

{ #category : #calc }
GEOInertiaMatrixSolver >> forwardEliminateWithPivot: p [ 
	| rowp app rowi aip factor |
	rowp := aJcmPcopy at: p.
	app := rowp at: p.
	p + 1 to: 3
		do: 
			[:i | 
			rowi := aJcmPcopy at: i.
			aip := rowi at: p.
			aip = 0
				ifFalse: 
					[rowi at: p put: 0.0d.
					factor := aip / app.
					p + 1 to: 3 do: [:j | rowi at: j minusNumber: factor * (rowp at: j)]]]
]

{ #category : #'initialize-release' }
GEOInertiaMatrixSolver >> initialize [
	"Do nothing."
]

{ #category : #accessing }
GEOInertiaMatrixSolver >> m: double [ 
	m := double
]

{ #category : #calc }
GEOInertiaMatrixSolver >> momentsFrom: array [ 
	| I1 x1mx2 d a2x1expy2 b y12expy22 c Ix x1expy2 a n2dexpy2 x1expy22 Iy y13expy23 Iz d2 b2 a2 c2 Ixx x13expy2 x12expy22 Iyy y14expy24 x1expy23 Izz d3 b3 a3 c3 Ixy Ixz Iyz y1py2 answer |
	a := array at: 1.
	b := array at: 2.
	c := array at: 3.
	d := array at: 4.
	x1mx2 := array at: 5.
	y1py2 := array at: 6.
	a2 := array at: 7.
	b2 := array at: 8.
	c2 := array at: 9.
	d2 := array at: 10.
	x1expy22 := array at: 11.
	a2x1expy2 := array at: 12.
	y12expy22 := array at: 13.
	x1expy2 := array at: 14.
	a3 := array at: 15.
	b3 := array at: 16.
	c3 := array at: 17.
	d3 := array at: 18.
	y13expy23 := array at: 19.
	n2dexpy2 := array at: 20.
	x12expy22 := array at: 21.
	x1expy23 := array at: 22.
	y14expy24 := array at: 23.
	x13expy2 := array at: 24.
	I1 := x1mx2 * (3.0d * d * y1py2 + a2x1expy2 + (b * y12expy22)) / (6.0d * c).
	Ix := x1mx2 * (4.0d * d * x1expy2 + (2.0d * a * n2dexpy2) + (b * x1expy22)) / (24.0d * c).
	Iy := x1mx2 * (4.0d * d * y12expy22 + (2.0d * b * y13expy23) + (a * x1expy22)) / (24.0d * c).
	Iz := 0.0d - (x1mx2 * (6.0d * d2 * y1py2 + (b2 * y13expy23) + (a2 * n2dexpy2) + (4.0d * d * (a2x1expy2 + (b * y12expy22))) + (a * b * x1expy22))) / (24.0d * c2).
	Ixx := x1mx2 * (5.0d * d * n2dexpy2 + (3.0d * a * x13expy2) + (b * x12expy22)) / (60.0d * c).
	Iyy := x1mx2 * (5.0d * d * y13expy23 + (3.0d * b * y14expy24) + (a * x1expy23)) / (60.0d * c).
	Izz := x1mx2 * (10.0d * d3 * y1py2 + (b3 * y14expy24) + (a3 * x13expy2) + (10.0d * d2 * (a2x1expy2 + (b * y12expy22))) + (a2 * b * x12expy22) + (a * b2 * x1expy23) + (5.0d * d * (b2 * y13expy23 + (a2 * n2dexpy2) + (a * b * x1expy22)))) / (60.0d * c3).
	Ixy := x1mx2 * (5.0d * d * x1expy22 + (2.0d * (a * x12expy22 + (b * x1expy23)))) / (120.0d * c).
	Ixz := 0.0d - (x1mx2 * (10.0d * d2 * x1expy2 + (3.0d * a2 * x13expy2) + (2.0d * a * b * x12expy22) + (b2 * x1expy23) + (5.0d * d * (2.0d * a * n2dexpy2 + (b * x1expy22))))) / (120.0d * c2).
	Iyz := 0.0d - (x1mx2 * (10.0d * d2 * y12expy22 + (3.0d * b2 * y14expy24) + (a2 * x12expy22) + (2.0d * a * b * x1expy23) + (5.0d * d * (2.0d * b * y13expy23 + (a * x1expy22))))) / (120.0d * c2).
	answer := FullColumn new: 10.
	answer at: 1 put: I1.
	answer at: 2 put: Ix.
	answer at: 3 put: Iy.
	answer at: 4 put: Iz.
	answer at: 5 put: Ixx.
	answer at: 6 put: Iyy.
	answer at: 7 put: Izz.
	answer at: 8 put: Ixy.
	answer at: 9 put: Ixz.
	answer at: 10 put: Iyz.
	^answer
]

{ #category : #calc }
GEOInertiaMatrixSolver >> momentsOfVolume: solid [ 
	| momentsOfVolume answer |
	momentsOfVolume := (FullColumn zero: 10).
	solid faces do: [:face | momentsOfVolume equalSelfPlus: (self momentsOfVolumeUnderFace: face)].
	answer := GEOMomentsOfVolume newWithMoments: momentsOfVolume.
	^answer
]

{ #category : #calc }
GEOInertiaMatrixSolver >> momentsOfVolumeUnderFace: face [ 
	"
	Face Plane is ax + by +cz + d = 0. 
	For an edge of the face defined by (x1,y1,z1) and (x2,y2,z2) on the plane: 
	.					x2		y1 + ((y2 -y1)*(x - x1)/(x2 -x1))	-(ax + by +d)/c 
	.					f		f									f 
	iedge(bullet) := 	|		|									|	(bullet)		dz	dy	dx						 
	.					j		j									j 
	.					x1		0									0 
	bullet := 1,x,y,z,x^2,y^2,z^2,xy,xz,yz.	 
	iface := sum of iedges according to right hand rule for outward normal of face. 
	ivolume := sum of ifaces. 
	"
	"Calculations of I's are done in momentsFrom: because the compiler cannot handle all the operations 
	in one big method."
	"The right hand rule gives negative volumes for the integrals, hence the negation."

	| answer startPoint nvertex rPpointsP a b c d endPoint x1 y1 x2 y2 a2 a3 b2 b3 c2 c3 d2 d3 x12 x13 x22 x23 y12 y13 y14 y22 y23 y24 x1mx2 y1y2 x1expy22 y13expy23 n2dexpy2 a2x1expy2 y12expy22 x12expy22 x13expy2 x1expy23 y14expy24 x1expy2 dataArray y1py2 abcd |
	answer := (FullColumn zero: 10).
	nvertex := face nvertex.
	rPpointsP := face rPpointsP.
	abcd := face eqnOfPlaneInPart.
	a := abcd at: 1.
	b := abcd at: 2.
	c := abcd at: 3.
	d := abcd at: 4.
	c abs < 1.0d-6
		ifTrue: 
			[answer atAllPut: 0.0d.
			^answer].
	a2 := a * a.
	b2 := b * b.
	c2 := c * c.
	d2 := d * d.
	a3 := a2 * a.
	b3 := b2 * b.
	c3 := c2 * c.
	d3 := d2 * d.
	1 to: nvertex
		do: 
			[:i | 
			startPoint := rPpointsP at: i.
			endPoint := rPpointsP at: i + 1.
			x1 := startPoint at: 1.
			y1 := startPoint at: 2.
			x2 := endPoint at: 1.
			y2 := endPoint at: 2.
			x1mx2 := x1 - x2.
			y1py2 := y1 + y2.
			x1mx2 abs > 1.0d-6
				ifTrue: 
					[x12 := x1 * x1.
					y12 := y1 * y1.
					x22 := x2 * x2.
					y22 := y2 * y2.
					y1y2 := y1 * y2.
					x1expy22 := x1 * (3.0d * y12 + (2.0d * y1y2) + y22) + (x2 * (y12 + (2.0d * y1y2) + (3.0d * y22))).
					a2x1expy2 := a * (2.0d * x1 * y1 + (x2 * y1) + (x1 * y2) + (2.0d * x2 * y2)).
					y12expy22 := y12 + y1y2 + y22.
					x1expy2 := x1 * (2.0d * y1 + y2) + (x2 * (y1 + (2.0d * y2))).
					x13 := x12 * x1.
					y13 := y12 * y1.
					x23 := x22 * x2.
					y23 := y22 * y2.
					y13expy23 := y13 + (y12 * y2) + (y1 * y22) + y23.
					n2dexpy2 := 2.0d * x1 * x2 * (y1 + y2) + (x12 * (3.0d * y1 + y2)) + (x22 * (y1 + (3.0d * y2))).
					x12expy22 := x12 * (6.0d * y12 + (3.0d * y1y2) + y22) + (x1 * x2 * (3.0d * y12 + (4.0d * y1y2) + (3.0d * y22))) + (x22 * (y12 + (3.0d * y1y2) + (6.0d * y22))).
					x1expy23 := x1 * (4.0d * y13 + (3.0d * y12 * y2) + (2.0d * y1 * y22) + y23) + (x2 * (y13 + (2.0d * y12 * y2) + (3.0d * y1 * y22) + (4.0d * y23))).
					y14 := y13 * y1.
					y24 := y23 * y2.
					y14expy24 := y14 + (y13 * y2) + (y12 * y22) + (y1 * y23) + y24.
					x13expy2 := x13 * (4.0d * y1 + y2) + (x12 * x2 * (3.0d * y1 + (2.0d * y2))) + (x1 * x22 * (2.0d * y1 + (3.0d * y2))) + (x23 * (y1 + (4.0d * y2))).
					dataArray := Array new: 24.
					dataArray at: 1 put: a.
					dataArray at: 2 put: b.
					dataArray at: 3 put: c.
					dataArray at: 4 put: d.
					dataArray at: 5 put: x1mx2.
					dataArray at: 6 put: y1py2.
					dataArray at: 7 put: a2.
					dataArray at: 8 put: b2.
					dataArray at: 9 put: c2.
					dataArray at: 10 put: d2.
					dataArray at: 11 put: x1expy22.
					dataArray at: 12 put: a2x1expy2.
					dataArray at: 13 put: y12expy22.
					dataArray at: 14 put: x1expy2.
					dataArray at: 15 put: a3.
					dataArray at: 16 put: b3.
					dataArray at: 17 put: c3.
					dataArray at: 18 put: d3.
					dataArray at: 19 put: y13expy23.
					dataArray at: 20 put: n2dexpy2.
					dataArray at: 21 put: x12expy22.
					dataArray at: 22 put: x1expy23.
					dataArray at: 23 put: y14expy24.
					dataArray at: 24 put: x13expy2.
					answer equalSelfPlus: (self momentsFrom: dataArray)]].
	^answer negated
]

{ #category : #accessing }
GEOInertiaMatrixSolver >> rPcmP: col [ 
	rPcmP := col
]

{ #category : #accessing }
GEOInertiaMatrixSolver >> rPoP: col [ 
	rPoP := col
]
