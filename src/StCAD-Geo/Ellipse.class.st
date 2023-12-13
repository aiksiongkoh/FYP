Class {
	#name : #Ellipse,
	#superclass : #Circle,
	#instVars : [
		'yRadius'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
Ellipse class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #comparing }
Ellipse >> = aObject [

	^self == aObject or: [aObject equalToEllipse: self]
]

{ #category : #accessing }
Ellipse >> cEdgeUse [

	| cEdgeUse aEdgeUse rfstartf aVertexUse |
	self halt: 'Edge should only be created by Model.'.
	cEdgeUse := OrderedCollection new.
	aEdgeUse := StCAD_NMT_Edge new newUse. "VW_TRANSLATION:StCAD.NMT.Edge:StCAD_NMT_Edge"
	rfstartf := FullColumn with: xRadius with: 0.0 d with: 0.0 d.
	aVertexUse := (StCAD_NMT_Vertex new: rfstartf) newUse. "VW_TRANSLATION:StCAD.NMT.Vertex:StCAD_NMT_Vertex"
	aVertexUse t: 0.0 d.
	aEdgeUse aVertexUse: aVertexUse.
	aEdgeUse uvOFt: self.
	aEdgeUse isSameSense: true.
	cEdgeUse add: aEdgeUse.
	^ cEdgeUse
]

{ #category : #accessing }
Ellipse >> createNurbs [
	^NurbsCurve fromEllipse: self
]

{ #category : #accessing }
Ellipse >> crfpf_n: n [

	^EllipticArc
		rfpointsf_xRadius: xRadius
		yRadius: yRadius
		theStart: 0.0d
		theEnd: TwoPi
		n: n
]

{ #category : #ops }
Ellipse >> magnifySelf: aDouble [

	super magnifySelf: aDouble.
	yRadius := yRadius * aDouble
]

{ #category : #calc }
Ellipse >> privateCalcBoundingBox [

	aBoundingBox := StCAD_Misc_BoundingBox
		                origin:
		                (FullColumn
			                 with: xRadius negated
			                 with: yRadius negated
			                 with: 0.0 d)
		                corner:
		                (FullColumn with: xRadius with: yRadius with: 0.0 d) "VW_TRANSLATION:StCAD.Misc.BoundingBox:StCAD_Misc_BoundingBox"
]

{ #category : #accessing }
Ellipse >> radiusAt: theta [ 
	^(self xyAt: theta) length
]

{ #category : #accessing }
Ellipse >> rfpf_the: theta [

	^EllipticArc rfpf_xRadius: xRadius yRadius: yRadius theta: theta
]

{ #category : #accessing }
Ellipse >> rfpf_u: u [

	^EllipticArc
		rfpf_xRadius: xRadius
		yRadius: yRadius
		theta: u * TwoPi
]

{ #category : #accessing }
Ellipse >> rfpointsf [

	^EllipticArc
		rfpointsf_xRadius: xRadius
		yRadius: yRadius
		theStart: 0.0d
		theEnd: TwoPi
		n: 17
]

{ #category : #accessing }
Ellipse >> uOfPoint: rFpF [ 
	| rfpf the u |
	rfpf := aRefFrame rfpffromrFpF: rFpF.
	the := Double arcTan0to2piY: rfpf y / yRadius overX: rfpf x / xRadius.
	u := the / Double twoPi \\ 1.0d.
	"self assert: 
			[| tol radius |
			tol := 1.0d-6 * (xRadius + yRadius) / 2.0d.
			radius := self radiusAt: the.
			self toTranscriptCrShow: 'Ellipse (z / tol) <1p>' ifOverOne: rfpf z abs / tol.
			self toTranscriptCrShow: 'Ellipse (dr / tol) <1p>'
				ifOverOne: (rfpf length - radius) abs / tol.
			true]."
	^u
]

{ #category : #accessing }
Ellipse >> uv_the: theta [

	^aRefFrame rFpFfromrfpf2D: (FullColumn with: xRadius * theta cos
				with: yRadius * theta sin)
]

{ #category : #accessing }
Ellipse >> value: u [ 
	^FullColumn 
		with: xRadius * u cos
		with: yRadius * u sin
		with: 0.0d
]

{ #category : #accessing }
Ellipse >> xyAt: theta [ 
	^FullColumn with: xRadius * theta cos with: yRadius * theta sin
]

{ #category : #accessing }
Ellipse >> yRadius [
	^yRadius
]

{ #category : #accessing }
Ellipse >> yRadius: anObject [
	yRadius := anObject
]
