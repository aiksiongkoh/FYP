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
