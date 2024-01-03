Class {
	#name : #'B_SPLINE_CURVE',
	#superclass : #'BOUNDED_CURVE',
	#instVars : [
		'degree',
		'control_points_list',
		'curve_form',
		'closed_curve',
		'self_intersect'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
B_SPLINE_CURVE >> closed_curve [
	^closed_curve
]

{ #category : #accessing }
B_SPLINE_CURVE >> closed_curve: anObject [
	closed_curve := anObject
]

{ #category : #accessing }
B_SPLINE_CURVE >> control_points_list [
	^control_points_list
]

{ #category : #accessing }
B_SPLINE_CURVE >> control_points_list: anObject [
	control_points_list := anObject
]

{ #category : #accessing }
B_SPLINE_CURVE >> curve_form [
	^curve_form
]

{ #category : #accessing }
B_SPLINE_CURVE >> curve_form: anObject [
	curve_form := anObject
]

{ #category : #accessing }
B_SPLINE_CURVE >> degree [
	^degree
]

{ #category : #accessing }
B_SPLINE_CURVE >> degree: anObject [
	degree := anObject
]

{ #category : #accessing }
B_SPLINE_CURVE >> self_intersect [
	^self_intersect
]

{ #category : #accessing }
B_SPLINE_CURVE >> self_intersect: anObject [
	self_intersect := anObject
]
