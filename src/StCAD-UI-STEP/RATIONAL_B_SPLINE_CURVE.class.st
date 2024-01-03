Class {
	#name : #'RATIONAL_B_SPLINE_CURVE',
	#superclass : #'B_SPLINE_CURVE_WITH_KNOTS',
	#instVars : [
		'weights_data'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
RATIONAL_B_SPLINE_CURVE >> cWeight [

	^ StCAD_Math_FullColumn
		  fromCollection: weights_data
		  aBlock: [ :a | a ] "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn"
]

{ #category : #accessing }
RATIONAL_B_SPLINE_CURVE >> fillWith: cObject [ 
	self fillWithB_SPLINE_CURVE_WITH_KNOTS: (cObject 
				detect: [:a | a isMemberOf: B_SPLINE_CURVE_WITH_KNOTS]).
	self fillWithB_SPLINE_CURVE: (cObject 
				detect: [:a | a isMemberOf: B_SPLINE_CURVE])
]

{ #category : #accessing }
RATIONAL_B_SPLINE_CURVE >> fillWithB_SPLINE_CURVE: arg [ 
	self degree: arg degree.
	self control_points_list: arg control_points_list.
	self curve_form: arg curve_form.
	self closed_curve: arg closed_curve.
	self self_intersect: arg self_intersect
]

{ #category : #accessing }
RATIONAL_B_SPLINE_CURVE >> fillWithB_SPLINE_CURVE_WITH_KNOTS: arg [ 
	self knot_multiplicities: arg knot_multiplicities.
	self knots: arg knots.
	self knot_spec: arg knot_spec
]

{ #category : #accessing }
RATIONAL_B_SPLINE_CURVE >> weights_data [
	^weights_data
]

{ #category : #accessing }
RATIONAL_B_SPLINE_CURVE >> weights_data: anObject [
	weights_data := anObject
]
