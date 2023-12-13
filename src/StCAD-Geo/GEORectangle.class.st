Class {
	#name : #GEORectangle,
	#superclass : #GEOCurve,
	#instVars : [
		'xLength',
		'yLength'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'instance creation' }
GEORectangle class >> minCorner: min maxCorner: max [ 
	^self new minCorner: min maxCorner: max
]

{ #category : #'VisualWorks metadata' }
GEORectangle class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #testing }
GEORectangle >> isClosed [
	^true
]

{ #category : #accessing }
GEORectangle >> magnifySelf: aDouble [ 
	self aRefFrame magnifySelf: aDouble.
	xLength := xLength * aDouble.
	yLength := yLength * aDouble
]

{ #category : #accessing }
GEORectangle >> maxCorner [
	^refFrame rFfF + (refFrame aAFf timesFullColumn: (FullColumn
				with: xLength
				with: yLength
				with: 0.0d))
]

{ #category : #accessing }
GEORectangle >> maxCorner: max [ 
	self minCorner: self minCorner maxCorner: max
]

{ #category : #accessing }
GEORectangle >> minCorner [
	^refFrame rFfF
]

{ #category : #accessing }
GEORectangle >> minCorner: min [ 
	self minCorner: min maxCorner: self maxCorner
]

{ #category : #accessing }
GEORectangle >> minCorner: min maxCorner1: max [ 
	| rMinMaxF rMinMaxf |
	refFrame rFfF: min.
	rMinMaxF := max - min.
	rMinMaxf := refFrame aAFf transposeTimesFullColumn: rMinMaxF.
	xLength := rMinMaxf at: 1.
	yLength := rMinMaxf at: 2.
	self changed
]

{ #category : #accessing }
GEORectangle >> minCorner: min maxCorner: max [ 
	| rMinMaxF rMinMaxf |
	refFrame rFfF: min.
	rMinMaxF := max - min.
	rMinMaxf := refFrame aAFf transposeTimesFullColumn: rMinMaxF.
	rMinMaxf := rMinMaxf max: (FullColumn zero: 3).
	xLength := rMinMaxf at: 1.
	yLength := rMinMaxf at: 2.
	self changed
]

{ #category : #accessing }
GEORectangle >> rfpointsf [
	| rfpointsf |
	rfpointsf := MathArray new: 5.
	rfpointsf at: 1 put: (FullColumn zero: 3).
	rfpointsf at: 2 put: (FullColumn
			with: xLength
			with: 0.0d
			with: 0.0d).
	rfpointsf at: 3 put: (FullColumn
			with: xLength
			with: yLength
			with: 0.0d).
	rfpointsf at: 4 put: (FullColumn
			with: 0.0d
			with: yLength
			with: 0.0d).
	rfpointsf at: 5 put: (rfpointsf at: 1).
	^rfpointsf
]

{ #category : #printing }
GEORectangle >> storeOn: aStream level: level [ 
	aStream storeLevel: level title: 'Rectangle'.
	self refFrame store2DOn: aStream level: level + 1.
	aStream
		storeLevel: level + 1
		title: 'xLength'
		object: xLength.
	aStream
		storeLevel: level + 1
		title: 'yLength'
		object: yLength
]

{ #category : #accessing }
GEORectangle >> theta: angle [ 
	| aA cosAngle sinAngle |
	aA := (FullMatrix zero: 3 by: 3).
	cosAngle := angle cos.
	sinAngle := angle sin.
	aA at: 1 and: 1 put: cosAngle.
	aA at: 1 and: 2 put: sinAngle negated.
	aA at: 2 and: 1 put: sinAngle.
	aA at: 2 and: 2 put: cosAngle.
	aA at: 3 and: 3 put: 1.0d.
	refFrame aAFf: aA.
	self changed
]

{ #category : #accessing }
GEORectangle >> xLength [
	^xLength
]

{ #category : #accessing }
GEORectangle >> xLength: double [ 
	xLength := double
]

{ #category : #accessing }
GEORectangle >> yLength [
	^yLength
]

{ #category : #accessing }
GEORectangle >> yLength: double [ 
	yLength := double
]
