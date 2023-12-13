Class {
	#name : #Circle,
	#superclass : #Curve2D,
	#instVars : [
		'xRadius'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
Circle class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #comparing }
Circle >> = aObject [

	^self == aObject or: [aObject equalToCircle: self]
]

{ #category : #accessing }
Circle >> _radius [

	^xRadius
]

{ #category : #accessing }
Circle >> _radius: radius [

	xRadius := radius
]

{ #category : #accessing }
Circle >> createNurbs [

	^NurbsCurve fromCircle: self
]

{ #category : #accessing }
Circle >> crfpf_n: n [

	^EllipticArc
		rfpointsf_xRadius: xRadius
		yRadius: xRadius
		theStart: 0.0d
		theEnd: TwoPi
		n: n
]

{ #category : #ops }
Circle >> magnifySelf: aDouble [

	super magnifySelf: aDouble.
	xRadius := xRadius * aDouble
]

{ #category : #accessing }
Circle >> rFendF [

	^self rFpF_the: self theEnd
]

{ #category : #accessing }
Circle >> rFpF_the: theta [

	^aRefFrame rFpFfromrfpf: (self rfpf_the: theta)
]

{ #category : #accessing }
Circle >> rFstartF [

	^self rFpF_the: self theStart
]

{ #category : #accessing }
Circle >> radius: r [

	xRadius := r abs.
	self changed
]

{ #category : #accessing }
Circle >> reverseSelf [

	aRefFrame rotatex: Double pi.
	^self
]

{ #category : #accessing }
Circle >> rfpf_the: theta [

	^EllipticArc rfpf_xRadius: xRadius yRadius: xRadius theta: theta
]

{ #category : #accessing }
Circle >> rfpf_u: u [

	^EllipticArc
		rfpf_xRadius: xRadius
		yRadius: xRadius
		theta: u * TwoPi
]

{ #category : #accessing }
Circle >> rfpointsf [

	^EllipticArc
		rfpointsf_xRadius: xRadius
		yRadius: xRadius
		theStart: 0.0d
		theEnd: TwoPi
		n: 17
]

{ #category : #accessing }
Circle >> uOfPoint: rFpF [

	| rfpf the u |
	rfpf := aRefFrame rfpffromrFpF: rFpF.
	the := EllipticArc
				theta_x: rfpf x
				y: rfpf y
				xRadius: xRadius
				yRadius: xRadius.
	u := the / TwoPi.
	^u
]

{ #category : #accessing }
Circle >> uv_the: theta [

	^aRefFrame rFpFfromrfpf2D: (FullColumn with: xRadius * theta cos
				with: xRadius * theta sin)
]

{ #category : #accessing }
Circle >> xRadius [
	^xRadius
]

{ #category : #accessing }
Circle >> xRadius: radius [
	xRadius := radius
]
