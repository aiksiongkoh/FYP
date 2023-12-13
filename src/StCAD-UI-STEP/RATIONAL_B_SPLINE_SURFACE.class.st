Class {
	#name : #'RATIONAL_B_SPLINE_SURFACE',
	#superclass : #'B_SPLINE_SURFACE_WITH_KNOTS',
	#instVars : [
		'weights_data'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
RATIONAL_B_SPLINE_SURFACE class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
RATIONAL_B_SPLINE_SURFACE >> ccWeight [

	^ StCAD_Math_FullMatrix
		  fromCollection: weights_data
		  aBlock: [ :a | a ] "VW_TRANSLATION:StCAD.Math.FullMatrix:StCAD_Math_FullMatrix"
]

{ #category : #accessing }
RATIONAL_B_SPLINE_SURFACE >> fillWith: cObject [ 
	self fillWithB_SPLINE_SURFACE_WITH_KNOTS: (cObject 
				detect: [:a | a isMemberOf: B_SPLINE_SURFACE_WITH_KNOTS]).
	self fillWithB_SPLINE_SURFACE: (cObject 
				detect: [:a | a isMemberOf: B_SPLINE_SURFACE])
]

{ #category : #accessing }
RATIONAL_B_SPLINE_SURFACE >> fillWithB_SPLINE_SURFACE: arg [ 
	self u_degree: arg u_degree.
	self v_degree: arg v_degree.
	self control_points_list: arg control_points_list.
	self surface_form: arg surface_form.
	self u_closed: arg u_closed.
	self v_closed: arg v_closed.
	self self_intersect: arg self_intersect
]

{ #category : #accessing }
RATIONAL_B_SPLINE_SURFACE >> fillWithB_SPLINE_SURFACE_WITH_KNOTS: arg [ 
	self u_multiplicities: arg u_multiplicities.
	self v_multiplicities: arg v_multiplicities.
	self u_knots: arg u_knots.
	self v_knots: arg v_knots.
	self knot_spec: arg knot_spec
]

{ #category : #accessing }
RATIONAL_B_SPLINE_SURFACE >> weights_data [
	^weights_data
]

{ #category : #accessing }
RATIONAL_B_SPLINE_SURFACE >> weights_data: anObject [
	weights_data := anObject
]
