Class {
	#name : #'B_SPLINE_CURVE_WITH_KNOTS',
	#superclass : #'B_SPLINE_CURVE',
	#instVars : [
		'knot_multiplicities',
		'knots',
		'knot_spec'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
B_SPLINE_CURVE_WITH_KNOTS >> cPoint [

	^ StCAD_Math_FullColumn
		  fromCollection: control_points_list
		  aBlock: [ :a | a xyzPoint ] "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn"
]

{ #category : #accessing }
B_SPLINE_CURVE_WITH_KNOTS >> cWeight [

	^ StCAD_Math_FullColumn
		  fromCollection: control_points_list
		  aBlock: [ :a | 1.0 d ] "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn"
]

{ #category : #accessing }
B_SPLINE_CURVE_WITH_KNOTS >> cuKnot [

	| n aStream |
	n := knot_multiplicities
		     inject: 0
		     into: [ :subTotal :next | subTotal + next ].
	aStream := (StCAD_Math_MathArray new: n) writeStream. "VW_TRANSLATION:StCAD.Math.MathArray:StCAD_Math_MathArray"
	knot_multiplicities
		with: knots
		parallelDo: [ :m :knot | m timesRepeat: [ aStream nextPut: knot ] ].
	^ aStream contents
]

{ #category : #accessing }
B_SPLINE_CURVE_WITH_KNOTS >> knot_multiplicities [
	^knot_multiplicities
]

{ #category : #accessing }
B_SPLINE_CURVE_WITH_KNOTS >> knot_multiplicities: anObject [
	knot_multiplicities := anObject
]

{ #category : #accessing }
B_SPLINE_CURVE_WITH_KNOTS >> knot_spec [
	^knot_spec
]

{ #category : #accessing }
B_SPLINE_CURVE_WITH_KNOTS >> knot_spec: anObject [
	knot_spec := anObject
]

{ #category : #accessing }
B_SPLINE_CURVE_WITH_KNOTS >> knots [
	^knots
]

{ #category : #accessing }
B_SPLINE_CURVE_WITH_KNOTS >> knots: anObject [
	knots := anObject
]

{ #category : #accessing }
B_SPLINE_CURVE_WITH_KNOTS >> xyzCurve [

	| aNurbsCurve |
	aNurbsCurve := StCAD_Geo_NurbsCurve new. "VW_TRANSLATION:StCAD.Geo.NurbsCurve:StCAD_Geo_NurbsCurve"
	aNurbsCurve
		_cPoint: self cPoint;
		cWeight: self cWeight;
		_cuKnot: self cuKnot.
	self assert: [ aNurbsCurve isOK ].
	^ aNurbsCurve
		  normalizeKnots;
		  yourself
]

{ #category : #accessing }
B_SPLINE_CURVE_WITH_KNOTS >> xyzCurveFrom: aEDGE_CURVE [ 
	^self xyzCurve
]
