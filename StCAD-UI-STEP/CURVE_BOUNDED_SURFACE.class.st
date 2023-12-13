Class {
	#name : #'CURVE_BOUNDED_SURFACE',
	#superclass : #'BOUNDED_SURFACE',
	#instVars : [
		'basis_surface',
		'boundaries',
		'implicit_outer'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
CURVE_BOUNDED_SURFACE class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
CURVE_BOUNDED_SURFACE >> basis_surface [
	^basis_surface
]

{ #category : #accessing }
CURVE_BOUNDED_SURFACE >> basis_surface: anObject [
	basis_surface := anObject
]

{ #category : #accessing }
CURVE_BOUNDED_SURFACE >> boundaries [
	^boundaries
]

{ #category : #accessing }
CURVE_BOUNDED_SURFACE >> boundaries: anObject [
	boundaries := anObject
]

{ #category : #accessing }
CURVE_BOUNDED_SURFACE >> implicit_outer [
	^implicit_outer
]

{ #category : #accessing }
CURVE_BOUNDED_SURFACE >> implicit_outer: anObject [
	implicit_outer := anObject
]
