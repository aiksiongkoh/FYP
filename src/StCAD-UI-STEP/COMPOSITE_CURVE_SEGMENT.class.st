Class {
	#name : #'COMPOSITE_CURVE_SEGMENT',
	#superclass : #'FOUNDED_ITEM',
	#instVars : [
		'transition',
		'same_sense',
		'parent_curve'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
COMPOSITE_CURVE_SEGMENT >> parent_curve [
	^parent_curve
]

{ #category : #accessing }
COMPOSITE_CURVE_SEGMENT >> parent_curve: anObject [
	parent_curve := anObject
]

{ #category : #accessing }
COMPOSITE_CURVE_SEGMENT >> same_sense [
	^same_sense
]

{ #category : #accessing }
COMPOSITE_CURVE_SEGMENT >> same_sense: anObject [
	same_sense := anObject
]

{ #category : #accessing }
COMPOSITE_CURVE_SEGMENT >> transition [
	^transition
]

{ #category : #accessing }
COMPOSITE_CURVE_SEGMENT >> transition: anObject [
	transition := anObject
]
