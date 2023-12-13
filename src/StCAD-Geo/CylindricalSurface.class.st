"
aCurve is a line from
(radius, zStart)
to
(radius, zEnd)

zStart < zEnd

"
Class {
	#name : #CylindricalSurface,
	#superclass : #SurfaceOfRevolution,
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
CylindricalSurface class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
CylindricalSurface >> _radius [
	^aCurve rfstartf x
]

{ #category : #accessing }
CylindricalSurface >> _radius: radius [ 
	aCurve rfstartf x: radius asDouble.
	aCurve rfendf x: radius asDouble
]

{ #category : #accessing }
CylindricalSurface >> _zend: zend [ 
	aCurve rfendf z: zend
]

{ #category : #accessing }
CylindricalSurface >> _zstart: zstart [ 
	aCurve rfstartf z: zstart
]

{ #category : #ops }
CylindricalSurface >> condition_cgluvTrimNurbs: cgluvTrimNurbs [

	^cgluvTrimNurbs
]

{ #category : #'initialize-release' }
CylindricalSurface >> initialize [

	| aLine |
	super initialize.
	aLine := StCAD_Geo_Line new
		         rfstartf: (FullColumn zero: 3);
		         rfendf: (FullColumn zero: 3);
		         yourself. "VW_TRANSLATION:StCAD.Geo.Line:StCAD_Geo_Line"
	self _aCurve: aLine
]

{ #category : #accessing }
CylindricalSurface >> uvCurveOfEllipticArc1: aEllipticArc [ 
	| cnPoint cnPointOn_uv |
	cnPoint := aEllipticArc crFpF_n: 4.
	cnPointOn_uv := cnPoint collect: [:aPointXYZ | self uvOfPoint: aPointXYZ].
	^(Line new)
		isSpatial: false;
		cuv: cnPointOn_uv;
		yourself
]

{ #category : #accessing }
CylindricalSurface >> uvCurveOfEllipticArc: aEllipticArc [
	"uv of cylindrical surface is not the same as the uv of Nurbs cylinder."

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
CylindricalSurface >> uvCurveOfEllipticArc: aEllipticArc preCurve: preCurve [ 
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
CylindricalSurface >> uvCurveOfLine1: aLine [ 
	| cnPoint cnPointOn_uv |
	cnPoint := aLine crFpF_n: 4.
	cnPointOn_uv := cnPoint collect: [:aPointXYZ | self uvOfPoint: aPointXYZ].
	^(Line new)
		isSpatial: false;
		cuv: cnPointOn_uv;
		yourself
]

{ #category : #accessing }
CylindricalSurface >> uvCurveOfLine: aLine [
	"uv of cylindrical surface is not the same as the uv of Nurbs cylinder."

	| glSurface cnPoint cnPointOn_uv uvCurve |
	glSurface := self glSurface.
	cnPoint := aLine crFpF_n: 4.
	cnPointOn_uv := cnPoint collect: 
					[:aPointXYZ |
					| uvGuess |
					uvGuess := self uvOfPoint: aPointXYZ.
					glSurface uvOfPoint: aPointXYZ uvGuess: uvGuess].
	uvCurve := (Line new)
				isSpatial: false;
				cuv: cnPointOn_uv;
				yourself.
	^Array with: uvCurve
]

{ #category : #accessing }
CylindricalSurface >> uvCurveOfLine: aLine preCurve: preCurve [ 
	| cnPoint cnPointOn_uv pre_uvEnd uvStart uvEnd uvLine |
	cnPoint := aLine crFpF_n: 4.
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
