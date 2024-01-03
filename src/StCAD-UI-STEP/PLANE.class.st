Class {
	#name : #PLANE,
	#superclass : #'ELEMENTARY_SURFACE',
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
PLANE >> aSurface [

	| aRectSurface |
	aRectSurface := StCAD_Geo_RectSurface new. "VW_TRANSLATION:StCAD.Geo.RectSurface:StCAD_Geo_RectSurface"
	aRectSurface name: name.
	aRectSurface aRefFrame: position aRefFrame.
	^ aRectSurface
]

{ #category : #accessing }
PLANE >> aSurfaceWithBounds1: cFACE_BOUND [

	| aRectSurface aRefFrame aBoundingBox |
	aRectSurface := StCAD_Geo_RectSurface new. "VW_TRANSLATION:StCAD.Geo.RectSurface:StCAD_Geo_RectSurface"
	aRectSurface name: name.
	aRefFrame := position aRefFrame.
	aRectSurface aRefFrame: aRefFrame.
	aBoundingBox := aRectSurface aBoundingBox.
	cFACE_BOUND do: [ :aFACE_BOUND | 
		aFACE_BOUND cPoint do: [ :aPoint | 
			aBoundingBox expandToBound: (aRefFrame rfpffromrFpF: aPoint) ] ].
	^ aRectSurface
]

{ #category : #accessing }
PLANE >> aSurfaceWithBounds: cFACE_BOUND [

	| aRectSurface |
	aRectSurface := StCAD_Geo_RectSurface new. "VW_TRANSLATION:StCAD.Geo.RectSurface:StCAD_Geo_RectSurface"
	aRectSurface name: name.
	aRectSurface aRefFrame copyrFfFandAFfFrom: position aRefFrame.
	cFACE_BOUND do: [ :aFACE_BOUND | 
		aFACE_BOUND boundRectSurface: aRectSurface ].
	aRectSurface conditionSelf.
	^ aRectSurface
]

{ #category : #accessing }
PLANE >> position [
	^position
]

{ #category : #accessing }
PLANE >> position: anObject [
	position := anObject
]

{ #category : #printing }
PLANE >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'PLANE';
		cr;
		printVerbose: position
]
