"
aBoundingBox stores extent of RectSurface. z should be zero. u and v values are from 0 to 1.
"
Class {
	#name : #RectSurface,
	#superclass : #Surface,
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
RectSurface class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
RectSurface >> aSup: aSpatialItem [ 
	aSup := aSpatialItem
]

{ #category : #accessing }
RectSurface >> cEndSingularityOf: aaCurve [ 
	^MathArray with: false with: false
]

{ #category : #accessing }
RectSurface >> conditionSelf [
	| tol minCorner maxCorner |
	tol := 1.0d-3 * aBoundingBox diagonal_length.
	minCorner := aBoundingBox minCorner.
	minCorner x: minCorner x - tol.
	minCorner y: minCorner y - tol.
	maxCorner := aBoundingBox maxCorner.
	maxCorner x: maxCorner x + tol.
	maxCorner y: maxCorner y + tol
]

{ #category : #ops }
RectSurface >> condition_cLoopUse: cLoopUse [

	^self
]

{ #category : #ops }
RectSurface >> condition_cgluvTrimNurbs: cgluvTrimNurbs [

	^cgluvTrimNurbs
]

{ #category : #accessing }
RectSurface >> condition_cuv: aCurve [ 
	"Do nothing."
]

{ #category : #accessing }
RectSurface >> condition_cuv: aaCurve within: aaBoundingRectangle [ 
	^self uvBound
]

{ #category : #ops }
RectSurface >> condtionFaceUse: aFaceUse [

	^self
]

{ #category : #accessing }
RectSurface >> createNurbs [
	^NurbsSurface fromRectSurface: self
]

{ #category : #accessing }
RectSurface >> maxxmaxymaxz [
	^aBoundingBox maxxmaxymaxz
]

{ #category : #accessing }
RectSurface >> maxxmaxyminz [
	^aBoundingBox maxxmaxyminz
]

{ #category : #accessing }
RectSurface >> maxxminymaxz [
	^aBoundingBox maxxminymaxz
]

{ #category : #accessing }
RectSurface >> maxxminyminz [
	^aBoundingBox maxxminyminz
]

{ #category : #accessing }
RectSurface >> minxmaxymaxz [
	^aBoundingBox minxmaxymaxz
]

{ #category : #accessing }
RectSurface >> minxmaxyminz [
	^aBoundingBox minxmaxyminz
]

{ #category : #accessing }
RectSurface >> minxminymaxz [
	^aBoundingBox minxminymaxz
]

{ #category : #accessing }
RectSurface >> minxminyminz [
	^aBoundingBox minxminyminz
]

{ #category : #printing }
RectSurface >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'RectSurface';
		cr;
		printVerbose: aRefFrame;
		cr;
		printVerbose: aBoundingBox
]

{ #category : #accessing }
RectSurface >> rSkFacePointSkAt: uv [ 
	^aRefFrame rFpFfromrfpf: (self value: uv)
]

{ #category : #accessing }
RectSurface >> reverseNew [
	"
	For plane loops only. 
	Flip refFrame 180 degrees about x-axis. 
	Reverse order of rfpointsf. 
	Negate all y coordinates of rfpointsf. 
	"

	| answer |
	answer := self copy.
	answer aRefFrame rotatex: Double pi.
	answer aBoundingBox reverseSelf.
	^answer
]

{ #category : #accessing }
RectSurface >> reverseSelf [
	"
	For plane loops only. 
	Flip refFrame 180 degrees about x-axis. 
	Reverse order of rfpointsf. 
	Negate all y coordinates of rfpointsf. 
	"

	aRefFrame rotatex: Double pi.
	aBoundingBox reverseSelf.
	^self
]

{ #category : #accessing }
RectSurface >> rfpfNurbs [
	^NurbsSurface fromRectSurface: self
]

{ #category : #accessing }
RectSurface >> smooth_cuv: aCurve [ 
	"Do nothing."
]

{ #category : #accessing }
RectSurface >> smooth_cuv: aCurve within: uvBound [ 
	"Do nothing."
]

{ #category : #calc }
RectSurface >> uvCurveOfCircularArc: aCircularArc [
	"
	aAFR*aARe := aAFe
	aARe := aAFRT*aAFe
	"

	| uvEllipticalArc aAFf tol |
	uvEllipticalArc := aCircularArc asEllipticalArc.
	uvEllipticalArc isSpatial: false.
	aAFf := aRefFrame aAFf
				transposeTimesFullMatrix: aCircularArc aRefFrame aAFf.
	tol := 1.0d-9.
	self assert: [(aAFf column: 3) length > (1.0d - tol)].
	(uvEllipticalArc aRefFrame)
		rFfF: (self uvwOfPoint: aCircularArc aRefFrame rFfF);
		aAFf: aAFf.
	uvEllipticalArc
		scaleF: self uvwScale;
		privateCalcBoundingBox.
	^Array with: uvEllipticalArc
]

{ #category : #accessing }
RectSurface >> uvCurveOfEllipticArc: aEllipticArc [ 
	"
	aAFR*aARe := aAFe
	aARe := aAFRT*aAFe
	"

	| uvEllipticArc aAFf tol |
	uvEllipticArc := aEllipticArc copy.
	uvEllipticArc isSpatial: false.
	aAFf := aRefFrame aAFf 
				transposeTimesFullMatrix: aEllipticArc aRefFrame aAFf.
	tol := 1.0d-9.
	self assert: [(aAFf column: 3) length > (1.0d - tol)].
	(uvEllipticArc aRefFrame)
		rFfF: (self uvwOfPoint: aEllipticArc aRefFrame rFfF);
		aAFf: aAFf.
	uvEllipticArc
		scaleF: self uvwScale;
		privateCalcBoundingBox.
	^Array with: uvEllipticArc
]

{ #category : #accessing }
RectSurface >> uvCurveOfEllipticArc: aEllipticArc preCurve: preCurve [ 
	"
	aAFR*aARe := aAFe
	aARe := aAFRT*aAFe
	"

	| uvEllipticArc aAFf tol |
	uvEllipticArc := aEllipticArc copy.
	uvEllipticArc isSpatial: false.
	aAFf := aRefFrame aAFf 
				transposeTimesFullMatrix: aEllipticArc aRefFrame aAFf.
	tol := 1.0d-9.
	self assert: [(aAFf column: 3) length > (1.0d - tol)].
	(uvEllipticArc aRefFrame)
		rFfF: (self uvwOfPoint: aEllipticArc aRefFrame rFfF);
		aAFf: aAFf.
	uvEllipticArc
		scaleF: self uvwScale;
		privateCalcBoundingBox.
	^uvEllipticArc
]

{ #category : #accessing }
RectSurface >> uvCurveOfLine: aLine [

	| uvstart uvend uvCurve |
	uvstart := self uvOfPoint: aLine rfstartf.
	uvend := self uvOfPoint: aLine rfendf.
	uvCurve := (Line new)
				isSpatial: false;
				uvStart: uvstart;
				uvEnd: uvend;
				dsdt: 1 / (uvend - uvstart) length;
				privateCalcBoundingBox;
				yourself.
	^Array with: uvCurve
]

{ #category : #accessing }
RectSurface >> uvCurveOfLine: aLine preCurve: preCurve [ 
	| uvstart uvend uvLine |
	uvstart := self uvOfPoint: aLine rfstartf.
	uvend := self uvOfPoint: aLine rfendf.
	uvLine := Line new.
	uvLine
		isSpatial: false;
		uvStart: uvstart;
		uvEnd: uvend;
		dsdt: 1 / (uvend - uvstart) length;
		privateCalcBoundingBox.
	^uvLine
]

{ #category : #accessing }
RectSurface >> uvCurveOfNurbsCurve: aNurbsCurve [
	"
	rFpF = rFpF
	rFRF + aAFR*rRpR = rFNF + aAFN*rNpN
	rRpR = aAFRT(rFNF - rFRF + aAFN*rNpN)
	"

	| aNurbsRefFrame aAFRT aAFN rFNFrFRF cuvPoint uvNurbsCurve |
	aNurbsRefFrame := aNurbsCurve aRefFrame.
	aAFRT := aRefFrame aAFf transpose.
	aAFN := aNurbsRefFrame aAFf.
	rFNFrFRF := aNurbsRefFrame rFfF minusFullColumn: aRefFrame rFfF.
	cuvPoint := aNurbsCurve cPoint collect: 
					[:rNpN |
					| rRpR |
					rRpR := aAFRT
								timesFullColumn: (rFNFrFRF plusFullColumn: (aAFN timesFullColumn: rNpN)).
					aBoundingBox uvwOfPoint: rRpR].
	uvNurbsCurve := aNurbsCurve copy.
	uvNurbsCurve aRefFrame fixedAtRef.
	uvNurbsCurve
		isSpatial: false;
		_cPoint: cuvPoint;
		be2D;
		privateCalcBoundingBox.
	^Array with: uvNurbsCurve
]

{ #category : #accessing }
RectSurface >> uvCurveOfNurbsCurve: aNurbsCurve preCurve: preCurve [ 
	"
	rFpF = rFpF
	rFRF + aAFR*rRpR = rFNF + aAFN*rNpN
	rRpR = aAFRT(rFNF - rFRF + aAFN*rNpN)
	"

	| aNurbsRefFrame aAFRT aAFN rFNFrFRF cuvPoint uvNurbsCurve |
	aNurbsRefFrame := aNurbsCurve aRefFrame.
	aAFRT := aRefFrame aAFf transpose.
	aAFN := aNurbsRefFrame aAFf.
	rFNFrFRF := aNurbsRefFrame rFfF minusFullColumn: aRefFrame rFfF.
	cuvPoint := aNurbsCurve cPoint collect: 
					[:rNpN | 
					| rRpR |
					rRpR := aAFRT 
								timesFullColumn: (rFNFrFRF plusFullColumn: (aAFN timesFullColumn: rNpN)).
					aBoundingBox uvwOfPoint: rRpR].
	uvNurbsCurve := aNurbsCurve copy.
	uvNurbsCurve aRefFrame fixedAtRef.
	uvNurbsCurve
		isSpatial: false;
		_cPoint: cuvPoint;
		be2D;
		privateCalcBoundingBox.
	^uvNurbsCurve
]

{ #category : #accessing }
RectSurface >> uvOfPoint: rFpF [ 
	| uvw |
	uvw := self uvwOfPoint: rFpF.
	^uvw copyFrom: 1 to: 2
]

{ #category : #accessing }
RectSurface >> uvwOfPoint: rFpF [ 
	| rfpf |
	rfpf := aRefFrame rfpffromrFpF: rFpF.
	^aBoundingBox uvwOfPoint: rfpf
]

{ #category : #accessing }
RectSurface >> uvwScale [
	^aBoundingBox uvwScale
]

{ #category : #accessing }
RectSurface >> value: uv [ 
	^uv
]
