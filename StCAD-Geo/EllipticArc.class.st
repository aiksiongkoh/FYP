Class {
	#name : #EllipticArc,
	#superclass : #CircularArc,
	#instVars : [
		'yRadius'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #utility }
EllipticArc class >> condition_theStart: thetaStart theEnd: thetaEnd [

	| theStart theEnd n theOver |
	theStart := thetaStart.
	theEnd := thetaEnd.
	n := theStart // TwoPi.
	n ~= 0
		ifTrue: 
			[| nTwoPi |
			nTwoPi := n * TwoPi.
			theStart := theStart - nTwoPi.
			theEnd := theEnd - nTwoPi].
	theStart < theEnd ifFalse: [theEnd := theEnd + TwoPi].
	theOver := theEnd - theStart - TwoPi.
	theOver > 0.0d
		ifTrue: 
			[theOver < 1.0d-9
				ifTrue: [theEnd := theStart + TwoPi]
				ifFalse: [self checkThis]].
	^Array with: theStart with: theEnd
]

{ #category : #utility }
EllipticArc class >> rfpf_xRadius: xRadius yRadius: yRadius theta: the [

	^FullColumn
		with: xRadius * the cos
		with: yRadius * the sin
		with: 0.0d
]

{ #category : #utility }
EllipticArc class >> rfpointsf_xRadius: xRadius yRadius: yRadius theStart: theStart theEnd: theEnd n: n [

	| rfpointsf angle dangle |
	dangle := (theEnd - theStart) / (n - 1).
	angle := theStart.
	rfpointsf := MathArray new: n.
	1 to: n
		do: 
			[:i |
			| xi yi |
			xi := xRadius * angle cos.
			yi := yRadius * angle sin.
			rfpointsf at: i put: (FullColumn with: xi with: yi with: 0.0d).
			angle := angle + dangle].
	^rfpointsf
]

{ #category : #utility }
EllipticArc class >> theta_x: x y: y xRadius: xRadius yRadius: yRadius [

	^Double arcTan0to2piY: y / yRadius overX: x / xRadius
]

{ #category : #'VisualWorks metadata' }
EllipticArc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #comparing }
EllipticArc >> = aObject [

	^self == aObject or: [aObject equalToEllipticArc: self]
]

{ #category : #accessing }
EllipticArc >> _rFendF: rFpF [

	| rfpf x y |
	rfpf := aRefFrame rfpffromrFpF: rFpF.
	x := rfpf x.
	y := rfpf y.
	self theEnd: (Double arcTan0to2piY: y / yRadius overX: x / xRadius).
	self theEnd < MachineAccuracy OfDoubleTimesFour ifTrue: [self theEnd: TwoPi].
	"self assert: 
			[| tol r |
			r := (x * x + (y * y)) sqrt.
			tol := 1.0d-6 * (xRadius + yRadius) / 2.0d.
			self toTranscriptCrShow: 'EllipseArc (dr / tol) <1p>'
				ifOverOne: (r - (self radiusAt: theEnd)) abs / tol.
			true]"
]

{ #category : #accessing }
EllipticArc >> _rFstartF: rFpF [

	| rfpf x y |
	rfpf := aRefFrame rfpffromrFpF: rFpF.
	x := rfpf x.
	y := rfpf y.
	self theStart: (Double arcTan0to2piY: y / yRadius overX: x / xRadius).
	self theStart > (TwoPi - MachineAccuracy OfDoubleTimesFour)
		ifTrue: [self theStart: 0.0d].
	"self assert: 
			[| tol r |
			tol := 1.0d-6 * (xRadius + yRadius) / 2.0d.
			r := (x * x + (y * y)) sqrt.
			self toTranscriptCrShow: 'EllipseArc (dr / tol) <1p>'
				ifOverOne: (r - (self radiusAt: theStart)) abs / tol.
			true]"
]

{ #category : #accessing }
EllipticArc >> _radius [
	self assert: [xRadius = yRadius].
	^xRadius
]

{ #category : #accessing }
EllipticArc >> _radius: radius [ 
	xRadius := radius.
	yRadius := radius
]

{ #category : #accessing }
EllipticArc >> boundConicalSurface: aConicalSurface [ 
	aConicalSurface boundByEllipticArc: self
]

{ #category : #accessing }
EllipticArc >> boundCylindricalSurface: aCylindricalSurface [ 
	aCylindricalSurface boundByEllipticArc: self
]

{ #category : #accessing }
EllipticArc >> boundNurbsSurface: aNurbsSurface [ 
	aNurbsSurface boundByEllipticArc: self
]

{ #category : #accessing }
EllipticArc >> boundRectSurface: aRectSurface [ 
	aRectSurface boundByEllipticArc: self
]

{ #category : #accessing }
EllipticArc >> boundSphericalSurface: aSphericalSurface [ 
	aSphericalSurface boundByEllipticArc: self
]

{ #category : #accessing }
EllipticArc >> boundSurfaceOfRevolution: aSurfaceOfRevolution [ 
	aSurfaceOfRevolution boundByEllipticArc: self
]

{ #category : #accessing }
EllipticArc >> boundToroidalSurface: aToroidalSurface [ 
	aToroidalSurface boundByEllipticArc: self
]

{ #category : #accessing }
EllipticArc >> c3Point [
	| aPoint bPoint cPoint |
	aPoint := aRefFrame rFpFfromrfpf: (self rfpf_the: self theStart).
	bPoint := aRefFrame rFpFfromrfpf: (self rfpf_the: self theEnd).
	cPoint := aRefFrame rFpFfromrfpf: (self rfpf_the: (self theStart + self theEnd) / 2).
	^Array 
		with: aPoint
		with: bPoint
		with: cPoint
]

{ #category : #accessing }
EllipticArc >> cPoint [
	| n dthe stream |
	n := 64.
	dthe := Double twoPi / n.
	stream := (Array new: n + 1) writeStream.
	stream nextPut: (self rfpf_the: self theStart).
	(self theStart / dthe) ceiling to: (self theEnd / dthe) floor
		do: [:i | stream nextPut: (self rfpf_the: i * dthe)].
	stream nextPut: (self rfpf_the: self theEnd).
	^stream contents
]

{ #category : #accessing }
EllipticArc >> conditionSelf [
	| n theOver |
	n := theStart // TwoPi.
	n ~= 0 
		ifTrue: 
			[| nTwoPi |
			nTwoPi := n * TwoPi.
			theStart := theStart - nTwoPi.
			theEnd := theEnd - nTwoPi].
	theStart < theEnd ifFalse: [theEnd := theEnd + TwoPi].
	theOver := theEnd - theStart - TwoPi.
	theOver > 0.0d 
		ifTrue: 
			[theOver < 1.0d-9 
				ifTrue: [theEnd := theStart + TwoPi]
				ifFalse: [self checkThis]].
	"self clearBoundingBox"
]

{ #category : #accessing }
EllipticArc >> createNurbs [
	^NurbsCurve fromEllipticArc: self
]

{ #category : #accessing }
EllipticArc >> crfpf_n: n [

	^EllipticArc
		rfpointsf_xRadius: xRadius
		yRadius: yRadius
		theStart: theStart
		theEnd: theEnd
		n: n
]

{ #category : #accessing }
EllipticArc >> finalize_cuv [
	self cuv ifNotNil: [self assert: false]
]

{ #category : #accessing }
EllipticArc >> isOK [
	^xRadius >= 0.0d and: [yRadius >= 0.0d and: [self theEnd >= self theStart]]
]

{ #category : #ops }
EllipticArc >> magnifySelf: aDouble [

	super magnifySelf: aDouble.
	yRadius := yRadius * aDouble
]

{ #category : #printing }
EllipticArc >> printOn: aStream [

	aStream nextPut: $a.
	aStream print: self class.
	aStream nextPut: $(.
	aStream
		cr;
		print: self aRefFrame rFfF.
	aStream
		cr;
		print: self aRefFrame aAFf.
	aStream
		cr;
		print: self xRadius.
	aStream
		cr;
		print: self yRadius.
	aStream
		cr;
		print: self theStart.
	aStream
		cr;
		print: self theEnd.
	aStream
		cr;
		print: self rFstartF.
	aStream
		cr;
		print: self rFendF.
	aStream nextPut: $)
]

{ #category : #printing }
EllipticArc >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'EllipticArc';
		cr;
		printVerbose: aRefFrame;
		cr;
		nextPutAll: 'xRadius = ';
		printVerbose: xRadius;
		cr;
		nextPutAll: 'yRadius = ';
		printVerbose: xRadius;
		cr;
		nextPutAll: 'theStart = ';
		printVerbose: self theStart;
		cr;
		nextPutAll: 'theEnd = ';
		printVerbose: self theEnd
]

{ #category : #calc }
EllipticArc >> privateCalcBoundingBox [

	| block half_pi |
	isSpatial
		ifTrue: [ 
			aBoundingBox := StCAD_Misc_BoundingBox new. "VW_TRANSLATION:StCAD.Misc.BoundingBox:StCAD_Misc_BoundingBox"
			block := [ :the | aBoundingBox expandToBound: (self rfpf_the: the) ] ]
		ifFalse: [ 
			aBoundingBox := StCAD_Misc_BoundingRectangle new. "VW_TRANSLATION:StCAD.Misc.BoundingRectangle:StCAD_Misc_BoundingRectangle"
			block := [ :the | aBoundingBox expandToBound: (self uv_the: the) ] ].
	block value: self theStart.
	block value: self theEnd.
	"Include salient points."
	half_pi := Double pi / 2.0 d.
	(self theStart / half_pi) ceiling to: (self theEnd / half_pi) floor
	do: [ :i | block value: i * half_pi ]
]

{ #category : #calc }
EllipticArc >> privateCalcBoundingBox1 [

	| n dthe |
	aBoundingBox := isSpatial
		                ifTrue: [ 
			                StCAD_Misc_BoundingBox new "VW_TRANSLATION:StCAD.Misc.BoundingBox:StCAD_Misc_BoundingBox" ]
		                ifFalse: [ 
			                StCAD_Misc_BoundingRectangle new "VW_TRANSLATION:StCAD.Misc.BoundingRectangle:StCAD_Misc_BoundingRectangle" ].
	n := 16.
	dthe := self theEnd - self theStart / (n - 1).
	1 to: n do: [ :i | 
		| the |
		the := self theStart + (i - 1 * dthe).
		isSpatial
			ifTrue: [ aBoundingBox expandToBound: (self rfpf_the: the) ]
			ifFalse: [ aBoundingBox expandToBound: (self uv_the: the) ] ].
	1 to: 5 do: [ :i | "Include salient points."
		| the |
		the := i - 1 * (Double pi / 2).
		(the ge: self theStart le: self theEnd) ifTrue: [ 
			isSpatial
				ifTrue: [ aBoundingBox expandToBound: (self rfpf_the: the) ]
				ifFalse: [ aBoundingBox expandToBound: (self uv_the: the) ] ] ]
]

{ #category : #accessing }
EllipticArc >> rFendF [
	^self rFpFAt: self theEnd
]

{ #category : #accessing }
EllipticArc >> rFendminusF [
	| dthe the |
	dthe := 0.001d * (self theEnd - self theStart).
	the := self theEnd - dthe.
	^self rFpFAt: the
]

{ #category : #accessing }
EllipticArc >> rFpFAt: theta [ 
	^aRefFrame rFpFfromrfpf: (self rfpf_the: theta)
]

{ #category : #accessing }
EllipticArc >> rFstartF [
	^self rFpFAt: self theStart
]

{ #category : #accessing }
EllipticArc >> rFstartplusF [
	| dthe the |
	dthe := 0.001d * (self theEnd - self theStart).
	the := self theStart + dthe.
	^self rFpFAt: the
]

{ #category : #accessing }
EllipticArc >> reverse [
	| newEllipticArc |
	newEllipticArc := self copy.
	newEllipticArc aRefFrame rotatex: Double pi.
	newEllipticArc theStart: TwoPi - self theEnd.
	newEllipticArc theEnd: TwoPi - self theStart.
	newEllipticArc conditionSelf.
	self assert: [newEllipticArc isOK].
	^newEllipticArc
]

{ #category : #accessing }
EllipticArc >> reverseSelf [
	| newStart newEnd |
	aRefFrame rotatex: Double pi.
	newStart := Double twoPi - self theEnd.
	newEnd := Double twoPi - self theStart.
	self theStart: newStart.
	self theEnd: newEnd
]

{ #category : #accessing }
EllipticArc >> rfpfNurbs [
	^NurbsCurve fromEllipticArc: self
]

{ #category : #accessing }
EllipticArc >> rfpf_the: theta [

	^EllipticArc rfpf_xRadius: xRadius yRadius: yRadius theta: theta
]

{ #category : #accessing }
EllipticArc >> rfpf_u: u [

	^EllipticArc
		rfpf_xRadius: xRadius
		yRadius: yRadius
		theta: theStart + (u * (theEnd - theStart))
]

{ #category : #accessing }
EllipticArc >> rfpointsf [

	^EllipticArc
		rfpointsf_xRadius: xRadius
		yRadius: yRadius
		theStart: theStart
		theEnd: theEnd
		n: 17
]

{ #category : #accessing }
EllipticArc >> scaleF: uvwScale [
	"
	Stretching an oblique ellipse in XY direction.
	Refer to ecllipse4.sxw
	"

	| bryantAngles theXx sT cT sTsT cTcT s2T rx ry rxrx ryry cU cV cUcU cVcV num den phiUu sP cP cUsPsT cVcPcT cUsPcT cVcPsT cUcPsT cVsPcT cUcPcT cVsPsT cUcVrx cUcVry ru rv block tol |
	tol := 1.0d-9.
	(((uvwScale at: 1) equal: (uvwScale at: 2) tol: tol) or: 
			[bryantAngles := aRefFrame aAFf bryantAngles.
			theXx := bryantAngles at: 3.
			theXx \\ Double pi equal: 0.0d tol: tol])
		ifTrue: 
			[xRadius := xRadius * (uvwScale at: 1).
			yRadius := yRadius * (uvwScale at: 2)]
		ifFalse: 
			[sT := theXx sin.
			cT := theXx cos.
			sTsT := sT * sT.
			cTcT := cT * cT.
			s2T := 2.0d * sT * cT.
			rx := xRadius.
			ry := yRadius.
			rxrx := rx * rx.
			ryry := ry * ry.
			cU := uvwScale at: 1.
			cV := uvwScale at: 2.
			cUcU := cU * cU.
			cVcV := cV * cV.
			num := (rxrx - ryry) * cU * cV * s2T.
			den := (rxrx * cUcU - (ryry * cVcV)) * cTcT
						- ((rxrx * cVcV - (ryry * cUcU)) * sTsT).
			phiUu := (num isZero and: [den isZero])
						ifTrue: [0.0d]
						ifFalse: [0.5d * (Double arcTan0to2piY: num overX: den)].
			sP := phiUu sin.
			cP := phiUu cos.
			cUsPsT := cU * sP * sT.
			cVcPcT := cV * cP * cT.
			cUsPcT := cU * sP * cT.
			cVcPsT := cV * cP * sT.
			cUcPsT := cU * cP * sT.
			cVsPcT := cV * sP * cT.
			cUcPcT := cU * cP * cT.
			cVsPsT := cV * sP * sT.
			cUcVrx := cU * cV * rx.
			cUcVry := cU * cV * ry.
			ru := (((cUsPsT + cVcPcT) / cUcVrx) squared
						+ ((cUsPcT - cVcPsT) / cUcVry) squared) reciprocal
						sqrt.
			rv := (((cUcPsT - cVsPcT) / cUcVrx) squared
						+ ((cUcPcT + cVsPsT) / cUcVry) squared) reciprocal
						sqrt.
			block :=
					[:the |
					| x y |
					x := rx * the cos.
					y := ry * the sin.
					num := ru * (x negated * (cUsPcT - cVcPsT) + (y * (cUsPsT + cVcPcT))).
					den := rv * (x * (cUcPcT + cVsPsT) - (y * (cUcPsT - cVsPcT))).
					(num isZero and: [den isZero])
						ifTrue: [0.0d]
						ifFalse: [Double arcTan0to2piY: num overX: den]].
			self theStart: (block value: self theStart).
			self theEnd: (block value: self theEnd).
			self theStart + tol > self theEnd
				ifTrue: [self theEnd: self theEnd + Double twoPi].
			xRadius := ru.
			yRadius := rv.
			aRefFrame
				aAFf: (GEOEulerAnglesxyz
						with: (bryantAngles at: 1)
						with: (bryantAngles at: 2)
						with: phiUu) aA].
	self assert: [self isOK]
]

{ #category : #accessing }
EllipticArc >> tangentAt: theta [ 
	^FullColumn 
		with: xRadius * theta sin negated
		with: yRadius * theta cos
		with: 0.0d
]

{ #category : #accessing }
EllipticArc >> tangentFAt: theta [ 
	^aRefFrame aAFf timesFullColumn: (self tangentAt: theta)
]

{ #category : #accessing }
EllipticArc >> theEnd [
	^theEnd
]

{ #category : #accessing }
EllipticArc >> theEnd: anObject [
	theEnd := anObject
]

{ #category : #accessing }
EllipticArc >> theStart [
	^theStart
]

{ #category : #accessing }
EllipticArc >> theStart: anObject [
	theStart := anObject
]

{ #category : #accessing }
EllipticArc >> the_rFpF: rFpF [

	| rfpf |
	rfpf := aRefFrame rfpffromrFpF: rFpF.
	^self the_rfpf: rfpf
]

{ #category : #accessing }
EllipticArc >> the_rfpf: rfpf [

	| the |
	the := Double arcTan0to2piY: rfpf y / yRadius overX: rfpf x / xRadius.
	the <= (self theStart - Double pi) ifTrue: [the := the + Double twoPi].
	the >= (self theStart + Double pi) ifTrue: [the := the - Double twoPi].
	^the
]

{ #category : #accessing }
EllipticArc >> the_u: u [

	| dthe theta |
	dthe := u * (self theEnd - self theStart).
	theta := self theStart + dthe.
	^theta
]

{ #category : #accessing }
EllipticArc >> uOfPoint: rFpF [

	| rfpf the u |
	rfpf := aRefFrame rfpffromrFpF: rFpF.
	the := Double arcTan0to2piY: rfpf y / yRadius overX: rfpf x / xRadius.
	the - self theStart < 0.0d ifTrue: [the := the + Double twoPi].
	u := (the - self theStart) / (self theEnd - self theStart).
	"self assert: 
			[| tol radius |
			tol := 1.0d-6 * (xRadius + yRadius) / 2.0d.
			radius := self radiusAt: the.
			self toTranscriptCrShow: 'Ellipse (z / tol) <1p>'
				ifOverOne: rfpf z abs / tol.
			self toTranscriptCrShow: 'Ellipse (dr / tol) <1p>'
				ifOverOne: (rfpf length - radius) abs / tol.
			true]."
	^u
]

{ #category : #accessing }
EllipticArc >> uend [
	^isSpatial 
		ifTrue: [self halt: 'Check this']
		ifFalse: [(self rfpf_the: self theEnd) u]
]

{ #category : #accessing }
EllipticArc >> uvBound [
	self assert: [isSpatial not].
	^aBoundingBox
]

{ #category : #accessing }
EllipticArc >> uvCurveOnSurface: aSurface [

	| c_uvCurve |
	c_uvCurve := aSurface uvCurveOfEllipticArc: self.
	"	aSurface condition_cuv: aaCurve."
	^c_uvCurve
]

{ #category : #accessing }
EllipticArc >> uvCurveOnSurface: aSurface preCurve: preCurve [ 
	^aSurface uvCurveOfEllipticArc: self preCurve: preCurve
]

{ #category : #accessing }
EllipticArc >> uvEnd [
	self assert: [isSpatial not].
	^self uv_the: self theEnd
]

{ #category : #accessing }
EllipticArc >> uvStart [
	self assert: [isSpatial not].
	^self uv_the: self theStart
]

{ #category : #accessing }
EllipticArc >> uv_the: theta [

	^aRefFrame rFpFfromrfpf2D: (FullColumn with: xRadius * theta cos
				with: yRadius * theta sin)
]

{ #category : #accessing }
EllipticArc >> uvend [
	^isSpatial ifTrue: [self halt: 'Check this'] ifFalse: [self rfpf_the: self theEnd]
]

{ #category : #accessing }
EllipticArc >> yRadius [
	^yRadius
]

{ #category : #accessing }
EllipticArc >> yRadius: anObject [
	yRadius := anObject
]
