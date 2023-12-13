Class {
	#name : #CIRCLE,
	#superclass : #CONIC,
	#instVars : [
		'radius'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
CIRCLE class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #printing }
CIRCLE >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'CIRCLE';
		cr;
		nextPutAll: 'radius = ';
		printVerbose: radius;
		cr;
		printVerbose: position
]

{ #category : #accessing }
CIRCLE >> radius [
	^radius
]

{ #category : #accessing }
CIRCLE >> radius: anObject [
	radius := anObject
]

{ #category : #'As yet unclassified' }
CIRCLE >> xyzCurveFrom: aEDGE_CURVE [

	| aCircularArc rFstartF rFendF |
	aCircularArc := StCAD_Geo_CircularArc new. "VW_TRANSLATION:StCAD.Geo.CircularArc:StCAD_Geo_CircularArc"
	aCircularArc _radius: radius.
	aCircularArc aRefFrame copyrFfFandAFfFrom: position aRefFrame.
	aEDGE_CURVE same_sense
		ifTrue: [ 
			rFstartF := aEDGE_CURVE xyzStart.
			rFendF := aEDGE_CURVE xyzEnd ]
		ifFalse: [ 
			rFstartF := aEDGE_CURVE xyzEnd.
			rFendF := aEDGE_CURVE xyzStart ].
	aCircularArc _rFstartF: rFstartF copy.
	aCircularArc _rFendF: rFendF copy.
	aCircularArc conditionSelf.
	self assert: [ aCircularArc isOK ].
	^ aCircularArc
]
