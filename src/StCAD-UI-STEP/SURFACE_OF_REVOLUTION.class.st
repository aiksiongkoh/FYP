Class {
	#name : #'SURFACE_OF_REVOLUTION',
	#superclass : #'SWEPT_SURFACE',
	#instVars : [
		'axis_position'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
SURFACE_OF_REVOLUTION >> aAFf [

	| cPoint sum_rFpF xPoint |
	cPoint := swept_curve xyzCurve cPoint.
	sum_rFpF := cPoint
		            inject: (StCAD_Math_FullColumn zero: 3)
		            into: [ :subTotal :next | subTotal + next ]. "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn"
	xPoint := (sum_rFpF magnifySelf: cPoint size asDouble reciprocal)
	          - self rFfF.
	^ StCAD_Math_FullMatrix
		  rotationMatrixFromzDir: self zDir
		  xDir: xPoint normalizeSelf "VW_TRANSLATION:StCAD.Math.FullMatrix:StCAD_Math_FullMatrix"
]

{ #category : #accessing }
SURFACE_OF_REVOLUTION >> aSurfaceWithBounds: cFACE_BOUND [

	| aSurfaceOfRevolution aRefFrame rFcurveF |
	aSurfaceOfRevolution := StCAD_Geo_SurfaceOfRevolution new. "VW_TRANSLATION:StCAD.Geo.SurfaceOfRevolution:StCAD_Geo_SurfaceOfRevolution"
	aSurfaceOfRevolution name: name.
	aRefFrame := StCAD_Geo_CartesianFrame new. "VW_TRANSLATION:StCAD.Geo.CartesianFrame:StCAD_Geo_CartesianFrame"
	aRefFrame rFfF: self rFfF.
	aRefFrame aAFf: self aAFf.
	rFcurveF := swept_curve xyzCurve.
	rFcurveF cPoint:
		(rFcurveF cPoint collect: [ :aPoint | 
			 aRefFrame rfpffromrFpF: aPoint ]).
	aSurfaceOfRevolution _aCurve: rFcurveF.
	aSurfaceOfRevolution aRefFrame copyrFfFandAFfFrom: aRefFrame.
	cFACE_BOUND do: [ :aFACE_BOUND | 
		aFACE_BOUND boundSurfaceOfRevolution: aSurfaceOfRevolution ].
	^ aSurfaceOfRevolution
]

{ #category : #accessing }
SURFACE_OF_REVOLUTION >> axis_position [
	^axis_position
]

{ #category : #accessing }
SURFACE_OF_REVOLUTION >> axis_position: anObject [
	axis_position := anObject
]

{ #category : #accessing }
SURFACE_OF_REVOLUTION >> rFfF [
	^axis_position rFfF
]

{ #category : #accessing }
SURFACE_OF_REVOLUTION >> zDir [
	^axis_position zDir
]
