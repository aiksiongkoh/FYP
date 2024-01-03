Class {
	#name : #'QUASI_UNIFORM_CURVE',
	#superclass : #'B_SPLINE_CURVE',
	#category : #'StCAD-UI-STEP'
}

{ #category : #'As yet unclassified' }
QUASI_UNIFORM_CURVE >> cControlPoint [

	^ StCAD_Math_FullColumn
		  fromCollection: control_points_list
		  aBlock: [ :a | a xyzPoint ] "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn"
]

{ #category : #'As yet unclassified' }
QUASI_UNIFORM_CURVE >> uDegree [
	^degree
]

{ #category : #accessing }
QUASI_UNIFORM_CURVE >> xyzCurve [

	| aNurbsCurve |
	aNurbsCurve := StCAD_Geo_NurbsCurve
		               fromcControlPoint: self cControlPoint
		               uDegree: self uDegree. "VW_TRANSLATION:StCAD.Geo.NurbsCurve:StCAD_Geo_NurbsCurve"
	self assert: [ aNurbsCurve isOK ].
	^ aNurbsCurve
		  normalizeKnots;
		  yourself
]

{ #category : #'As yet unclassified' }
QUASI_UNIFORM_CURVE >> xyzCurveFrom: aEDGE_CURVE [ 
	^self xyzCurve
]
