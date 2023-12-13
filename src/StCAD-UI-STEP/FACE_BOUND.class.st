Class {
	#name : #'FACE_BOUND',
	#superclass : #'TOPOLOGICAL_REPRESENTATION_ITEM',
	#instVars : [
		'bound',
		'orientation'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
FACE_BOUND class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #'As yet unclassified' }
FACE_BOUND >> aBoundingBox [
	^bound aBoundingBox
]

{ #category : #accessing }
FACE_BOUND >> bound [
	^bound
]

{ #category : #accessing }
FACE_BOUND >> bound: anObject [
	bound := anObject
]

{ #category : #'As yet unclassified' }
FACE_BOUND >> boundConicalSurface: aConicalSurface [ 
	bound boundConicalSurface: aConicalSurface
]

{ #category : #'As yet unclassified' }
FACE_BOUND >> boundCylindricalSurface: aCylindricalSurface [ 
	bound boundCylindricalSurface: aCylindricalSurface
]

{ #category : #'As yet unclassified' }
FACE_BOUND >> boundNurbsSurface: aNurbsSurface [ 
	bound boundNurbsSurface: aNurbsSurface
]

{ #category : #'As yet unclassified' }
FACE_BOUND >> boundRectSurface: aRectSurface [ 
	bound boundRectSurface: aRectSurface
]

{ #category : #'As yet unclassified' }
FACE_BOUND >> boundSphericalSurface: aSphericalSurface [ 
	bound boundSphericalSurface: aSphericalSurface
]

{ #category : #'As yet unclassified' }
FACE_BOUND >> boundSurfaceOfRevolution: aSurfaceOfRevolution [ 
	bound boundSurfaceOfRevolution: aSurfaceOfRevolution
]

{ #category : #'As yet unclassified' }
FACE_BOUND >> boundSweep: aSweep [ 
	bound boundSweep: aSweep
]

{ #category : #'As yet unclassified' }
FACE_BOUND >> boundToroidalSurface: aToroidalSurface [ 
	bound boundToroidalSurface: aToroidalSurface
]

{ #category : #accessing }
FACE_BOUND >> cCurve [
	| answer |
	answer := bound cCurve.
	^orientation 
		ifTrue: [answer]
		ifFalse: [answer reverse collect: [:a | a reverse]]
]

{ #category : #'As yet unclassified' }
FACE_BOUND >> cCurve1 [
	| answer |
	answer := bound cCurve.
	^orientation ifTrue: [answer] ifFalse: [answer reverse]
]

{ #category : #accessing }
FACE_BOUND >> cPoint [
	| answer startPoint |
	answer := bound cPoint.
	^orientation 
		ifTrue: [answer]
		ifFalse: 
			[answer := answer reverse.
			startPoint := answer removeLast.
			answer addFirst: startPoint.
			answer]
]

{ #category : #accessing }
FACE_BOUND >> hasVERTEX_POINT: aVERTEX_POINT tol: tol [ 
	^bound hasVERTEX_POINT: aVERTEX_POINT tol: tol
]

{ #category : #accessing }
FACE_BOUND >> orientation [
	^orientation
]

{ #category : #accessing }
FACE_BOUND >> orientation: anObject [
	orientation := anObject
]

{ #category : #printing }
FACE_BOUND >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'FACE_BOUND';
		cr;
		nextPutAll: 'orientation = ';
		printVerbose: orientation;
		cr;
		printVerbose: bound
]

{ #category : #accessing }
FACE_BOUND >> size [
	^bound size
]

{ #category : #accessing }
FACE_BOUND >> startPoint [
	^orientation ifTrue: [bound startPoint] ifFalse: [bound endPoint]
]
