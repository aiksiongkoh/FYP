Class {
	#name : #'SPHERICAL_SURFACE',
	#superclass : #'ELEMENTARY_SURFACE',
	#instVars : [
		'radius'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
SPHERICAL_SURFACE >> aSurfaceWithBounds: cFACE_BOUND [

	| aSphericalSurface |
	aSphericalSurface := StCAD_Geo_SphericalSurface new. "VW_TRANSLATION:StCAD.Geo.SphericalSurface:StCAD_Geo_SphericalSurface"
	aSphericalSurface name: name.
	aSphericalSurface radius: radius.
	aSphericalSurface aRefFrame copyrFfFandAFfFrom: position aRefFrame.
	cFACE_BOUND do: [ :aFACE_BOUND | 
		aFACE_BOUND boundSphericalSurface: aSphericalSurface ].
	^ aSphericalSurface
]

{ #category : #printing }
SPHERICAL_SURFACE >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'SPHERICAL_SURFACE';
		cr;
		nextPutAll: 'radius = ';
		printVerbose: radius;
		cr;
		printVerbose: position
]

{ #category : #accessing }
SPHERICAL_SURFACE >> radius [
	^radius
]

{ #category : #accessing }
SPHERICAL_SURFACE >> radius: anObject [
	radius := anObject
]
