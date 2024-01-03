Class {
	#name : #ELLIPSE,
	#superclass : #CONIC,
	#instVars : [
		'semi_axis_1',
		'semi_axis_2'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
ELLIPSE >> semi_axis_1 [
	^semi_axis_1
]

{ #category : #accessing }
ELLIPSE >> semi_axis_1: anObject [
	semi_axis_1 := anObject
]

{ #category : #accessing }
ELLIPSE >> semi_axis_2 [
	^semi_axis_2
]

{ #category : #accessing }
ELLIPSE >> semi_axis_2: anObject [
	semi_axis_2 := anObject
]

{ #category : #calc }
ELLIPSE >> xyzCurveFrom: aEDGE_CURVE [

	| aEllipticArc rFstartF rFendF |
	aEllipticArc := StCAD_Geo_EllipticArc new. "VW_TRANSLATION:StCAD.Geo.EllipticArc:StCAD_Geo_EllipticArc"
	aEllipticArc xRadius: semi_axis_1.
	aEllipticArc yRadius: semi_axis_2.
	aEllipticArc aRefFrame copyrFfFandAFfFrom: position aRefFrame.
	aEDGE_CURVE same_sense
		ifTrue: [ 
			rFstartF := aEDGE_CURVE xyzStart.
			rFendF := aEDGE_CURVE xyzEnd ]
		ifFalse: [ 
			rFstartF := aEDGE_CURVE xyzEnd.
			rFendF := aEDGE_CURVE xyzStart ].
	aEllipticArc _rFstartF: rFstartF.
	aEllipticArc _rFendF: rFendF.
	aEllipticArc conditionSelf.
	self assert: [ aEllipticArc isOK ].
	^ aEllipticArc
]
