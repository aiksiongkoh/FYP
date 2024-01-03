Class {
	#name : #'SURFACE_CURVE',
	#superclass : #CURVE,
	#instVars : [
		'curve_3d',
		'associated_geometry',
		'master_representation'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
SURFACE_CURVE >> associated_geometry [
	^associated_geometry
]

{ #category : #accessing }
SURFACE_CURVE >> associated_geometry: anObject [
	associated_geometry := anObject
]

{ #category : #accessing }
SURFACE_CURVE >> curve_3d [
	^curve_3d
]

{ #category : #accessing }
SURFACE_CURVE >> curve_3d: anObject [
	curve_3d := anObject
]

{ #category : #accessing }
SURFACE_CURVE >> master_representation [
	^master_representation
]

{ #category : #accessing }
SURFACE_CURVE >> master_representation: anObject [
	master_representation := anObject
]
