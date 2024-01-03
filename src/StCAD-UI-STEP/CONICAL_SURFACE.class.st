Class {
	#name : #'CONICAL_SURFACE',
	#superclass : #'ELEMENTARY_SURFACE',
	#instVars : [
		'radius',
		'semi_angle'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'As yet unclassified' }
CONICAL_SURFACE >> aSurfaceWithBounds: cFACE_BOUND [

	| aConicalSurface |
	aConicalSurface := StCAD_Geo_ConicalSurface new. "VW_TRANSLATION:StCAD.Geo.ConicalSurface:StCAD_Geo_ConicalSurface"
	aConicalSurface name: name.
	aConicalSurface radius: radius.
	aConicalSurface semi_angle: semi_angle * REPRESENTATION angleFactor.
	aConicalSurface aRefFrame copyrFfFandAFfFrom: position aRefFrame.
	cFACE_BOUND do: [ :aFACE_BOUND | 
		aFACE_BOUND boundConicalSurface: aConicalSurface ].
	aConicalSurface _zstart: aConicalSurface aBoundingBox minCorner z.
	aConicalSurface _zend: aConicalSurface aBoundingBox maxCorner z.
	^ aConicalSurface
]

{ #category : #printing }
CONICAL_SURFACE >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'CONICAL_SURFACE';
		cr;
		nextPutAll: 'radius = ';
		printVerbose: radius;
		cr;
		nextPutAll: 'semi_angle = ';
		printVerbose: semi_angle;
		cr;
		printVerbose: position
]

{ #category : #accessing }
CONICAL_SURFACE >> radius [
	^radius
]

{ #category : #accessing }
CONICAL_SURFACE >> radius: anObject [
	radius := anObject
]

{ #category : #accessing }
CONICAL_SURFACE >> semi_angle [
	^semi_angle
]

{ #category : #accessing }
CONICAL_SURFACE >> semi_angle: anObject [
	semi_angle := anObject
]
