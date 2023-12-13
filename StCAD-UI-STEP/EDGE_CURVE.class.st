"
same-sense is for the direction of the curve relative to the equation.
"
Class {
	#name : #'EDGE_CURVE',
	#superclass : #EDGE,
	#instVars : [
		'edge_geometry',
		'same_sense'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
EDGE_CURVE class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
EDGE_CURVE >> edge_end [
	^edge_end
]

{ #category : #accessing }
EDGE_CURVE >> edge_end: anObject [
	edge_end := anObject
]

{ #category : #accessing }
EDGE_CURVE >> edge_geometry [
	edge_geometry isSequenceable 
		ifTrue: 
			[| cClass aCURVE |
			cClass := OrderedCollection new: 4.
			cClass add: RATIONAL_B_SPLINE_CURVE.
			cClass add: B_SPLINE_CURVE_WITH_KNOTS.
			cClass detect: 
					[:aClass | 
					aCURVE := edge_geometry detect: [:a | a isMemberOf: aClass] ifNone: nil.
					aCURVE ~~ nil].
			aCURVE fillWith: edge_geometry.
			edge_geometry := aCURVE].
	^edge_geometry
]

{ #category : #accessing }
EDGE_CURVE >> edge_geometry: anObject [
	edge_geometry := anObject
]

{ #category : #accessing }
EDGE_CURVE >> edge_start [
	^edge_start
]

{ #category : #accessing }
EDGE_CURVE >> edge_start: anObject [
	edge_start := anObject
]

{ #category : #accessing }
EDGE_CURVE >> endPoint [
	^edge_end aPoint
]

{ #category : #accessing }
EDGE_CURVE >> hasVERTEX_POINT: aVERTEX_POINT tol: tol [ 
	(edge_start hasVERTEX_POINT: aVERTEX_POINT tol: tol) ifTrue: [^true].
	(edge_end hasVERTEX_POINT: aVERTEX_POINT tol: tol) ifTrue: [^true].
	^false
]

{ #category : #printing }
EDGE_CURVE >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'EDGE_CURVE';
		cr;
		nextPutAll: 'edge_start = ';
		printVerbose: edge_start;
		cr;
		nextPutAll: 'edge_end = ';
		printVerbose: edge_end;
		cr;
		printVerbose: edge_geometry;
		cr;
		nextPutAll: 'same_sense = ';
		printVerbose: same_sense
]

{ #category : #accessing }
EDGE_CURVE >> same_sense [
	^same_sense
]

{ #category : #accessing }
EDGE_CURVE >> same_sense: anObject [
	same_sense := anObject
]

{ #category : #accessing }
EDGE_CURVE >> startPoint [
	^edge_start aPoint
]

{ #category : #accessing }
EDGE_CURVE >> xyzCurve [
	| xyzCurve |
	xyzCurve := self edge_geometry xyzCurveFrom: self.
	^same_sense ifTrue: [xyzCurve] ifFalse: [xyzCurve reverse]
]

{ #category : #accessing }
EDGE_CURVE >> xyzEnd [
	^edge_end xyzPoint
]

{ #category : #accessing }
EDGE_CURVE >> xyzStart [
	^edge_start xyzPoint
]
