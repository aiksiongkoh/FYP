Class {
	#name : #'ORIENTED_EDGE',
	#superclass : #EDGE,
	#instVars : [
		'edge_element',
		'orientation',
		'xyzCurve'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
ORIENTED_EDGE >> _xyzCurve [
	xyzCurve := orientation 
				ifTrue: [edge_element xyzCurve]
				ifFalse: [edge_element xyzCurve reverse].
	^xyzCurve
]

{ #category : #accessing }
ORIENTED_EDGE >> aCurve [
	"Dummy method template.  This was installed by the debugger
	define method command."

	^self halt
]

{ #category : #accessing }
ORIENTED_EDGE >> aPoint [
	"Dummy method template.  This was installed by the debugger
	define method command."

	^self halt
]

{ #category : #accessing }
ORIENTED_EDGE >> boundConicalSurface: aConicalSurface [ 
	self assert: [edge_start isNil].
	self assert: [edge_end isNil].
	self xyzCurve boundConicalSurface: aConicalSurface
]

{ #category : #accessing }
ORIENTED_EDGE >> boundCylindricalSurface: aCylindricalSurface [ 
	self assert: [edge_start isNil].
	self assert: [edge_end isNil].
	self xyzCurve boundCylindricalSurface: aCylindricalSurface
]

{ #category : #accessing }
ORIENTED_EDGE >> boundNurbsSurface: aNurbsSurface [ 
	self assert: [edge_start isNil].
	self assert: [edge_end isNil].
	self xyzCurve boundNurbsSurface: aNurbsSurface
]

{ #category : #accessing }
ORIENTED_EDGE >> boundRectSurface: aRectSurface [ 
	self assert: [edge_start isNil].
	self assert: [edge_end isNil].
	self xyzCurve boundRectSurface: aRectSurface
]

{ #category : #accessing }
ORIENTED_EDGE >> boundSphericalSurface: aSphericalSurface [ 
	self assert: [edge_start isNil].
	self assert: [edge_end isNil].
	self xyzCurve boundSphericalSurface: aSphericalSurface
]

{ #category : #accessing }
ORIENTED_EDGE >> boundSurfaceOfRevolution: aSurfaceOfRevolution [ 
	self assert: [edge_start isNil].
	self assert: [edge_end isNil].
	self xyzCurve boundSurfaceOfRevolution: aSurfaceOfRevolution
]

{ #category : #'As yet unclassified' }
ORIENTED_EDGE >> boundSweep: aSweep [ 
	self assert: [edge_start isNil].
	self assert: [edge_end isNil].
	self xyzCurve boundSweep: aSweep
]

{ #category : #accessing }
ORIENTED_EDGE >> boundToroidalSurface: aToroidalSurface [ 
	self assert: [edge_start isNil].
	self assert: [edge_end isNil].
	self xyzCurve boundToroidalSurface: aToroidalSurface
]

{ #category : #accessing }
ORIENTED_EDGE >> edge_element [
	^edge_element
]

{ #category : #accessing }
ORIENTED_EDGE >> edge_element: anObject [
	edge_element := anObject
]

{ #category : #accessing }
ORIENTED_EDGE >> edge_end [
	^edge_end
]

{ #category : #accessing }
ORIENTED_EDGE >> edge_end: anObject [
	edge_end := anObject
]

{ #category : #accessing }
ORIENTED_EDGE >> edge_start [
	^edge_start
]

{ #category : #accessing }
ORIENTED_EDGE >> edge_start: anObject [
	edge_start := anObject
]

{ #category : #'As yet unclassified' }
ORIENTED_EDGE >> endPoint [
	^orientation 
		ifTrue: [edge_element endPoint]
		ifFalse: [edge_element startPoint]
]

{ #category : #accessing }
ORIENTED_EDGE >> hasVERTEX_POINT: aVERTEX_POINT tol: tol [ 
	^edge_element hasVERTEX_POINT: aVERTEX_POINT tol: tol
]

{ #category : #accessing }
ORIENTED_EDGE >> orientation [
	^orientation
]

{ #category : #accessing }
ORIENTED_EDGE >> orientation: anObject [
	orientation := anObject
]

{ #category : #printing }
ORIENTED_EDGE >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'ORIENTED_EDGE';
		cr;
		nextPutAll: 'orientation = ';
		printVerbose: orientation;
		cr;
		printVerbose: edge_element
]

{ #category : #accessing }
ORIENTED_EDGE >> startPoint [
	^orientation 
		ifTrue: [edge_element startPoint]
		ifFalse: [edge_element endPoint]
]

{ #category : #accessing }
ORIENTED_EDGE >> xyzCurve [
	^xyzCurve ifNil: [self _xyzCurve]
]
