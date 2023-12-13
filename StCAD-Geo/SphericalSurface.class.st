"
aCurve is a meridian arc from the south pole (-z) to the north pole (+z).
"
Class {
	#name : #SphericalSurface,
	#superclass : #SurfaceOfRevolution,
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
SphericalSurface class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #ops }
SphericalSurface >> atPolesBreakMeridianArc: aEllipticArc [

	| cPole cthe theStart theEnd arc tol |
	cPole := (0 to: 1) collect: [ :i | self rFpF_u: 0.0 d v: i asDouble ].
	cthe := cPole collect: [ :pole | aEllipticArc the_rFpF: pole ].
	cthe := cthe asSortedCollection.
	tol := 1.0d-9.
	theStart := aEllipticArc theStart + tol.
	theEnd := aEllipticArc theEnd - tol.
	cthe := cthe select: [ :u | u gt: theStart lt: theEnd ].
	cthe := cthe asOrderedCollection.
	cthe addLast: theEnd.
	^ cthe collect: [ :the | 
		  arc := StCAD_Geo_EllipticArc new. "VW_TRANSLATION:StCAD.Geo.EllipticArc:StCAD_Geo_EllipticArc"
		  arc aRefFrame copyrFfFandAFfFrom: aEllipticArc aRefFrame.
		  arc
			  _radius: aEllipticArc _radius;
			  theStart: theStart;
			  theEnd: the;
			  conditionSelf.
		  self assert: [ arc isOK ].
		  theStart := the.
		  arc ]
]

{ #category : #accessing }
SphericalSurface >> cEndSingularityOf: aaCurve [ 
	| cuv tol n uv1 uvn v1 vn startSingularity endSingularity |
	cuv := aaCurve cuv.
	tol := 1.0d-6.
	n := cuv size.
	uv1 := (cuv at: 1) ifNil: 
					[cuv at: 1
						put: (FullColumn with: (cuv at: 2) u with: (cuv at: 2) v rounded asDouble)].
	uvn := (cuv at: n) ifNil: 
					[cuv at: n
						put: (FullColumn with: (cuv at: n - 1) u
								with: (cuv at: n - 1) v rounded asDouble)].
	v1 := uv1 v.
	vn := uvn v.
	startSingularity := false.
	endSingularity := false.
	((v1 equal: 0.0d tol: tol) or: [v1 equal: 1.0d tol: tol]) 
		ifTrue: 
			[uv1 u: (cuv at: 2) u.
			startSingularity := true].
	((vn equal: 0.0d tol: tol) or: [vn equal: 1.0d tol: tol]) 
		ifTrue: 
			[uvn u: (cuv at: n - 1) u.
			endSingularity := true].
	^MathArray with: startSingularity with: endSingularity
]

{ #category : #ops }
SphericalSurface >> condition_cglTrimNurbs1: cglTrimNurbs [ 
	| tol uvStart uvEnd aStream uvNext uvStarti v aPoint bPoint cPoint dPoint |
	tol := 1.0d-6.
	uvStart := cglTrimNurbs first uvStart.
	uvEnd := cglTrimNurbs last uvEnd.
	^(uvStart - uvEnd) length < tol 
		ifTrue: 
			[aStream := (cglTrimNurbs species new: cglTrimNurbs size) writeStream.
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
			aStream contents]
		ifFalse: 
			[((uvStart v equal: 0.0d tol: tol) or: [uvStart v equal: 1.0d tol: tol]) 
				ifTrue: 
					[self name: #debug.
					cglTrimNurbs
						addLast: (NurbsCurve fromStart: uvEnd copy toEnd: uvStart copy);
						yourself]
				ifFalse: 
					[self name: #debug.
					v := uvStart u < uvEnd u ifTrue: [1.0d] ifFalse: [0.0d].
					aPoint := uvEnd.
					bPoint := FullColumn with: uvEnd u with: v.
					cPoint := FullColumn with: uvStart u with: v.
					dPoint := uvStart.
					cglTrimNurbs
						addLast: (NurbsCurve fromStart: aPoint copy toEnd: bPoint copy);
						addLast: (NurbsCurve fromStart: bPoint copy toEnd: cPoint copy);
						addLast: (NurbsCurve fromStart: cPoint copy toEnd: dPoint copy);
						yourself]]
]

{ #category : #ops }
SphericalSurface >> condition_cglTrimNurbs: cglTrimNurbs [ 
	| tol uvStart uvEnd aStream uvNext uvStarti v aPoint bPoint cPoint dPoint |
	tol := 1.0d-4.
	uvStart := cglTrimNurbs first uvStart.
	uvEnd := cglTrimNurbs last uvEnd.
	^(uvStart - uvEnd) length < tol 
		ifTrue: 
			[aStream := (cglTrimNurbs species new: cglTrimNurbs size) writeStream.
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
			aStream contents]
		ifFalse: 
			[((uvStart v equal: 0.0d tol: tol) or: [uvStart v equal: 1.0d tol: tol]) 
				ifTrue: 
					[self name: #debug.
					cglTrimNurbs
						addLast: (NurbsCurve fromStart: uvEnd copy toEnd: uvStart copy);
						yourself]
				ifFalse: 
					[self name: #debug.
					v := uvStart u < uvEnd u ifTrue: [1.0d] ifFalse: [0.0d].
					aPoint := uvEnd.
					bPoint := FullColumn with: uvEnd u with: v.
					cPoint := FullColumn with: uvStart u with: v.
					dPoint := uvStart.
					cglTrimNurbs
						addLast: (NurbsCurve fromStart: aPoint copy toEnd: bPoint copy);
						addLast: (NurbsCurve fromStart: bPoint copy toEnd: cPoint copy);
						addLast: (NurbsCurve fromStart: cPoint copy toEnd: dPoint copy);
						yourself]]
]

{ #category : #ops }
SphericalSurface >> condition_cgluvTrimNurbs: cgluvTrimNurbs [

	| tol uvStart uvEnd aStream uvNext uvStarti v aPoint bPoint cPoint dPoint |
	tol := 1.0d-4.
	uvStart := cgluvTrimNurbs first uvStart.
	uvEnd := cgluvTrimNurbs last uvEnd.
	^(uvStart - uvEnd) length < tol
		ifTrue: 
			[aStream := (cgluvTrimNurbs species new: cgluvTrimNurbs size) writeStream.
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
		ifFalse: 
			[((uvStart v equal: 0.0d tol: tol) or: [uvStart v equal: 1.0d tol: tol])
				ifTrue: 
					[self name: #debug.
					cgluvTrimNurbs
						addLast: (NurbsCurve fromStart: uvEnd copy toEnd: uvStart copy);
						yourself]
				ifFalse: 
					[self name: #debug.
					v := uvStart u < uvEnd u ifTrue: [1.0d] ifFalse: [0.0d].
					aPoint := uvEnd.
					bPoint := FullColumn with: uvEnd u with: v.
					cPoint := FullColumn with: uvStart u with: v.
					dPoint := uvStart.
					cgluvTrimNurbs
						addLast: (NurbsCurve fromStart: aPoint copy toEnd: bPoint copy);
						addLast: (NurbsCurve fromStart: bPoint copy toEnd: cPoint copy);
						addLast: (NurbsCurve fromStart: cPoint copy toEnd: dPoint copy);
						yourself]]
]

{ #category : #accessing }
SphericalSurface >> condition_cuv: aaCurve [ 
	"
	Since the solid of revolution is periodic, u=0 is the same as u=integer.	
	Condition the series to have smooth u's.
	"

	| umin umax cuv uvPrevious u tol offset |
	umin := MachineAccuracy OfLargestDouble.
	umax := MachineAccuracy OfLargestDouble negated.
	cuv := aaCurve cuv.
	uvPrevious := (cuv at: 1) ifNil: [cuv at: 2].
	u := uvPrevious u.
	umin := umin min: u.
	umax := umax max: u.
	2 to: cuv size
		do: 
			[:i | 
			(cuv at: i) ifNotNil: 
					[:cuvi | 
					| du |
					du := cuvi u - uvPrevious u.
					cuvi u: cuvi u - du rounded.
					uvPrevious := cuvi.
					u := uvPrevious u.
					umin := umin min: u.
					umax := umax max: u]].
	tol := 1.0d-9.
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

{ #category : #accessing }
SphericalSurface >> condition_cuv: cuv pre_uvEnd1: pre_uvend [ 
	| tol n uv1 uvn v1 vn new_pre_uvend |
	tol := 1.0d-6.
	n := cuv size.
	uv1 := cuv at: 1.
	uvn := cuv at: n.
	v1 := uv1 v.
	vn := uvn v.
	((v1 equal: 0.0d tol: tol) or: [v1 equal: 1.0d tol: tol]) 
		ifTrue: 
			[uv1 u: (cuv at: 2) u.
			"Discontinuity expected."
			new_pre_uvend := nil]
		ifFalse: 
			[((vn equal: 0.0d tol: tol) or: [vn equal: 1.0d tol: tol]) 
				ifTrue: [uvn u: (cuv at: n - 1) u].
			new_pre_uvend := pre_uvend].
	super condition_cuv: cuv pre_uvEnd: new_pre_uvend
]

{ #category : #accessing }
SphericalSurface >> condition_cuv: cuv pre_uvEnd2: pre_uvend [ 
	| tol n uv1 uvn v1 vn |
	tol := 1.0d-6.
	n := cuv size.
	uv1 := cuv at: 1.
	uvn := cuv at: n.
	v1 := uv1 v.
	vn := uvn v.
	((v1 equal: 0.0d tol: tol) or: [v1 equal: 1.0d tol: tol]) 
		ifTrue: [uv1 u: (cuv at: 2) u]
		ifFalse: 
			[((vn equal: 0.0d tol: tol) or: [vn equal: 1.0d tol: tol]) 
				ifTrue: [uvn u: (cuv at: n - 1) u]].
	super condition_cuv: cuv pre_uvEnd: pre_uvend
]

{ #category : #accessing }
SphericalSurface >> condition_cuv: cuv pre_uvEnd: pre_uvend [ 
	| tol n uv1 uvn v1 vn new_pre_uvend |
	tol := 1.0d-6.
	n := cuv size.
	uv1 := cuv at: 1.
	uvn := cuv at: n.
	v1 := uv1 v.
	vn := uvn v.
	((v1 equal: 0.0d tol: tol) or: [v1 equal: 1.0d tol: tol]) 
		ifTrue: 
			[uv1 u: (cuv at: 2) u.
			"Discontinuity expected."
			new_pre_uvend := nil]
		ifFalse: 
			[((vn equal: 0.0d tol: tol) or: [vn equal: 1.0d tol: tol]) 
				ifTrue: [uvn u: (cuv at: n - 1) u].
			new_pre_uvend := pre_uvend].
	super condition_cuv: cuv pre_uvEnd: new_pre_uvend
]

{ #category : #'initialize-release' }
SphericalSurface >> initialize [

	"The semi circular arc starts from the south pole to the north pole in the xz plane."

	| aEllipticArc |
	super initialize.
	aEllipticArc := StCAD_Geo_EllipticArc new
		                _radius: 0.0 d;
		                theStart: 0.0 d;
		                theEnd: Double pi;
		                yourself. "VW_TRANSLATION:StCAD.Geo.EllipticArc:StCAD_Geo_EllipticArc"
	aEllipticArc aRefFrame rotatex: Double pi / 2.0 d.
	aEllipticArc aRefFrame rotatez: Double pi / 2.0 d negated.
	self _aCurve: aEllipticArc
]

{ #category : #ops }
SphericalSurface >> isMeridian: aEllipticArc [ 
	| tol |
	tol := 1.0d-6.
	^(self radius equal: aEllipticArc _radius tol: tol) and: 
			[((aRefFrame aAFf column: 3) dot: (aEllipticArc aRefFrame aAFf column: 3)) 
				equal: 0.0d
				tol: tol]
]

{ #category : #accessing }
SphericalSurface >> radius [
	^aCurve _radius
]

{ #category : #accessing }
SphericalSurface >> radius: aDouble [ 
	aCurve _radius: aDouble abs asDouble
]

{ #category : #ops }
SphericalSurface >> reverseSelf [
	aCurve aRefFrame rotatey: Double pi
]

{ #category : #accessing }
SphericalSurface >> smooth_cgluvTrimNurbs: anOrderedCollection [ 
	self halt
]

{ #category : #calc }
SphericalSurface >> uvCurveOfCircularArc: aCircularArc [

	^(self isMeridian: aCircularArc)
		ifTrue: [self uvCurveOfMeridianArc: aCircularArc]
		ifFalse: 
			[(self isLatitute: aCircularArc)
				ifTrue: [super uvCurveOfCircularArc: aCircularArc]
				ifFalse: [self uvCurveOfCurve: aCircularArc]]
]

{ #category : #accessing }
SphericalSurface >> uvCurveOfEllipticArc1: aEllipticArc [ 
	^(self isMeridian: aEllipticArc) 
		ifTrue: 
			[| cnPoint cnPointOn_uv |
			cnPoint := aEllipticArc crFpF_n: 4.
			cnPointOn_uv := cnPoint collect: [:aPointXYZ | self uvOfPoint: aPointXYZ].
			(Line new)
				isSpatial: false;
				cuv: cnPointOn_uv;
				yourself]
		ifFalse: [self uvCurveOfCurve: aEllipticArc]
]

{ #category : #accessing }
SphericalSurface >> uvCurveOfEllipticArc2: aEllipticArc [ 
	^(self isMeridian: aEllipticArc) 
		ifTrue: 
			[| glSurface cnPoint cnPointOn_uv |
			glSurface := self glSurface.
			cnPoint := aEllipticArc crFpF_n: 4.
			cnPointOn_uv := cnPoint collect: 
							[:aPointXYZ | 
							| uvGuess |
							uvGuess := self uvOfPoint: aPointXYZ.
							glSurface uvOfPoint: aPointXYZ uvGuess: uvGuess].
			(Line new)
				isSpatial: false;
				cuv: cnPointOn_uv;
				yourself]
		ifFalse: [self uvCurveOfCurve: aEllipticArc]
]

{ #category : #accessing }
SphericalSurface >> uvCurveOfEllipticArc: aEllipticArc [

	^(self isMeridian: aEllipticArc)
		ifTrue: [self uvCurveOfMeridianArc: aEllipticArc]
		ifFalse: [self uvCurveOfCurve: aEllipticArc]
]

{ #category : #accessing }
SphericalSurface >> uvCurveOfEllipticArc: aEllipticArc preCurve: preCurve [ 
	^(self isMeridian: aEllipticArc) 
		ifTrue: 
			[| cnPoint cnPointOn_uv pre_uvEnd uvStart uvEnd uvLine |
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
				privateCalcBoundingBox;
				yourself]
		ifFalse: [self uvCurveOfCurve: aEllipticArc preCurve: preCurve]
]

{ #category : #accessing }
SphericalSurface >> uvCurveOfMeridianArc: aEllipticArc [

	| cMeridianArc glSurface cnPoint cnPointOn_uv |
	cMeridianArc := self atPolesBreakMeridianArc: aEllipticArc.
	glSurface := self glSurface.
	^cMeridianArc collect: 
			[:aMeridianArc |
			cnPoint := aMeridianArc crFpF_n: 4.
			cnPointOn_uv := cnPoint collect: 
							[:aPointXYZ |
							| uvGuess |
							uvGuess := self uvOfPoint: aPointXYZ.
							glSurface uvOfPoint: aPointXYZ uvGuess: uvGuess].
			(Line new)
				isSpatial: false;
				cuv: cnPointOn_uv;
				yourself]
]

{ #category : #accessing }
SphericalSurface >> uvOfPoint: rFpF [ 
	| uv tol |
	uv := super uvOfPoint: rFpF.
	tol := 1.0d-9.
	(uv v equal: 2.0d tol: tol) ifTrue: [uv v: 0.0d].
	^uv
]

{ #category : #accessing }
SphericalSurface >> uv_gluv: gluv [ 
	"v = 0,1 is at singularity."

	| glu glv tol uv |
	glu := (gluv at: 1) \\ 1.0d.
	glv := gluv at: 2.
	tol := 1.0d-9.
	^(glv - glv rounded) abs < tol 
		ifTrue: 
			[uv := super uv_gluv: (glu yd: 0.5d).
			uv u yd: glv]
		ifFalse: [super uv_gluv: gluv]
]
