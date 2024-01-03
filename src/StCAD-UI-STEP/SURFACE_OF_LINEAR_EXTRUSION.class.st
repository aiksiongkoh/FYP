Class {
	#name : #'SURFACE_OF_LINEAR_EXTRUSION',
	#superclass : #'SWEPT_SURFACE',
	#instVars : [
		'extrusion_axis'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'As yet unclassified' }
SURFACE_OF_LINEAR_EXTRUSION >> aSurfaceWithBounds1: cFACE_BOUND [

	| aSweep aRefFrame rFcurveF |
	aSweep := StCAD_Geo_Sweep new. "VW_TRANSLATION:StCAD.Geo.Sweep:StCAD_Geo_Sweep"
	aSweep name: name.
	aRefFrame := StCAD_Geo_CartesianFrame new. "VW_TRANSLATION:StCAD.Geo.CartesianFrame:StCAD_Geo_CartesianFrame"
	aRefFrame rFfF: self rFfF.
	aRefFrame aAFf: self aAFf.
	rFcurveF := swept_curve xyzCurve.
	rFcurveF cPoint:
		(rFcurveF cPoint collect: [ :aPoint | 
			 aRefFrame rfpffromrFpF: aPoint ]).
	aSweep _aCurve: rFcurveF.
	aSweep aRefFrame copyrFfFandAFfFrom: aRefFrame.
	cFACE_BOUND do: [ :aFACE_BOUND | aFACE_BOUND boundSweep: aSweep ].
	^ aSweep
]

{ #category : #'As yet unclassified' }
SURFACE_OF_LINEAR_EXTRUSION >> aSurfaceWithBounds: cFACE_BOUND [

	| aSweep aRefFrame rFcurveF trajectory |
	aSweep := StCAD_Geo_Sweep new. "VW_TRANSLATION:StCAD.Geo.Sweep:StCAD_Geo_Sweep"
	aSweep name: name.
	aRefFrame := StCAD_Geo_CartesianFrame new. "VW_TRANSLATION:StCAD.Geo.CartesianFrame:StCAD_Geo_CartesianFrame"
	aRefFrame fixedAtRef.
	rFcurveF := swept_curve xyzCurve.
	rFcurveF cPoint:
		(rFcurveF cPoint collect: [ :aPoint | 
			 aRefFrame rfpffromrFpF: aPoint ]).
	aSweep _aCurve: rFcurveF.
	trajectory := StCAD_Geo_Line new
		              rfstartf: (StCAD_Math_FullColumn zero: 3);
		              rfendf: extrusion_axis aDir;
		              yourself. "VW_TRANSLATION:StCAD.Geo.Line:StCAD_Geo_Line" "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn"
	aSweep _trajectory: trajectory.
	aSweep aRefFrame copyrFfFandAFfFrom: aRefFrame.
	cFACE_BOUND do: [ :aFACE_BOUND | aFACE_BOUND boundSweep: aSweep ].
	aSweep conditionSelf.
	^ aSweep
]

{ #category : #accessing }
SURFACE_OF_LINEAR_EXTRUSION >> extrusion_axis [
	^extrusion_axis
]

{ #category : #accessing }
SURFACE_OF_LINEAR_EXTRUSION >> extrusion_axis: anObject [
	extrusion_axis := anObject
]

{ #category : #'As yet unclassified' }
SURFACE_OF_LINEAR_EXTRUSION >> rFfF [

	^ StCAD_Math_FullColumn zero: 3 "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn"
]

{ #category : #'As yet unclassified' }
SURFACE_OF_LINEAR_EXTRUSION >> zDir [
	^extrusion_axis aDir
]
