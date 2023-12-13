Class {
	#name : #'CYLINDRICAL_SURFACE',
	#superclass : #'ELEMENTARY_SURFACE',
	#instVars : [
		'radius'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
CYLINDRICAL_SURFACE class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
CYLINDRICAL_SURFACE >> aSurfaceWithBounds: cFACE_BOUND [

	| aCylindricalSurface |
	aCylindricalSurface := StCAD_Geo_CylindricalSurface new. "VW_TRANSLATION:StCAD.Geo.CylindricalSurface:StCAD_Geo_CylindricalSurface"
	aCylindricalSurface name: name.
	aCylindricalSurface _radius: radius.
	aCylindricalSurface aRefFrame copyrFfFandAFfFrom: position aRefFrame.
	cFACE_BOUND do: [ :aFACE_BOUND | 
		aFACE_BOUND boundCylindricalSurface: aCylindricalSurface ].
	aCylindricalSurface _zstart:
		aCylindricalSurface aBoundingBox minCorner z.
	aCylindricalSurface _zend:
		aCylindricalSurface aBoundingBox maxCorner z.
	^ aCylindricalSurface
]

{ #category : #printing }
CYLINDRICAL_SURFACE >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'CYLINDRICAL_SURFACE';
		cr;
		nextPutAll: 'radius = ';
		printVerbose: radius;
		cr;
		printVerbose: position
]

{ #category : #accessing }
CYLINDRICAL_SURFACE >> radius [
	^radius
]

{ #category : #accessing }
CYLINDRICAL_SURFACE >> radius: anObject [
	radius := anObject
]
