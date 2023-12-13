Class {
	#name : #Line,
	#superclass : #Curve,
	#instVars : [
		'rfstartf',
		'rfendf',
		'dsdu'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #utilities }
Line class >> dataIntersectionPoint: p0 aDir: v bPoint: q0 bDir: w tolerance: tol [ 
	| array rfpf rfqf |
	array := self 
				dataMinDistPoint: p0
				aDir: v
				bPoint: q0
				bDir: w.
	array ifNotNil: 
			[rfpf := array at: 1.
			rfqf := array at: 2.
			array
				at: 1 put: (rfqf - rfpf) length <= tol;
				at: 2 put: (rfqf + rfpf times: 0.5d)].
	^array
]

{ #category : #utilities }
Line class >> dataMinDistPoint: p0 aDir: v bPoint: q0 bDir: w [ 
	"
	Find the minimum distance between two lines. 
	Line is P(t) = P0 + tv. 
	Line is Q(u) = Q0 + uw. 
	Minimize P(t) - Q(u). 
	Therefore 
	t = w*(P0 - Q0) v*w - v*(P0 - Q0) w*w / (v*v w*w - v*w v*w). 
	u = w*(P0 - Q0) v*v - v*(P0 - Q0) w*v / (v*v w*w - v*w v*w). 
	"

	| p0mq0 vdotv wdotw vdotw vdotp0mq0 wdotp0mq0 denominator t u px qx |
	p0mq0 := p0 - q0.
	vdotv := v sumOfSquares.
	wdotw := w sumOfSquares.
	vdotw := v dot: w.
	vdotp0mq0 := v dot: p0mq0.
	wdotp0mq0 := w dot: p0mq0.
	denominator := vdotv * wdotw - (vdotw * vdotw).
	^denominator > 0.0d 
		ifTrue: 
			[t := (wdotp0mq0 * vdotw - (vdotp0mq0 * wdotw)) / denominator.
			u := (wdotp0mq0 * vdotv - (vdotp0mq0 * vdotw)) / denominator.
			px := p0 plus: v times: t.
			qx := q0 plus: w times: u.
			Array 
				with: px
				with: qx
				with: t
				with: u]
		ifFalse: 
			["Lines are parallel."

			self assert: [false]]
]

{ #category : #'VisualWorks metadata' }
Line class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #comparing }
Line >> = aObject [

	^self == aObject or: 
			[self class == aObject class
				and: [rfstartf = aObject rfstartf and: [rfendf = aObject rfendf]]]
]

{ #category : #accessing }
Line >> atU: u [ 
	^rfstartf plusFullColumn: dsdu times: u
]

{ #category : #accessing }
Line >> boundConicalSurface: aConicalSurface [ 
	aConicalSurface boundByLine: self
]

{ #category : #accessing }
Line >> boundCylindricalSurface: aCylindricalSurface [ 
	aCylindricalSurface boundByLine: self
]

{ #category : #accessing }
Line >> boundNurbsSurface: aNurbsSurface [ 
	aNurbsSurface boundByLine: self
]

{ #category : #accessing }
Line >> boundRectSurface: aRectSurface [ 
	aRectSurface boundByLine: self
]

{ #category : #accessing }
Line >> c2Point [
	| aPoint bPoint |
	aPoint := aRefFrame rFpFfromrfpf: rfstartf.
	bPoint := aRefFrame rFpFfromrfpf: rfendf.
	^FullColumn with: aPoint with: bPoint
]

{ #category : #accessing }
Line >> cPoint [
	^Array with: rfstartf with: rfendf
]

{ #category : #calc }
Line >> calc [
	dsdu := rfendf minusFullColumn: rfstartf
]

{ #category : #accessing }
Line >> crFpF_n: n [

	| delta answer |
	delta := (rfendf - rfstartf) / (n - 1).
	answer := FullColumn new: n.
	1 to: n
		do: [:i | answer at: i put: rfstartf + (delta times: (i - 1) asDouble)].
	^answer
]

{ #category : #accessing }
Line >> createNurbs [
	^NurbsCurve fromLine: self
]

{ #category : #accessing }
Line >> dsdt: dsdt [ 
	dsdu := dsdt
]

{ #category : #comparing }
Line >> equal: aObject ltol: tol [

	^self == aObject or: 
			[self class == aObject class and: 
					[(rfstartf - aObject rfstartf) length < tol
						and: [(rfendf - aObject rfendf) length < tol]]]
]

{ #category : #comparing }
Line >> equalToCircularArc: aCircularArc ltol: tol [

	^false
]

{ #category : #accessing }
Line >> finalize_cuv [
	self cuv ifNotNil: 
			[:cuv | 
			| uvStart uvEnd |
			uvStart := cuv first.
			uvEnd := cuv last.
			self
				isSpatial: false;
				uvStart: uvStart;
				uvEnd: uvEnd;
				dsdt: 1 / (uvEnd - uvStart) length;
				privateCalcBoundingBox]
]

{ #category : #ops }
Line >> magnifySelf: aDouble [ 
	super magnifySelf: aDouble.
	rfstartf magnifySelf: aDouble.
	rfendf magnifySelf: aDouble.
	dsdu := dsdu ifNotNil: [dsdu * aDouble]
]

{ #category : #calc }
Line >> minusU: offset [

	self cuv ifNotNil: [:cuv | cuv do: [:uv | uv u: uv u - offset]].
	rfstartf
		ifNotNil: 
			[rfstartf u: rfstartf u - offset.
			rfendf u: rfendf u - offset]
]

{ #category : #calc }
Line >> minusV: offset [

	self cuv ifNotNil: [:cuv | cuv do: [:uv | uv v: uv v - offset]].
	rfstartf
		ifNotNil: 
			[rfstartf v: rfstartf v - offset.
			rfendf v: rfendf v - offset]
]

{ #category : #printing }
Line >> printOn: aStream [ 
	aStream nextPut: $a.
	aStream print: self class.
	aStream nextPut: $(.
	aStream
		cr;
		print: rfstartf.
	aStream
		cr;
		print: rfendf.
	aStream nextPut: $)
]

{ #category : #printing }
Line >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'Line';
		cr;
		print: rfstartf;
		cr;
		print: rfendf
]

{ #category : #calc }
Line >> privateCalcBoundingBox [

	aBoundingBox := isSpatial
		                ifTrue: [ 
			                StCAD_Misc_BoundingBox new "VW_TRANSLATION:StCAD.Misc.BoundingBox:StCAD_Misc_BoundingBox" ]
		                ifFalse: [ 
			                StCAD_Misc_BoundingRectangle new "VW_TRANSLATION:StCAD.Misc.BoundingRectangle:StCAD_Misc_BoundingRectangle" ].
	aBoundingBox expandToBound: rfstartf.
	aBoundingBox expandToBound: rfendf
]

{ #category : #accessing }
Line >> rFendF [
	^rfendf
]

{ #category : #accessing }
Line >> rFstartF [
	^rfstartf
]

{ #category : #accessing }
Line >> reverse [
	| answer |
	answer := self copy.
	answer rfstartf: rfendf.
	answer rfendf: rfstartf.
	^answer
]

{ #category : #accessing }
Line >> reverseSelf [
	| temp |
	temp := rfstartf.
	rfstartf := rfendf.
	rfendf := temp.
	dsdu ifNotNil: [dsdu := dsdu negated]
]

{ #category : #accessing }
Line >> rfendf [
	^rfendf
]

{ #category : #accessing }
Line >> rfendf: anObject [
	rfendf := anObject
]

{ #category : #accessing }
Line >> rfpfNurbs [
	^NurbsCurve fromLine: self
]

{ #category : #accessing }
Line >> rfstartf [
	^rfstartf
]

{ #category : #accessing }
Line >> rfstartf: anObject [
	rfstartf := anObject
]

{ #category : #accessing }
Line >> uOfPoint: rFpF [ 
	| avec bvec |
	avec := rFpF - rfstartf.
	bvec := rfendf - rfstartf.
	self assert: 
			[| tol |
			tol := 1.0d-3.
			self toTranscriptCrShow: 'Line ((avec cross: bvec) length / tol) <1p>'
				ifOverOne: (avec cross: bvec) length / tol.
			true].
	^(avec dot: bvec) / bvec sumOfSquares
]

{ #category : #accessing }
Line >> uend [
	^isSpatial ifTrue: [self halt: 'Check this'] ifFalse: [rfendf u]
]

{ #category : #accessing }
Line >> uvBound [
	self assert: [isSpatial not].
	^aBoundingBox
]

{ #category : #accessing }
Line >> uvCurveOnSurface: aSurface [ 
	| aaCurve |
	aaCurve := aSurface uvCurveOfLine: self.
"	aSurface condition_cuv: aaCurve."
	^aaCurve
]

{ #category : #accessing }
Line >> uvCurveOnSurface: aSurface preCurve: preCurve [ 
	^aSurface uvCurveOfLine: self preCurve: preCurve
]

{ #category : #accessing }
Line >> uvEnd [

	self assert: [isSpatial not].
	^rfendf copy
]

{ #category : #accessing }
Line >> uvEnd: uvend [ 
	rfendf := uvend
]

{ #category : #accessing }
Line >> uvStart [

	self assert: [isSpatial not].
	^rfstartf copy
]

{ #category : #accessing }
Line >> uvStart: uvstart [ 
	rfstartf := uvstart
]

{ #category : #accessing }
Line >> uvend [
	^isSpatial ifTrue: [self halt: 'Check this'] ifFalse: [rfendf copy]
]

{ #category : #accessing }
Line >> value: u [ 
	^rfstartf plusFullColumn: dsdu times: u
]

{ #category : #accessing }
Line >> vend [
	^isSpatial ifTrue: [self halt: 'Check this'] ifFalse: [rfendf v]
]
