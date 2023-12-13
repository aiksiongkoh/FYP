Class {
	#name : #ToroidalSurface,
	#superclass : #SurfaceOfRevolution,
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
ToroidalSurface class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
ToroidalSurface >> condition_cLoopUse: cLoopUse within: uvBound [

	| vmin vmax tol block vShift |
	vmin := uvBound vmin.
	vmax := uvBound vmax.
	tol := 1.0d-6.
	self assert: [ vmax - vmin < (1.0 d + tol) ].
	block := [ :offset | 
	         offset isZero ifFalse: [ 
		         cLoopUse do: [ :aLoopUse | 
			         aLoopUse ccuv do: [ :cuv | 
				         cuv do: [ :uv | uv ifNotNil: [ uv v: uv v - offset ] ] ] ] ] ].
	(vmin equal: vmin rounded tol: tol)
		ifTrue: [ block value: vmin ]
		ifFalse: [ 
			(vmax equal: vmax rounded tol: tol)
				ifTrue: [ block value: vmax - 1.0 d ]
				ifFalse: [ 
					vShift := self vShiftToFituvBound: uvBound.
					vShift ifNotNil: [ 
						StCAD_UI_STEP_SurfaceChangedException raiseSignal "VW_TRANSLATION:StCAD.UI.STEP.SurfaceChangedException:StCAD_UI_STEP_SurfaceChangedException" ] ] ].
	super condition_cLoopUse: cLoopUse within: uvBound
]

{ #category : #ops }
ToroidalSurface >> condition_cgluvTrimNurbs: acgluvTrimNurbs [

	^acgluvTrimNurbs
]

{ #category : #calc }
ToroidalSurface >> condition_cuv: aaCurve [ 
	"
	Since the torus is periodic in v, v=0 is the same as v=integer.	
	Condition the series to have smooth v's.
	"

	| vmin vmax cuv uvPrevious v tol offset |
	vmin := MachineAccuracy OfLargestDouble.
	vmax := MachineAccuracy OfLargestDouble negated.
	cuv := aaCurve cuv.
	uvPrevious := cuv at: 1.
	v := uvPrevious v.
	vmin := vmin min: v.
	vmax := vmax max: v.
	2 to: cuv size
		do: 
			[:i | 
			| cuvi dv |
			cuvi := cuv at: i.
			dv := cuvi v - uvPrevious v.
			cuvi v: cuvi v - dv rounded.
			uvPrevious := cuvi.
			v := uvPrevious v.
			vmin := vmin min: v.
			vmax := vmax max: v].
	tol := 1.0d-9.
	self assert: [vmax - vmin < (1.0d + tol)].
	(vmin - vmin rounded) abs < tol 
		ifTrue: 
			[offset := vmin.
			cuv do: [:uv | uv ifNotNil: [uv v: uv v - offset]]]
		ifFalse: 
			[(vmax - vmax rounded) abs < tol 
				ifTrue: 
					[offset := vmax - 1.0d.
					cuv do: [:uv | uv ifNotNil: [uv v: uv v - offset]]]].
	^super condition_cuv: aaCurve
]

{ #category : #calc }
ToroidalSurface >> condition_cuv: cuv pre_uvEnd1: pre_uvend [ 
	"
	Since the cylinder is periodic u=0 is the same as u=integer.	
	Condition the series to have smooth u's and v's.
	"

	| tol n uvPrevious |
	tol := 0.5d.
	n := cuv size.
	uvPrevious := cuv at: 1.
	pre_uvend ifNil: 
			[uvPrevious u: uvPrevious u \\ 1.0d.
			uvPrevious v: uvPrevious v \\ 1.0d]
		ifNotNil: 
			[(uvPrevious u - pre_uvend u) abs > tol ifTrue: [uvPrevious u: pre_uvend u].
			(uvPrevious v - pre_uvend v) abs > tol ifTrue: [uvPrevious v: pre_uvend v]].
	2 to: n
		do: 
			[:i | 
			| cuvi du dv |
			cuvi := cuv at: i.
			du := cuvi u - uvPrevious u.
			du abs > tol 
				ifTrue: 
					[du positive 
						ifTrue: [cuvi u: cuvi u - 1.0d]
						ifFalse: [cuvi u: cuvi u + 1.0d]].
			dv := cuvi v - uvPrevious v.
			dv abs > tol 
				ifTrue: 
					[dv positive 
						ifTrue: [cuvi v: cuvi v - 1.0d]
						ifFalse: [cuvi v: cuvi v + 1.0d]].
			uvPrevious := cuvi]
]

{ #category : #calc }
ToroidalSurface >> condition_cuv: cuv pre_uvEnd2: pre_uvend [ 
	"
	Since the cylinder is periodic u=0 is the same as u=integer.	
	Condition the series to have smooth u's and v's.
	"

	| uvPrevious |
	uvPrevious := cuv at: 1.
	pre_uvend ifNil: 
			[uvPrevious u: uvPrevious u \\ 1.0d.
			uvPrevious v: uvPrevious v \\ 1.0d]
		ifNotNil: 
			[uvPrevious u: pre_uvend u.
			uvPrevious v: pre_uvend v].
	2 to: cuv size
		do: 
			[:i | 
			| cuvi du dv |
			cuvi := cuv at: i.
			du := cuvi u - uvPrevious u.
			cuvi u: cuvi u - du rounded.
			dv := cuvi v - uvPrevious v.
			cuvi v: cuvi v - dv rounded.
			uvPrevious := cuvi]
]

{ #category : #calc }
ToroidalSurface >> condition_cuv: cuv pre_uvEnd: pre_uvend [ 
	"
	Since the cylinder is periodic u=0 is the same as u=integer.	
	Condition the series to have smooth u's and v's.
	"

	| uvPrevious |
	uvPrevious := cuv at: 1.
	pre_uvend ifNil: 
			[uvPrevious u: uvPrevious u \\ 1.0d.
			uvPrevious v: uvPrevious v \\ 1.0d]
		ifNotNil: 
			[uvPrevious u: pre_uvend u.
			uvPrevious v: pre_uvend v].
	2 to: cuv size
		do: 
			[:i | 
			| cuvi du dv |
			cuvi := cuv at: i.
			du := cuvi u - uvPrevious u.
			cuvi u: cuvi u - du rounded.
			dv := cuvi v - uvPrevious v.
			cuvi v: cuvi v - dv rounded.
			uvPrevious := cuvi]
]

{ #category : #calc }
ToroidalSurface >> condition_cuv: aaCurve within: aaBoundingRectangle [ 
	"
	Since the toroidal surface is periodic, v=0 is the same as v=integer.	
	Condition the series to have smooth v's.
	"

	| newBoundingRectangle cuv uvPrevious u v |
	newBoundingRectangle := BoundingRectangle new.
	cuv := aaCurve cuv.
	uvPrevious := cuv at: 1.
	aaBoundingRectangle isDefined 
		ifTrue: 
			[u := uvPrevious u.
			u := u - (u - aaBoundingRectangle umin) floor.
			uvPrevious u: u.
			v := uvPrevious v.
			v := v - (v - aaBoundingRectangle vmin) floor.
			uvPrevious v: v].
	newBoundingRectangle expandToBound: uvPrevious.
	2 to: cuv size
		do: 
			[:i | 
			| cuvi du dv |
			cuvi := cuv at: i.
			du := cuvi u - uvPrevious u.
			cuvi u: cuvi u - du rounded.
			dv := cuvi v - uvPrevious v.
			cuvi v: cuvi v - dv rounded.
			uvPrevious := cuvi.
			newBoundingRectangle expandToBound: uvPrevious].
	^newBoundingRectangle
]

{ #category : #'initialize-release' }
ToroidalSurface >> initialize [

	"Circle must in xz plane."

	| aCircle |
	super initialize.
	aCircle := StCAD_Geo_Circle new
		           _radius: 0.0 d;
		           yourself. "VW_TRANSLATION:StCAD.Geo.Circle:StCAD_Geo_Circle"
	aCircle aRefFrame rotatex: Double pi / 2.0 d.
	self _aCurve: aCircle
]

{ #category : #'initialize-release' }
ToroidalSurface >> initialize1 [

	"Circle must in xz plane."

	| aCircle |
	super initialize.
	aCircle := StCAD_Geo_Circle new
		           _radius: 0.0 d;
		           yourself. "VW_TRANSLATION:StCAD.Geo.Circle:StCAD_Geo_Circle"
	aCircle aRefFrame rotatex: Double pi / 2.0 d.
	self _aCurve: aCircle
]

{ #category : #'initialize-release' }
ToroidalSurface >> initialize2 [

	"Circle must in xz plane."

	| aCircle |
	super initialize.
	aCircle := StCAD_Geo_Circle new
		           _radius: 0.0 d;
		           yourself. "VW_TRANSLATION:StCAD.Geo.Circle:StCAD_Geo_Circle"
	aCircle aRefFrame rotatex: Double pi / 2.0 d.
	aCircle aRefFrame rotatez: Double pi / 2.0 d negated.
	self _aCurve: aCircle
]

{ #category : #accessing }
ToroidalSurface >> majorRadius [
	^aCurve aRefFrame rFfF x
]

{ #category : #accessing }
ToroidalSurface >> majorRadius: aDouble [ 
	^aCurve aRefFrame rFfF x: aDouble asDouble
]

{ #category : #accessing }
ToroidalSurface >> minorRadius [
	^aCurve _radius
]

{ #category : #accessing }
ToroidalSurface >> minorRadius: aDouble [ 
	^aCurve _radius: aDouble asDouble
]

{ #category : #accessing }
ToroidalSurface >> smooth_cgluvTrimNurbs: anOrderedCollection [ 
	self halt
]

{ #category : #calc }
ToroidalSurface >> smooth_cuv: aaCurve [ 
	"
	Since the torus is periodic in v, v=0 is the same as v=integer.	
	"

	| cuv uvPrevious |
	cuv := aaCurve cuv.
	uvPrevious := cuv at: 1.
	2 to: cuv size
		do: 
			[:i | 
			| cuvi dv |
			cuvi := cuv at: i.
			dv := cuvi v - uvPrevious v.
			cuvi v: cuvi v - dv rounded.
			uvPrevious := cuvi].
	^super smooth_cuv: aaCurve
]

{ #category : #accessing }
ToroidalSurface >> smooth_cuv: aaCurve within: uvBound [ 
	| cuv umin offset vmin |
	self smooth_cuv: aaCurve.
	cuv := aaCurve cuv.
	(cuv allSatisfy: [:uv | uvBound containsPoint: uv]) 
		ifFalse: 
			[umin := (cuv collect: [:uv | uv at: 1]) minValue.
			offset := (umin - uvBound umin) floor asDouble.
			offset isZero ifFalse: [cuv do: [:uv | uv u: uv u - offset]].
			vmin := (cuv collect: [:uv | uv at: 2]) minValue.
			offset := (vmin - uvBound vmin) floor asDouble.
			offset isZero ifFalse: [cuv do: [:uv | uv v: uv v - offset]]]
]

{ #category : #accessing }
ToroidalSurface >> uvCurveOfEllipticArc1: aEllipticArc [ 
	| cnPoint cnPointOn_uv |
	cnPoint := aEllipticArc crFpF_n: 4.
	cnPointOn_uv := cnPoint collect: [:aPointXYZ | self uvOfPoint: aPointXYZ].
	^(Line new)
		isSpatial: false;
		cuv: cnPointOn_uv;
		yourself
]

{ #category : #accessing }
ToroidalSurface >> uvCurveOfEllipticArc: aEllipticArc [

	| glSurface cnPoint cnPointOn_uv |
	glSurface := self glSurface.
	cnPoint := aEllipticArc crFpF_n: 4.
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
ToroidalSurface >> uvCurveOfEllipticArc: aEllipticArc preCurve: preCurve [ 
	| cnPoint cnPointOn_uv pre_uvEnd uvStart uvEnd uvLine |
	cnPoint := aEllipticArc crFpF_n: 4.
	cnPointOn_uv := cnPoint collect: [:aPointXYZ | self uvOfPoint: aPointXYZ].
	pre_uvEnd := preCurve ifNotNil: [preCurve uvEnd].
	self condition_cuv: cnPointOn_uv pre_uvEnd: pre_uvEnd.
	uvStart := cnPointOn_uv first.
	uvEnd := cnPointOn_uv last.
	uvLine := Line new.
	uvLine
		isSpatial: false;
		uvStart: uvStart;
		uvEnd: uvEnd;
		dsdt: 1 / (uvEnd - uvStart) length;
		privateCalcBoundingBox.
	^uvLine
]

{ #category : #accessing }
ToroidalSurface >> uvShiftToFituvBound1: uvBound [ 
	^(self uvBoundTol contains: uvBound) 
		ifTrue: [nil]
		ifFalse: 
			[| answer umin umax vmin vmax |
			answer := FullColumn with: 0.0d with: 0.0d.
			umin := uvBound umin.
			umax := uvBound umax.
			(umin < 0.0d or: [umax > 1.0d]) 
				ifTrue: 
					[aRefFrame rotatez: umin * Double twoPi.
					answer at: 1 put: umin negated].
			vmin := uvBound vmin.
			vmax := uvBound vmax.
			(vmin < 0.0d or: [vmax > 1.0d]) 
				ifTrue: 
					[aCurve aRefFrame rotatez: vmin * Double twoPi.
					answer at: 2 put: vmin negated].
			answer]
]

{ #category : #accessing }
ToroidalSurface >> uv_gluv: gluv [
	"u_theta and u_nurbs do not have a linear relationship. Nurb circle and r theta circle are not identical."
	"
	-0.2d \\ 1.0d	= 0.8d
	0.8d \\ -1.0d	= -0.2d
	"

	| glu glv rFpF uv |
	glu := gluv u.
	glv := gluv v.
	rFpF := self glSurface rFpF_u: glu \\ 1.0d v: glv \\ 1.0d.
	uv := self uvOfPoint: rFpF.
	glu negative ifTrue: [uv u: uv u \\ -1.0d].
	glv negative ifTrue: [uv v: uv v \\ -1.0d].
	^uv
]

{ #category : #ops }
ToroidalSurface >> vShiftToFituvBound: uvBound [

	| tol uv vmin vmax vShift |
	tol := 1.0d-6.
	vmin := uvBound vmin.
	vmax := uvBound vmax.
	^(vmin >= (0.0d - tol) and: [vmax <= (1.0d + tol)])
		ifTrue: [nil]
		ifFalse: 
			[(vmin < 0.0d or: [vmax > 1.0d])
				ifTrue: 
					[uv := self uv_gluv: uvBound minCorner.
					vShift := uv last.
					aCurve aRefFrame rotatez: vShift * Double twoPi].
			vShift]
]
