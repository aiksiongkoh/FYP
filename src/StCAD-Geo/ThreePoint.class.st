Class {
	#name : #ThreePoint,
	#superclass : #Combination,
	#instVars : [
		'a1Point',
		'a2Point',
		'a3Point'
	],
	#category : #'StCAD-Geo'
}

{ #category : #'instance creation' }
ThreePoint class >> a1Point: a1Point a2Point: a2Point a3Point: a3Point [ 
	^(self new)
		a1Point: a1Point;
		a2Point: a2Point;
		a3Point: a3Point;
		yourself
]

{ #category : #'VisualWorks metadata' }
ThreePoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
ThreePoint >> a1Point [
	^a1Point
]

{ #category : #accessing }
ThreePoint >> a1Point: anObject [
	a1Point := anObject
]

{ #category : #accessing }
ThreePoint >> a2Point [
	^a2Point
]

{ #category : #accessing }
ThreePoint >> a2Point: anObject [
	a2Point := anObject
]

{ #category : #accessing }
ThreePoint >> a3Point [
	^a3Point
]

{ #category : #accessing }
ThreePoint >> a3Point: anObject [
	a3Point := anObject
]

{ #category : #accessing }
ThreePoint >> center_r_angleS_angleE [
	"Answer radius and center of circle passing through three points."

	| x1 y1 x2 y2 x3 y3 a b c d e f g cx cy r inf angleS angleE posDir aStartTangent temp |
	x1 := a1Point at: 1.
	y1 := a1Point at: 2.
	x2 := a2Point at: 1.
	y2 := a2Point at: 2.
	x3 := a3Point at: 1.
	y3 := a3Point at: 2.
	a := x2 - x1.
	b := y2 - y1.
	c := x3 - x1.
	d := y3 - y1.
	e := a * (x1 + x2) + (b * (y1 + y2)).
	f := c * (x1 + x3) + (d * (y1 + y3)).
	g := 2 * (a * (y3 - y2) - (b * (x3 - x2))).
	g abs > 0.0d 
		ifTrue: 
			[cx := (d * e - (b * f)) / g.
			cy := (a * f - (c * e)) / g.
			r := ((x1 - cx raisedTo: 2) + (y1 - cy raisedTo: 2)) sqrt]
		ifFalse: 
			[inf := 1.0d100.
			cx := cy := r := inf].
	angleS := Double arcTan0to2piY: y1 - cy overX: x1 - cx.
	angleE := Double arcTan0to2piY: y3 - cy overX: x3 - cx.
	posDir := (a2Point - a1Point) normalizeSelf.
	aStartTangent := FullColumn 
				with: angleS negated sin
				with: angleS cos
				with: 0.0d.
	(posDir dot: aStartTangent) positive 
		ifFalse: 
			[temp := angleS.
			angleS := angleE.
			angleE := temp].
	angleE > angleS ifFalse: [angleE := angleE + Double twoPi].
	^Array 
		with: (FullColumn 
				with: cx
				with: cy
				with: 0.0d)
		with: r
		with: angleS
		with: angleE
]
