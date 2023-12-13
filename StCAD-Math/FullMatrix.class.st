Class {
	#name : #FullMatrix,
	#superclass : #RowTypeMatrix,
	#type : #variable,
	#category : #'StCAD-Math-StMathArray'
}

{ #category : #'instance creation' }
FullMatrix class >> fromCollection: aCollection aBlock: aBlock [ 
	| nrow ncol aFullMatrix |
	nrow := aCollection size.
	ncol := aCollection first size.
	aFullMatrix := self new: nrow.
	1 to: nrow
		do: 
			[:i | 
			| rowi browi |
			rowi := FullRow new: ncol.
			browi := aCollection at: i.
			1 to: ncol do: [:j | rowi at: j put: (aBlock value: (browi at: j))].
			aFullMatrix at: i put: rowi].
	^aFullMatrix
]

{ #category : #'instance creation' }
FullMatrix class >> newWithElements: a2DArray [ 
	| answer |
	answer := a2DArray shallowCopy changeClassToThatOf: (self new: 0).
	1 to: answer nrow do: [:i | answer at: i put: (FullRow newWithElements: (a2DArray at: i))].
	^answer
]

{ #category : #'instance creation' }
FullMatrix class >> rotateSymbolicx: the [ 
	| zero one sthe cthe answer |
	zero := 0.0d asConstant.
	one := 1.0d asConstant.
	sthe := the sin.
	cthe := the cos.
	answer := self new: 3 by: 3.
	(answer at: 1)
		at: 1 put: one;
		at: 2 put: zero;
		at: 3 put: zero.
	(answer at: 2)
		at: 1 put: zero;
		at: 2 put: cthe;
		at: 3 put: sthe negated.
	(answer at: 3)
		at: 1 put: zero;
		at: 2 put: sthe;
		at: 3 put: cthe.
	^answer
]

{ #category : #'instance creation' }
FullMatrix class >> rotateSymbolicx: the rotDot: thedot [ 
	| zero sthe cthe sthedot cthedot answer |
	zero := 0.0d asConstant.
	sthe := the sin.
	cthe := the cos.
	sthedot := cthe * thedot.
	cthedot := (sthe * thedot) negated.
	answer := self new: 3 by: 3.
	(answer at: 1)
		at: 1 put: zero;
		at: 2 put: zero;
		at: 3 put: zero.
	(answer at: 2)
		at: 1 put: zero;
		at: 2 put: cthedot;
		at: 3 put: sthedot negated.
	(answer at: 3)
		at: 1 put: zero;
		at: 2 put: sthedot;
		at: 3 put: cthedot.
	^answer
]

{ #category : #'instance creation' }
FullMatrix class >> rotateSymbolicx: the rotDot: thedot rotDDot: theddot [ 
	| zero sthe cthe sthedot cthedot stheddot ctheddot answer |
	zero := 0.0d asConstant.
	sthe := the sin.
	cthe := the cos.
	sthedot := cthe * thedot.
	cthedot := (sthe * thedot) negated.
	stheddot := cthedot * thedot + (cthe * theddot).
	ctheddot := (sthedot * thedot + (sthe * theddot)) negated.
	answer := self new: 3 by: 3.
	(answer at: 1)
		at: 1 put: zero;
		at: 2 put: zero;
		at: 3 put: zero.
	(answer at: 2)
		at: 1 put: zero;
		at: 2 put: ctheddot;
		at: 3 put: stheddot negated.
	(answer at: 3)
		at: 1 put: zero;
		at: 2 put: stheddot;
		at: 3 put: ctheddot.
	^answer
]

{ #category : #'instance creation' }
FullMatrix class >> rotateSymbolicy: the [ 
	| zero one sthe cthe answer |
	zero := 0.0d asConstant.
	one := 1.0d asConstant.
	sthe := the sin.
	cthe := the cos.
	answer := self new: 3 by: 3.
	(answer at: 1)
		at: 1 put: cthe;
		at: 2 put: zero;
		at: 3 put: sthe.
	(answer at: 2)
		at: 1 put: zero;
		at: 2 put: one;
		at: 3 put: zero.
	(answer at: 3)
		at: 1 put: sthe negated;
		at: 2 put: zero;
		at: 3 put: cthe.
	^answer
]

{ #category : #'instance creation' }
FullMatrix class >> rotateSymbolicy: the rotDot: thedot [ 
	| zero sthe cthe sthedot cthedot answer |
	zero := 0.0d asConstant.
	sthe := the sin.
	cthe := the cos.
	sthedot := cthe * thedot.
	cthedot := (sthe * thedot) negated.
	answer := self new: 3 by: 3.
	(answer at: 1)
		at: 1 put: cthedot;
		at: 2 put: zero;
		at: 3 put: sthedot.
	(answer at: 2)
		at: 1 put: zero;
		at: 2 put: zero;
		at: 3 put: zero.
	(answer at: 3)
		at: 1 put: sthedot negated;
		at: 2 put: zero;
		at: 3 put: cthedot.
	^answer
]

{ #category : #'instance creation' }
FullMatrix class >> rotateSymbolicy: the rotDot: thedot rotDDot: theddot [ 
	| zero sthe cthe sthedot cthedot stheddot ctheddot answer |
	zero := 0.0d asConstant.
	sthe := the sin.
	cthe := the cos.
	sthedot := cthe * thedot.
	cthedot := (sthe * thedot) negated.
	stheddot := cthedot * thedot + (cthe * theddot).
	ctheddot := (sthedot * thedot + (sthe * theddot)) negated.
	answer := self new: 3 by: 3.
	(answer at: 1)
		at: 1 put: ctheddot;
		at: 2 put: zero;
		at: 3 put: stheddot.
	(answer at: 2)
		at: 1 put: zero;
		at: 2 put: zero;
		at: 3 put: zero.
	(answer at: 3)
		at: 1 put: stheddot negated;
		at: 2 put: zero;
		at: 3 put: ctheddot.
	^answer
]

{ #category : #'instance creation' }
FullMatrix class >> rotateSymbolicz: the [ 
	| zero one sthe cthe answer |
	zero := 0.0d asConstant.
	one := 1.0d asConstant.
	sthe := the sin.
	cthe := the cos.
	answer := self new: 3 by: 3.
	(answer at: 1)
		at: 1 put: cthe;
		at: 2 put: sthe negated;
		at: 3 put: zero.
	(answer at: 2)
		at: 1 put: sthe;
		at: 2 put: cthe;
		at: 3 put: zero.
	(answer at: 3)
		at: 1 put: zero;
		at: 2 put: zero;
		at: 3 put: one.
	^answer
]

{ #category : #'instance creation' }
FullMatrix class >> rotateSymbolicz: the rotDot: thedot [ 
	| zero sthe cthe sthedot cthedot answer |
	zero := 0.0d asConstant.
	sthe := the sin.
	cthe := the cos.
	sthedot := cthe * thedot.
	cthedot := (sthe * thedot) negated.
	answer := self new: 3 by: 3.
	(answer at: 1)
		at: 1 put: cthedot;
		at: 2 put: sthedot negated;
		at: 3 put: zero.
	(answer at: 2)
		at: 1 put: sthedot;
		at: 2 put: cthedot;
		at: 3 put: zero.
	(answer at: 3)
		at: 1 put: zero;
		at: 2 put: zero;
		at: 3 put: zero.
	^answer
]

{ #category : #'instance creation' }
FullMatrix class >> rotateSymbolicz: the rotDot: thedot rotDDot: theddot [ 
	| zero sthe cthe sthedot cthedot stheddot ctheddot answer |
	zero := 0.0d asConstant.
	sthe := the sin.
	cthe := the cos.
	sthedot := cthe * thedot.
	cthedot := (sthe * thedot) negated.
	stheddot := cthedot * thedot + (cthe * theddot).
	ctheddot := ((sthedot * thedot) + (sthe * theddot)) negated.
	answer := self new: 3 by: 3.
	(answer at: 1)
		at: 1 put: ctheddot;
		at: 2 put: stheddot negated;
		at: 3 put: zero.
	(answer at: 2)
		at: 1 put: stheddot;
		at: 2 put: ctheddot;
		at: 3 put: zero.
	(answer at: 3)
		at: 1 put: zero;
		at: 2 put: zero;
		at: 3 put: zero.
	^answer
]

{ #category : #'instance creation' }
FullMatrix class >> rotatex: the [ 
	| sthe cthe answer |
	sthe := the sin.
	cthe := the cos.
	answer := self new: 3 by: 3.
	(answer at: 1)
		at: 1 put: 1.0d;
		at: 2 put: 0.0d;
		at: 3 put: 0.0d.
	(answer at: 2)
		at: 1 put: 0.0d;
		at: 2 put: cthe;
		at: 3 put: 0.0d - sthe.
	(answer at: 3)
		at: 1 put: 0.0d;
		at: 2 put: sthe;
		at: 3 put: cthe.
	^answer
]

{ #category : #'instance creation' }
FullMatrix class >> rotatex: the rotDot: thedot [ 
	| sthe cthe sthedot cthedot answer |
	sthe := the sin.
	cthe := the cos.
	sthedot := cthe * thedot.
	cthedot := 0.0d - (sthe * thedot).
	answer := self new: 3 by: 3.
	(answer at: 1)
		at: 1 put: 0.0d;
		at: 2 put: 0.0d;
		at: 3 put: 0.0d.
	(answer at: 2)
		at: 1 put: 0.0d;
		at: 2 put: cthedot;
		at: 3 put: 0.0d - sthedot.
	(answer at: 3)
		at: 1 put: 0.0d;
		at: 2 put: sthedot;
		at: 3 put: cthedot.
	^answer
]

{ #category : #'instance creation' }
FullMatrix class >> rotatex: the rotDot: thedot rotDDot: theddot [ 
	| sthe cthe sthedot cthedot stheddot ctheddot answer |
	sthe := the sin.
	cthe := the cos.
	sthedot := cthe * thedot.
	cthedot := 0.0d - (sthe * thedot).
	stheddot := cthedot * thedot + (cthe * theddot).
	ctheddot := 0.0d - (sthedot * thedot) - (sthe * theddot).
	answer := self new: 3 by: 3.
	(answer at: 1)
		at: 1 put: 0.0d;
		at: 2 put: 0.0d;
		at: 3 put: 0.0d.
	(answer at: 2)
		at: 1 put: 0.0d;
		at: 2 put: ctheddot;
		at: 3 put: 0.0d - stheddot.
	(answer at: 3)
		at: 1 put: 0.0d;
		at: 2 put: stheddot;
		at: 3 put: ctheddot.
	^answer
]

{ #category : #'instance creation' }
FullMatrix class >> rotatey: the [ 
	| sthe cthe answer |
	sthe := the sin.
	cthe := the cos.
	answer := self new: 3 by: 3.
	(answer at: 1)
		at: 1 put: cthe;
		at: 2 put: 0.0d;
		at: 3 put: sthe.
	(answer at: 2)
		at: 1 put: 0.0d;
		at: 2 put: 1.0d;
		at: 3 put: 0.0d.
	(answer at: 3)
		at: 1 put: 0.0d - sthe;
		at: 2 put: 0.0d;
		at: 3 put: cthe.
	^answer
]

{ #category : #'instance creation' }
FullMatrix class >> rotatey: the rotDot: thedot [ 
	| sthe cthe sthedot cthedot answer |
	sthe := the sin.
	cthe := the cos.
	sthedot := cthe * thedot.
	cthedot := 0.0d - (sthe * thedot).
	answer := self new: 3 by: 3.
	(answer at: 1)
		at: 1 put: cthedot;
		at: 2 put: 0.0d;
		at: 3 put: sthedot.
	(answer at: 2)
		at: 1 put: 0.0d;
		at: 2 put: 0.0d;
		at: 3 put: 0.0d.
	(answer at: 3)
		at: 1 put: 0.0d - sthedot;
		at: 2 put: 0.0d;
		at: 3 put: cthedot.
	^answer
]

{ #category : #'instance creation' }
FullMatrix class >> rotatey: the rotDot: thedot rotDDot: theddot [ 
	| sthe cthe sthedot cthedot stheddot ctheddot answer |
	sthe := the sin.
	cthe := the cos.
	sthedot := cthe * thedot.
	cthedot := 0.0d - (sthe * thedot).
	stheddot := cthedot * thedot + (cthe * theddot).
	ctheddot := 0.0d - (sthedot * thedot) - (sthe * theddot).
	answer := self new: 3 by: 3.
	(answer at: 1)
		at: 1 put: ctheddot;
		at: 2 put: 0.0d;
		at: 3 put: stheddot.
	(answer at: 2)
		at: 1 put: 0.0d;
		at: 2 put: 0.0d;
		at: 3 put: 0.0d.
	(answer at: 3)
		at: 1 put: 0.0d - stheddot;
		at: 2 put: 0.0d;
		at: 3 put: ctheddot.
	^answer
]

{ #category : #'instance creation' }
FullMatrix class >> rotatez: the [ 
	| sthe cthe answer |
	sthe := the sin.
	cthe := the cos.
	answer := self new: 3 by: 3.
	(answer at: 1)
		at: 1 put: cthe;
		at: 2 put: 0.0d - sthe;
		at: 3 put: 0.0d.
	(answer at: 2)
		at: 1 put: sthe;
		at: 2 put: cthe;
		at: 3 put: 0.0d.
	(answer at: 3)
		at: 1 put: 0.0d;
		at: 2 put: 0.0d;
		at: 3 put: 1.0d.
	^answer
]

{ #category : #'instance creation' }
FullMatrix class >> rotatez: the rotDot: thedot [ 
	| sthe cthe sthedot cthedot answer |
	sthe := the sin.
	cthe := the cos.
	sthedot := cthe * thedot.
	cthedot := 0.0d - (sthe * thedot).
	answer := self new: 3 by: 3.
	(answer at: 1)
		at: 1 put: cthedot;
		at: 2 put: 0.0d - sthedot;
		at: 3 put: 0.0d.
	(answer at: 2)
		at: 1 put: sthedot;
		at: 2 put: cthedot;
		at: 3 put: 0.0d.
	(answer at: 3)
		at: 1 put: 0.0d;
		at: 2 put: 0.0d;
		at: 3 put: 0.0d.
	^answer
]

{ #category : #'instance creation' }
FullMatrix class >> rotatez: the rotDot: thedot rotDDot: theddot [ 
	| sthe cthe sthedot cthedot stheddot ctheddot answer |
	sthe := the sin.
	cthe := the cos.
	sthedot := cthe * thedot.
	cthedot := 0.0d - (sthe * thedot).
	stheddot := cthedot * thedot + (cthe * theddot).
	ctheddot := 0.0d - (sthedot * thedot) - (sthe * theddot).
	answer := self new: 3 by: 3.
	(answer at: 1)
		at: 1 put: ctheddot;
		at: 2 put: 0.0d - stheddot;
		at: 3 put: 0.0d.
	(answer at: 2)
		at: 1 put: stheddot;
		at: 2 put: ctheddot;
		at: 3 put: 0.0d.
	(answer at: 3)
		at: 1 put: 0.0d;
		at: 2 put: 0.0d;
		at: 3 put: 0.0d.
	^answer
]

{ #category : #'instance creation' }
FullMatrix class >> rotationMatrixFromOrigin: origin xPoint: xPoint yPoint: yPoint [ 
	"
	X point and Y point method of specifying orientation of a coordinate frame. Used in 
	ADAMS. 
	origin is the coordinate of the origin. 
	xPoint is the coordinate of a point on the positive x axis. 
	yPoint is the coordinate of a point on the positive xy plane. 
	The three points must form a triangle. The closer to equilateral the better. 
	"

	^self rotationMatrixFromxDir: xPoint - origin yDir: yPoint - origin
]

{ #category : #'instance creation' }
FullMatrix class >> rotationMatrixFromOrigin: origin xPoint: xPoint zPoint: zPoint [ 
	"
	origin is the coordinate of the origin. 
	xPoint is the coordinate of a point on the positive x axis. 
	zPoint is the coordinate of a point on the positive xz plane. 
	The three points must form a triangle. The closer to equilateral the better. 
	"

	^self rotationMatrixFromxDir: xPoint - origin zDir: zPoint - origin
]

{ #category : #'instance creation' }
FullMatrix class >> rotationMatrixFromOrigin: origin zPoint: zPoint xPoint: xPoint [ 
	"
	origin is the coordinate of the origin. 
	zPoint is the coordinate of a point on the positive z axis. 
	xPoint is the coordinate of a point on the positive xz plane. 
	The three points must for a triangle. The closer to equilateral the better. 
	"

	^self rotationMatrixFromzDir: zPoint - origin xDir: xPoint - origin
]

{ #category : #'instance creation' }
FullMatrix class >> rotationMatrixFromOrigin: origin zPoint: zPoint yPoint: yPoint [ 
	"
	origin is the coordinate of the origin. 
	zPoint is the coordinate of a point on the positive z axis. 
	yPoint is the coordinate of a point on the positive yz plane. 
	The three points must for a triangle. The closer to equilateral the better. 
	"

	^self rotationMatrixFromzDir: zPoint - origin yDir: yPoint - origin
]

{ #category : #'instance creation' }
FullMatrix class >> rotationMatrixFromxDir: xDir yDir: yDir [ 
	"
	xDir is the direction of the positive x axis. 
	yDir is the direction of the positive xy plane. 
	The directions must not be parallel.
	"

	| aAcol1 aAcol3 aAcol2 aA |
	aAcol1 := xDir normalizeSelf.	"x axis"
	aAcol3 := (aAcol1 cross: yDir) normalizeSelf.	"z axis"
	aAcol2 := (aAcol3 cross: aAcol1) normalizeSelf.	"y axis"
	aA := self new: 3 by: 3.
	aA at: 1 and: 1 putFullColumn: aAcol1.
	aA at: 1 and: 2 putFullColumn: aAcol2.
	aA at: 1 and: 3 putFullColumn: aAcol3.
	^aA
]

{ #category : #'instance creation' }
FullMatrix class >> rotationMatrixFromxDir: xDir zDir: zDir [ 
	"
	xDir is the direction of the positive x axis. 
	zDir is the direction of the positive xz plane. 
	The directions must not be paralle.
	"

	| aAcol1 aAcol3 aAcol2 aA |
	aAcol1 := xDir normalizeSelf.	"x axis"
	aAcol2 := (zDir cross: aAcol1) normalizeSelf.	"y axis"
	aAcol3 := (aAcol1 cross: aAcol2) normalizeSelf.	"z axis"
	aA := self new: 3 by: 3.
	aA at: 1 and: 1 putFullColumn: aAcol1.
	aA at: 1 and: 2 putFullColumn: aAcol2.
	aA at: 1 and: 3 putFullColumn: aAcol3.
	^aA
]

{ #category : #'instance creation' }
FullMatrix class >> rotationMatrixFromzDir: zDir xDir: xDir [ 
	"
	zDir is the direction of the positive z axis. 
	xDir is the direction of the positive xz plane. 
	The directions must not be parallel.
	"

	| aAcol1 aAcol3 aAcol2 aA |
	aAcol3 := zDir normalizeSelf.	"z axis"
	aAcol2 := (aAcol3 cross: xDir) normalizeSelf.	"y axis"
	aAcol1 := (aAcol2 cross: aAcol3) normalizeSelf.	"x axis"
	aA := self new: 3 by: 3.
	aA at: 1 and: 1 putFullColumn: aAcol1.
	aA at: 1 and: 2 putFullColumn: aAcol2.
	aA at: 1 and: 3 putFullColumn: aAcol3.
	^aA
]

{ #category : #'instance creation' }
FullMatrix class >> rotationMatrixFromzDir: zDir yDir: yDir [ 
	"
	zDir is the direction of the positive z axis. 
	yDir is the direction of the positive yz plane. 
	The directions must not be parallel.
	"

	| aAcol1 aAcol3 aAcol2 aA |
	aAcol3 := zDir normalizeSelf.	"z axis"
	aAcol1 := (yDir cross: aAcol3) normalizeSelf.	"x axis"
	aAcol2 := (aAcol3 cross: aAcol1) normalizeSelf.	"y axis"
	aA := self new: 3 by: 3.
	aA at: 1 and: 1 putFullColumn: aAcol1.
	aA at: 1 and: 2 putFullColumn: aAcol2.
	aA at: 1 and: 3 putFullColumn: aAcol3.
	^aA
]

{ #category : #accessing }
FullMatrix class >> veryShortName [
	^'Mat'
]

{ #category : #'VisualWorks metadata' }
FullMatrix class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #converting }
FullMatrix >> asFullMatrix [
	^self
]

{ #category : #converting }
FullMatrix >> asSparseMatrix [
	| nrow ncol answer tol fullRowi sparseRowi aij |
	nrow := self nrow.
	ncol := self ncol.
	answer := SparseMatrix new: nrow by: ncol.
	tol := self maxElement * MachineAccuracy OfDouble.
	1 to: nrow
		do: 
			[:i | 
			fullRowi := self at: i.
			sparseRowi := answer at: i.
			1 to: ncol
				do: 
					[:j | 
					aij := fullRowi at: j.
					aij abs >= tol ifTrue: [sparseRowi at: j put: aij]]].
	^answer
]

{ #category : #'ops on self' }
FullMatrix >> at: i1 and: j1 minusFullColumn: aFullColumn [ 
	| iOffset rowi |
	iOffset := i1 - 1.
	1 to: aFullColumn size
		do: 
			[:ii | 
			rowi := self at: iOffset + ii.
			rowi at: j1 put: (rowi at: j1)
					- (aFullColumn at: ii)]
]

{ #category : #'ops on self' }
FullMatrix >> at: i1 and: j1 minusFullColumn: aFullColumn times: aNumber [ 
	| iOffset rowi |
	iOffset := i1 - 1.
	1 to: aFullColumn size
		do: 
			[:ii | 
			rowi := self at: iOffset + ii.
			rowi at: j1 put: (rowi at: j1)
					- ((aFullColumn at: ii)
							* aNumber)]
]

{ #category : #'ops on self' }
FullMatrix >> at: i and: j minusNumber: aNumber [ 
	| rowi |
	rowi := self at: i.
	rowi at: j put: (rowi at: j)
			- aNumber
]

{ #category : #'ops on self' }
FullMatrix >> at: i1 and: j1 plusFullColumn: aFullColumn [ 
	| iOffset rowi |
	iOffset := i1 - 1.
	1 to: aFullColumn size
		do: 
			[:ii | 
			rowi := self at: iOffset + ii.
			rowi at: j1 put: (rowi at: j1)
					+ (aFullColumn at: ii)]
]

{ #category : #'ops on self' }
FullMatrix >> at: i1 and: j1 plusFullColumn: aFullColumn times: aNumber [ 
	| iOffset rowi |
	iOffset := i1 - 1.
	1 to: aFullColumn size
		do: 
			[:ii | 
			rowi := self at: iOffset + ii.
			rowi at: j1 put: (rowi at: j1)
					+ ((aFullColumn at: ii)
							* aNumber)]
]

{ #category : #'ops on self' }
FullMatrix >> at: i and: j plusNumber: aNumber [ 
	| rowi |
	rowi := self at: i.
	rowi at: j put: (rowi at: j)
			+ aNumber
]

{ #category : #'basic ops' }
FullMatrix >> eigenvalues [
	"3 by 3 positive definite case only. Generalise later."
	"Rounding error can be significant, e.g. (diag 100.0d 100.0d 1.0d) gives only 8 digit 
	accuracy."

	| a11 a12 a13 a22 a23 a33 a b c p q phiDiv3 twoSqrtMinusp piDiv3 dum roots lam1 lam2 lam3 average |
	a11 := self at: 1 and: 1.
	a12 := self at: 1 and: 2.
	a13 := self at: 1 and: 3.
	a22 := self at: 2 and: 2.
	a23 := self at: 2 and: 3.
	a33 := self at: 3 and: 3.
	a := (a11 + a22 + a33) negated.
	b := a11 * a22 + (a11 * a33) + (a22 * a33) - (a12 * a12) - (a13 * a13) - (a23 * a23).
	c := a11 * a23 * a23 + (a22 * a13 * a13) + (a33 * a12 * a12) - (a11 * a22 * a33) - (2.0d * a12 * a13 * a23).
	p := b - (a * a / 3.0d) / 3.0d.
	q := c + (2.0d * a * a * a / 27.0d) - (a * b / 3.0d) / 2.0d.
	ArithmeticValue divisionByZeroSignal
		handle: 
			[:ex | 
			phiDiv3 := 0.0d.
			ex return]
		do: [phiDiv3 := (q negated / (p * p * p) negated sqrt) modifiedArcCos / 3.0d].
	twoSqrtMinusp := 2.0d * p negated sqrt.
	piDiv3 := Double pi / 3.0d.
	dum := SortedCollection new.
	dum add: twoSqrtMinusp * phiDiv3 cos.
	dum add: twoSqrtMinusp * (phiDiv3 + piDiv3) cos negated.
	dum add: twoSqrtMinusp * (phiDiv3 - piDiv3) cos negated.
	roots := DiagonalMatrix new: 3.
	1 to: 3 do: [:i | roots at: i put: (dum at: i)
				- (a / 3.0d)].
	lam1 := roots at: 1.
	lam2 := roots at: 2.
	lam3 := roots at: 3.
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
	roots at: 1 put: lam1.
	roots at: 2 put: lam2.
	roots at: 3 put: lam3.
	^roots
]

{ #category : #'basic ops' }
FullMatrix >> eigenvectorsFor: eigenvalues [ 
	"For inertia matrix case only. Eigenvalues are orders from smallest to largest."

	| lam1 lam2 lam3 aAcm eigenvector2 eigenvector3 eigenvector1 |
	lam1 := eigenvalues at: 1.
	lam2 := eigenvalues at: 2.
	lam3 := eigenvalues at: 3.
	lam1 = lam2
		ifTrue: [lam2 = lam3
				ifTrue: [^aAcm := (FullMatrix identity: 3)]
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
	aAcm := FullMatrix new: 3 by: 3.
	aAcm at: 1 and: 1 putFullColumn: eigenvector1.
	aAcm at: 1 and: 2 putFullColumn: eigenvector2.
	aAcm at: 1 and: 3 putFullColumn: eigenvector3.
	^aAcm
]

{ #category : #accessing }
FullMatrix >> eulerParameters [
	"Given [A], compute Euler parameter."

	| traceA qE OneMinusTraceDivFour dumSq dum max num maxE FourE |
	traceA := self trace.
	qE := EulerParameters new.
	OneMinusTraceDivFour := 1.0d - traceA / 4.0d.
	1 to: 3
		do: 
			[:i | 
			dumSq := (self at: i and: i)
						/ 2.0d + OneMinusTraceDivFour.
			dum := dumSq > 0.0d
						ifTrue: [dumSq sqrt]
						ifFalse: [0.0d].
			qE at: i put: dum].
	dumSq := 1.0d + traceA / 4.0d.
	dum := dumSq > 0.0d
				ifTrue: [dumSq sqrt]
				ifFalse: [0.0d].
	qE at: 4 put: dum.
	max := 0.0d.
	1 to: 4
		do: 
			[:i | 
			num := qE at: i.
			max < num
				ifTrue: 
					[max := num.
					maxE := i]].
	maxE = 1
		ifTrue: 
			[FourE := 4.0d * (qE at: 1).
			qE at: 2 put: (self at: 1 and: 2)
					+ (self at: 2 and: 1) / FourE.
			qE at: 3 put: (self at: 1 and: 3)
					+ (self at: 3 and: 1) / FourE.
			qE at: 4 put: (self at: 3 and: 2)
					- (self at: 2 and: 3) / FourE].
	maxE = 2
		ifTrue: 
			[FourE := 4.0d * (qE at: 2).
			qE at: 1 put: (self at: 1 and: 2)
					+ (self at: 2 and: 1) / FourE.
			qE at: 3 put: (self at: 2 and: 3)
					+ (self at: 3 and: 2) / FourE.
			qE at: 4 put: (self at: 1 and: 3)
					- (self at: 3 and: 1) / FourE].
	maxE = 3
		ifTrue: 
			[FourE := 4.0d * (qE at: 3).
			qE at: 1 put: (self at: 1 and: 3)
					+ (self at: 3 and: 1) / FourE.
			qE at: 2 put: (self at: 2 and: 3)
					+ (self at: 3 and: 2) / FourE.
			qE at: 4 put: (self at: 2 and: 1)
					- (self at: 1 and: 2) / FourE].
	maxE = 4
		ifTrue: 
			[FourE := 4.0d * (qE at: 4).
			qE at: 1 put: (self at: 3 and: 2)
					- (self at: 2 and: 3) / FourE.
			qE at: 2 put: (self at: 1 and: 3)
					- (self at: 3 and: 1) / FourE.
			qE at: 3 put: (self at: 2 and: 1)
					- (self at: 1 and: 2) / FourE].
	^qE conditionSelf calc
]

{ #category : #testing }
FullMatrix >> isDiagonalToWithin: ratio [ 
	| maxElement tol nrow |
	maxElement := self maxElement.
	tol := ratio * maxElement.
	nrow := self nrow.
	nrow == self ncol
		ifTrue: 
			[1 to: nrow do: [:i | i + 1 to: nrow
					do: 
						[:j | 
						(self at: i and: j) abs > tol ifTrue: [^false].
						(self at: j and: i) abs > tol ifTrue: [^false]]].
			^true]
		ifFalse: [^false]
]

{ #category : #accessing }
FullMatrix >> matrixSolverClass [
	^GEFullMatParPv
]

{ #category : #'basic ops' }
FullMatrix >> minusFullMatrix: aFullMatrix [ 
	"No checking for speed. Assumes correct dimensions and type."

	| nrow answer |
	nrow := self nrow.
	answer := self class new: nrow.
	1 to: nrow do: [:i | answer at: i put: ((self at: i)
				minusFullRow: (aFullMatrix at: i))].
	^answer
]

{ #category : #'basic ops' }
FullMatrix >> minusFullMatrix: aFullMatrix times: aNumber [ 
	"No checking for speed. Assumes correct dimensions and type."

	| nrow answer |
	nrow := self nrow.
	answer := self class new: nrow.
	1 to: nrow do: [:i | answer at: i put: ((self at: i)
				minusFullRow: (aFullMatrix at: i)
				times: aNumber)].
	^answer
]

{ #category : #'basic ops' }
FullMatrix >> minusSelfTransposed [
	^self minusFullMatrix: self transpose
]

{ #category : #'basic ops' }
FullMatrix >> plusFullMatrix: aFullMatrix [ 
	"No checking for speed. Assumes correct dimensions and type."

	| nrow answer |
	nrow := self nrow.
	answer := self class new: nrow.
	1 to: nrow do: [:i | answer at: i put: ((self at: i)
				plusFullRow: (aFullMatrix at: i))].
	^answer
]

{ #category : #'basic ops' }
FullMatrix >> plusFullMatrix: aFullMatrix times: aNumber [ 
	"No checking for speed. Assumes correct dimensions and type."

	| nrow answer |
	nrow := self nrow.
	answer := self class new: nrow.
	1 to: nrow do: [:i | answer at: i put: ((self at: i)
				plusFullRow: (aFullMatrix at: i)
				times: aNumber)].
	^answer
]

{ #category : #'basic ops' }
FullMatrix >> plusSelfTransposed [
	^self plusFullMatrix: self transpose
]

{ #category : #accessing }
FullMatrix >> secondDimensionClass [
	^FullRow
]

{ #category : #'basic ops' }
FullMatrix >> times: alpha minusFullMatrix: aFullMatrix [ 
	"a*alpha - b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| nrow answer |
	nrow := self nrow.
	answer := self class new: nrow.
	1 to: nrow do: [:i | answer at: i put: ((self at: i)
				times: alpha minusFullRow: (aFullMatrix at: i))].
	^answer
]

{ #category : #'basic ops' }
FullMatrix >> times: beta minusFullMatrix: aFullMatrix times: alpha [ 
	"a*alpha + b*beta = b*beta + a*alpha."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| nrow answer |
	nrow := self nrow.
	answer := self class new: nrow.
	1 to: nrow do: [:i | answer at: i put: ((self at: i)
				times: beta
				minusFullRow: (aFullMatrix at: i)
				times: alpha)].
	^answer
]

{ #category : #'basic ops' }
FullMatrix >> times: alpha plusFullMatrix: aFullMatrix [ 
	"a*alpha + b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| nrow answer |
	nrow := self nrow.
	answer := self class new: nrow.
	1 to: nrow do: [:i | answer at: i put: ((self at: i)
				times: alpha plusFullRow: (aFullMatrix at: i))].
	^answer
]

{ #category : #'basic ops' }
FullMatrix >> times: beta plusFullMatrix: aFullMatrix times: alpha [ 
	"a*alpha + b*beta = b*beta + a*alpha."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| nrow answer |
	nrow := self nrow.
	answer := self class new: nrow.
	1 to: nrow do: [:i | answer at: i put: ((self at: i)
				times: beta
				plusFullRow: (aFullMatrix at: i)
				times: alpha)].
	^answer
]

{ #category : #'basic ops' }
FullMatrix >> timesZeroColumn: aZeroColumn [ 
	"a*b = a(i,j)b(j) sum j."

	^aZeroColumn class new: self nrow
]

{ #category : #'basic ops' }
FullMatrix >> timesZeroMatrix: aZeroMatrix [ 
	"a*b = a(i,j)b(j,k) sum j."

	^aZeroMatrix class new: self nrow by: aZeroMatrix ncol
]

{ #category : #'basic ops' }
FullMatrix >> transpose [
	"Returns a new Matrix which is the transpose of self."

	| nrow ncol answer rowi |
	nrow := self nrow.
	ncol := self ncol.
	answer := self class new: ncol by: nrow.
	1 to: nrow
		do: 
			[:i | 
			rowi := self at: i.
			1 to: ncol do: [:j | answer
					at: j
					and: i
					put: (rowi at: j)]].
	^answer
]

{ #category : #'basic ops' }
FullMatrix >> transposeTimes: aNumber [ 
	| nrow ncol answer |
	nrow := self nrow.
	ncol := self ncol.
	answer := self class new: ncol by: nrow.
	1 to: nrow
		do: 
			[:i | 
			| aVectori |
			aVectori := self at: i.
			1 to: ncol do: [:j | answer
					at: j
					and: i
					put: (aVectori at: j)
							* aNumber]].
	^answer
]

{ #category : #'basic ops' }
FullMatrix >> transposeTimesDiagonalMatrix: aDiagonalMatrix [ 
	"aTb = (bTa)T=(ba)T"

	^(aDiagonalMatrix timesFullMatrix: self) transpose
]

{ #category : #'basic ops' }
FullMatrix >> transposeTimesFullColumn1: aFullColumn [ 
	"aT*b = a(i,j)b(i) sum i."

	| answer nrow ncol |
	answer := (self at: 1)
				times: (aFullColumn at: 1).
	nrow := self nrow.
	ncol := self ncol.
	2 to: nrow
		do: 
			[:i | 
			| ai bi |
			ai := self at: i.
			bi := aFullColumn at: i.
			1 to: ncol do: [:j | answer at: j put: (answer at: j)
						+ ((ai at: j)
								* bi)]].
	^answer
]

{ #category : #'basic ops' }
FullMatrix >> transposeTimesFullColumn: aFullColumn [ 
	"aT*b = (bTa)T a(i,j)b(i) sum i."
	"Transpose of vector is easier than transpose of matrix."

	^(aFullColumn transpose timesFullMatrix: self) transpose
]

{ #category : #'basic ops' }
FullMatrix >> transposeTimesZeroColumn: aZeroColumn [ 
	"aT*b = a(i,j)b(i) sum i."

	^aZeroColumn class new: self ncol
]

{ #category : #'basic ops' }
FullMatrix >> transposeTimesZeroMatrix: aZeroMatrix [ 
	"aT*b = a(i,j)b(i,k) sum i."

	^aZeroMatrix class new: self ncol by: aZeroMatrix ncol
]
