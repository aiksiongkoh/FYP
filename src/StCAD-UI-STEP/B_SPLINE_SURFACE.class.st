Class {
	#name : #'B_SPLINE_SURFACE',
	#superclass : #'BOUNDED_SURFACE',
	#instVars : [
		'u_degree',
		'v_degree',
		'control_points_list',
		'surface_form',
		'u_closed',
		'v_closed',
		'self_intersect'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
B_SPLINE_SURFACE >> control_points_list [
	^control_points_list
]

{ #category : #accessing }
B_SPLINE_SURFACE >> control_points_list: anObject [
	control_points_list := anObject
]

{ #category : #accessing }
B_SPLINE_SURFACE >> self_intersect [
	^self_intersect
]

{ #category : #accessing }
B_SPLINE_SURFACE >> self_intersect: anObject [
	self_intersect := anObject
]

{ #category : #accessing }
B_SPLINE_SURFACE >> surface_form [
	^surface_form
]

{ #category : #accessing }
B_SPLINE_SURFACE >> surface_form: anObject [
	surface_form := anObject
]

{ #category : #accessing }
B_SPLINE_SURFACE >> u_closed [
	^u_closed
]

{ #category : #accessing }
B_SPLINE_SURFACE >> u_closed: anObject [
	u_closed := anObject
]

{ #category : #accessing }
B_SPLINE_SURFACE >> u_degree [
	^u_degree
]

{ #category : #accessing }
B_SPLINE_SURFACE >> u_degree: anObject [
	u_degree := anObject
]

{ #category : #accessing }
B_SPLINE_SURFACE >> v_closed [
	^v_closed
]

{ #category : #accessing }
B_SPLINE_SURFACE >> v_closed: anObject [
	v_closed := anObject
]

{ #category : #accessing }
B_SPLINE_SURFACE >> v_degree [
	^v_degree
]

{ #category : #accessing }
B_SPLINE_SURFACE >> v_degree: anObject [
	v_degree := anObject
]
