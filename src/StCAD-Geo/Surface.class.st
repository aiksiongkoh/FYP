Class {
	#name : #Surface,
	#superclass : #Geometry,
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
Surface class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #converting }
Surface >> asJunOpenGL3dObject [

	^self glNurbs asJunOpenGL3dObject
]

{ #category : #accessing }
Surface >> at_uv: uv [ 
	^self atu: uv first v: uv last
]

{ #category : #bounds }
Surface >> boundByCircularArc: aCircularArc [

	self boundByCurve: aCircularArc
]

{ #category : #bounds }
Surface >> boundByCurve: aCurve [ 
	"
	rFpF = rFpF
	rFSF + aAFS*rSpS = rFCF + aAFC*rCpC
	rSpS = aAFST(rFCF - rFSF + aAFC*rCpC)
	"

	| aCurveRefFrame aAFST aAFC rFCFrFSF |
	aCurveRefFrame := aCurve aRefFrame.
	aAFST := aRefFrame aAFf transpose.
	aAFC := aCurveRefFrame aAFf.
	rFCFrFSF := aCurveRefFrame rFfF minusFullColumn: aRefFrame rFfF.
	aCurve cPoint do: 
			[:rCpC | 
			| rSpS |
			rSpS := aAFST 
						timesFullColumn: (rFCFrFSF plusFullColumn: (aAFC timesFullColumn: rCpC)).
			aBoundingBox expandToBound: rSpS]
]

{ #category : #bounds }
Surface >> boundByEllipticArc: aEllipticArc [ 
	self boundByCurve: aEllipticArc
]

{ #category : #bounds }
Surface >> boundByLine: aLine [ 
	self boundByCurve: aLine
]

{ #category : #bounds }
Surface >> boundByNurbsCurve: aNurbsCurve [ 
	self boundByCurve: aNurbsCurve
]

{ #category : #ops }
Surface >> condition_cLoopUse: cLoopUse [

	| aBoundingRectangle |
	aBoundingRectangle := BoundingRectangle new.
	cLoopUse do: 
			[:aLoopUse |
			aLoopUse ccuv
				do: [:cuv | cuv do: [:uv | aBoundingRectangle expandToBound: uv]]].
	cLoopUse
		do: [:aLoopUse | aLoopUse conditionSelfWithin: aBoundingRectangle].
	self condition_cLoopUse: cLoopUse within: aBoundingRectangle
]

{ #category : #accessing }
Surface >> condition_cglTrimNurbs1: cglTrimNurbs [ 
	"Do nothing."

	^cglTrimNurbs
]

{ #category : #accessing }
Surface >> condition_cglTrimNurbs: cglTrimNurbs [ 
	"Do nothing."

	^cglTrimNurbs
]

{ #category : #ops }
Surface >> condition_cgluvTrimNurbs: acgluvTrimNurbs [
	"
	acgluvTrimNurbs are uv curves that represent a closed loop on surface.
	uv curve may not be closed if surface is cyclical or have singularities.
	"

	| cgluvTrimNurbs |
	cgluvTrimNurbs := acgluvTrimNurbs.
	cgluvTrimNurbs := self smooth_cgluvTrimNurbs: cgluvTrimNurbs.
	cgluvTrimNurbs := self normalize_cgluvTrimNurbs: cgluvTrimNurbs.
	cgluvTrimNurbs := self finalize_cgluvTrimNurbs: cgluvTrimNurbs.
	cgluvTrimNurbs := self cleanzero_cgluvTrimNurbs: cgluvTrimNurbs.
	cgluvTrimNurbs := self patch_cgluvTrimNurbs: cgluvTrimNurbs.
	^cgluvTrimNurbs
]

{ #category : #calc }
Surface >> condition_cuv: cuv pre_uvEnd: pre_uvend [ 
	"Do nothing."
]

{ #category : #ops }
Surface >> condtionFaceUse: aFaceUse [

	aFaceUse conditionForSurface
]

{ #category : #accessing }
Surface >> create_glSurface [
	^self create_glNurbs
]

{ #category : #accessing }
Surface >> finalize_uvCurve: aaCurve [ 
	self condition_cuv: aaCurve.
	aaCurve finalize_cuv
]

{ #category : #accessing }
Surface >> glSurface [
	^(self triggerEvent: #glSurface) ifNil: 
			[| answer |
			answer := self create_glSurface.
			self glSurface: answer.
			answer]
]

{ #category : #accessing }
Surface >> glSurface: glSurface [ 
	self removeActionsForEvent: #glSurface.
	glSurface ifNotNil: 
			[self 
				when: #glSurface
				ask: glSurface
				perform: #yourself]
]

{ #category : #testing }
Surface >> isCyclic [

	^false
]

{ #category : #ops }
Surface >> magnifySelf: aDouble [ 
	super magnifySelf: aDouble.
	self glSurface: nil.
	self aNurbs: nil
]

{ #category : #accessing }
Surface >> rFpF_u: u v: v [ 
	^aRefFrame rFpFfromrfpf: (self rfpf_u: u v: v)
]

{ #category : #accessing }
Surface >> rFpF_uv: uv [ 
	^self rFpF_u: uv first v: uv last
]

{ #category : #accessing }
Surface >> rfpf_u: u v: v [ 
	self subclassResponsibility
]

{ #category : #accessing }
Surface >> rfpf_uv: uv [ 
	^self rfpf_u: uv first v: uv last
]

{ #category : #accessing }
Surface >> uvBound [
	^BoundingRectangle origin: (FullColumn zero: 2)
		corner: (FullColumn with: 1.0d with: 1.0d)
]

{ #category : #accessing }
Surface >> uvBoundTol [
	| tol umin vmin umax vmax |
	tol := 1.0d-6.
	umin := 0.0d.
	vmin := 0.0d.
	umax := 1.0d.
	vmax := 1.0d.
	^BoundingRectangle 
		origin: (FullColumn with: umin - tol with: vmin - tol)
		corner: (FullColumn with: umax + tol with: vmax + tol)
]

{ #category : #calc }
Surface >> uvCurveOfCircularArc: aCircularArc [

	^self uvCurveOfCurve: aCircularArc
]

{ #category : #calc }
Surface >> uvCurveOfCurve: aCurve [

	| glSurface cnPoint cnPointOn_uv uvCurve |
	glSurface := self glSurface.
	cnPoint := aCurve crFpF_n: 32.
	cnPointOn_uv := cnPoint collect: 
					[:aPointXYZ |
					| uvGuess |
					uvGuess := self uvOfPoint: aPointXYZ.
					glSurface uvOfPoint: aPointXYZ uvGuess: uvGuess].
	uvCurve := (NurbsCurve new)
				isSpatial: false;
				cuv: cnPointOn_uv;
				yourself.
	^Array with: uvCurve
]

{ #category : #calc }
Surface >> uvCurveOfCurve: aCurve preCurve: preCurve [ 
	| cnPoint cnPointOn_uv pre_uvEnd |
	cnPoint := aCurve crFpF_n: 32.
	cnPointOn_uv := cnPoint collect: [:aPointXYZ | self uvOfPoint: aPointXYZ].
	pre_uvEnd := preCurve ifNotNil: [preCurve uvEnd].
	self condition_cuv: cnPointOn_uv pre_uvEnd: pre_uvEnd.
	^(NurbsCurve fromcDataPoint: cnPointOn_uv uDegree: 3)
		isSpatial: false;
		privateCalcBoundingBox;
		yourself
]

{ #category : #calc }
Surface >> uvCurveOfEllipticArc: aEllipticArc [ 
	^self uvCurveOfCurve: aEllipticArc
]

{ #category : #calc }
Surface >> uvCurveOfEllipticArc: aEllipticArc preCurve: preCurve [ 
	^self uvCurveOfCurve: aEllipticArc preCurve: preCurve
]

{ #category : #calc }
Surface >> uvCurveOfLine: aLine [ 
	^self uvCurveOfCurve: aLine
]

{ #category : #calc }
Surface >> uvCurveOfLine: aLine preCurve: preCurve [ 
	^self uvCurveOfCurve: aLine preCurve: preCurve
]

{ #category : #calc }
Surface >> uvCurveOfNurbsCurve: aNurbsCurve [ 
	^self uvCurveOfCurve: aNurbsCurve
]

{ #category : #calc }
Surface >> uvCurveOfNurbsCurve: aNurbsCurve preCurve: preCurve [ 
	^self uvCurveOfCurve: aNurbsCurve preCurve: preCurve
]

{ #category : #calc }
Surface >> uvOfPoint: rFpF [ 
	self subclassResponsibility
]

{ #category : #calc }
Surface >> uvOfPoint: rFpF uvGuess: uvGuess [ 
	^self uvOfPoint: rFpF
]
