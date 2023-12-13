"
aCurve is a line from
(xStart, zStart)
to
(xEnd, zEnd)

zStart < zEnd
xStart := radius + (zStart * semi_angle tan)
"
Class {
	#name : #ConicalSurface,
	#superclass : #SurfaceOfRevolution,
	#instVars : [
		'radius',
		'semi_angle'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
ConicalSurface class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
ConicalSurface >> _zend: zend [ 
	| rfendf |
	rfendf := aCurve rfendf.
	rfendf z: zend.
	rfendf x: radius + (zend * semi_angle tan)
]

{ #category : #accessing }
ConicalSurface >> _zstart: zstart [ 
	| rfstartf |
	rfstartf := aCurve rfstartf.
	rfstartf z: zstart.
	rfstartf x: radius + (zstart * semi_angle tan)
]

{ #category : #accessing }
ConicalSurface >> cEndSingularityOf: aaCurve [ 
	| cuv tol n startSingularity endSingularity |
	cuv := aaCurve cuv.
	tol := 1.0d-6.
	n := cuv size.
	startSingularity := false.
	endSingularity := false.
	(cuv at: 1) ifNil: 
			[cuv at: 1
				put: (FullColumn with: (cuv at: 2) u with: (cuv at: 2) v rounded asDouble).
			startSingularity := true]
		ifNotNil: 
			[:uv1 | 
			(self isSingular_v: uv1 v tol: tol) 
				ifTrue: 
					[uv1 u: (cuv at: 2) u.
					startSingularity := true]].
	(cuv at: n) ifNil: 
			[cuv at: n
				put: (FullColumn with: (cuv at: n - 1) u
						with: (cuv at: n - 1) v rounded asDouble).
			endSingularity := true]
		ifNotNil: 
			[:uvn | 
			(self isSingular_v: uvn v tol: tol) 
				ifTrue: 
					[uvn u: (cuv at: n - 1) u.
					endSingularity := true]].
	^MathArray with: startSingularity with: endSingularity
]

{ #category : #calc }
ConicalSurface >> condition_cglTrimNurbs: cglTrimNurbs [ 
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
ConicalSurface >> condition_cgluvTrimNurbs: cgluvTrimNurbs [

	^cgluvTrimNurbs
]

{ #category : #'initialize-release' }
ConicalSurface >> initialize [

	| aLine |
	super initialize.
	aLine := StCAD_Geo_Line new
		         rfstartf: (FullColumn zero: 3);
		         rfendf: (FullColumn zero: 3);
		         yourself. "VW_TRANSLATION:StCAD.Geo.Line:StCAD_Geo_Line"
	self _aCurve: aLine
]

{ #category : #accessing }
ConicalSurface >> isEndSingular_tol: tol [ 
	^aCurve rfendf x < (tol * aBoundingBox diagonal_length)
]

{ #category : #accessing }
ConicalSurface >> isSingular_v: v tol: tol [ 
	"If cone has an apex, singularity is when v is 0 or 1."

	^(v equal: 0.0d tol: tol) 
		ifTrue: [self isStartSingular_tol: tol]
		ifFalse: 
			[(v equal: 1.0d tol: tol) 
				ifTrue: [self isEndSingular_tol: tol]
				ifFalse: [false]]
]

{ #category : #accessing }
ConicalSurface >> isStartSingular_tol: tol [ 
	^aCurve rfstartf x < (tol * aBoundingBox diagonal_length)
]

{ #category : #ops }
ConicalSurface >> magnifySelf: aDouble [ 
	super magnifySelf: aDouble.
	radius := radius * aDouble
]

{ #category : #printing }
ConicalSurface >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'ConicalSurface';
		cr;
		printVerbose: aRefFrame;
		cr;
		printVerbose: aCurve
]

{ #category : #accessing }
ConicalSurface >> radius [
	^radius
]

{ #category : #accessing }
ConicalSurface >> radius: aDouble [ 
	radius := aDouble abs asDouble
]

{ #category : #accessing }
ConicalSurface >> semi_angle [
	^semi_angle
]

{ #category : #accessing }
ConicalSurface >> semi_angle: aDouble [ 
	semi_angle := aDouble abs asDouble
]

{ #category : #accessing }
ConicalSurface >> uvCurveOfLine: aLine [

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
ConicalSurface >> uvCurveOfLine: aLine preCurve: preCurve [ 
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
