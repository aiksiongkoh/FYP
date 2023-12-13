"
Refer: Edward Haug's book and 91moment.doc

Define
rIJK = displacement from I to J in K components.
If a body is defined in the o frame.
ropo := [xopo yopo zopo]T
ropoTilde := 	|	0 	-z	y	|
				|	z	0	-x	|
				|	-y	x	0	|opo
rocmo := displacement from o frame origin to center of mass in o components.
aJo := -integral(ropoTilde*ropoTilde*dmass)
New frame P
rPpP := rPoP + aAPo*ropo.
rocmP := aAPo*rocmo
aJP := aAPo*aJo*aAPoT - mass*(rPoPTilde*rPoPTilde + rPoPTilde*rocmPTilde + rocmPTilde*rPoPTilde)

aJp is the principle aJ at frame P origin.
ijkP := aAPp * ijkp.
"
Class {
	#name : #MbDMomentOfInertiaSolver,
	#superclass : #MbDSolver,
	#instVars : [
		'm',
		'aJP',
		'aJo',
		'rPoP',
		'aAPo',
		'rocmP',
		'aJp',
		'aAPp',
		'aJPcopy',
		'colOrder'
	],
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'VisualWorks metadata' }
MbDMomentOfInertiaSolver class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDMomentOfInertiaSolver >> aAPo: mat [ 
	aAPo := mat
]

{ #category : #accessing }
MbDMomentOfInertiaSolver >> aAPp [
	^aAPp
]

{ #category : #accessing }
MbDMomentOfInertiaSolver >> aJo: mat [ 
	aJo := mat
]

{ #category : #accessing }
MbDMomentOfInertiaSolver >> aJp [
	^aJp
]

{ #category : #calc }
MbDMomentOfInertiaSolver >> calc [
	self calcJP.
	self calcJp.
	self calcAPp
]

{ #category : #calc }
MbDMomentOfInertiaSolver >> calcAPp [
	| lam1 lam2 lam3 eigenvector2 eigenvector3 eigenvector1 |
	lam1 := aJp at: 1.
	lam2 := aJp at: 2.
	lam3 := aJp at: 3.
	lam1 = lam2
		ifTrue: [lam2 = lam3
				ifTrue: [^aAPp := (FullMatrix identity: 3)]
				ifFalse: 
					[eigenvector2 := self eigenvectorFor: lam2.
					eigenvector3 := self eigenvectorFor: lam3.
					eigenvector2 normalizeSelf.
					eigenvector3 normalizeSelf.
					(eigenvector2 at: 2) < 0.0d ifTrue: [eigenvector2 negateSelf].
					(eigenvector3 at: 3) < 0.0d ifTrue: [eigenvector3 negateSelf].
					eigenvector1 := eigenvector2 cross: eigenvector3]]
		ifFalse: 
			[eigenvector1 := self eigenvectorFor: lam1.
			eigenvector2 := self eigenvectorFor: lam2.
			eigenvector1 normalizeSelf.
			eigenvector2 normalizeSelf.
			(eigenvector1 at: 1) < 0.0d ifTrue: [eigenvector1 negateSelf].
			(eigenvector2 at: 2) < 0.0d ifTrue: [eigenvector2 negateSelf].
			eigenvector3 := eigenvector1 cross: eigenvector2].
	aAPp := FullMatrix new: 3.
	aAPp at: 1 put: eigenvector1 asFullRow.
	aAPp at: 2 put: eigenvector2 asFullRow.
	aAPp at: 3 put: eigenvector3 asFullRow
]

{ #category : #calc }
MbDMomentOfInertiaSolver >> calcJP [
	| rocmPtilde rPoPtilde term1 term21 term22 term23 term2 |
	rocmPtilde := rocmP tildeMatrix.
	rPoPtilde := rPoP tildeMatrix.
	term1 := (aAPo timesFullMatrix: aJo) timesTransposeFullMatrix: aAPo.
	term21 := rPoPtilde timesFullMatrix: rPoPtilde.
	term22 := rPoPtilde timesFullMatrix: rocmPtilde.
	term23 := term22 transpose.
	term2 := term21 + term22 + term23 times: m.
	aJP := term1 minusFullMatrix: term2.
	aJP symLowerWithUpper.
	aJP conditionSelfWithTol: aJP maxElement * 1.0d-6
]

{ #category : #calc }
MbDMomentOfInertiaSolver >> calcJp [
	aJP isDiagonal
		ifTrue: [self calcJpFromDiagJP]
		ifFalse: [self calcJpFromFullJP]
]

{ #category : #calc }
MbDMomentOfInertiaSolver >> calcJpFromDiagJP [
	"Eigenvalues are orders from smallest to largest."

	| sortedJ lam1 lam2 lam3 average |
	sortedJ := SortedCollection new.
	sortedJ add: (aJP at: 1 and: 1).
	sortedJ add: (aJP at: 2 and: 2).
	sortedJ add: (aJP at: 3 and: 3).
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
	aJp := DiagonalMatrix
				with: lam1
				with: lam2
				with: lam3
]

{ #category : #calc }
MbDMomentOfInertiaSolver >> calcJpFromFullJP [
	"Eigenvalues are orders from smallest to largest."
	"Rounding error can be significant."
	"e.g. (diag 100.0d 100.0d 1.0d) gives only 8 digit accuracy."

	| a11 a12 a13 a22 a23 a33 a b c aDiv3 p q phiDiv3 twoSqrtMinusp piDiv3 sortedJ lam1 lam2 lam3 average |
	a11 := aJP at: 1 and: 1.
	a12 := aJP at: 1 and: 2.
	a13 := aJP at: 1 and: 3.
	a22 := aJP at: 2 and: 2.
	a23 := aJP at: 2 and: 3.
	a33 := aJP at: 3 and: 3.
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
	lam1 := (sortedJ at: 1) - aDiv3.
	lam2 := (sortedJ at: 2) - aDiv3.
	lam3 := (sortedJ at: 3) - aDiv3.
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
	aJp := DiagonalMatrix
				with: lam1
				with: lam2
				with: lam3
]

{ #category : #calc }
MbDMomentOfInertiaSolver >> doFullPivoting: p [ 
	| max pivotRow pivotCol rowi aij mag |
	max := 0.
	pivotRow := p.
	pivotCol := p.
	p to: 3 do: [:i | 
			rowi := aJPcopy at: i.
			p to: 3 do: [:j | 
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
	p == pivotRow ifFalse: [aJPcopy swap: p with: pivotRow].
	p == pivotCol
		ifFalse: 
			[aJPcopy do: [:row | row swap: p with: pivotCol].
			colOrder swap: p with: pivotCol]
]

{ #category : #calc }
MbDMomentOfInertiaSolver >> dummy [
	| lam1 lam2 lam3 |
	lam1 := aJP at: 1 and: 1.
	lam2 := aJP at: 2 and: 2.
	lam3 := aJP at: 3 and: 3.
	aJp := DiagonalMatrix new: 3.
	aJp at: 1 put: lam1.
	aJp at: 2 put: lam2.
	aJp at: 3 put: lam3
]

{ #category : #calc }
MbDMomentOfInertiaSolver >> eigenvectorFor: lam [ 
	"[aJP] - lam[I]."

	| eigenvector row1 row2 row3 norm1 e3 e2 e1 dum |
	aJPcopy := aJP copy.
	colOrder := FullColumn new: 3.
	eigenvector := FullColumn new: 3.
	1 to: 3 do: [:i | 
			colOrder at: i put: i.
			aJPcopy at: i and: i minusNumber: lam].
	1 to: 3 do: [:p | 
			self doFullPivoting: p.
			self forwardEliminateWithPivot: p].
	row1 := aJPcopy at: 1.
	row2 := aJPcopy at: 2.
	row3 := aJPcopy at: 3.
	norm1 := row1 length.
	row3 length / norm1 > 1.0d-6 ifTrue: [self error: '3rd row should be very small.'].
	row2 length / norm1 > 1.0d-6
		ifTrue: 
			[e3 := 1.0d.
			e2 := e3 * (row2 at: 3) negated / (row2 at: 2).
			e1 := (e2 * (row1 at: 2) + (e3 * (row1 at: 3))) negated / (row1 at: 1)]
		ifFalse: 
			["Repeated roots."
			e3 := 1.0d.
			e2 := 0.0d.
			e1 := (e2 * (row1 at: 2) + (e3 * (row1 at: 3))) negated / (row1 at: 1)].
	dum := FullColumn with: e1 with: e2 with: e3.
	1 to: 3 do: [:i | eigenvector at: (colOrder at: i) put: (dum at: i)].
	^eigenvector
]

{ #category : #calc }
MbDMomentOfInertiaSolver >> forwardEliminateWithPivot: p [ 
	| rowp app rowi aip factor |
	rowp := aJPcopy at: p.
	app := rowp at: p.
	p + 1 to: 3 do: [:i | 
			rowi := aJPcopy at: i.
			aip := rowi at: p.
			aip = 0
				ifFalse: 
					[rowi at: p put: 0.0d.
					factor := aip / app.
					p + 1 to: 3 do: [:j | rowi at: j minusNumber: factor * (rowp at: j)]]]
]

{ #category : #accessing }
MbDMomentOfInertiaSolver >> m: double [ 
	m := double
]

{ #category : #calc }
MbDMomentOfInertiaSolver >> momentsFrom: array [ 
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
	Iyz := 0.0d - (x1mx2 * (10.0d * d2 * y12expy22 + 3.0d * b2 * y14expy24 + (a2 * x12expy22) + (2.0d * a * b * x1expy23) + (5.0d * d * (2.0d * b * y13expy23 + (a * x1expy22))))) / (120.0d * c2).
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
MbDMomentOfInertiaSolver >> momentsOfAreaUnderLine: aLine [ 
	"Line is in xy plane."
	"					x2		y1 + ((y2 -y1)*(x - x1)/(x2 -x1))		"
	"					f		f										"
	"integ(bullet) := 	|		|	(bullet)	dy	dx						"
	"					j		j										"
	"					x1		0										"
	"bullet := 1,x,y,x^2,y^2,xy.	"

	| answer startPoint endPoint x1 y1 x2 y2 x2mx1 y2my1 I1 Ix Iy Ixx Iyy Ixy x22 x12 x23 x13 x24 x14 y22 y12 y23 y13 y24 y14 y2py1 x22mx12 x23mx13 y23my13 x24mx14 slope y24my14 |
	answer := Array new: 6.
	startPoint := aLine startPoint.
	endPoint := aLine endPoint.
	x1 := startPoint at: 1.
	y1 := startPoint at: 2.
	x2 := endPoint at: 1.
	y2 := endPoint at: 2.
	x2mx1 := x2 - x1.
	y2my1 := y2 - y1.
	x2mx1 < MachineAccuracy OfDoubleTimesFour		ifTrue: 
			[answer atAllPut: 0.0d.
			^answer].
	x22 := x2 * x2.
	x12 := x1 * x1.
	x23 := x22 * x2.
	x13 := x12 * x1.
	x24 := x23 * x2.
	x14 := x13 * x1.
	y22 := y2 * y2.
	y12 := y1 * y1.
	y23 := y22 * y2.
	y13 := y12 * y1.
	y24 := y23 * y2.
	y14 := y13 * y1.
	y2py1 := y2 + y1.
	x22mx12 := x22 - x12.
	x23mx13 := x23 - x13.
	x24mx14 := x24 - x14.
	y23my13 := y23 - y13.
	y24my14 := y24 - y14.
	slope := y2my1 / x2mx1.
	y2my1 < MachineAccuracy OfDoubleTimesFour
		ifTrue: 
			[I1 := x2mx1 * y1.
			Ix := x22mx12 * y1 / 2.0d.
			Iy := x2mx1 * y12 / 2.0d.
			Ixx := x23mx13 * y1 / 3.0d.
			Iyy := x2mx1 * y13 / 3.0d.
			Ixy := x22mx12 * y12 / 4.0d]
		ifFalse: 
			[I1 := y2py1 * x2mx1 / 2.0d.
			Ix := y1 - (slope * x1) * x22mx12 / 2.0d + (slope * x23mx13 / 3.0d).
			Iy := y23my13 / (6.0d * slope).
			Ixx := y1 - (slope * x1) * x23mx13 / 3.0d + (slope * x24mx14 / 4.0d).
			Iyy := y24my14 / (12.0d * slope).
			Ixy := x2 * y23 - (x1 * y13) / (6.0d * slope) - (y24my14 / (24.0d * slope * slope))].
	answer at: 1 put: I1.
	answer at: 2 put: Ix.
	answer at: 3 put: Iy.
	answer at: 4 put: Ixx.
	answer at: 5 put: Iyy.
	answer at: 6 put: Ixy.
	^answer
]

{ #category : #accessing }
MbDMomentOfInertiaSolver >> rPoP: col [ 
	rPoP := col
]

{ #category : #accessing }
MbDMomentOfInertiaSolver >> rocmP: col [ 
	rocmP := col
]
