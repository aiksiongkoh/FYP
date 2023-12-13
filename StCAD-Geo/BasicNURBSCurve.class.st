Class {
	#name : #BasicNURBSCurve,
	#superclass : #BasicCurve,
	#instVars : [
		'cControlPoint',
		'cWeight',
		'cuKnot',
		'uDegree',
		'umin',
		'umax',
		'isCyclic',
		'aBoundingBox',
		'cSamplePoint'
	],
	#classVars : [
		'Geo'
	],
	#category : #'StCAD-Geo'
}

{ #category : #'initialize-release' }
BasicNURBSCurve class >> CcBinomial [
	^CcBinomial.
]

{ #category : #'initialize-release' }
BasicNURBSCurve class >> aMatrixNu_cu: cu cuKnot: cuKnot uDegree: uDegree [ 
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

{ #category : #'instance creation' }
BasicNURBSCurve class >> cControlPoint: acControlPoint cWeight: acWeight cuKnot: acuKnot [ 
	| answer |
	answer := self new.
	answer 
		cControlPoint: acControlPoint
		cWeight: acWeight
		cuKnot: acuKnot.
	^answer
]

{ #category : #'instance creation' }
BasicNURBSCurve class >> cControlPoint: acControlPoint cWeight: acWeight cuKnot: acuKnot isSpatial: isSpatial [ 
	| answer |
	answer := self new.
	answer 
		cControlPoint: acControlPoint
		cWeight: acWeight
		cuKnot: acuKnot
		isSpatial: isSpatial.
	^answer
]

{ #category : #'initialize-release' }
BasicNURBSCurve class >> cNu_at: u uSpan: uSpan cuKnot: cuKnot uDegree: uDegree [ 
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

{ #category : #'initialize-release' }
BasicNURBSCurve class >> ccDerivNu_at: u uDeriv: uDeriv uSpan: uSpan cuKnot: cuKnot uDegree: uDegree [ 
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

{ #category : #'initialize-release' }
BasicNURBSCurve class >> cuKnot_cu: cu uDegree: uDegree [ 
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

{ #category : #'initialize-release' }
BasicNURBSCurve class >> cu_cDataPoint: cDataPoint [ 
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

{ #category : #'initialize-release' }
BasicNURBSCurve class >> fromLine: aLine [ 
	| cPoint cWeight cuKnot |
	cPoint := MathArray with: aLine rfStartPointf copy
				with: aLine rfEndPointf copy.
	cWeight := MathArray with: 1.0d with: 1.0d.
	cuKnot := MathArray 
				with: 0.0d
				with: 0.0d
				with: 1.0d
				with: 1.0d.
	^self 
		cControlPoint: cPoint
		cWeight: cWeight
		cuKnot: cuKnot
]

{ #category : #'initialize-release' }
BasicNURBSCurve class >> fromcDataPoint: cDataPoint uDegree: uDegree [ 
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
	^self 
		cControlPoint: cPoint
		cWeight: cWeight
		cuKnot: cuKnot
]

{ #category : #'class initialization' }
BasicNURBSCurve class >> initialize [
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

{ #category : #'initialize-release' }
BasicNURBSCurve class >> uSpan_at: u cuKnot: cuKnot uDegree: uDegree [ 
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
BasicNURBSCurve class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> _cPoint: acPoint [ 
	cControlPoint := acPoint.
	self calc_uDegree
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> _cuKnot: acuKnot [ 
	cuKnot := acuKnot.
	self calc_uDegree
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> asJunOpenGL2dTrimCurve [
	^JunOpenGL2dTrimNurbsCurve 
		controlPoints: (cControlPoint collect: [:aPoint | aPoint asJun2dPoint])
		weights: cWeight copy
		knotVector: cuKnot copy
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> atU: u [ 
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
			numerator equalSelfPlusFullColumn: (cControlPoint at: ii) times: nw.
			denominator := denominator + nw].
	^numerator / denominator
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> cControlPoint: acControlPoint cWeight: acWeight cuKnot: acuKnot [ 
	cControlPoint := acControlPoint.
	cWeight := acWeight.
	cuKnot := acuKnot.
	self calcAll
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> cDeriv: iDeriv u: u [ 
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
	ccDerivNu := self class 
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
					numerator equalSelfPlusFullColumn: (cControlPoint at: jj) times: nw.
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

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> cNu_at: u uSpan: uSpan [ 
	^self class 
		cNu_at: u
		uSpan: uSpan
		cuKnot: cuKnot
		uDegree: uDegree
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> cPoint [
	^cControlPoint
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> cWeight [
	^cWeight
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> cWeight: anObject [
	cWeight := anObject
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> calcAll [

	isCyclic := cControlPoint first
		            equal: cControlPoint last
		            lTol: 1.0d-6.
	uDegree := cuKnot size - cControlPoint size - 1.
	self normalizeKnots.
	aBoundingBox := StCAD_Misc_BoundingBox new. "VW_TRANSLATION:StCAD.Misc.BoundingBox:StCAD_Misc_BoundingBox"
	cSamplePoint := StCAD_Math_SparseVector new. "VW_TRANSLATION:StCAD.Math.SparseVector:StCAD_Math_SparseVector"
	(0.0 d to: 1.0 d nCenter: cControlPoint size) keysAndValuesDo: [ :i :u | 
		| aPoint |
		aPoint := self atU: u.
		cSamplePoint at: u put: aPoint.
		aBoundingBox expandToBound: aPoint ].
	1 to: self nDimension do: [ :i | 
		(self minmaxAxis: i) do: [ :u | 
			aBoundingBox expandToBound: (self rFpF_u: u) ] ]
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> calc_uDegree [
	cControlPoint 
		ifNotNil: [cuKnot ifNotNil: [uDegree := cuKnot size - cControlPoint size - 1]]
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> cuKnot [
	^cuKnot
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> extremeValueAxis: axis uguess: uguess [ 
	| uextreme |
	uextreme := (CurveExtremum new)
				x: uguess;
				system: self;
				dir: (FullColumn zero: self nDimension unitAt: axis);
				run;
				x.
	uextreme < 0.0d 
		ifTrue: [uextreme := 0.0d]
		ifFalse: [uextreme > 1.0d ifTrue: [uextreme := 1.0d]].
	^uextreme
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> minmaxAxis: axis [ 
	| minmax tol min max |
	minmax := self minmaxGuessAxis: axis.
	minmax := minmax collect: [:u | self extremeValueAxis: axis uguess: u].
	tol := MachineAccuracy OfDoubleTimesFour.
	min := minmax first.
	max := minmax last.
	((min equal: max lTol: tol) 
		and: [(min equal: 0.0d lTol: tol) or: [min equal: 1.0d lTol: tol]]) 
			ifTrue: 
				[minmax at: 1 put: 0.0d.
				minmax at: 2 put: 1.0d].
	^minmax
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> minmaxGuessAxis: axis [
	| min max coordinate |
	min := MachineAccuracy OfLargestDouble.
	max := MachineAccuracy OfLargestDouble negated.
	umin := nil.
	umax := nil.
	cSamplePoint keysAndValuesDo: 
			[:i :aPoint |
			coordinate := aPoint at: axis.
			min > coordinate
				ifTrue: 
					[min := coordinate.
					umin := i.].
			max < coordinate
				ifTrue: 
					[max := coordinate.
					umax := i.].].
	^Array with: umin with: umax.
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> nDimension [
	^cControlPoint first size
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> normalizeKnots [
	| magnification |
	umin := cuKnot first.
	umax := cuKnot last.
	magnification := 1.0d / (umax - umin).
	cuKnot := cuKnot collect: [:u | (u - umin) * magnification.].
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> order [
	^uDegree + 1
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> pprFpFpupu_u: u [
	^self pprfpfpupu_u: u.
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> pprfpfpupu_u: u [ 
	^(self cDeriv: 2 u: u) at: 2 + 1
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> prFpFpu_u: u [
	^self prfpfpu_u: u.
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> prfpfpu_u: u [ 
	^(self cDeriv: 1 u: u) at: 1 + 1
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> rfpf_u: u [ 
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
			numerator equalSelfPlusFullColumn: (cControlPoint at: ii) times: nw.
			denominator := denominator + nw].
	^numerator / denominator
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> uspan_at: u [ 
	^self class 
		uSpan_at: u
		cuKnot: cuKnot
		uDegree: uDegree
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> uvEnd [
	^self atU: 1.0d
]

{ #category : #'As yet unclassified' }
BasicNURBSCurve >> uvStart [
	^self atU: 0.0d
]
