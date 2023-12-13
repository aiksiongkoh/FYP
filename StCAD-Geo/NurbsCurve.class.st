"
Ref: The NURBS Book, 2nd Ed. by Les Piegl and Wayne Tiller.
cPoint is the collection of control points (p0, p1, ..., pn)
cWeight is the collection of weights (w0, w1, ..., wn)
cUKnot is the collection of knots (u0, u1, ..., um)
The degree of the spline is p.
m + 1 = (n + 1) + (p + 1).
In words: nKnot - nPoint = degree + 1.
The end values of the knots are identical for (p+ 1) values.
(a, a, ..., a, up+1, up+2, ..., um-p-2, um-p-1, b, ...,b, b)

B-Spline basis functions
Ni,j := basis function for span i of degree j.
i = 0, ..., m-1
j = 0, ..., p


Instance Variables:
	cPoint	<Object>	description of cPoint
	cUKnot	<Object>	description of cUKnot
	cWeight	<Object>	description of cWeight


"
Class {
	#name : #NurbsCurve,
	#superclass : #Curve3D,
	#instVars : [
		'cPoint',
		'cWeight',
		'cWPoint',
		'cuKnot',
		'uDegree',
		'umin',
		'umax'
	],
	#classVars : [
		'Geo'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #accessing }
NurbsCurve class >> CcBinomial [
	^CcBinomial
]

{ #category : #accessing }
NurbsCurve class >> aMatrixNu_cu: cu cuKnot: cuKnot uDegree: uDegree [ 
	"
	Ref: The NURBS Book, 2nd Ed. by Les Piegl and Wayne Tiller.
	pp. 70, 369
	"

	| nPoint aMatrixNu |
	nPoint := cu size.
	aMatrixNu := SparseMatrix new: nPoint by: nPoint.
	0 to: nPoint - 1
		do: 
			[:i | 
			| i1 rowi1 u uSpan cNu |
			i1 := i + 1.
			rowi1 := aMatrixNu at: i1.
			u := cu at: i1.
			uSpan := self 
						uSpan_at: u
						cuKnot: cuKnot
						uDegree: uDegree.
			cNu := self 
						cNu_at: u
						uSpan: uSpan
						cuKnot: cuKnot
						uDegree: uDegree.
			0 to: uDegree
				do: 
					[:j | 
					| jj |
					jj := uSpan - uDegree + j.
					rowi1 at: jj put: (cNu at: j + 1)]].
	^aMatrixNu
]

{ #category : #utilities }
NurbsCurve class >> cNu_at: u uSpan: uSpan cuKnot: cuKnot uDegree: uDegree [ 
	"
	Ref: The NURBS Book, 2nd Ed. by Les Piegl and Wayne Tiller.
	pp. 70
	"

	| cN left right uSpan1 |
	cN := MathArray new: uDegree + 1.
	left := MathArray new: uDegree.
	right := MathArray new: uDegree.
	uSpan1 := uSpan + 1.
	cN at: 1 put: 1.0d.
	1 to: uDegree
		do: 
			[:i | 
			| saved |
			left at: i put: u - (cuKnot at: uSpan1 - i).
			right at: i put: (cuKnot at: uSpan + i) - u.
			saved := 0.0d.
			0 to: i - 1
				do: 
					[:j | 
					| jj rightjj leftij temp |
					jj := j + 1.
					rightjj := right at: jj.
					leftij := left at: i - j.
					temp := (cN at: jj) / (rightjj + leftij).
					cN at: jj put: saved + (rightjj * temp).
					saved := leftij * temp].
			cN at: i + 1 put: saved].
	^cN
]

{ #category : #utilities }
NurbsCurve class >> ccDerivNu_at: u uDeriv: uDeriv uSpan: uSpan cuKnot: cuKnot uDegree: uDegree [ 
	"
	Ref: The NURBS Book, 2nd Ed. by Les Piegl and Wayne Tiller.
	pp. 72
	"

	| uDegree1 ccDerivN ccNdu ccA left right uSpan1 product |
	uDegree1 := uDegree + 1.
	ccDerivN := FullMatrix new: uDeriv + 1 by: uDegree1.
	ccNdu := FullMatrix new: uDegree1 by: uDegree1.
	ccA := FullMatrix new: 2 by: uDegree1.
	left := MathArray new: uDegree.
	right := MathArray new: uDegree.
	uSpan1 := uSpan + 1.
	ccNdu 
		at: 1
		and: 1
		put: 1.0d.
	1 to: uDegree
		do: 
			[:i | 
			| ii saved |
			left at: i put: u - (cuKnot at: uSpan1 - i).
			right at: i put: (cuKnot at: uSpan + i) - u.
			saved := 0.0d.
			ii := i + 1.
			0 to: i - 1
				do: 
					[:j | 
					| jj rightjj leftij aNduij temp |
					jj := j + 1.
					rightjj := right at: jj.
					leftij := left at: i - j.
					aNduij := rightjj + leftij.
					ccNdu 
						at: ii
						and: jj
						put: aNduij.
					temp := (ccNdu at: jj and: i) / aNduij.
					ccNdu 
						at: jj
						and: ii
						put: saved + (rightjj * temp).
					saved := leftij * temp].
			ccNdu 
				at: ii
				and: ii
				put: saved].
	0 to: uDegree
		do: 
			[:i | 
			| ii |
			ii := i + 1.
			ccDerivN 
				at: 1
				and: ii
				put: (ccNdu at: ii and: uDegree1)].
	0 to: uDegree
		do: 
			[:i | 
			| ii s1 s2 |
			ii := i + 1.
			s1 := 1.
			s2 := 2.
			ccA 
				at: 1
				and: 1
				put: 1.0d.
			1 to: uDeriv
				do: 
					[:j | 
					| jj d ij ij1 pj pj1 k1 k2 tmp |
					jj := j + 1.
					d := 0.0d.
					ij := i - j.
					ij1 := ij + 1.
					pj := uDegree - j.
					pj1 := pj + 1.
					i >= j 
						ifTrue: 
							[| temp |
							temp := (ccA at: s1 and: 1) / (ccNdu at: pj1 + 1 and: ij1).
							ccA 
								at: s2
								and: 1
								put: temp.
							d := temp * (ccNdu at: ij1 and: pj1)].
					k1 := ij >= -1 ifTrue: [1] ifFalse: [ij negated].
					k2 := i - 1 <= pj ifTrue: [j - 1] ifFalse: [uDegree - i].
					k1 to: k2
						do: 
							[:k | 
							| kk ijk1 temp |
							kk := k + 1.
							ijk1 := ij1 + k.
							temp := ((ccA at: s1 and: kk) - (ccA at: s1 and: k)) 
										/ (ccNdu at: pj1 + 1 and: ijk1).
							ccA 
								at: s2
								and: kk
								put: temp.
							d := d + (temp * (ccNdu at: ijk1 and: pj1))].
					i <= pj 
						ifTrue: 
							[| temp |
							temp := (ccA at: s1 and: j) negated / (ccNdu at: pj1 + 1 and: ii).
							ccA 
								at: s2
								and: jj
								put: temp.
							d := d + (temp * (ccNdu at: ii and: pj1))].
					ccDerivN 
						at: jj
						and: ii
						put: d.
					tmp := s1.
					s1 := s2.
					s2 := tmp]].
	product := uDegree.
	1 to: uDeriv
		do: 
			[:i | 
			| ii |
			ii := i + 1.
			0 to: uDegree
				do: 
					[:j | 
					| jj |
					jj := j + 1.
					ccDerivN 
						at: ii
						and: jj
						put: product * (ccDerivN at: ii and: jj)].
			product := product * (uDegree - i)].
	^ccDerivN
]

{ #category : #accessing }
NurbsCurve class >> cuKnot_cu: cu uDegree: uDegree [ 
	| nPoint uDegree1 nKnot cKnot |
	nPoint := cu size.
	uDegree1 := uDegree + 1.
	nKnot := nPoint + uDegree1.
	cKnot := FullColumn new: nKnot.
	0 to: uDegree
		do: 
			[:i | 
			cKnot at: i + 1 put: 0.0d.
			cKnot at: nKnot - i put: 1.0d].
	1 to: nPoint - 1 - uDegree
		do: 
			[:i | 
			| sum |
			sum := 0.0d.
			i to: i + uDegree - 1 do: [:j | sum := sum + (cu at: j + 1)].
			cKnot at: i + uDegree1 put: sum / uDegree].
	^cKnot
]

{ #category : #accessing }
NurbsCurve class >> cu_cDataPoint: cDataPoint [ 
	| n cdelta d cu u |
	n := cDataPoint size.
	cdelta := cDataPoint shallowCopy.
	d := 0.0d.
	2 to: n
		do: 
			[:i | 
			| delta |
			delta := ((cDataPoint at: i) - (cDataPoint at: i - 1)) length.
			cdelta at: i put: delta.
			d := d + delta].
	cu := cDataPoint shallowCopy.
	cu at: 1 put: 0.0d.
	cu at: n put: 1.0d.
	u := 0.0d.
	2 to: n - 1
		do: 
			[:i | 
			u := u + ((cdelta at: i) / d).
			cu at: i put: u].
	^cu
]

{ #category : #'instance creation' }
NurbsCurve class >> ellipse_xRadius: xRadius yRadius: yRadius [

	| answer mxRadius myRadius cPoint cWeight oneOverRootTwo cuKnot |
	answer := self new.
	mxRadius := xRadius negated.
	myRadius := yRadius negated.
	cPoint := MathArray new: 9.
	cPoint at: 1 put: (FullColumn with: xRadius with: 0.0d with: 0.0d).
	cPoint at: 2 put: (FullColumn with: xRadius with: yRadius with: 0.0d).
	cPoint at: 3 put: (FullColumn with: 0.0d with: yRadius with: 0.0d).
	cPoint at: 4 put: (FullColumn with: mxRadius with: yRadius with: 0.0d).
	cPoint at: 5 put: (FullColumn with: mxRadius with: 0.0d with: 0.0d).
	cPoint at: 6 put: (FullColumn with: mxRadius with: myRadius with: 0.0d).
	cPoint at: 7 put: (FullColumn with: 0.0d with: myRadius with: 0.0d).
	cPoint at: 8 put: (FullColumn with: xRadius with: myRadius with: 0.0d).
	cPoint at: 9 put: (FullColumn with: xRadius with: 0.0d with: 0.0d).
	answer _cPoint: cPoint.
	cWeight := MathArray new: 9.
	oneOverRootTwo := 1 / 2.0d sqrt.
	cWeight at: 1 put: 1.0d.
	cWeight at: 2 put: oneOverRootTwo.
	cWeight at: 3 put: 1.0d.
	cWeight at: 4 put: oneOverRootTwo.
	cWeight at: 5 put: 1.0d.
	cWeight at: 6 put: oneOverRootTwo.
	cWeight at: 7 put: 1.0d.
	cWeight at: 8 put: oneOverRootTwo.
	cWeight at: 9 put: 1.0d.
	answer cWeight: cWeight.
	cuKnot := MathArray new: 12.
	cuKnot at: 1 put: 0.0d.
	cuKnot at: 2 put: 0.0d.
	cuKnot at: 3 put: 0.0d.
	cuKnot at: 4 put: 0.25d.
	cuKnot at: 5 put: 0.25d.
	cuKnot at: 6 put: 0.5d.
	cuKnot at: 7 put: 0.5d.
	cuKnot at: 8 put: 0.75d.
	cuKnot at: 9 put: 0.75d.
	cuKnot at: 10 put: 1.0d.
	cuKnot at: 11 put: 1.0d.
	cuKnot at: 12 put: 1.0d.
	answer _cuKnot: cuKnot.
	^answer
]

{ #category : #examples }
NurbsCurve class >> example1 [
	"NurbsCurve example1"

	| answer |
	answer := self exampleCircle.
	answer atU: -1.0d.
	answer atU: -0.5d.
	answer atU: 0.0d.
	answer atU: 0.5d.
	answer atU: 1.0d.
	answer atU: 1.5d.
	answer atU: 2.0d.
	answer atU: 2.5d.
	answer atU: 3.0d.
	answer atU: 3.5d.
	answer atU: 4.0d.
	answer atU: 4.5d.
	answer atU: 5.0d
]

{ #category : #examples }
NurbsCurve class >> example2 [
	"NurbsCurve example2"

	| answer |
	answer := self exampleCircle.
	answer derivative: 1 at: -1.0d.
	answer derivative: 1 at: -0.5d.
	answer derivative: 1 at: 0.0d.
	answer derivative: 1 at: 0.5d.
	answer derivative: 1 at: 1.0d.
	answer derivative: 1 at: 1.5d.
	answer derivative: 1 at: 2.0d.
	answer derivative: 1 at: 2.5d.
	answer derivative: 1 at: 3.0d.
	answer derivative: 1 at: 3.5d.
	answer derivative: 1 at: 4.0d.
	answer derivative: 1 at: 4.5d.
	answer derivative: 1 at: 5.0d
]

{ #category : #examples }
NurbsCurve class >> example2a [
	"NurbsCurve example2a"

	| answer |
	answer := self exampleLine.
	answer derivative: 1 at: -1.0d.
	answer derivative: 1 at: -0.5d.
	answer derivative: 1 at: 0.0d.
	answer derivative: 1 at: 0.5d.
	answer derivative: 1 at: 1.0d.
	answer derivative: 1 at: 1.5d.
	answer derivative: 1 at: 2.0d.
	answer derivative: 1 at: 2.5d.
	answer derivative: 1 at: 3.0d.
	answer derivative: 1 at: 3.5d.
	answer derivative: 1 at: 4.0d.
	answer derivative: 1 at: 4.5d.
	answer derivative: 1 at: 5.0d
]

{ #category : #examples }
NurbsCurve class >> example2b [
	"NurbsCurve example2b"

	| answer |
	answer := self exampleTest.
	answer derivative: 2 at: 2.5d
]

{ #category : #examples }
NurbsCurve class >> exampleCircle [
	"NurbsCurve exampleCircle"

	| cPoint cWeight cuKnot |
	cPoint := Array new: 9.
	cPoint at: 1 put: (0 , -1 , 0) asFullColumn.
	cPoint at: 2 put: (1 , -1 , 0) asFullColumn.
	cPoint at: 3 put: (1 , 0 , 0) asFullColumn.
	cPoint at: 4 put: (1 , 1 , 0) asFullColumn.
	cPoint at: 5 put: (0 , 1 , 0) asFullColumn.
	cPoint at: 6 put: (-1 , 1 , 0) asFullColumn.
	cPoint at: 7 put: (-1 , 0 , 0) asFullColumn.
	cPoint at: 8 put: (-1 , -1 , 0) asFullColumn.
	cPoint at: 9 put: (0 , -1 , 0) asFullColumn.
	cWeight := Array new: 9.
	cWeight at: 1 put: 1.0d.
	cWeight at: 2 put: 1 / 2.0d sqrt.
	cWeight at: 3 put: 1.0d.
	cWeight at: 4 put: 1 / 2.0d sqrt.
	cWeight at: 5 put: 1.0d.
	cWeight at: 6 put: 1 / 2.0d sqrt.
	cWeight at: 7 put: 1.0d.
	cWeight at: 8 put: 1 / 2.0d sqrt.
	cWeight at: 9 put: 1.0d.
	cuKnot := #(0 0 0 1 1 2 2 3 3 4 4 4).
	^(self new)
		_cPoint: cPoint;
		cWeight: cWeight;
		_cuKnot: cuKnot;
		yourself
]

{ #category : #examples }
NurbsCurve class >> exampleEllipticArc [

	"NurbsCurve exampleEllipticArc"

	| aEllipticArc aNurbs |
	aEllipticArc := StCAD_Geo_EllipticArc new
		                xRadius: 1.0 d;
		                yRadius: 2.0 d;
		                theStart: 0.0 d;
		                theEnd: 1.5 d * Double pi;
		                yourself. "VW_TRANSLATION:StCAD.Geo.EllipticArc:StCAD_Geo_EllipticArc"
	aNurbs := NurbsCurve fromEllipticArc: aEllipticArc.
	aNurbs asJunOpenGL3dNurbsCurve show
]

{ #category : #examples }
NurbsCurve class >> exampleLine [
	"NurbsCurve exampleLine"

	| cPoint cWeight cuKnot |
	cPoint := Array new: 2.
	cPoint at: 1 put: (0 , 0 , 0) asFullColumn.
	cPoint at: 2 put: (1 , 1 , 0) asFullColumn.
	cWeight := Array new: 2.
	cWeight at: 1 put: 1.0d.
	cWeight at: 2 put: 1.0d.
	cuKnot := #(0 0 1 1).
	^(self new)
		_cPoint: cPoint;
		cWeight: cWeight;
		_cuKnot: cuKnot;
		yourself
]

{ #category : #examples }
NurbsCurve class >> exampleTest [
	"NurbsCurve exampleTest"

	| cPoint cWeight cuKnot |
	cPoint := Array new: 8.
	cPoint at: 1 put: (0 , 0 , 0) asFullColumn.
	cPoint at: 2 put: (1 , 1 , 0) asFullColumn.
	cPoint at: 3 put: (0 , 0 , 0) asFullColumn.
	cPoint at: 4 put: (1 , 1 , 0) asFullColumn.
	cPoint at: 5 put: (0 , 0 , 0) asFullColumn.
	cPoint at: 6 put: (1 , 1 , 0) asFullColumn.
	cPoint at: 7 put: (0 , 0 , 0) asFullColumn.
	cPoint at: 8 put: (1 , 1 , 0) asFullColumn.
	cWeight := Array new: 8.
	cWeight at: 1 put: 1.0d.
	cWeight at: 2 put: 1.0d.
	cWeight at: 3 put: 1.0d.
	cWeight at: 4 put: 1.0d.
	cWeight at: 5 put: 1.0d.
	cWeight at: 6 put: 1.0d.
	cWeight at: 7 put: 1.0d.
	cWeight at: 8 put: 1.0d.
	cuKnot := #(0 0 0 1 2 3 4 4 5 5 5).
	^(self new)
		_cPoint: cPoint;
		cWeight: cWeight;
		_cuKnot: cuKnot;
		yourself
]

{ #category : #'instance creation' }
NurbsCurve class >> fromCircle: aCircle [

	| radius |
	radius := aCircle xRadius.
	^self ellipse_xRadius: radius yRadius: radius
]

{ #category : #'instance creation' }
NurbsCurve class >> fromEllipse: aEllipse [

	^self ellipse_xRadius: aEllipse xRadius yRadius: aEllipse yRadius
]

{ #category : #'instance creation' }
NurbsCurve class >> fromEllipticArc: aEllipticArc [ 
	"Refer to Nurbs Book pp 310."

	| theStart theEnd nseg ndegree dthe cPoint cWeight cuKnot aSmallEllipticArc aNurbs answer |
	theStart := aEllipticArc theStart.
	theEnd := aEllipticArc theEnd.
	nseg := ((theEnd - theStart) / Double halfPi) ceiling.
	ndegree := 2.
	dthe := (theEnd - theStart) / nseg.
	cPoint := (MathArray new: nseg * ndegree + 1) writeStream.
	cWeight := (MathArray new: nseg * ndegree + 1) writeStream.
	cuKnot := (MathArray new: (nseg + 1) * ndegree + 2) writeStream.
	aSmallEllipticArc := aEllipticArc copy.
	aSmallEllipticArc theStart: theStart.
	aSmallEllipticArc theEnd: theStart + dthe.
	self assert: [aSmallEllipticArc isOK].
	aNurbs := self fromSmallEllipticArc: aSmallEllipticArc.
	1 to: ndegree + 1
		do: 
			[:i | 
			cPoint nextPut: (aNurbs cPoint at: i).
			cWeight nextPut: (aNurbs cWeight at: i).
			cuKnot nextPut: 0.0d].
	2 to: nseg
		do: 
			[:i | 
			aSmallEllipticArc := aEllipticArc copy.
			aSmallEllipticArc theStart: theStart + ((i - 1) * dthe).
			aSmallEllipticArc theEnd: theStart + (i * dthe).
			self assert: [aSmallEllipticArc isOK].
			aNurbs := self fromSmallEllipticArc: aSmallEllipticArc.
			1 to: ndegree
				do: 
					[:ii | 
					cPoint nextPut: (aNurbs cPoint at: 1 + ii).
					cWeight nextPut: (aNurbs cWeight at: 1 + ii).
					cuKnot nextPut: ((i - 1) / nseg) asDouble]].
	ndegree + 1 timesRepeat: [cuKnot nextPut: 1.0d].
	answer := self new.
	answer _cPoint: cPoint contents.
	answer cWeight: cWeight contents.
	answer _cuKnot: cuKnot contents.
	^answer
]

{ #category : #'instance creation' }
NurbsCurve class >> fromLine: aLine [ 
	| answer cPoint cWeight cuKnot |
	answer := self new.
	cPoint := MathArray with: aLine rfstartf with: aLine rfendf.
	answer _cPoint: cPoint.
	cWeight := MathArray with: 1.0d with: 1.0d.
	answer cWeight: cWeight.
	cuKnot := #(0.0d 0.0d 1.0d 1.0d).
	answer _cuKnot: cuKnot copy.
	^answer
]

{ #category : #'instance creation' }
NurbsCurve class >> fromSmallEllipticArc: aEllipticArc [ 
	"
	Refer to Nurbs Book pp 310.
	Subtended angle is =< 120 degrees.
	"

	| theStart theEnd p0 p2 t0 t2 p v02 array p1 v1p alf0 alf2 a u num den w1 answer cPoint cWeight cuKnot |
	theStart := aEllipticArc theStart.
	theEnd := aEllipticArc theEnd.
	p0 := aEllipticArc rfpf_the: theStart.
	p2 := aEllipticArc rfpf_the: theEnd.
	t0 := aEllipticArc tangentAt: theStart.
	t2 := aEllipticArc tangentAt: theEnd.
	p := aEllipticArc rfpf_the: (theStart + theEnd) / 2.0d.
	v02 := p2 - p0.
	array := Line 
				dataIntersectionPoint: p0
				aDir: t0
				bPoint: p2
				bDir: t2
				tolerance: 1.0d-9.
	self assert: [array first]
		do: 
			[p1 := array at: 2.
			v1p := p - p1.
			array := Line 
						dataIntersectionPoint: p1
						aDir: v1p
						bPoint: p0
						bDir: v02
						tolerance: 1.0d-9.
			self assert: [array first]
				do: 
					[alf0 := array at: 3.
					alf2 := array at: 4.
					a := (alf2 / (1.0d - alf2)) sqrt.
					u := a / (1.0d + a).
					num := (1.0d - u) squared * (p - p0 dot: p1 - p) 
								+ (u squared * (p - p2 dot: p1 - p)).
					den := 2.0d * u * (1.0d - u) * (p1 - p) sumOfSquares.
					w1 := num / den]].
	answer := self new.
	cPoint := MathArray 
				with: p0
				with: p1
				with: p2.
	cWeight := MathArray 
				with: 1.0d
				with: w1
				with: 1.0d.
	cuKnot := MathArray new: 6.
	cuKnot at: 1 put: 0.0d.
	cuKnot at: 2 put: 0.0d.
	cuKnot at: 3 put: 0.0d.
	cuKnot at: 4 put: 1.0d.
	cuKnot at: 5 put: 1.0d.
	cuKnot at: 6 put: 1.0d.
	answer _cPoint: cPoint.
	answer cWeight: cWeight.
	answer _cuKnot: cuKnot.
	^answer
]

{ #category : #'instance creation' }
NurbsCurve class >> fromStart: aStart toEnd: aEnd [ 
	| answer cPoint cWeight cuKnot |
	answer := self new.
	cPoint := MathArray with: aStart with: aEnd.
	answer _cPoint: cPoint.
	cWeight := MathArray with: 1.0d with: 1.0d.
	answer cWeight: cWeight.
	cuKnot := #(0.0d 0.0d 1.0d 1.0d).
	answer _cuKnot: cuKnot copy.
	^answer
]

{ #category : #accessing }
NurbsCurve class >> fromcDataPoint: cDataPoint uDegree: uDegree [ 
	"Interpolate thru cDataPoint.
	Ref: The NURBS Book, 2nd Ed. by Les Piegl and Wayne Tiller.
	pp 369
	"

	| cu cuKnot aMatrix cPoint cWeight |
	cu := self cu_cDataPoint: cDataPoint.
	cuKnot := self cuKnot_cu: cu uDegree: uDegree.
	aMatrix := self 
				aMatrixNu_cu: cu
				cuKnot: cuKnot
				uDegree: uDegree.
	cPoint := GESpMatParPvMarkoFast new 
				solve: aMatrix
				with: cDataPoint asFullColumn
				saveOriginal: false.
	cWeight := (cPoint shallowCopy)
				atAllPut: 1.0d;
				yourself.
	^(self new)
		_cPoint: cPoint;
		cWeight: cWeight;
		_cuKnot: cuKnot;
		yourself
]

{ #category : #'class initialization' }
NurbsCurve class >> initialize [
	"self initialize."

	| n aRow previousRow |
	n := 10.
	CcBinomial := MathArray new: n.
	aRow := FullRow new: 1.
	aRow at: 1 put: 1.
	CcBinomial at: 1 put: aRow.
	previousRow := aRow.
	2 to: n
		do: 
			[:i | 
			aRow := FullRow new: i.
			aRow at: 1 put: 1.
			2 to: i - 1
				do: [:j | aRow at: j put: (previousRow at: j - 1) + (previousRow at: j)].
			aRow at: i put: 1.
			CcBinomial at: i put: aRow.
			previousRow := aRow].
	^CcBinomial
]

{ #category : #utilities }
NurbsCurve class >> uSpan_at: u cuKnot: cuKnot uDegree: uDegree [ 
	"
	Ref: The NURBS Book, 2nd Ed. by Les Piegl and Wayne Tiller.
	pp. 68
	"

	| iFirst iLast iLast1 iLow iHigh iMiddle |
	iFirst := uDegree + 1.
	iLast := cuKnot size - iFirst.
	iLast1 := iLast + 1.
	^u = (cuKnot at: iLast1) 
		ifTrue: [iLast]
		ifFalse: 
			[iLow := iFirst.
			iHigh := iLast1.
			
			[iMiddle := (iLow + iHigh) // 2.
			iLow = iMiddle] whileFalse: 
						[u < (cuKnot at: iMiddle) 
							ifTrue: [iHigh := iMiddle]
							ifFalse: [iLow := iMiddle]].
			iLow]
]

{ #category : #'VisualWorks metadata' }
NurbsCurve class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #comparing }
NurbsCurve >> = aObject [ 
	^self == aObject or: 
			[self class == aObject class and: 
					[| block |
					block := 
							[:ca :cb | 
							ca size = cb size ifFalse: [^false].
							ca with: cb parallelDo: [:a :b | (a - b) length < 1.0d-9 ifFalse: [^false]]].
					block value: self cPoint value: aObject cPoint.
					block value: self cWeight value: aObject cWeight.
					block value: self cuKnot value: aObject cuKnot.
					true]]
]

{ #category : #accessing }
NurbsCurve >> _cPoint: acPoint [ 
	cPoint := acPoint.
	self calcWPoint.
	self calc_uDegree
]

{ #category : #accessing }
NurbsCurve >> _cWeight: acWeight [ 
	cWeight := acWeight.
	self calcWPoint
]

{ #category : #accessing }
NurbsCurve >> _cuKnot: acuKnot [ 
	cuKnot := acuKnot.
	self calc_uDegree.
	umin := cuKnot first.
	umax := cuKnot last
]

{ #category : #accessing }
NurbsCurve >> aNurbs [
	^self
]

{ #category : #accessing }
NurbsCurve >> asJunOpenGL3dNurbsCurve [
	^JunOpenGL3dNurbsCurve 
		controlPoints: (cPoint first size = 3 
				ifTrue: [cPoint copy]
				ifFalse: [cPoint collect: [:aPoint | aPoint copyWith: 0.0d]])
		weights: cWeight copy
		knotVector: cuKnot copy
]

{ #category : #accessing }
NurbsCurve >> atU: u [ 
	"
	Ref: The NURBS Book, 2nd Ed. by Les Piegl and Wayne Tiller. 
	pp 124.
	"

	| uSpan cN numerator denominator ii nw |
	uSpan := self uspan_at: u.
	cN := self cNu_at: u uSpan: uSpan.
	numerator := FullColumn zero: self nDimension.
	denominator := 0.0d.
	0 to: uDegree
		do: 
			[:i | 
			ii := uSpan - uDegree + i.
			nw := (cN at: i + 1) * (cWeight at: ii).
			numerator equalSelfPlusFullColumn: (cPoint at: ii) times: nw.
			denominator := denominator + nw].
	^numerator / denominator
]

{ #category : #accessing }
NurbsCurve >> be2D [
	cPoint := cPoint collect: [:aPoint | aPoint copyFrom: 1 to: 2]
]

{ #category : #accessing }
NurbsCurve >> boundConicalSurface: aConicalSurface [ 
	aConicalSurface boundByNurbsCurve: self
]

{ #category : #accessing }
NurbsCurve >> boundCylindricalSurface: aCylindricalSurface [ 
	aCylindricalSurface boundByNurbsCurve: self
]

{ #category : #accessing }
NurbsCurve >> boundNurbsSurface: aNurbsSurface [ 
	aNurbsSurface boundByNurbsCurve: self
]

{ #category : #accessing }
NurbsCurve >> boundRectSurface: aRectSurface [ 
	aRectSurface boundByNurbsCurve: self
]

{ #category : #accessing }
NurbsCurve >> boundSphericalSurface: aSphericalSurface [ 
	aSphericalSurface boundByNurbsCurve: self
]

{ #category : #accessing }
NurbsCurve >> boundSurfaceOfRevolution: aSurfaceOfRevolution [ 
	aSurfaceOfRevolution boundByNurbsCurve: self
]

{ #category : #accessing }
NurbsCurve >> boundToroidalSurface: aToroidalSurface [ 
	"Do nothing."
]

{ #category : #accessing }
NurbsCurve >> cDeriv: iDeriv u: u [ 
	"
	Ref: The NURBS Book, 2nd Ed. by Les Piegl and Wayne Tiller.
	pp 93 and 127.
	"

	| iDeriv1 nDimension iDerivu cDeriv cDerivP cDerivW uSpan ccDerivNu |
	iDeriv1 := iDeriv + 1.
	nDimension := self nDimension.
	iDerivu := iDeriv min: uDegree.
	cDeriv := FullColumn new: iDeriv1.
	cDerivP := FullColumn new: iDeriv1.
	cDerivW := FullColumn new: iDeriv1.
	uDegree + 1 to: iDeriv
		do: 
			[:i | 
			| i1 |
			i1 := i + 1.
			cDeriv at: i1 put: (FullColumn zero: nDimension).
			cDerivP at: i1 put: (FullColumn zero: nDimension).
			cDerivW at: i1 put: 0.0d].
	uSpan := self uspan_at: u.
	ccDerivNu := NurbsCurve 
				ccDerivNu_at: u
				uDeriv: iDerivu
				uSpan: uSpan
				cuKnot: cuKnot
				uDegree: uDegree.
	0 to: iDerivu
		do: 
			[:i | 
			| i1 numerator denominator |
			i1 := i + 1.
			numerator := FullColumn zero: nDimension.
			denominator := 0.0d.
			0 to: uDegree
				do: 
					[:j | 
					| j1 jj nw |
					j1 := j + 1.
					jj := uSpan - uDegree + j.
					nw := (ccDerivNu at: i1 and: j1) * (cWeight at: jj).
					numerator equalSelfPlusFullColumn: (cPoint at: jj) times: nw.
					denominator := denominator + nw].
			cDerivP at: i1 put: numerator.
			cDerivW at: i1 put: denominator].
	0 to: iDeriv
		do: 
			[:i | 
			| i1 temp |
			i1 := i + 1.
			temp := cDerivP at: i1.
			1 to: i
				do: 
					[:j | 
					| j1 ij1 bw |
					j1 := j + 1.
					ij1 := i - j + 1.
					bw := ((CcBinomial at: i1) at: j1) negated * (cDerivW at: j1).
					temp equalSelfPlusFullColumn: (cDeriv at: ij1) times: bw].
			cDeriv at: i1 put: temp / (cDerivW at: 1)].
	^cDeriv
]

{ #category : #accessing }
NurbsCurve >> cLineNurbs [
	| n aPoint du bPoint aLineNurbs |
	n := 8.
	aPoint := self atU: umin.
	du := (umax - umin) / n.
	^(1 to: n) collect: 
			[:i | 
			bPoint := self atU: i * du.
			aLineNurbs := NurbsCurve fromStart: aPoint copy toEnd: bPoint copy.
			aPoint := bPoint.
			aLineNurbs]
]

{ #category : #accessing }
NurbsCurve >> cNu_at: u uSpan: uSpan [ 
	^NurbsCurve 
		cNu_at: u
		uSpan: uSpan
		cuKnot: cuKnot
		uDegree: uDegree
]

{ #category : #accessing }
NurbsCurve >> cPoint [
	^cPoint
]

{ #category : #accessing }
NurbsCurve >> cPoint: anObject [
	cPoint := anObject
]

{ #category : #accessing }
NurbsCurve >> cWeight [
	^cWeight
]

{ #category : #accessing }
NurbsCurve >> cWeight: anObject [
	cWeight := anObject
]

{ #category : #calc }
NurbsCurve >> calcWPoint [
	cWPoint := cPoint ifNotNil: 
					[cWeight ifNotNil: 
							[cPoint with: cWeight
								parallelCollect: [:aPoint :aWeight | (aPoint times: aWeight) copyWith: aWeight]]]
]

{ #category : #calc }
NurbsCurve >> calc_uDegree [
	cPoint 
		ifNotNil: [cuKnot ifNotNil: [uDegree := cuKnot size - cPoint size - 1]]
]

{ #category : #accessing }
NurbsCurve >> conditionOpenGL [
	| tol |
	tol := 1.0d-9.
	cPoint conditionSelfWithTol: tol.
	cWeight conditionSelfWithTol: tol.
	cuKnot conditionSelfWithTol: tol
]

{ #category : #accessing }
NurbsCurve >> conditionOpenGL1 [
	| tol |
	tol := 1.0d-9.
	cPoint conditionSelfWithTol: tol.
	cWeight conditionSelfWithTol: tol.
	cuKnot conditionSelfWithTol: tol
]

{ #category : #accessing }
NurbsCurve >> conditionOpenGL2 [
	| tol magnification |
	tol := 1.0d-9.
	cPoint conditionSelfWithTol: tol.
	cWeight conditionSelfWithTol: tol.
	cuKnot conditionSelfWithTol: tol.
	magnification := 1.0d / (umax - umin).
	cuKnot := cuKnot collect: [:u | (u - umin) * magnification].
	umin := 0.0d.
	umax := 1.0d
]

{ #category : #accessing }
NurbsCurve >> crFpF_n: n [

	| du answer |
	du := (umax - umin) / (n - 1).
	answer := (1 to: n) collect: 
					[:i |
					| u |
					u := umin + ((i - 1) * du).
					self atU: u].
	answer changeClassToThatOf: FullColumn basicNew.
	^answer
]

{ #category : #accessing }
NurbsCurve >> cuGuess [
	| n du cuGuess |
	n := 9.
	du := (umax - umin) / (n - 1).
	cuGuess := OrderedCollection new: n.
	1 to: n
		do: 
			[:i | 
			| u |
			u := umin + ((i - 1) * du).
			cuGuess add: u].
	^cuGuess
]

{ #category : #accessing }
NurbsCurve >> cuKnot [
	^cuKnot
]

{ #category : #accessing }
NurbsCurve >> cuKnot: cDouble [ 
	cuKnot := cDouble
]

{ #category : #accessing }
NurbsCurve >> derivative: iDeriv at: u [ 
	^(self cDeriv: iDeriv u: u) at: iDeriv + 1
]

{ #category : #comparing }
NurbsCurve >> equal: aObject ltol: tol [

	^self == aObject or: 
			[self class == aObject class and: 
					[| block |
					block :=
							[:ca :cb |
							ca size = cb size ifFalse: [^false].
							ca with: cb parallelDo: [:a :b | (a - b) length < tol ifFalse: [^false]]].
					block value: self cPoint value: aObject cPoint.
					block value: self cWeight value: aObject cWeight.
					block value: self cuKnot value: aObject cuKnot.
					true]]
]

{ #category : #comparing }
NurbsCurve >> equalToCircularArc: aCircularArc ltol: tol [
	"Implement later."

	^false
]

{ #category : #accessing }
NurbsCurve >> finalize_cuv [
	self cuv ifNotNil: 
			[:cuv | 
			| newNurbsCurve |
			newNurbsCurve := NurbsCurve fromcDataPoint: cuv uDegree: 1.
			self
				_cPoint: newNurbsCurve cPoint;
				cWeight: newNurbsCurve cWeight;
				_cuKnot: newNurbsCurve cuKnot;
				isSpatial: false;
				privateCalcBoundingBox]
]

{ #category : #accessing }
NurbsCurve >> isOK [
	^true
]

{ #category : #accessing }
NurbsCurve >> magnifySelf: aDouble [ 
	super magnifySelf: aDouble.
	cPoint magnifySelf: aDouble
]

{ #category : #calc }
NurbsCurve >> minusU: offset [

	self cuv ifNotNil: [:cuv | cuv do: [:uv | uv u: uv u - offset]].
	cPoint ifNotNil: [cPoint do: [:uv | uv u: uv u - offset]]
]

{ #category : #calc }
NurbsCurve >> minusV: offset [

	self cuv ifNotNil: [:cuv | cuv do: [:uv | uv v: uv v - offset]].
	cPoint ifNotNil: [cPoint do: [:uv | uv v: uv v - offset]]
]

{ #category : #accessing }
NurbsCurve >> nDimension [
	^cPoint first size
]

{ #category : #accessing }
NurbsCurve >> normalizeKnots [
	| magnification |
	magnification := 1.0d / (umax - umin).
	cuKnot := cuKnot collect: [:u | (u - umin) * magnification].
	umin := 0.0d.
	umax := 1.0d
]

{ #category : #accessing }
NurbsCurve >> order [
	^uDegree + 1
]

{ #category : #copying }
NurbsCurve >> postCopy [
	super postCopy.
	cPoint := cPoint copy.
	cWeight := cWeight copy.
	cuKnot := cuKnot copy
]

{ #category : #printing }
NurbsCurve >> printOn: aStream [ 
	aStream nextPut: $a.
	aStream print: self class.
	aStream nextPut: $(.
	aStream print: cPoint.
	aStream nextPut: $)
]

{ #category : #printing }
NurbsCurve >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'NurbsCurve';
		cr;
		nextPutAll: 'cPoint = ';
		cr.
	cPoint do: 
			[:a | 
			aStream
				print: a;
				cr].
	aStream
		nextPutAll: 'cWeight = ';
		print: cWeight;
		cr;
		nextPutAll: 'cuKnot = ';
		print: cuKnot
]

{ #category : #calc }
NurbsCurve >> privateCalcBoundingBox [

	| n |
	aBoundingBox := isSpatial
		                ifTrue: [ 
			                StCAD_Misc_BoundingBox new "VW_TRANSLATION:StCAD.Misc.BoundingBox:StCAD_Misc_BoundingBox" ]
		                ifFalse: [ 
			                StCAD_Misc_BoundingRectangle new "VW_TRANSLATION:StCAD.Misc.BoundingRectangle:StCAD_Misc_BoundingRectangle" ].
	n := cPoint size max: 128.
	umin to: umax by: umax - umin / n do: [ :u | 
	aBoundingBox expandToBound: (self atU: u) ]
]

{ #category : #accessing }
NurbsCurve >> rFendF [
	^self rFpF_u: umax
]

{ #category : #accessing }
NurbsCurve >> rFstartF [
	^self rFpF_u: umin
]

{ #category : #accessing }
NurbsCurve >> reverse [
	| answer |
	answer := self class new.
	answer _cPoint: cPoint reverse.
	answer cWeight: cWeight reverse.
	answer _cuKnot: (cuKnot collect: [:knot | knot negated]) reverse.
	^answer
]

{ #category : #accessing }
NurbsCurve >> reverseSelf [
	self _cPoint: cPoint reverse.
	self cWeight: cWeight reverse.
	self _cuKnot: cuKnot negated reverse
]

{ #category : #accessing }
NurbsCurve >> rfpfNurbs [
	^self copy
]

{ #category : #accessing }
NurbsCurve >> rfpf_u: u [ 
	"
	Ref: The NURBS Book, 2nd Ed. by Les Piegl and Wayne Tiller. 
	pp 124.
	"

	| uSpan cN numerator denominator ii nw |
	uSpan := self uspan_at: u.
	cN := self cNu_at: u uSpan: uSpan.
	numerator := FullColumn zero: self nDimension.
	denominator := 0.0d.
	0 to: uDegree
		do: 
			[:i | 
			ii := uSpan - uDegree + i.
			nw := (cN at: i + 1) * (cWeight at: ii).
			numerator equalSelfPlusFullColumn: (cPoint at: ii) times: nw.
			denominator := denominator + nw].
	^numerator / denominator
]

{ #category : #accessing }
NurbsCurve >> scaleF: uvwScale [ 
	cPoint do: [:aPoint | aPoint scaleSelfBy: uvwScale]
]

{ #category : #accessing }
NurbsCurve >> show [
	(self asJunOpenGL3dNurbsCurve)
		paint: ColorValue blue;
		show
]

{ #category : #accessing }
NurbsCurve >> transformSelfBy_rFfF: rFfF aAFf: aAFf [ 
	| rFfF2D aAFf2D |
	cPoint := isSpatial 
				ifTrue: 
					[cPoint 
						collect: [:aPoint | rFfF plusFullColumn: (aAFf timesFullColumn: aPoint)]]
				ifFalse: 
					[rFfF2D := rFfF copyFrom: 1 to: 2.
					aAFf2D := FullMatrix new: 2 by: 2.
					aAFf2D equalFullMatrix: aAFf.
					cPoint 
						collect: [:aPoint | rFfF2D plusFullColumn: (aAFf2D timesFullColumn: aPoint)]]
]

{ #category : #accessing }
NurbsCurve >> uDegree [
	^uDegree
]

{ #category : #accessing }
NurbsCurve >> uOfPoint: rFpF [ 
	| dist newdist uGuess |
	dist := MachineAccuracy OfLargestDouble.
	self cuGuess do: 
			[:aGuess | 
			newdist := (rFpF minusFullColumn: (self atU: aGuess)) length.
			newdist < dist 
				ifTrue: 
					[dist := newdist.
					uGuess := aGuess]].
	^self uOfPoint: rFpF uGuess: uGuess
]

{ #category : #accessing }
NurbsCurve >> uOfPoint: rFpF uGuess: uGuess [ 
	^(NurbsCurveInversion new)
		rFpF: rFpF;
		x: uGuess;
		system: self;
		run;
		x
]

{ #category : #accessing }
NurbsCurve >> uend [
	^isSpatial ifTrue: [self halt: 'Check this'] ifFalse: [(self atU: umax) u]
]

{ #category : #accessing }
NurbsCurve >> umax [
	^umax
]

{ #category : #accessing }
NurbsCurve >> umin [
	^umin
]

{ #category : #accessing }
NurbsCurve >> uspan_at: u [ 
	^NurbsCurve 
		uSpan_at: u
		cuKnot: cuKnot
		uDegree: uDegree
]

{ #category : #accessing }
NurbsCurve >> uvBound [
	self assert: [isSpatial not].
	^aBoundingBox
]

{ #category : #accessing }
NurbsCurve >> uvCurveOnSurface: aSurface [ 
	| aaCurve |
	aaCurve := aSurface uvCurveOfNurbsCurve: self.
"	aSurface condition_cuv: aaCurve."
	^aaCurve
]

{ #category : #accessing }
NurbsCurve >> uvCurveOnSurface: aSurface preCurve: preCurve [ 
	^aSurface uvCurveOfNurbsCurve: self preCurve: preCurve
]

{ #category : #accessing }
NurbsCurve >> uvEnd [
	^self atU: umax
]

{ #category : #accessing }
NurbsCurve >> uvStart [
	self assert: [isSpatial not].
	^self atU: umin
]

{ #category : #accessing }
NurbsCurve >> uvend [
	^isSpatial ifTrue: [self halt: 'Check this'] ifFalse: [self atU: umax]
]
