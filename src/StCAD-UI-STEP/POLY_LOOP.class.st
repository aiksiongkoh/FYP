Class {
	#name : #'POLY_LOOP',
	#superclass : #LOOP,
	#instVars : [
		'polygon'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #ops }
POLY_LOOP >> boundRectSurface: aRectSurface [ 
	self cCurve do: [:edge | edge boundRectSurface: aRectSurface]

	"@__markp	11/14/2009 09:00:12 pm"
]

{ #category : #accessing }
POLY_LOOP >> cCurve [

	| answer aLine |
	answer := polygon copyEmpty.
	1 to: polygon size do: [ :i | 
		aLine := StCAD_Geo_Line new
			         rfstartf: (polygon at: i) aPoint;
			         rfendf: (polygon cyclic_at: i + 1) aPoint;
			         yourself. "VW_TRANSLATION:StCAD.Geo.Line:StCAD_Geo_Line"
		answer add: aLine ].
	^ answer

	"@__markp	11/14/2009 08:59:23 pm"
]

{ #category : #accessing }
POLY_LOOP >> cPoint [
	^polygon collect: [:vertex | vertex aPoint copy]

	"@__markp	11/14/2009 08:58:30 pm"
]

{ #category : #accessing }
POLY_LOOP >> polygon [
	^polygon
]

{ #category : #accessing }
POLY_LOOP >> polygon: anObject [
	polygon := anObject
]
