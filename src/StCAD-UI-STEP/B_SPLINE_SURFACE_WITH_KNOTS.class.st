Class {
	#name : #'B_SPLINE_SURFACE_WITH_KNOTS',
	#superclass : #'B_SPLINE_SURFACE',
	#instVars : [
		'u_multiplicities',
		'v_multiplicities',
		'u_knots',
		'v_knots',
		'knot_spec'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
B_SPLINE_SURFACE_WITH_KNOTS class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
B_SPLINE_SURFACE_WITH_KNOTS >> aSurfaceWithBounds: cFACE_BOUND [

	| aNurbsSurface |
	aNurbsSurface := StCAD_Geo_NurbsSurface new. "VW_TRANSLATION:StCAD.Geo.NurbsSurface:StCAD_Geo_NurbsSurface"
	aNurbsSurface
		name: name;
		_ccPoint: self ccPoint;
		ccWeight: self ccWeight;
		_cuKnot: self cuKnot;
		_cvKnot: self cvKnot.
	cFACE_BOUND do: [ :aFACE_BOUND | 
		aFACE_BOUND boundNurbsSurface: aNurbsSurface ].
	^ aNurbsSurface
		  normalizeKnots;
		  yourself
]

{ #category : #accessing }
B_SPLINE_SURFACE_WITH_KNOTS >> ccPoint [

	^ StCAD_Math_FullMatrix
		  fromCollection: control_points_list
		  aBlock: [ :a | a xyzPoint ] "VW_TRANSLATION:StCAD.Math.FullMatrix:StCAD_Math_FullMatrix"
]

{ #category : #accessing }
B_SPLINE_SURFACE_WITH_KNOTS >> ccWeight [

	^ StCAD_Math_FullMatrix
		  fromCollection: control_points_list
		  aBlock: [ :a | 1.0 d ] "VW_TRANSLATION:StCAD.Math.FullMatrix:StCAD_Math_FullMatrix"
]

{ #category : #accessing }
B_SPLINE_SURFACE_WITH_KNOTS >> cuKnot [

	| n aStream |
	n := u_multiplicities
		     inject: 0
		     into: [ :subTotal :next | subTotal + next ].
	aStream := (StCAD_Math_MathArray new: n) writeStream. "VW_TRANSLATION:StCAD.Math.MathArray:StCAD_Math_MathArray"
	u_multiplicities
		with: u_knots
		parallelDo: [ :m :knot | m timesRepeat: [ aStream nextPut: knot ] ].
	^ aStream contents
]

{ #category : #accessing }
B_SPLINE_SURFACE_WITH_KNOTS >> cvKnot [

	| n aStream |
	n := v_multiplicities
		     inject: 0
		     into: [ :subTotal :next | subTotal + next ].
	aStream := (StCAD_Math_MathArray new: n) writeStream. "VW_TRANSLATION:StCAD.Math.MathArray:StCAD_Math_MathArray"
	v_multiplicities
		with: v_knots
		parallelDo: [ :m :knot | m timesRepeat: [ aStream nextPut: knot ] ].
	^ aStream contents
]

{ #category : #accessing }
B_SPLINE_SURFACE_WITH_KNOTS >> knot_spec [
	^knot_spec
]

{ #category : #accessing }
B_SPLINE_SURFACE_WITH_KNOTS >> knot_spec: anObject [
	knot_spec := anObject
]

{ #category : #accessing }
B_SPLINE_SURFACE_WITH_KNOTS >> u_knots [
	^u_knots
]

{ #category : #accessing }
B_SPLINE_SURFACE_WITH_KNOTS >> u_knots: anObject [
	u_knots := anObject
]

{ #category : #accessing }
B_SPLINE_SURFACE_WITH_KNOTS >> u_multiplicities [
	^u_multiplicities
]

{ #category : #accessing }
B_SPLINE_SURFACE_WITH_KNOTS >> u_multiplicities: anObject [
	u_multiplicities := anObject
]

{ #category : #accessing }
B_SPLINE_SURFACE_WITH_KNOTS >> v_knots [
	^v_knots
]

{ #category : #accessing }
B_SPLINE_SURFACE_WITH_KNOTS >> v_knots: anObject [
	v_knots := anObject
]

{ #category : #accessing }
B_SPLINE_SURFACE_WITH_KNOTS >> v_multiplicities [
	^v_multiplicities
]

{ #category : #accessing }
B_SPLINE_SURFACE_WITH_KNOTS >> v_multiplicities: anObject [
	v_multiplicities := anObject
]
