"
See comment for NurbsCurve.
"
Class {
	#name : #NurbsSurface,
	#superclass : #Surface,
	#instVars : [
		'ccPoint',
		'ccWeight',
		'cuKnot',
		'cvKnot',
		'uDegree',
		'vDegree',
		'umin',
		'umax',
		'vmin',
		'vmax',
		'isCyclicu',
		'isCyclicv',
		'tolSingularity',
		'u0isSingular',
		'u1isSingular',
		'v0isSingular',
		'v1isSingular'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #examples }
NurbsSurface class >> example1 [
	"NurbsSurface example1"

	| answer |
	answer := self exampleCylinder.
	answer atu: -1.0d v: 0.0d.
	answer atu: -0.5d v: 0.0d.
	answer atu: 0.0d v: 0.0d.
	answer atu: 0.5d v: 0.0d.
	answer atu: 1.0d v: 0.0d.
	answer atu: 1.5d v: 0.0d.
	answer atu: 2.0d v: 0.0d.
	answer atu: 2.5d v: 0.0d.
	answer atu: 3.0d v: 0.0d.
	answer atu: 3.5d v: 0.0d.
	answer atu: 4.0d v: 0.0d.
	answer atu: 4.5d v: 0.0d.
	answer atu: 5.0d v: 0.0d
]

{ #category : #examples }
NurbsSurface class >> example2 [
	"NurbsSurface example2"

	| answer |
	answer := self exampleCylinder.
	answer 
		partialu: 1
		partialv: 1
		u: -1.0d
		v: 0.0d.
	answer 
		partialu: 1
		partialv: 1
		u: -0.5d
		v: 0.0d.
	answer 
		partialu: 1
		partialv: 1
		u: 0.0d
		v: 0.0d.
	answer 
		partialu: 1
		partialv: 1
		u: 0.5d
		v: 0.0d.
	answer 
		partialu: 1
		partialv: 1
		u: 1.0d
		v: 0.0d.
	answer 
		partialu: 1
		partialv: 1
		u: 1.5d
		v: 0.0d.
	answer 
		partialu: 1
		partialv: 1
		u: 2.0d
		v: 0.0d.
	answer 
		partialu: 1
		partialv: 1
		u: 2.5d
		v: 0.0d.
	answer 
		partialu: 1
		partialv: 1
		u: 3.0d
		v: 0.0d.
	answer 
		partialu: 1
		partialv: 1
		u: 3.5d
		v: 0.0d.
	answer 
		partialu: 1
		partialv: 1
		u: 4.0d
		v: 0.0d.
	answer 
		partialu: 1
		partialv: 1
		u: 4.5d
		v: 0.0d.
	answer 
		partialu: 1
		partialv: 1
		u: 5.0d
		v: 0.0d
]

{ #category : #examples }
NurbsSurface class >> exampleCylinder [
	"NurbsSurface exampleCylinder"

	| ccPoint ccWeight cuKnot cvKnot |
	ccPoint := FullMatrix new: 9 by: 2.
	ccPoint at: 1 and: 1 put: (0 , -1 , 0) asFullColumn.
	ccPoint at: 2 and: 1 put: (1 , -1 , 0) asFullColumn.
	ccPoint at: 3 and: 1 put: (1 , 0 , 0) asFullColumn.
	ccPoint at: 4 and: 1 put: (1 , 1 , 0) asFullColumn.
	ccPoint at: 5 and: 1 put: (0 , 1 , 0) asFullColumn.
	ccPoint at: 6 and: 1 put: (-1 , 1 , 0) asFullColumn.
	ccPoint at: 7 and: 1 put: (-1 , 0 , 0) asFullColumn.
	ccPoint at: 8 and: 1 put: (-1 , -1 , 0) asFullColumn.
	ccPoint at: 9 and: 1 put: (0 , -1 , 0) asFullColumn.
	ccPoint at: 1 and: 2 put: (0 , -1 , 1) asFullColumn.
	ccPoint at: 2 and: 2 put: (1 , -1 , 1) asFullColumn.
	ccPoint at: 3 and: 2 put: (1 , 0 , 1) asFullColumn.
	ccPoint at: 4 and: 2 put: (1 , 1 , 1) asFullColumn.
	ccPoint at: 5 and: 2 put: (0 , 1 , 1) asFullColumn.
	ccPoint at: 6 and: 2 put: (-1 , 1 , 1) asFullColumn.
	ccPoint at: 7 and: 2 put: (-1 , 0 , 1) asFullColumn.
	ccPoint at: 8 and: 2 put: (-1 , -1 , 1) asFullColumn.
	ccPoint at: 9 and: 2 put: (0 , -1 , 1) asFullColumn.
	ccWeight := FullMatrix new: 9 by: 2.
	ccWeight at: 1 and: 1 put: 1.0d.
	ccWeight at: 2 and: 1 put: 1 / 2.0d sqrt.
	ccWeight at: 3 and: 1 put: 1.0d.
	ccWeight at: 4 and: 1 put: 1 / 2.0d sqrt.
	ccWeight at: 5 and: 1 put: 1.0d.
	ccWeight at: 6 and: 1 put: 1 / 2.0d sqrt.
	ccWeight at: 7 and: 1 put: 1.0d.
	ccWeight at: 8 and: 1 put: 1 / 2.0d sqrt.
	ccWeight at: 9 and: 1 put: 1.0d.
	ccWeight at: 1 and: 2 put: 1.0d.
	ccWeight at: 2 and: 2 put: 1 / 2.0d sqrt.
	ccWeight at: 3 and: 2 put: 1.0d.
	ccWeight at: 4 and: 2 put: 1 / 2.0d sqrt.
	ccWeight at: 5 and: 2 put: 1.0d.
	ccWeight at: 6 and: 2 put: 1 / 2.0d sqrt.
	ccWeight at: 7 and: 2 put: 1.0d.
	ccWeight at: 8 and: 2 put: 1 / 2.0d sqrt.
	ccWeight at: 9 and: 2 put: 1.0d.
	cuKnot := #(0 0 0 1 1 2 2 3 3 4 4 4).
	cvKnot := #(0 0 1 1).
	^(self new) _ccPoint: ccPoint; ccWeight: ccWeight; _cuKnot: cuKnot; _cvKnot: cvKnot; yourself
]

{ #category : #examples }
NurbsSurface class >> exampleSphere [

	"NurbsSurface exampleSphere"

	| aSphere aNurbs |
	aSphere := StCAD_Geo_SphericalSurface new radius: 1.0 d. "VW_TRANSLATION:StCAD.Geo.SphericalSurface:StCAD_Geo_SphericalSurface"
	aNurbs := NurbsSurface fromSolidOfRevolution: aSphere.
	aNurbs asJunOpenGL3dNurbsSurface
		paint: ColorValue blue;
		show
]

{ #category : #examples }
NurbsSurface class >> exampleSphere1 [

	"NurbsSurface exampleSphere1"

	| aSphere aNurbs nurbs trimCurve |
	aSphere := StCAD_Geo_SphericalSurface new radius: 1.0 d. "VW_TRANSLATION:StCAD.Geo.SphericalSurface:StCAD_Geo_SphericalSurface"
	aNurbs := NurbsSurface fromSolidOfRevolution: aSphere.
	nurbs := aNurbs asJunOpenGL3dNurbsSurface.
	trimCurve := JunOpenGL2dTrimNurbsCurve fromRectangle:
		             (Graphics_Rectangle origin: 0.2 @ 0.2 corner: 0.8 @ 0.8). "VW_TRANSLATION:Graphics.Rectangle:Graphics_Rectangle"
	nurbs addTrimCurve: trimCurve.
	nurbs name: 'exampleSphere1'.
	nurbs paint: ColorValue blue.
	nurbs show.
	^ nurbs
]

{ #category : #examples }
NurbsSurface class >> exampleSphere2 [

	"NurbsSurface exampleSphere2"

	| aSphere aNurbs nurbs trimCurve |
	aSphere := StCAD_Geo_SphericalSurface new radius: 1.0 d. "VW_TRANSLATION:StCAD.Geo.SphericalSurface:StCAD_Geo_SphericalSurface"
	aNurbs := NurbsSurface fromSolidOfRevolution: aSphere.
	nurbs := aNurbs asJunOpenGL3dNurbsSurface.
	trimCurve := JunOpenGL2dTrimNurbsCurve nonconvexPolygon.
	nurbs addTrimCurve: trimCurve.
	nurbs name: 'exampleSphere2'.
	nurbs paint: ColorValue blue.
	nurbs show.
	^ nurbs
]

{ #category : #examples }
NurbsSurface class >> exampleSphere3 [

	"NurbsSurface exampleSphere3"

	| aSphere aNurbs nurbs trimCurve |
	aSphere := StCAD_Geo_SphericalSurface new radius: 1.0 d. "VW_TRANSLATION:StCAD.Geo.SphericalSurface:StCAD_Geo_SphericalSurface"
	aNurbs := NurbsSurface fromSolidOfRevolution: aSphere.
	nurbs := aNurbs asJunOpenGL3dNurbsSurface.
	trimCurve := JunOpenGL2dTrimNurbsCurve fromRectangle:
		             (Graphics_Rectangle
			              origin: 0.05 @ 0.05
			              corner: 0.95 @ 0.95). "VW_TRANSLATION:Graphics.Rectangle:Graphics_Rectangle"
	nurbs addTrimCurve: trimCurve.
	trimCurve := JunOpenGL2dTrimNurbsCurve nonconvexPolygon reverse.
	nurbs addTrimCurve: trimCurve.
	nurbs name: 'exampleSphere2'.
	nurbs paint: ColorValue blue.
	nurbs show.
	^ nurbs
]

{ #category : #examples }
NurbsSurface class >> exampleTorus [

	"NurbsSurface exampleTorus"

	| aTorus aNurbs |
	aTorus := StCAD_Geo_ToroidalSurface new
		          majorRadius: 1.0 d;
		          minorRadius: 1.0 d;
		          yourself. "VW_TRANSLATION:StCAD.Geo.ToroidalSurface:StCAD_Geo_ToroidalSurface"
	aNurbs := NurbsSurface fromSolidOfRevolution: aTorus.
	aNurbs asJunOpenGL3dNurbsSurface
		paint: ColorValue blue;
		show
]

{ #category : #accessing }
NurbsSurface class >> fromRectSurface: aRectSurface [ 
	| answer ccPoint ccWeight cuKnot umin umax cvKnot vmin vmax |
	answer := self new.
	ccPoint := FullMatrix new: 2 by: 2.
	ccPoint 
		at: 1
		and: 1
		put: aRectSurface minxminyminz.
	ccPoint 
		at: 1
		and: 2
		put: aRectSurface minxmaxyminz.
	ccPoint 
		at: 2
		and: 1
		put: aRectSurface maxxminyminz.
	ccPoint 
		at: 2
		and: 2
		put: aRectSurface maxxmaxyminz.
	ccPoint do: [:cPoint | cPoint do: [:aPoint | aPoint z: 0.0d]].
	answer _ccPoint: ccPoint.
	ccWeight := FullMatrix new: 2 by: 2.
	ccWeight do: [:cWeight | cWeight atAllPut: 1.0d].
	answer ccWeight: ccWeight.
	cuKnot := Array new: 4.
	umin := 0.0d.
	umax := 1.0d.
	cuKnot at: 1 put: umin.
	cuKnot at: 2 put: umin.
	cuKnot at: 3 put: umax.
	cuKnot at: 4 put: umax.
	cvKnot := Array new: 4.
	vmin := 0.0d.
	vmax := 1.0d.
	cvKnot at: 1 put: vmin.
	cvKnot at: 2 put: vmin.
	cvKnot at: 3 put: vmax.
	cvKnot at: 4 put: vmax.
	answer _cuKnot: cuKnot.
	answer _cvKnot: cvKnot.
	^answer
]

{ #category : #accessing }
NurbsSurface class >> fromSolidOfRevolution: aSolidOfRevolution [

	| answer aCircleNurbs aCurveNurbs aCirclecPoint aCurvecPoint aCirclecWeight aCurvecWeight m n cRadius cHeight ccPoint ccWeight |
	answer := self new.
	aCircleNurbs := StCAD_Geo_Circle new
		                _radius: 1.0 d;
		                aNurbs. "VW_TRANSLATION:StCAD.Geo.Circle:StCAD_Geo_Circle"
	aCurveNurbs := aSolidOfRevolution aCurve rFpFNurbs.
	aCirclecPoint := aCircleNurbs cPoint.
	aCurvecPoint := aCurveNurbs cPoint.
	aCirclecWeight := aCircleNurbs cWeight.
	aCurvecWeight := aCurveNurbs cWeight.
	m := aCirclecPoint size.
	n := aCurvecPoint size.
	cRadius := aCurvecPoint shallowCopy.
	cHeight := aCurvecPoint shallowCopy.
	1 to: n do: [ :j | 
		| aCurvecPointj |
		aCurvecPointj := aCurvecPoint at: j.
		cRadius at: j put: aCurvecPointj x.
		cHeight at: j put: aCurvecPointj z ].
	ccPoint := FullMatrix new: m by: n.
	ccWeight := FullMatrix new: m by: n.
	1 to: m do: [ :i | 
		| aCirclecPointi aCirclecWeighti ccPointi ccWeighti |
		aCirclecPointi := aCirclecPoint at: i.
		aCirclecWeighti := aCirclecWeight at: i.
		ccPointi := ccPoint at: i.
		ccWeighti := ccWeight at: i.
		1 to: n do: [ :j | 
			| xyz |
			xyz := aCirclecPointi times: (cRadius at: j).
			xyz z: (cHeight at: j).
			ccPointi at: j put: xyz.
			ccWeighti at: j put: aCirclecWeighti * (aCurvecWeight at: j) ] ].
	answer _ccPoint: ccPoint.
	answer ccWeight: ccWeight.
	answer _cuKnot: aCircleNurbs cuKnot.
	answer _cvKnot: aCurveNurbs cuKnot.
	^ answer
]

{ #category : #accessing }
NurbsSurface class >> fromSweep: aSweep [ 
	self notYetImplemented.
	self halt
]

{ #category : #'VisualWorks metadata' }
NurbsSurface class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
NurbsSurface >> CcBinomial [
	^NurbsCurve CcBinomial
]

{ #category : #accessing }
NurbsSurface >> _ccPoint: accPoint [

	ccPoint := accPoint.
	self
		calc_isCyclicu;
		calc_isCyclicv;
		calc_ccSingularity;
		calc_uDegree;
		calc_vDegree
]

{ #category : #accessing }
NurbsSurface >> _cuKnot: acuKnot [ 
	cuKnot := acuKnot.
	self calc_uDegree.
	umin := cuKnot first.
	umax := cuKnot last
]

{ #category : #accessing }
NurbsSurface >> _cvKnot: acvKnot [ 
	cvKnot := acvKnot.
	self calc_vDegree.
	vmin := cvKnot first.
	vmax := cvKnot last
]

{ #category : #accessing }
NurbsSurface >> aNurbs [
	^self
]

{ #category : #accessing }
NurbsSurface >> asJunOpenGL3dNurbsSurface [
	^JunOpenGL3dNurbsSurface 
		controlPoints: ccPoint asJunMatrix
		weights: ccWeight asJunMatrix
		uKnotVector: cuKnot copy
		vKnotVector: cvKnot copy
]

{ #category : #converting }
NurbsSurface >> asJunOpenGL3dObject [

	^self asJunOpenGL3dNurbsSurface
]

{ #category : #accessing }
NurbsSurface >> atu: u v: v [ 
	"
	Ref: The NURBS Book, 2nd Ed. by Les Piegl and Wayne Tiller. 
	pp 134.
	"

	| uSpan cNu vSpan cNv cNumerator cDenominator nDimension uSpanDegree vSpanDegree numerator denominator |
	uSpan := self uspan_at: u.
	cNu := self cNu_at: u uSpan: uSpan.
	vSpan := self vspan_at: v.
	cNv := self cNv_at: v vSpan: vSpan.
	cNumerator := FullColumn new: vDegree + 1.
	cDenominator := FullColumn new: vDegree + 1.
	nDimension := self nDimension.
	uSpanDegree := uSpan - uDegree.
	vSpanDegree := vSpan - vDegree.
	0 to: vDegree
		do: 
			[:j | 
			| j1 jj |
			j1 := j + 1.
			jj := vSpanDegree + j.
			cNumerator at: j1 put: (FullColumn zero: nDimension).
			cDenominator at: j1 put: 0.0d.
			0 to: uDegree
				do: 
					[:i | 
					| ii nuw |
					ii := uSpanDegree + i.
					nuw := (cNu at: i + 1) * (ccWeight at: ii and: jj).
					(cNumerator at: j1) equalSelfPlusFullColumn: (ccPoint at: ii and: jj)
						times: nuw.
					cDenominator at: j1 plusNumber: nuw]].
	numerator := FullColumn zero: nDimension.
	denominator := 0.0d.
	0 to: vDegree
		do: 
			[:j | 
			| j1 nv |
			j1 := j + 1.
			nv := cNv at: j1.
			numerator equalSelfPlusFullColumn: (cNumerator at: j1) times: nv.
			denominator := denominator + ((cDenominator at: j1) * nv)].
	^numerator / denominator
]

{ #category : #accessing }
NurbsSurface >> cEndSingularityOf: aCurve [ 
	"Singularities occur at ends. Extrapolate the first or last point if necessary."

	| cuv cuv1 cuvn startInterval endInterval block startSingularity endSingularity |
	cuv := aCurve cuv.
	cuv1 := cuv first copy.
	cuvn := cuv last copy.
	startInterval := 1 to: 3.
	endInterval := cuv size to: cuv size - 2 by: -1.
	block := 
			[:aInterval | 
			| uv3 uv2 uv1 largeDummy du2 du1 tol u1 v1 |
			uv3 := cuv at: (aInterval at: 3).
			uv2 := cuv at: (aInterval at: 2).
			uv1 := cuv at: (aInterval at: 1).
			uv1 ifNil: 
					[largeDummy := 1.0d3.
					uv1 := FullColumn with: largeDummy with: largeDummy.
					cuv at: (aInterval at: 1) put: uv1].
			du2 := uv2 - uv3.
			du1 := uv1 - uv2.
			tol := 0.5d * du2 length.
			(du2 - du1) length >= tol 
				ifTrue: 
					[u1 := uv2 u + du2 u.
					v1 := uv2 v + du2 v.
					uv1 u: u1.
					uv1 v: v1]].
	block value: startInterval.
	block value: endInterval.
	startSingularity := (cuv1 = cuv first) not.
	endSingularity := (cuvn = cuv last) not.
	^MathArray with: startSingularity with: endSingularity
]

{ #category : #accessing }
NurbsSurface >> cNu_at: u uSpan: uSpan [ 
	^NurbsCurve 
		cNu_at: u
		uSpan: uSpan
		cuKnot: cuKnot
		uDegree: uDegree
]

{ #category : #accessing }
NurbsSurface >> cNv_at: v vSpan: vSpan [ 
	^NurbsCurve 
		cNu_at: v
		uSpan: vSpan
		cuKnot: cvKnot
		uDegree: vDegree
]

{ #category : #accessing }
NurbsSurface >> cSingularity [

	^(Array
		with: u0isSingular
		with: v0isSingular
		with: u1isSingular
		with: v1isSingular) select: [:a | a notNil]
]

{ #category : #accessing }
NurbsSurface >> calc_ccSingularity [

	| extend_length minPoint maxPoint |
	extend_length := self extend_length.
	tolSingularity := 1.0d-4 * extend_length.
	minPoint := ccPoint at: 1 and: 1.
	ccPoint first
		detect: [:aPoint | (aPoint - minPoint) length >= tolSingularity]
		ifNone: [u0isSingular := minPoint].
	ccPoint
		detect: [:cPoint | (cPoint first - minPoint) length >= tolSingularity]
		ifNone: [v0isSingular := minPoint].
	maxPoint := ccPoint at: ccPoint nrow and: ccPoint ncol.
	ccPoint last
		detect: [:aPoint | (aPoint - maxPoint) length >= tolSingularity]
		ifNone: [u1isSingular := maxPoint].
	ccPoint
		detect: [:cPoint | (cPoint last - maxPoint) length >= tolSingularity]
		ifNone: [v1isSingular := maxPoint]
]

{ #category : #calc }
NurbsSurface >> calc_isCyclicu [

	| tol tolsquared firstcPoint lastcPoint vsize |
	tol := 1.0d-6.
	tolsquared := tol * tol.
	firstcPoint := ccPoint first.
	lastcPoint := ccPoint last.
	vsize := firstcPoint size.
	isCyclicu := (1 to: vsize) allSatisfy: 
					[:i |
					((firstcPoint at: i) minusFullColumn: (lastcPoint at: i)) sumOfSquares
						< tolsquared]
]

{ #category : #calc }
NurbsSurface >> calc_isCyclicv [

	| tol tolsquared usize row |
	tol := 1.0d-6.
	tolsquared := tol * tol.
	usize := ccPoint size.
	isCyclicv := (1 to: usize) allSatisfy: 
					[:i |
					row := ccPoint at: i.
					(row first minusFullColumn: row last) sumOfSquares < tolsquared]
]

{ #category : #accessing }
NurbsSurface >> calc_uDegree [
	ccPoint 
		ifNotNil: [cuKnot ifNotNil: [uDegree := cuKnot size - ccPoint size - 1]]
]

{ #category : #accessing }
NurbsSurface >> calc_vDegree [
	ccPoint 
		ifNotNil: [cvKnot ifNotNil: [vDegree := cvKnot size - ccPoint first size - 1]]
]

{ #category : #accessing }
NurbsSurface >> ccDeriv: iDeriv u: u v: v [ 
	"
	Ref: The NURBS Book, 2nd Ed. by Les Piegl and Wayne Tiller.
	pp. 111, 137
	"

	| iDeriv1 nDimension ccDeriv ccDerivP ccDerivW iDerivu iDerivv uSpan ccDerivNu vSpan ccDerivNv cNumerator cDenominator uSpanDegree vSpanDegree |
	iDeriv1 := iDeriv + 1.
	nDimension := self nDimension.
	ccDeriv := FullMatrix new: iDeriv1 by: iDeriv1.
	ccDerivP := FullMatrix new: iDeriv1 by: iDeriv1.
	ccDerivW := FullMatrix new: iDeriv1 by: iDeriv1.
	uDegree + 1 to: iDeriv
		do: 
			[:i | 
			| i1 |
			i1 := i + 1.
			0 to: iDeriv - i
				do: 
					[:j | 
					| j1 |
					j1 := j + 1.
					ccDeriv 
						at: i1
						and: j1
						put: (FullColumn zero: nDimension).
					ccDerivP 
						at: i1
						and: j1
						put: (FullColumn zero: nDimension).
					ccDerivW 
						at: i1
						and: j1
						put: 0.0d]].
	vDegree + 1 to: iDeriv
		do: 
			[:i | 
			| i1 |
			i1 := i + 1.
			0 to: iDeriv - i
				do: 
					[:j | 
					| j1 |
					j1 := j + 1.
					ccDeriv 
						at: j1
						and: i1
						put: (FullColumn zero: nDimension).
					ccDerivP 
						at: j1
						and: i1
						put: (FullColumn zero: nDimension).
					ccDerivW 
						at: j1
						and: i1
						put: 0.0d]].
	iDerivu := iDeriv min: uDegree.
	iDerivv := iDeriv min: vDegree.
	uSpan := self uspan_at: u.
	ccDerivNu := NurbsCurve 
				ccDerivNu_at: u
				uDeriv: iDerivu
				uSpan: uSpan
				cuKnot: cuKnot
				uDegree: uDegree.
	vSpan := self vspan_at: v.
	ccDerivNv := NurbsCurve 
				ccDerivNu_at: v
				uDeriv: iDerivv
				uSpan: vSpan
				cuKnot: cvKnot
				uDegree: vDegree.
	cNumerator := FullColumn new: vDegree + 1.
	cDenominator := FullColumn new: vDegree + 1.
	uSpanDegree := uSpan - uDegree.
	vSpanDegree := vSpan - vDegree.
	0 to: iDerivu
		do: 
			[:i | 
			| i1 iDerivuv |
			i1 := i + 1.
			0 to: vDegree
				do: 
					[:j | 
					| j1 jj |
					j1 := j + 1.
					cNumerator at: j1 put: (FullColumn zero: nDimension).
					cDenominator at: j1 put: 0.0d.
					jj := vSpanDegree + j.
					0 to: uDegree
						do: 
							[:k | 
							| k1 kk ccDerivNuw |
							k1 := k + 1.
							kk := uSpanDegree + k.
							ccDerivNuw := (ccDerivNu at: i1 and: k1) * (ccWeight at: kk and: jj).
							(cNumerator at: j1) equalSelfPlusFullColumn: (ccPoint at: kk and: jj)
								times: ccDerivNuw.
							cDenominator at: j1 plusNumber: ccDerivNuw]].
			iDerivuv := iDeriv - i min: iDerivv.
			0 to: iDerivuv
				do: 
					[:j | 
					| j1 |
					j1 := j + 1.
					ccDerivP 
						at: i1
						and: j1
						put: (FullColumn zero: nDimension).
					ccDerivW 
						at: i1
						and: j1
						put: 0.0d.
					0 to: vDegree
						do: 
							[:k | 
							| k1 ccDerivNv1 |
							k1 := k + 1.
							ccDerivNv1 := ccDerivNv at: j1 and: k1.
							(ccDerivP at: i1 and: j1) equalSelfPlusFullColumn: (cNumerator at: k1)
								times: ccDerivNv1.
							ccDerivW 
								at: i1
								and: j1
								plusNumber: ccDerivNv1 * (cDenominator at: k1)]]].
	0 to: iDeriv
		do: 
			[:i | 
			| i1 |
			i1 := i + 1.
			0 to: iDeriv - i
				do: 
					[:j | 
					| j1 temp |
					j1 := j + 1.
					temp := ccDerivP at: i1 and: j1.
					1 to: j
						do: 
							[:k | 
							| k1 jk1 bw |
							k1 := k + 1.
							jk1 := j - k + 1.
							bw := ((self CcBinomial at: j1) at: k1) negated * (ccDerivW at: 1 and: k1).
							temp equalSelfPlusFullColumn: (ccDeriv at: i1 and: jk1) times: bw].
					1 to: i
						do: 
							[:k | 
							| k1 ik1 bw temp2 |
							k1 := k + 1.
							ik1 := i - k + 1.
							bw := ((self CcBinomial at: i1) at: k1) negated * (ccDerivW at: k1 and: 1).
							temp equalSelfPlusFullColumn: (ccDeriv at: ik1 and: j1) times: bw.
							temp2 := FullColumn zero: nDimension.
							1 to: j
								do: 
									[:l | 
									| l1 jl1 |
									l1 := l + 1.
									jl1 := j - l + 1.
									bw := ((self CcBinomial at: j1) at: l1) * (ccDerivW at: k1 and: l1).
									temp2 equalSelfPlusFullColumn: (ccDeriv at: ik1 and: jl1) times: bw].
							temp equalSelfPlusFullColumn: temp2
								times: ((self CcBinomial at: i1) at: k1) negated].
					ccDeriv 
						at: i1
						and: j1
						put: temp / (ccDerivW at: 1 and: 1)]].
	^ccDeriv
]

{ #category : #accessing }
NurbsSurface >> ccPoint [
	^ccPoint
]

{ #category : #accessing }
NurbsSurface >> ccPoint: anObject [
	ccPoint := anObject
]

{ #category : #accessing }
NurbsSurface >> ccWeight [
	^ccWeight
]

{ #category : #accessing }
NurbsSurface >> ccWeight: anObject [
	ccWeight := anObject
]

{ #category : #accessing }
NurbsSurface >> conditionEnd_cuv: cuv pre_uvEnd: pre_uvend [ 
	"Singularities occur at ends. Extrapolate the first or last point if necessary."

	| cuv1 startInterval endInterval block |
	cuv1 := cuv first copy.
	startInterval := 1 to: 3.
	endInterval := cuv size to: cuv size - 2 by: -1.
	block := 
			[:aInterval | 
			| uv3 uv2 uv1 largeDummy du2 du1 tol u1 v1 |
			uv3 := cuv at: (aInterval at: 3).
			uv2 := cuv at: (aInterval at: 2).
			uv1 := cuv at: (aInterval at: 1).
			uv1 ifNil: 
					[largeDummy := 1.0d3.
					uv1 := FullColumn with: largeDummy with: largeDummy.
					cuv at: (aInterval at: 1) put: uv1].
			du2 := uv2 - uv3.
			du1 := uv1 - uv2.
			tol := 0.5d * du2 length.
			(du2 - du1) length >= tol 
				ifTrue: 
					[u1 := uv2 u + du2 u.
					v1 := uv2 v + du2 v.
					uv1 u: u1.
					uv1 v: v1]].
	block value: startInterval.
	block value: endInterval.
	^cuv1 = cuv first 
		ifTrue: [pre_uvend]
		ifFalse: 
			["Discontinuity expected."

			nil]
]

{ #category : #accessing }
NurbsSurface >> conditionOpenGL [
	| tol |
	tol := 1.0d-9.
	ccPoint conditionSelfWithTol: tol.
	ccWeight conditionSelfWithTol: tol.
	cuKnot conditionSelfWithTol: tol.
	cvKnot conditionSelfWithTol: tol
]

{ #category : #accessing }
NurbsSurface >> conditionOpenGL1 [
	| tol |
	tol := 1.0d-9.
	ccPoint conditionSelfWithTol: tol.
	ccWeight conditionSelfWithTol: tol.
	cuKnot conditionSelfWithTol: tol.
	cvKnot conditionSelfWithTol: tol
]

{ #category : #accessing }
NurbsSurface >> conditionOpenGL2 [
	| tol magnification |
	tol := 1.0d-9.
	ccPoint conditionSelfWithTol: tol.
	ccWeight conditionSelfWithTol: tol.
	cuKnot conditionSelfWithTol: tol.
	cvKnot conditionSelfWithTol: tol.
	magnification := 1.0d / (umax - umin).
	cuKnot := cuKnot collect: [:u | (u - umin) * magnification].
	umin := 0.0d.
	umax := 1.0d.
	magnification := 1.0d / (vmax - vmin).
	cvKnot := cvKnot collect: [:v | (v - vmin) * magnification].
	vmin := 0.0d.
	vmax := 1.0d
]

{ #category : #ops }
NurbsSurface >> condition_cLoopUse: cLoopUse [

	| cuvLast offset |
	isCyclicu
		ifTrue: 
			[cLoopUse do: 
					[:aLoopUse |
					((aLoopUse cuvFirst u - aLoopUse cuvLast u) abs equal: 1.0d tol: 1.0d-6)
						ifTrue: [aLoopUse minusU: aLoopUse cuvFirst u]].
			cuvLast := cLoopUse first cuvFirst.
			cLoopUse do: 
					[:aLoopUse |
					offset := (aLoopUse cuvFirst u - cuvLast u) rounded.
					offset isZero ifFalse: [aLoopUse minusU: offset].
					cuvLast := aLoopUse cuvLast]].
	isCyclicv
		ifTrue: 
			[cLoopUse do: 
					[:aLoopUse |
					((aLoopUse cuvFirst v - aLoopUse cuvLast v) abs equal: 1.0d tol: 1.0d-6)
						ifTrue: [aLoopUse minusV: aLoopUse cuvFirst v]].
			cuvLast := cLoopUse first cuvFirst.
			cLoopUse do: 
					[:aLoopUse |
					offset := (aLoopUse cuvFirst v - cuvLast v) rounded.
					offset isZero ifFalse: [aLoopUse minusV: offset].
					cuvLast := aLoopUse cuvLast]]
]

{ #category : #accessing }
NurbsSurface >> condition_cLoopUse: cLoopUse within: uvBound [
	"Scale uv values to fit within umin, umax, vmin, vmax."

	| uumin uumax uscale vvmin vvmax vscale uoffset voffset |
	uumin := uvBound umin.
	uumax := uvBound umax.
	uoffset := 0.0d.
	isCyclicu
		ifTrue: 
			[uoffset := uumin rounded.
			uumin := uumin - uoffset.
			uumax := uumax - uoffset].
	umin < uumin ifTrue: [uumin := umin].
	umax > uumax ifTrue: [uumax := umax].
	uscale := (umax - umin) / (uumax - uumin).
	uscale < 1.0d
		ifTrue: 
			[cLoopUse do: 
					[:aLoopUse |
					aLoopUse ccuv
						do: [:cuv | cuv do: [:uv | uv u: (uv u - uumin - uoffset) * uscale + umin]]]].
	vvmin := uvBound vmin.
	vvmax := uvBound vmax.
	voffset := 0.0d.
	isCyclicv
		ifTrue: 
			[voffset := vvmin rounded.
			vvmin := vvmin - voffset.
			vvmax := vvmax - voffset].
	vmin < vvmin ifTrue: [vvmin := vmin].
	vmax > vvmax ifTrue: [vvmax := vmax].
	vscale := (vmax - vmin) / (vvmax - vvmin).
	vscale < 1.0d
		ifTrue: 
			[cLoopUse do: 
					[:aLoopUse |
					aLoopUse ccuv
						do: [:cuv | cuv do: [:uv | uv v: (uv v - vvmin - voffset) * vscale + vmin]]]]
]

{ #category : #accessing }
NurbsSurface >> condition_cglTrimNurbs1: cglTrimNurbs [ 
	| tol aStream uvStart uvNext uvStarti |
	tol := 1.0d-6.
	aStream := (cglTrimNurbs species new: cglTrimNurbs size) writeStream.
	uvStart := cglTrimNurbs first uvStart.
	uvNext := uvStart.
	cglTrimNurbs do: 
			[:glTrimNurbs | 
			uvStarti := glTrimNurbs uvStart.
			(uvNext - uvStarti) length < tol 
				ifFalse: 
					[self name: #debug.
					aStream nextPut: (NurbsCurve fromStart: uvNext copy toEnd: uvStarti copy)].
			aStream nextPut: glTrimNurbs.
			uvNext := glTrimNurbs uvEnd].
	(uvNext - uvStart) length < tol 
		ifFalse: 
			[self name: #debug.
			aStream nextPut: (NurbsCurve fromStart: uvNext copy toEnd: uvStart copy)].
	^aStream contents
]

{ #category : #accessing }
NurbsSurface >> condition_cglTrimNurbs: cglTrimNurbs [ 
	| tol aStream uvStart uvNext uvStarti |
	tol := 1.0d-4.
	aStream := (cglTrimNurbs species new: cglTrimNurbs size) writeStream.
	uvStart := cglTrimNurbs first uvStart.
	uvNext := uvStart.
	cglTrimNurbs do: 
			[:glTrimNurbs | 
			uvStarti := glTrimNurbs uvStart.
			(uvNext - uvStarti) length < tol 
				ifFalse: 
					[self name: #debug.
					aStream nextPut: (NurbsCurve fromStart: uvNext copy toEnd: uvStarti copy)].
			aStream nextPut: glTrimNurbs.
			uvNext := glTrimNurbs uvEnd].
	(uvNext - uvStart) length < tol 
		ifFalse: 
			[self name: #debug.
			aStream nextPut: (NurbsCurve fromStart: uvNext copy toEnd: uvStart copy)].
	^aStream contents
]

{ #category : #ops }
NurbsSurface >> condition_cgluvTrimNurbs: cgluvTrimNurbs [

	| tol aStream uvStart uvNext uvStarti |
	^isCyclicu | isCyclicv
		ifTrue: [cgluvTrimNurbs]
		ifFalse: 
			[tol := 1.0d-4.
			aStream := (cgluvTrimNurbs species new: cgluvTrimNurbs size) writeStream.
			uvStart := cgluvTrimNurbs first uvStart.
			uvNext := uvStart.
			cgluvTrimNurbs do: 
					[:glTrimNurbs |
					uvStarti := glTrimNurbs uvStart.
					(uvNext - uvStarti) length < tol
						ifFalse: 
							[self name: #debug.
							aStream nextPut: (NurbsCurve fromStart: uvNext copy toEnd: uvStarti copy)].
					aStream nextPut: glTrimNurbs.
					uvNext := glTrimNurbs uvEnd].
			(uvNext - uvStart) length < tol
				ifFalse: 
					[self name: #debug.
					aStream nextPut: (NurbsCurve fromStart: uvNext copy toEnd: uvStart copy)].
			aStream contents]
]

{ #category : #accessing }
NurbsSurface >> condition_cuv1: aCurve [ 
	| utol umin2 umax2 vtol vmin2 vmax2 |
	utol := 1.0d-3 * (umax - umin).
	umin2 := umin + utol.
	umax2 := umax - utol.
	vtol := 1.0d-3 * (vmax - vmin).
	vmin2 := vmin + vtol.
	vmax2 := vmax - vtol.
	aCurve cuv do: 
			[:uv | 
			uv at: 1
				put: ((uv at: 1) 
						conditionEqual: umin
						or_ge: umin2
						and_le: umax2
						orEqual: umax).
			uv at: 2
				put: ((uv at: 2) 
						conditionEqual: vmin
						or_ge: vmin2
						and_le: vmax2
						orEqual: vmax)]
]

{ #category : #accessing }
NurbsSurface >> condition_cuv2: aCurve [ 
	| uumin uumax vvmin vvmax cuv u v uscale vscale |
	uumin := MachineAccuracy OfLargestDouble.
	uumax := MachineAccuracy OfLargestDouble negated.
	vvmin := MachineAccuracy OfLargestDouble.
	vvmax := MachineAccuracy OfLargestDouble negated.
	cuv := aCurve cuv.
	cuv do: 
			[:uv | 
			u := uv at: 1.
			v := uv at: 2.
			uumin := uumin min: u.
			uumax := uumax max: u.
			vvmin := vvmin min: v.
			vvmax := vvmax max: v].
	umin < uumin ifTrue: [uumin := umin].
	umax > uumax ifTrue: [uumax := umax].
	uscale := (umax - umin) / (uumax - uumin).
	vmin < vvmin ifTrue: [vvmin := vmin].
	vmax > vvmax ifTrue: [vvmax := vmax].
	vscale := (vmax - vmin) / (vvmax - vvmin).
	uscale < 1.0d 
		ifTrue: 
			[vscale < 1.0d 
				ifTrue: 
					[cuv do: 
							[:uv | 
							uv u: (uv u - uumin) * uscale + umin.
							uv v: (uv v - vvmin) * vscale + vmin]]
				ifFalse: [cuv do: [:uv | uv u: (uv u - uumin) * uscale + umin]]]
		ifFalse: 
			[vscale < 1.0d 
				ifTrue: [cuv do: [:uv | uv v: (uv v - vvmin) * vscale + vmin]]]
]

{ #category : #accessing }
NurbsSurface >> condition_cuv3: aCurve [ 
	"Do nothing."
]

{ #category : #accessing }
NurbsSurface >> condition_cuv: aCurve [ 
	"Do nothing."
]

{ #category : #accessing }
NurbsSurface >> condition_cuv: cuv pre_uvEnd: pre_uvend [ 
	| new_pre_uvend utol umin2 umax2 vtol vmin2 vmax2 cuv1 |
	new_pre_uvend := self conditionEnd_cuv: cuv pre_uvEnd: pre_uvend.
	utol := 1.0d-3 * (umax - umin).
	umin2 := umin + utol.
	umax2 := umax - utol.
	vtol := 1.0d-3 * (vmax - vmin).
	vmin2 := vmin + vtol.
	vmax2 := vmax - vtol.
	cuv do: 
			[:uv | 
			uv at: 1
				put: ((uv at: 1) 
						conditionEqual: umin
						or_ge: umin2
						and_le: umax2
						orEqual: umax).
			uv at: 2
				put: ((uv at: 2) 
						conditionEqual: vmin
						or_ge: vmin2
						and_le: vmax2
						orEqual: vmax)].
	new_pre_uvend ifNotNil: 
			[cuv1 := cuv first.
			self assert: 
					[| tol |
					tol := 1.0d-6.
					(new_pre_uvend - cuv1) length < tol].
			cuv1 u: pre_uvend u.
			cuv1 v: pre_uvend v]
]

{ #category : #accessing }
NurbsSurface >> condition_cuv: aaCurve within: aaBoundingRectangle [ 
	^self uvBound
]

{ #category : #accessing }
NurbsSurface >> controlPointAtU: u v: v [ 
	^ccPoint at: u and: v
]

{ #category : #accessing }
NurbsSurface >> cuKnot [
	^cuKnot
]

{ #category : #accessing }
NurbsSurface >> cuKnot: anObject [
	cuKnot := anObject
]

{ #category : #accessing }
NurbsSurface >> cuvGuess [
	"Avoid ends to avoid singularities."

	| n du dv cuvGuess cu cv |
	n := 8.
	du := (umax - umin) / n.
	dv := (vmax - vmin) / n.
	cu := (umin + (0.5d * du) to: umax by: du) asArray.
	cv := (vmin + (0.5d * dv) to: vmax by: dv) asArray.
	cuvGuess := OrderedCollection new: n * n.
	cu do: [:u | cv do: [:v | cuvGuess add: (u yd: v)]].
	^cuvGuess
]

{ #category : #accessing }
NurbsSurface >> cvKnot [
	^cvKnot
]

{ #category : #accessing }
NurbsSurface >> cvKnot: anObject [ 
	cvKnot := anObject
]

{ #category : #accessing }
NurbsSurface >> extend_length [

	| aBBox ncol |
	aBBox := StCAD_Misc_BoundingBox new. "VW_TRANSLATION:StCAD.Misc.BoundingBox:StCAD_Misc_BoundingBox"
	ncol := ccPoint ncol.
	1 to: ccPoint nrow do: [ :i | 
		| rowi |
		rowi := ccPoint at: i.
		1 to: ncol do: [ :j | aBBox expandToBound: (rowi at: j) ] ].
	^ aBBox diagonal_length
]

{ #category : #testing }
NurbsSurface >> isCyclic [

	^isCyclicu | isCyclicv
]

{ #category : #accessing }
NurbsSurface >> magnifySelf: aDouble [ 
	super magnifySelf: aDouble.
	ccPoint magnifySelf: aDouble
]

{ #category : #accessing }
NurbsSurface >> nDimension [
	^ccPoint first first size
]

{ #category : #accessing }
NurbsSurface >> normalizeKnots [
	| magnification |
	magnification := 1.0d / (umax - umin).
	cuKnot := cuKnot collect: [:u | (u - umin) * magnification].
	umin := 0.0d.
	umax := 1.0d.
	magnification := 1.0d / (vmax - vmin).
	cvKnot := cvKnot collect: [:v | (v - vmin) * magnification].
	vmin := 0.0d.
	vmax := 1.0d
]

{ #category : #accessing }
NurbsSurface >> partialu: uDeriv partialv: vDeriv u: u v: v [ 
	| ccDeriv |
	ccDeriv := self 
				ccDeriv: uDeriv + vDeriv
				u: u
				v: v.
	^ccDeriv at: uDeriv + 1 and: vDeriv + 1
]

{ #category : #copying }
NurbsSurface >> postCopy [
	super postCopy.
	ccPoint := ccPoint copy.
	ccWeight := ccWeight copy.
	cuKnot := cuKnot copy.
	cvKnot := cvKnot copy
]

{ #category : #accessing }
NurbsSurface >> reverse [
	| answer answercuKnot size answerccPoint nrow ncol |
	answer := self copy.
	answercuKnot := answer cuKnot.
	size := cuKnot size.
	1 to: size
		do: [:i | answercuKnot at: size - i + 1 put: (cuKnot at: i) negated].
	answerccPoint := answer ccPoint.
	nrow := ccPoint nrow.
	ncol := ccPoint ncol.
	1 to: nrow
		do: 
			[:i | 
			1 to: ncol
				do: 
					[:j | 
					answerccPoint 
						at: nrow - i + 1
						and: j
						put: (ccPoint at: i and: j)]].
	^answer
]

{ #category : #accessing }
NurbsSurface >> reverseSelf [

	u0isSingular := nil.
	v0isSingular := nil.
	u1isSingular := nil.
	v1isSingular := nil.
	tolSingularity := nil.
	self _ccPoint: ccPoint reverse.
	self ccWeight: ccWeight reverse.
	self _cuKnot: cuKnot negated reverse
]

{ #category : #accessing }
NurbsSurface >> rfpfNurbs [
	^self copy
]

{ #category : #accessing }
NurbsSurface >> rfpf_u: u v: v [ 
	"
	Ref: The NURBS Book, 2nd Ed. by Les Piegl and Wayne Tiller. 
	pp 134.
	"

	| uSpan cNu vSpan cNv cNumerator cDenominator nDimension uSpanDegree vSpanDegree numerator denominator |
	uSpan := self uspan_at: u.
	cNu := self cNu_at: u uSpan: uSpan.
	vSpan := self vspan_at: v.
	cNv := self cNv_at: v vSpan: vSpan.
	cNumerator := FullColumn new: vDegree + 1.
	cDenominator := FullColumn new: vDegree + 1.
	nDimension := self nDimension.
	uSpanDegree := uSpan - uDegree.
	vSpanDegree := vSpan - vDegree.
	0 to: vDegree
		do: 
			[:j | 
			| j1 jj |
			j1 := j + 1.
			jj := vSpanDegree + j.
			cNumerator at: j1 put: (FullColumn zero: nDimension).
			cDenominator at: j1 put: 0.0d.
			0 to: uDegree
				do: 
					[:i | 
					| ii nuw |
					ii := uSpanDegree + i.
					nuw := (cNu at: i + 1) * (ccWeight at: ii and: jj).
					(cNumerator at: j1) equalSelfPlusFullColumn: (ccPoint at: ii and: jj)
						times: nuw.
					cDenominator at: j1 plusNumber: nuw]].
	numerator := FullColumn zero: nDimension.
	denominator := 0.0d.
	0 to: vDegree
		do: 
			[:j | 
			| j1 nv |
			j1 := j + 1.
			nv := cNv at: j1.
			numerator equalSelfPlusFullColumn: (cNumerator at: j1) times: nv.
			denominator := denominator + ((cDenominator at: j1) * nv)].
	^numerator / denominator
]

{ #category : #accessing }
NurbsSurface >> show [
	(self asJunOpenGL3dNurbsSurface)
		paint: ColorValue blue;
		show
]

{ #category : #accessing }
NurbsSurface >> smooth_cuv: aaCurve [

	| cuv uvPrevious |
	cuv := aaCurve cuv.
	uvPrevious := (cuv at: 1) ifNil: [cuv at: 2].
	isCyclicu
		ifTrue: 
			[2 to: cuv size
				do: 
					[:i |
					(cuv at: i)
						ifNotNil: 
							[:cuvi |
							| du |
							du := cuvi u - uvPrevious u.
							cuvi u: cuvi u - du rounded.
							uvPrevious := cuvi]]].
	isCyclicv
		ifTrue: 
			[2 to: cuv size
				do: 
					[:i |
					(cuv at: i)
						ifNotNil: 
							[:cuvi |
							| dv |
							dv := cuvi v - uvPrevious v.
							cuvi v: cuvi v - dv rounded.
							uvPrevious := cuvi]]]
]

{ #category : #accessing }
NurbsSurface >> smooth_cuv: aCurve within: uvBound [ 
	"Do nothing."
]

{ #category : #accessing }
NurbsSurface >> standardDeviation [
	| n ncol sum ssq |
	n := ccPoint numberOfElements.
	ncol := ccPoint ncol.
	sum := ssq := 0.0d.
	1 to: ccPoint nrow
		do: 
			[:i | 
			| rowi |
			rowi := ccPoint at: i.
			1 to: ncol
				do: 
					[:j | 
					| lengthsq length |
					lengthsq := (rowi at: j) sumOfSquaresOfVector.
					length := lengthsq sqrt.
					sum := sum + length.
					ssq := ssq + lengthsq]].
	^((n * ssq - (sum * sum)) / (n * n)) sqrt
]

{ #category : #accessing }
NurbsSurface >> transformSelfBy_rFfF: rFfF aAFf: aAFf [ 
	self 
		_ccPoint: (ccPoint collect: 
					[:cPoint | 
					cPoint 
						collect: [:aPoint | rFfF plusFullColumn: (aAFf timesFullColumn: aPoint)]])
]

{ #category : #accessing }
NurbsSurface >> uDegree [
	^uDegree
]

{ #category : #accessing }
NurbsSurface >> uKnotVector [
	^cuKnot
]

{ #category : #accessing }
NurbsSurface >> uOrder [
	^cuKnot size - self uSize
]

{ #category : #accessing }
NurbsSurface >> uSize [
	^ccPoint nrow
]

{ #category : #accessing }
NurbsSurface >> uspan_at: u [ 
	^NurbsCurve 
		uSpan_at: u
		cuKnot: cuKnot
		uDegree: uDegree
]

{ #category : #accessing }
NurbsSurface >> uvBound [
	^BoundingRectangle origin: (FullColumn with: umin with: vmin)
		corner: (FullColumn with: umax with: vmax)
]

{ #category : #accessing }
NurbsSurface >> uvBoundTol [
	| tol |
	tol := 1.0d-6.
	^BoundingRectangle 
		origin: (FullColumn with: umin - tol with: vmin - tol)
		corner: (FullColumn with: umax + tol with: vmax + tol)
]

{ #category : #accessing }
NurbsSurface >> uvCurveOfCurve: aCurve [
	"Since singularities occur at ends, solve from middle out to the ends."

	| n cnPoint cnPointOn_uv countdown countup block uvCurve |
	n := 64.
	cnPoint := aCurve crFpF_n: n.
	cnPointOn_uv := cnPoint copyEmpty: n.
	countdown := n // 2 to: 1 by: -1.
	countup := n // 2 + 1 to: n.
	block :=
			[:interval |
			| ii uvGuess uvGuessPrevious |
			ii := interval at: 1.
			uvGuessPrevious := self uvOfPoint: (cnPoint at: ii).
			cnPointOn_uv at: ii put: uvGuessPrevious.
			ii := interval at: 2.
			uvGuess := self uvOfPoint: (cnPoint at: ii) uvGuess: uvGuessPrevious.
			cnPointOn_uv at: ii put: uvGuess.
			3 to: interval size
				do: 
					[:i |
					| aPointXYZ uvGuessNew |
					ii := interval at: i.
					aPointXYZ := cnPoint at: ii.
					uvGuessNew := uvGuess + (uvGuess - uvGuessPrevious).
					uvGuessNew u: (uvGuessNew u condition_ge: umin le: umax).
					uvGuessNew v: (uvGuessNew v condition_ge: vmin le: vmax).
					uvGuessPrevious := uvGuess.
					uvGuess := self uvOfPoint: aPointXYZ uvGuess: uvGuessNew.
					cnPointOn_uv at: ii put: uvGuess]].
	block value: countdown.
	block value: countup.
	uvCurve := (NurbsCurve new)
				isSpatial: false;
				cuv: cnPointOn_uv;
				yourself.
	self smooth_cuv: uvCurve.
	^Array with: uvCurve
]

{ #category : #accessing }
NurbsSurface >> uvCurveOfCurve: aCurve preCurve1: preCurve [ 
	| n cnPoint cnPointOn_uv uvGuess interval pre_uvEnd |
	n := 32.
	cnPoint := aCurve crFpF_n: n.
	cnPointOn_uv := cnPoint copyEmpty: n.
	uvGuess := self uvOfPoint: cnPoint first.
	interval := uvGuess ifNil: [n to: 1 by: -1] ifNotNil: [1 to: n].
	interval do: 
			[:i | 
			| aPointXYZ |
			aPointXYZ := cnPoint at: i.
			uvGuess := uvGuess ifNil: [self uvOfPoint: aPointXYZ]
						ifNotNil: [self uvOfPoint: aPointXYZ uvGuess: uvGuess].
			cnPointOn_uv at: i put: uvGuess].
	pre_uvEnd := preCurve ifNotNil: [preCurve uvEnd].
	self condition_cuv: cnPointOn_uv pre_uvEnd: pre_uvEnd.
	^(NurbsCurve fromcDataPoint: cnPointOn_uv uDegree: 3)
		isSpatial: false;
		privateCalcBoundingBox;
		yourself
]

{ #category : #accessing }
NurbsSurface >> uvCurveOfCurve: aCurve preCurve: preCurve [ 
	"Since singularities occur at ends, solve from middle out to the ends."

	| n cnPoint cnPointOn_uv countdown countup block pre_uvEnd |
	n := 32.
	cnPoint := aCurve crFpF_n: n.
	cnPointOn_uv := cnPoint copyEmpty: n.
	countdown := n // 2 to: 1 by: -1.
	countup := n // 2 + 1 to: n.
	block := 
			[:interval | 
			| ii uvGuess uvGuessPrevious |
			ii := interval at: 1.
			uvGuessPrevious := self uvOfPoint: (cnPoint at: ii).
			cnPointOn_uv at: ii put: uvGuessPrevious.
			ii := interval at: 2.
			uvGuess := self uvOfPoint: (cnPoint at: ii) uvGuess: uvGuessPrevious.
			cnPointOn_uv at: ii put: uvGuess.
			3 to: interval size
				do: 
					[:i | 
					| aPointXYZ uvGuessNew |
					ii := interval at: i.
					aPointXYZ := cnPoint at: ii.
					uvGuessNew := uvGuess + (uvGuess - uvGuessPrevious).
					uvGuessNew u: (uvGuessNew u condition_ge: umin le: umax).
					uvGuessNew v: (uvGuessNew v condition_ge: vmin le: vmax).
					uvGuessPrevious := uvGuess.
					uvGuess := self uvOfPoint: aPointXYZ uvGuess: uvGuessNew.
					cnPointOn_uv at: ii put: uvGuess]].
	block value: countdown.
	block value: countup.
	pre_uvEnd := preCurve ifNotNil: [preCurve uvEnd].
	self condition_cuv: cnPointOn_uv pre_uvEnd: pre_uvEnd.
	^(NurbsCurve fromcDataPoint: cnPointOn_uv uDegree: 3)
		isSpatial: false;
		privateCalcBoundingBox;
		yourself
]

{ #category : #accessing }
NurbsSurface >> uvOfPoint: rFpF [ 
	| dist newdist uvGuess tol |
	self cSingularity 
		do: [:aSingularity | (rFpF - aSingularity) length < tolSingularity ifTrue: [^nil]].
	dist := MachineAccuracy OfLargestDouble.
	self cuvGuess do: 
			[:aGuess | 
			newdist := (rFpF minusFullColumn: (self at_uv: aGuess)) length.
			newdist < dist 
				ifTrue: 
					[dist := newdist.
					uvGuess := aGuess]].
	tol := 1.0d-6 * aBoundingBox diagonal_length.
	^dist < tol 
		ifTrue: [uvGuess]
		ifFalse: [self uvOfPoint: rFpF uvGuess: uvGuess]
]

{ #category : #accessing }
NurbsSurface >> uvOfPoint: rFpF uvGuess: uvGuess [

	| uv |
	self cSingularity
		do: [:aSingularity | (rFpF - aSingularity) length < tolSingularity ifTrue: [^nil]].
	uv := (NurbsSurfaceInversion new)
				rFpF: rFpF;
				x: uvGuess;
				system: self;
				run;
				x.
	isCyclicu
		ifTrue: 
			[[uv u < umin] whileTrue: [uv u: uv u + (umax - umin)].
			[uv u >= umax] whileTrue: [uv u: uv u - (umax - umin)]].
	isCyclicv
		ifTrue: 
			[[uv v < vmin] whileTrue: [uv v: uv v + (vmax - vmin)].
			[uv v >= vmax] whileTrue: [uv v: uv v - (vmax - vmin)]].
	^uv
]

{ #category : #accessing }
NurbsSurface >> vDegree [
	^vDegree
]

{ #category : #accessing }
NurbsSurface >> vKnotVector [
	^cvKnot
]

{ #category : #accessing }
NurbsSurface >> vOrder [
	^cvKnot size - self vSize
]

{ #category : #accessing }
NurbsSurface >> vSize [
	^ccPoint ncol
]

{ #category : #accessing }
NurbsSurface >> vspan_at: v [ 
	^NurbsCurve 
		uSpan_at: v
		cuKnot: cvKnot
		uDegree: vDegree
]

{ #category : #accessing }
NurbsSurface >> weightAtU: u v: v [ 
	^ccWeight at: u and: v
]
