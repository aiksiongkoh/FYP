Class {
	#name : #'TOROIDAL_SURFACE',
	#superclass : #'ELEMENTARY_SURFACE',
	#instVars : [
		'major_radius',
		'minor_radius'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
TOROIDAL_SURFACE >> aSurfaceWithBounds: cFACE_BOUND [

	| aToroidalSurface |
	aToroidalSurface := StCAD_Geo_ToroidalSurface new. "VW_TRANSLATION:StCAD.Geo.ToroidalSurface:StCAD_Geo_ToroidalSurface"
	aToroidalSurface name: name.
	aToroidalSurface majorRadius: major_radius.
	aToroidalSurface minorRadius: minor_radius.
	aToroidalSurface aRefFrame copyrFfFandAFfFrom: position aRefFrame.
	cFACE_BOUND do: [ :aFACE_BOUND | 
		aFACE_BOUND boundToroidalSurface: aToroidalSurface ].
	^ aToroidalSurface
]

{ #category : #accessing }
TOROIDAL_SURFACE >> major_radius [
	^major_radius
]

{ #category : #accessing }
TOROIDAL_SURFACE >> major_radius: anObject [
	major_radius := anObject
]

{ #category : #accessing }
TOROIDAL_SURFACE >> minor_radius [
	^minor_radius
]

{ #category : #accessing }
TOROIDAL_SURFACE >> minor_radius: anObject [
	minor_radius := anObject
]

{ #category : #printing }
TOROIDAL_SURFACE >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'TOROIDAL_SURFACE';
		cr;
		nextPutAll: 'major_radius = ';
		printVerbose: major_radius;
		cr;
		nextPutAll: 'minor_radius = ';
		printVerbose: minor_radius;
		cr;
		printVerbose: position
]
