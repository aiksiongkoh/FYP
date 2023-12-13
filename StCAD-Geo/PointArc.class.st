Class {
	#name : #PointArc,
	#superclass : #Combination,
	#instVars : [
		'aCenter',
		'aRadius',
		'aStartAngle',
		'aEndAngle',
		'aPar',
		'bPoint',
		'bAngle',
		'aClosestPoint',
		'aRightDist',
		'aMinDist'
	],
	#category : #'StCAD-Geo'
}

{ #category : #'instance creation' }
PointArc class >> aCenter: aCenter aRadius: aRadius aStartAngle: aStartAngle aEndAngle: aEndAngle bPoint: bPoint [ 
	^(super new)
		aCenter: aCenter
			aRadius: aRadius
			aStartAngle: aStartAngle
			aEndAngle: aEndAngle
			bPoint: bPoint;
		calc;
		yourself
]

{ #category : #'VisualWorks metadata' }
PointArc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
PointArc >> aCenter: aFullColumn aRadius: aDouble aStartAngle: argStartAngle aEndAngle: argEndAngle bPoint: bFullColumn [ 
	aCenter := aFullColumn.
	aRadius := aDouble.
	aStartAngle := argStartAngle.
	aEndAngle := argEndAngle.
	bPoint := bFullColumn
]

{ #category : #accessing }
PointArc >> aClosestPoint [
	^aClosestPoint
]

{ #category : #accessing }
PointArc >> aMinDist [
	^aMinDist
]

{ #category : #accessing }
PointArc >> aPar [
	^aPar
]

{ #category : #accessing }
PointArc >> aRightDist [
	^aRightDist
]

{ #category : #accessing }
PointArc >> bAngle [
	^bAngle
]

{ #category : #'initialize-release' }
PointArc >> calc [
	| delta dist a1Par a2Par |
	aEndAngle > aStartAngle ifFalse: [self error: 'Check this.'].
	delta := bPoint - aCenter.
	dist := delta length.
	bAngle := Double arcTan0to2piY: (delta at: 2) overX: (delta at: 1).
	a1Par := (bAngle - aStartAngle) / (aEndAngle - aStartAngle).
	a2Par := (bAngle + TwoPi - aStartAngle) / (aEndAngle - aStartAngle).
	aPar := (a1Par - 0.5d) abs < (a2Par - 0.5d) abs 
				ifTrue: [a1Par]
				ifFalse: [a2Par].
	aRightDist := dist - aRadius.
	aMinDist := aRightDist abs.
	aClosestPoint := aCenter + (CoordinateFrame 
						xyz_r: aRadius
						theta: bAngle
						z: 0.0d)
]
