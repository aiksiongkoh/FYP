Class {
	#name : #GEOEquationCurve,
	#superclass : #GEOCurve,
	#instVars : [
		'rfpfEqn'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOEquationCurve >> renderOn: aRenderingContext withCurveMarker: aCurveMarker [ 
	aRenderingContext pushTransformation: refFrame aMFf
		while: 
			["aRenderingContext paint: self paint"

			aRenderingContext displayLines: rfpfEqn ys.
			aCurveMarker basicRenderOn: aRenderingContext]
]

{ #category : #accessing }
GEOEquationCurve >> rfpfEqn [
	^rfpfEqn
]

{ #category : #accessing }
GEOEquationCurve >> rfpfEqn: eqn [ 
	rfpfEqn := eqn
]

{ #category : #accessing }
GEOEquationCurve >> rfpointsf [
	| nseg ds rfpointsf s |
	nseg := 256.
	ds := 2.0d / nseg.
	rfpointsf := MathArray new: nseg + 1.
	1 to: nseg
		do: 
			[:i | 
			s := -1.0d + (i - 1 * ds).
			rfpointsf at: i put: (rfpfEqn y: s)].
	rfpointsf at: nseg + 1 put: (rfpointsf at: 1).
	^rfpointsf
]
