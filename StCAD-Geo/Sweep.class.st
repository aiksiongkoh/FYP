"
aCurve can be a full 3D curve. Refer to 'The NURBS Book'.
aSweep aRefFrame and trajectory aRefFrame are made coincident with the aCurve aRefFrame.

Instance Variables:
	aCurve	<Object>	description of aCurve
	trajectory	<Object>	description of trajectory


"
Class {
	#name : #Sweep,
	#superclass : #Surface,
	#instVars : [
		'aCurve',
		'trajectory'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
Sweep class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
Sweep >> _aCurve: aaCurve [ 
	aaCurve removeSup.
	super addRefFrame: aaCurve aRefFrame.
	aCurve := aaCurve.
	aaCurve aSup: self.
	^aaCurve
]

{ #category : #accessing }
Sweep >> _trajectory: aaCurve [ 
	aaCurve removeSup.
	super addRefFrame: aaCurve aRefFrame.
	trajectory := aaCurve.
	aaCurve aSup: self.
	^aaCurve
]

{ #category : #accessing }
Sweep >> aCurve [
	^aCurve
]

{ #category : #accessing }
Sweep >> cItemWithBoundingBox [
	^(OrderedCollection new: 2)
		add: aCurve;
		add: trajectory;
		yourself
]

{ #category : #calc }
Sweep >> calc [
	"Make origin of be the origin of curve. Should move in xy plane only."

	| aCurveRefFrame newrFfF newAFf |
	aCurveRefFrame := aCurve aRefFrame.
	newrFfF := aRefFrame rFfF 
				+ (aRefFrame aAFf timesFullColumn: aCurveRefFrame rFfF).
	newAFf := aRefFrame aAFf timesFullMatrix: aCurveRefFrame aAFf.
	aRefFrame rFfF: newrFfF.
	aRefFrame aAFf: newAFf.
	aCurveRefFrame fixedAtRef.
	trajectory aRefFrame fixedAtRef
]

{ #category : #accessing }
Sweep >> createNurbs [
	^NurbsSurface fromSweep: self
]

{ #category : #ops }
Sweep >> magnifySelf: aDouble [ 
	super magnifySelf: aDouble.
	aCurve magnifySelf: aDouble.
	trajectory magnifySelf: aDouble
]

{ #category : #accessing }
Sweep >> reverseSelf [
	trajectory reverseSelf
]

{ #category : #accessing }
Sweep >> trajectory [
	^trajectory
]
