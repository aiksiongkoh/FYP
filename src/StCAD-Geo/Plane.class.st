Class {
	#name : #Plane,
	#superclass : #Surface,
	#instVars : [
		'aRectSurface'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
Plane class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
Plane >> aRectSurface [
	^aRectSurface
]

{ #category : #accessing }
Plane >> aRectSurface: anObject [
	aRectSurface := anObject
]

{ #category : #accessing }
Plane >> addRectSurface: argaRectSurface [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	argaRectSurface removeSup.
	super addRefFrame: argaRectSurface aRefFrame.
	aRectSurface := argaRectSurface.
	argaRectSurface aSup: self.
	self calcBoundingBox.
	^argaRectSurface
]

{ #category : #'initialize-release' }
Plane >> initialize [
	super initialize.
	self addRectSurface: RectSurface new
]
