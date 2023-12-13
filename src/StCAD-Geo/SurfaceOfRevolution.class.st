"
Revolve about z axis.
u is equator. trajectory is a circle.
v is in positive direction. curve is defined in xz plane.
"
Class {
	#name : #SurfaceOfRevolution,
	#superclass : #Surface,
	#instVars : [
		'aCurve'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
SurfaceOfRevolution class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
SurfaceOfRevolution >> _aCurve: aaCurve [ 
	aaCurve removeSup.
	super addRefFrame: aaCurve aRefFrame.
	aCurve := aaCurve.
	aaCurve aSup: self.
	^aaCurve
]

{ #category : #accessing }
SurfaceOfRevolution >> aCurve [
	^aCurve
]

{ #category : #calc }
SurfaceOfRevolution >> cEndSingularityOf: aaCurve [ 
	^MathArray with: false with: false
]

{ #category : #ops }
SurfaceOfRevolution >> condition_cLoopUse: cLoopUse [

	| cuvLast offset |
	cLoopUse do: 
			[:aLoopUse |
			((aLoopUse cuvFirst u - aLoopUse cuvLast u) abs equal: 1.0d tol: 1.0d-6)
				ifTrue: [aLoopUse minusU: aLoopUse cuvFirst u]].
	cuvLast := cLoopUse first cuvFirst.
	cLoopUse do: 
			[:aLoopUse |
			offset := (aLoopUse cuvFirst u - cuvLast u) rounded.
			offset isZero ifFalse: [aLoopUse minusU: offset].
			cuvLast := aLoopUse cuvLast]
]

{ #category : #accessing }
SurfaceOfRevolution >> condition_cLoopUse: cLoopUse within: uvBound [

	| umin umax tol block uShift |
	umin := uvBound umin.
	umax := uvBound umax.
	tol := 1.0d-6.
	self assert: [ umax - umin < (1.0 d + tol) ].
	block := [ :offset | 
	         offset isZero ifFalse: [ 
		         cLoopUse do: [ :aLoopUse | 
			         aLoopUse ccuv do: [ :cuv | 
				         cuv do: [ :uv | uv ifNotNil: [ uv u: uv u - offset ] ] ] ] ] ].
	(umin equal: umin rounded tol: tol)
		ifTrue: [ block value: umin ]
		ifFalse: [ 
			(umax equal: umax rounded tol: tol)
				ifTrue: [ block value: umax - 1.0 d ]
				ifFalse: [ 
					uShift := self uShiftToFituvBound: uvBound.
					uShift ifNotNil: [ 
						StCAD_UI_STEP_SurfaceChangedException raiseSignal "VW_TRANSLATION:StCAD.UI.STEP.SurfaceChangedException:StCAD_UI_STEP_SurfaceChangedException" ] ] ]
]

{ #category : #calc }
SurfaceOfRevolution >> condition_cuv: aaCurve [ 
	"
	Since the solid of revolution is periodic, u=0 is the same as u=integer.	
	Condition the series to have smooth u's.
	"

	| umin umax cuv uvPrevious u tol offset |
	umin := MachineAccuracy OfLargestDouble.
	umax := MachineAccuracy OfLargestDouble negated.
	cuv := aaCurve cuv.
	uvPrevious := cuv at: 1.
	u := uvPrevious u.
	umin := umin min: u.
	umax := umax max: u.
	2 to: cuv size
		do: 
			[:i | 
			| cuvi du |
			cuvi := cuv at: i.
			du := cuvi u - uvPrevious u.
			cuvi u: cuvi u - du rounded.
			uvPrevious := cuvi.
			u := uvPrevious u.
			umin := umin min: u.
			umax := umax max: u].
	tol := 1.0d-6.
	self assert: [umax - umin < (1.0d + tol)].
	(umin - umin rounded) abs < tol 
		ifTrue: 
			[offset := umin.
			cuv do: [:uv | uv ifNotNil: [uv u: uv u - offset]]]
		ifFalse: 
			[(umax - umax rounded) abs < tol 
				ifTrue: 
					[offset := umax - 1.0d.
					cuv do: [:uv | uv ifNotNil: [uv u: uv u - offset]]]]
]

{ #category : #calc }
SurfaceOfRevolution >> condition_cuv: cuv pre_uvEnd1: pre_uvend [ 
	"
	Since the cylinder is periodic u=0 is the same as u=integer.	
	Condition the series to have smooth u's.
	"

	| tol n uvPrevious |
	tol := 0.5d.
	n := cuv size.
	uvPrevious := cuv at: 1.
	pre_uvend ifNil: [uvPrevious u: uvPrevious u \\ 1.0d]
		ifNotNil: 
			[(uvPrevious u - pre_uvend u) abs > tol ifTrue: [uvPrevious u: pre_uvend u]].
	2 to: n
		do: 
			[:i | 
			| cuvi du |
			cuvi := cuv at: i.
			du := cuvi u - uvPrevious u.
			du abs > tol 
				ifTrue: 
					[du positive 
						ifTrue: [cuvi u: cuvi u - 1.0d]
						ifFalse: [cuvi u: cuvi u + 1.0d]].
			uvPrevious := cuvi]
]

{ #category : #calc }
SurfaceOfRevolution >> condition_cuv: cuv pre_uvEnd2: pre_uvend [ 
	"
	Since the cylinder is periodic u=0 is the same as u=integer.	
	Condition the series to have smooth u's.
	"

	| tol n uvPrevious |
	tol := 0.5d.
	n := cuv size.
	uvPrevious := cuv at: 1.
	pre_uvend ifNil: [uvPrevious u: uvPrevious u \\ 1.0d]
		ifNotNil: 
			[(uvPrevious u - pre_uvend u) abs > tol ifTrue: [uvPrevious u: pre_uvend u]].
	2 to: n
		do: 
			[:i | 
			| cuvi du |
			cuvi := cuv at: i.
			du := cuvi u - uvPrevious u.
			cuvi u: cuvi u - du rounded.
			uvPrevious := cuvi]
]

{ #category : #calc }
SurfaceOfRevolution >> condition_cuv: cuv pre_uvEnd3: pre_uvend [ 
	"
	Since the cylinder is periodic u=0 is the same as u=integer.	
	Condition the series to have smooth u's.
	"

	| uvPrevious |
	uvPrevious := cuv at: 1.
	pre_uvend ifNil: [uvPrevious u: uvPrevious u \\ 1.0d]
		ifNotNil: [uvPrevious u: pre_uvend u].
	2 to: cuv size
		do: 
			[:i | 
			| cuvi du |
			cuvi := cuv at: i.
			du := cuvi u - uvPrevious u.
			cuvi u: cuvi u - du rounded.
			uvPrevious := cuvi]
]

{ #category : #calc }
SurfaceOfRevolution >> condition_cuv: cuv pre_uvEnd: pre_uvend [ 
	"
	Since the cylinder is periodic u=0 is the same as u=integer.	
	Condition the series to have smooth u's.
	"

	| uvPrevious |
	uvPrevious := cuv at: 1.
	pre_uvend ifNil: [uvPrevious u: uvPrevious u \\ 1.0d]
		ifNotNil: 
			[uvPrevious u: pre_uvend u.
			uvPrevious v: pre_uvend v].
	2 to: cuv size
		do: 
			[:i | 
			| cuvi du |
			cuvi := cuv at: i.
			du := cuvi u - uvPrevious u.
			cuvi u: cuvi u - du rounded.
			uvPrevious := cuvi]
]

{ #category : #calc }
SurfaceOfRevolution >> condition_cuv: aaCurve within: aaBoundingRectangle [ 
	"
	Since the solid of revolution is periodic, u=0 is the same as u=integer.	
	Condition the series to have smooth u's.
	"

	| newBoundingRectangle cuv uvPrevious u |
	newBoundingRectangle := BoundingRectangle new.
	cuv := aaCurve cuv.
	uvPrevious := cuv at: 1.
	aaBoundingRectangle isDefined 
		ifTrue: 
			[u := uvPrevious u.
			u := u - (u - aaBoundingRectangle umin) floor.
			uvPrevious u: u].
	newBoundingRectangle expandToBound: uvPrevious.
	2 to: cuv size
		do: 
			[:i | 
			| cuvi du |
			cuvi := cuv at: i.
			du := cuvi u - uvPrevious u.
			cuvi u: cuvi u - du rounded.
			uvPrevious := cuvi.
			newBoundingRectangle expandToBound: uvPrevious].
	^newBoundingRectangle
]

{ #category : #calc }
SurfaceOfRevolution >> createNurbs [
	^NurbsSurface fromSolidOfRevolution: self
]

{ #category : #testing }
SurfaceOfRevolution >> isCyclic [

	^true
]

{ #category : #testing }
SurfaceOfRevolution >> isLatitute: aCircularArc [

	| angleTol distTol zAxesParallel rfpf isConcentricInXY |
	angleTol := 1.0d-6.
	distTol := 1.0d-9.
	zAxesParallel := ((aRefFrame aAFf column: 3)
				dot: (aCircularArc aRefFrame aAFf column: 3)) abs
				equal: 1.0d
				tol: angleTol.
	rfpf := aRefFrame rfpffromrOpO: aCircularArc aRefFrame rOfO.
	isConcentricInXY := rfpf xy length < distTol.
	^zAxesParallel & isConcentricInXY
]

{ #category : #accessing }
SurfaceOfRevolution >> magnifySelf: aDouble [ 
	super magnifySelf: aDouble.
	aCurve magnifySelf: aDouble
]

{ #category : #accessing }
SurfaceOfRevolution >> reverseSelf [
	aCurve reverseSelf
]

{ #category : #calc }
SurfaceOfRevolution >> rfpfNurbs [
	^NurbsSurface fromSolidOfRevolution: self
]

{ #category : #accessing }
SurfaceOfRevolution >> rfpf_u: u v: v [ 
	| rCpC xyRadius z the x y |
	rCpC := aCurve rFpF_u: v.
	xyRadius := rCpC x.
	z := rCpC z.
	the := u * Double twoPi.
	x := xyRadius * the cos.
	y := xyRadius * the sin.
	^FullColumn 
		with: x
		with: y
		with: z
]

{ #category : #calc }
SurfaceOfRevolution >> smooth_cuv: aaCurve [ 
	"
	Since the solid of revolution is periodic, u=0 is the same as u=integer.	
	"

	| cuv uvPrevious |
	cuv := aaCurve cuv.
	uvPrevious := (cuv at: 1) ifNil: [cuv at: 2].
	2 to: cuv size
		do: 
			[:i | 
			(cuv at: i) ifNotNil: 
					[:cuvi | 
					| du |
					du := cuvi u - uvPrevious u.
					cuvi u: cuvi u - du rounded.
					uvPrevious := cuvi]]
]

{ #category : #calc }
SurfaceOfRevolution >> smooth_cuv: aaCurve within: uvBound [

	| cuv umin offset |
	self smooth_cuv: aaCurve.
	cuv := aaCurve cuv.
	(cuv allSatisfy: [:uv | uvBound containsPoint: uv])
		ifFalse: 
			[umin := (cuv collect: [:uv | uv at: 1]) minValue.
			offset := (umin - uvBound umin) floor asDouble.
			offset isZero ifFalse: [cuv do: [:uv | uv u: uv u - offset]]]
]

{ #category : #ops }
SurfaceOfRevolution >> uShiftToFituvBound: uvBound [

	| tol uv umin umax uShift |
	tol := 1.0d-6.
	umin := uvBound umin.
	umax := uvBound umax.
	^(umin >= (0.0d - tol) and: [umax <= (1.0d + tol)])
		ifTrue: [nil]
		ifFalse: 
			[(umin < 0.0d or: [umax > 1.0d])
				ifTrue: 
					[uv := self uv_gluv: uvBound minCorner.
					uShift := uv first.
					aRefFrame rotatez: uShift * Double twoPi].
			uShift]
]

{ #category : #calc }
SurfaceOfRevolution >> uvCurveOfCircularArc: aCircularArc [
	"uv of cylindrical surface is not the same as the uv of Nurbs cylinder."

	| glSurface cnPoint cnPointOn_uv |
	glSurface := self glSurface.
	cnPoint := aCircularArc crFpF_n: 4.
	cnPointOn_uv := cnPoint collect: 
					[:aPointXYZ |
					| uvGuess |
					uvGuess := self uvOfPoint: aPointXYZ.
					glSurface uvOfPoint: aPointXYZ uvGuess: uvGuess].
	^Array with: ((Line new)
				isSpatial: false;
				cuv: cnPointOn_uv;
				yourself)
]

{ #category : #accessing }
SurfaceOfRevolution >> uvOfPoint: rFpF [ 
	| rfpf x y z u v xyRadius |
	rfpf := aRefFrame rfpffromrFpF: rFpF.
	x := rfpf x.
	y := rfpf y.
	z := rfpf z.
	xyRadius := (x * x + (y * y)) sqrt.
	u := (Double 
				arcTan0to2piY: y
				overX: x
				ifUndefined: 0.0d) / Double twoPi.
	u := u \\ 1.0d.
	v := aCurve uOfPoint: (FullColumn 
						with: xyRadius
						with: 0.0d
						with: z).
	^u yd: v
]

{ #category : #accessing }
SurfaceOfRevolution >> uvShiftToFituvBound1: uvBound [ 
	| umin umax |
	^(self uvBoundTol contains: uvBound) 
		ifTrue: [nil]
		ifFalse: 
			[umin := uvBound umin.
			umax := uvBound umax.
			(umin < 0.0d or: [umax > 1.0d]) 
				ifTrue: 
					[aRefFrame rotatez: umin * Double twoPi.
					FullColumn with: umin negated with: 0.0d]
				ifFalse: 
					[self assert: 
							[| tol |
							tol := 1.0d-9.
							0.0d - tol <= uvBound vmin and: [uvBound vmax <= (1.0d + tol)]].
					nil]]
]

{ #category : #accessing }
SurfaceOfRevolution >> uv_gluv: gluv [
	"u_theta and u_nurbs do not have a linear relationship. Nurb cylinder and r theta cylinder are not identical."
	"
	-0.2d \\ 1.0d	= 0.8d
	0.8d \\ -1.0d	= -0.2d
	"

	| glu glv rFpF uv |
	glu := gluv u.
	glv := gluv v.
	rFpF := self glSurface rFpF_u: glu \\ 1.0d v: glv.
	uv := self uvOfPoint: rFpF.
	glu negative ifTrue: [uv u: uv u \\ -1.0d].
	^uv
]
