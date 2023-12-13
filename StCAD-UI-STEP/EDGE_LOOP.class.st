Class {
	#name : #'EDGE_LOOP',
	#superclass : #Item,
	#instVars : [
		'edge_list'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
EDGE_LOOP class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #'As yet unclassified' }
EDGE_LOOP >> aBoundingBox [

	| aBoundingBox |
	aBoundingBox := StCAD_Misc_BoundingBox new. "VW_TRANSLATION:StCAD.Misc.BoundingBox:StCAD_Misc_BoundingBox"
	self cPoint
		inject: aBoundingBox
		into: [ :bbox :aPoint | bbox expandToBound: aPoint ].
	^ aBoundingBox
]

{ #category : #accessing }
EDGE_LOOP >> boundConicalSurface: aConicalSurface [ 
	edge_list do: [:edge | edge boundConicalSurface: aConicalSurface]
]

{ #category : #accessing }
EDGE_LOOP >> boundCylindricalSurface: aCylindricalSurface [ 
	edge_list do: [:edge | edge boundCylindricalSurface: aCylindricalSurface]
]

{ #category : #accessing }
EDGE_LOOP >> boundNurbsSurface: aNurbsSurface [ 
	edge_list do: [:edge | edge boundNurbsSurface: aNurbsSurface]
]

{ #category : #accessing }
EDGE_LOOP >> boundRectSurface: aRectSurface [ 
	edge_list do: [:edge | edge boundRectSurface: aRectSurface]
]

{ #category : #accessing }
EDGE_LOOP >> boundSphericalSurface: aSphericalSurface [ 
	edge_list do: [:edge | edge boundSphericalSurface: aSphericalSurface]
]

{ #category : #accessing }
EDGE_LOOP >> boundSurfaceOfRevolution: aSurfaceOfRevolution [ 
	edge_list 
		do: [:edge | edge boundSurfaceOfRevolution: aSurfaceOfRevolution]
]

{ #category : #'As yet unclassified' }
EDGE_LOOP >> boundSweep: aSweep [ 
	edge_list do: [:edge | edge boundSweep: aSweep]
]

{ #category : #accessing }
EDGE_LOOP >> boundToroidalSurface: aToroidalSurface [ 
	edge_list do: [:edge | edge boundToroidalSurface: aToroidalSurface]
]

{ #category : #accessing }
EDGE_LOOP >> cCurve [
	^edge_list collect: [:edge | edge xyzCurve]
]

{ #category : #accessing }
EDGE_LOOP >> cPoint [
	^edge_list collect: [:edge | edge startPoint]
]

{ #category : #accessing }
EDGE_LOOP >> edge_list [
	^edge_list
]

{ #category : #accessing }
EDGE_LOOP >> edge_list: anObject [
	edge_list := anObject
]

{ #category : #'As yet unclassified' }
EDGE_LOOP >> endPoint [
	^edge_list last endPoint
]

{ #category : #accessing }
EDGE_LOOP >> hasVERTEX_POINT: aVERTEX_POINT tol: tol [ 
	edge_list 
		do: [:aORIENTED_EDGE | (aORIENTED_EDGE hasVERTEX_POINT: aVERTEX_POINT tol: tol) ifTrue: [^true]].
	^false
]

{ #category : #printing }
EDGE_LOOP >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'EDGE_LOOP';
		cr;
		printVerbose: edge_list
]

{ #category : #accessing }
EDGE_LOOP >> size [
	^edge_list size
]

{ #category : #accessing }
EDGE_LOOP >> startPoint [
	^edge_list first startPoint
]
