Class {
	#name : #MassMarker,
	#superclass : #Marker,
	#instVars : [
		'mass',
		'aJppx',
		'aJppy',
		'aJppz',
		'density'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
MassMarker class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
MassMarker >> aJppx [
	^aJppx
]

{ #category : #accessing }
MassMarker >> aJppx: anObject [
	aJppx := anObject
]

{ #category : #accessing }
MassMarker >> aJppy [
	^aJppy
]

{ #category : #accessing }
MassMarker >> aJppy: anObject [
	aJppy := anObject
]

{ #category : #accessing }
MassMarker >> aJppz [
	^aJppz
]

{ #category : #accessing }
MassMarker >> aJppz: anObject [
	aJppz := anObject
]

{ #category : #accessing }
MassMarker >> density [
	^density
]

{ #category : #accessing }
MassMarker >> density: anObject [
	density := anObject
]

{ #category : #accessing }
MassMarker >> mass [
	^mass
]

{ #category : #accessing }
MassMarker >> mass: anObject [
	mass := anObject
]
