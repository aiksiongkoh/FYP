Class {
	#name : #CircularArc,
	#superclass : #Circle,
	#instVars : [
		'theStart',
		'theEnd'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
CircularArc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #comparing }
CircularArc >> = aObject [

	^self == aObject or: [aObject equalToCircularArc: self]
]

{ #category : #accessing }
CircularArc >> _rFendF: rFpF [

	| rfpf x y |
	rfpf := aRefFrame rfpffromrFpF: rFpF.
	x := rfpf x.
	y := rfpf y.
	self theEnd: (EllipticArc
				theta_x: x
				y: y
				xRadius: xRadius
				yRadius: xRadius).
	self theEnd < MachineAccuracy OfDoubleTimesFour
		ifTrue: [self theEnd: TwoPi]
	"self assert: 
			[| tol r |
			r := (x * x + (y * y)) sqrt.
			tol := 1.0d-6 * (xRadius + yRadius) / 2.0d.
			self toTranscriptCrShow: 'EllipseArc (dr / tol) <1p>'
				ifOverOne: (r - (self radiusAt: theEnd)) abs / tol.
			true]"
]

{ #category : #accessing }
CircularArc >> _rFstartF: rFpF [

	| rfpf x y |
	rfpf := aRefFrame rfpffromrFpF: rFpF.
	x := rfpf x.
	y := rfpf y.
	self theStart: (EllipticArc
				theta_x: x
				y: y
				xRadius: xRadius
				yRadius: xRadius).
	self theStart > (TwoPi - MachineAccuracy OfDoubleTimesFour)
		ifTrue: [self theStart: 0.0d]
	"self assert: 
			[| tol r |
			tol := 1.0d-6 * (xRadius + yRadius) / 2.0d.
			r := (x * x + (y * y)) sqrt.
			self toTranscriptCrShow: 'EllipseArc (dr / tol) <1p>'
				ifOverOne: (r - (self radiusAt: theStart)) abs / tol.
			true]"
]

{ #category : #converting }
CircularArc >> asEllipticalArc [

	| aEllipticArc |
	aEllipticArc := StCAD_Geo_EllipticArc new
		                _radius: xRadius;
		                theStart: theStart;
		                theEnd: theEnd;
		                yourself. "VW_TRANSLATION:StCAD.Geo.EllipticArc:StCAD_Geo_EllipticArc"
	aEllipticArc aRefFrame copyrFfFandAFfFrom: aRefFrame.
	aEllipticArc conditionSelf.
	self assert: [ aEllipticArc isOK ].
	^ aEllipticArc
]

{ #category : #accessing }
CircularArc >> boundConicalSurface: aConicalSurface [

	aConicalSurface boundByCircularArc: self
]

{ #category : #accessing }
CircularArc >> boundCylindricalSurface: aCylindricalSurface [

	aCylindricalSurface boundByCircularArc: self
]

{ #category : #accessing }
CircularArc >> boundNurbsSurface: aNurbsSurface [

	aNurbsSurface boundByCircularArc: self
]

{ #category : #accessing }
CircularArc >> boundRectSurface: aRectSurface [

	aRectSurface boundByCircularArc: self
]

{ #category : #accessing }
CircularArc >> boundSphericalSurface: aSphericalSurface [

	aSphericalSurface boundByCircularArc: self
]

{ #category : #accessing }
CircularArc >> boundToroidalSurface: aToroidalSurface [

	aToroidalSurface boundByCircularArc: self
]

{ #category : #accessing }
CircularArc >> c3Point [

	^self crFpF_n: 3
]

{ #category : #accessing }
CircularArc >> cPoint [

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
CircularArc >> conditionSelf [

	| startend |
	startend := EllipticArc condition_theStart: theStart theEnd: theEnd.
	theStart := startend at: 1.
	theEnd := startend at: 2
]

{ #category : #accessing }
CircularArc >> crfpf_n: n [

	^EllipticArc
		rfpointsf_xRadius: xRadius
		yRadius: xRadius
		theStart: theStart
		theEnd: theEnd
		n: n
]

{ #category : #comparing }
CircularArc >> equal: aObject ltol: tol [

	^self == aObject or: [aObject equalToCircularArc: self ltol: tol]
]

{ #category : #comparing }
CircularArc >> equalToCircularArc: aCircularArc [

	^xRadius = aCircularArc xRadius and: 
			[theStart = aCircularArc theStart
				and: [theEnd = aCircularArc theEnd and: [aRefFrame = aCircularArc aRefFrame]]]
]

{ #category : #comparing }
CircularArc >> equalToCircularArc: aCircularArc ltol: tol [

	| n c1rFpF c2rFpF |
	^xRadius = aCircularArc xRadius and: 
			[n := 4.
			c1rFpF := self crFpF_n: n.
			c2rFpF := aCircularArc crFpF_n: n.
			(1 to: n)
				allSatisfy: [:i | ((c1rFpF at: i) - (c2rFpF at: i)) length < tol]]
]

{ #category : #accessing }
CircularArc >> isOK [

	^xRadius >= 0.0d and: [self theEnd >= self theStart]
]

{ #category : #printing }
CircularArc >> printOn: aStream [

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

{ #category : #accessing }
CircularArc >> reverse [

	| newArc |
	newArc := self copy.
	newArc aRefFrame rotatex: Double pi.
	newArc theStart: TwoPi - self theEnd.
	newArc theEnd: TwoPi - self theStart.
	newArc conditionSelf.
	self assert: [newArc isOK].
	^newArc
]

{ #category : #accessing }
CircularArc >> scaleF: aStCADMathFullColumn [ 
	self halt
]

{ #category : #accessing }
CircularArc >> theEnd [

	^theEnd
]

{ #category : #accessing }
CircularArc >> theEnd: anObject [

	theEnd := anObject
]

{ #category : #accessing }
CircularArc >> theStart [

	^theStart
]

{ #category : #accessing }
CircularArc >> theStart: anObject [

	theStart := anObject
]

{ #category : #accessing }
CircularArc >> the_rFpF: rFpF [

	| rfpf |
	rfpf := aRefFrame rfpffromrFpF: rFpF.
	^self the_rfpf: rfpf
]

{ #category : #accessing }
CircularArc >> the_rfpf: rfpf [

	| the |
	the := Double arcTan0to2piY: rfpf y overX: rfpf x.
	the <= (self theStart - Double pi) ifTrue: [the := the + Double twoPi].
	the >= (self theStart + Double pi) ifTrue: [the := the - Double twoPi].
	^the
]

{ #category : #accessing }
CircularArc >> uvCurveOnSurface: aSurface [

	| c_uvCurve |
	c_uvCurve := aSurface uvCurveOfCircularArc: self.
	^c_uvCurve
]
