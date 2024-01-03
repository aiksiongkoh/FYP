Class {
	#name : #PCURVE,
	#superclass : #CURVE,
	#instVars : [
		'basis_surface',
		'reference_to_curve'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
PCURVE >> basis_surface [
	^basis_surface
]

{ #category : #accessing }
PCURVE >> basis_surface: anObject [
	basis_surface := anObject
]

{ #category : #accessing }
PCURVE >> reference_to_curve [
	^reference_to_curve
]

{ #category : #accessing }
PCURVE >> reference_to_curve: anObject [
	reference_to_curve := anObject
]
