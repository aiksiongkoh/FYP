Class {
	#name : #'VERTEX_POINT',
	#superclass : #VERTEX,
	#instVars : [
		'vertex_geometry'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
VERTEX_POINT >> aPoint [
	^vertex_geometry aPoint
]

{ #category : #accessing }
VERTEX_POINT >> hasVERTEX_POINT: aVERTEX_POINT tol: tol [ 
	^vertex_geometry aPoint equal: aVERTEX_POINT tol: tol
]

{ #category : #printing }
VERTEX_POINT >> printVerboseOn: aStream [ 
	aStream printVerbose: vertex_geometry
]

{ #category : #accessing }
VERTEX_POINT >> vertex_geometry [
	^vertex_geometry
]

{ #category : #accessing }
VERTEX_POINT >> vertex_geometry: anObject [
	vertex_geometry := anObject
]

{ #category : #accessing }
VERTEX_POINT >> xyzPoint [
	^vertex_geometry xyzPoint
]
