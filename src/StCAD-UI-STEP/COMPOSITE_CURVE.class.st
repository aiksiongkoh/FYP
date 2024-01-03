Class {
	#name : #'COMPOSITE_CURVE',
	#superclass : #'BOUNDED_CURVE',
	#instVars : [
		'segments',
		'self_intersect'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
COMPOSITE_CURVE >> segments [
	^segments
]

{ #category : #accessing }
COMPOSITE_CURVE >> segments: anObject [
	segments := anObject
]

{ #category : #accessing }
COMPOSITE_CURVE >> self_intersect [
	^self_intersect
]

{ #category : #accessing }
COMPOSITE_CURVE >> self_intersect: anObject [
	self_intersect := anObject
]
