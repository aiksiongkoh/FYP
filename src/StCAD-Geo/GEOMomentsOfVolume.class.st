"
The volume is defined in the P frame which is usually the part frame.
I am an array of 14 elements containing:

1		vol			integ (1) dV
2		mX			integ (X) dV
3		mY			integ (Y) dV
4		mZ			integ (Z) dV
5		mXX		integ (XX) dV
6		mYY		integ (YY) dV
7		mZZ		integ (ZZ) dV
8		mXY		integ (XY) dV
9		mXZ		integ (XZ) dV
10		mYZ		integ (YZ) dV
11		rPcP		P origin to centroid in P components.
12		aJPP		moment of inertia matrix about P and its axes
13		aJpp		moment of inertia matrix about principal origin and axes
14		aAPp		{IJK}P := [aAPp] {ijk}prin
"
Class {
	#name : #GEOMomentsOfVolume,
	#superclass : #GEOItem,
	#instVars : [
		'm1',
		'mX',
		'mY',
		'mZ',
		'mXX',
		'mYY',
		'mZZ',
		'mXY',
		'mXZ',
		'mYZ',
		'rPcP',
		'aJPP',
		'aJpp',
		'aAPp'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOMomentsOfVolume >> aAPp [
	^aAPp
]

{ #category : #accessing }
GEOMomentsOfVolume >> aJPP [
	^aJPP
]

{ #category : #accessing }
GEOMomentsOfVolume >> aJpp [
	^aJpp
]

{ #category : #calc }
GEOMomentsOfVolume >> calc [
	| solver |
	self calcrPcP.
	self calcaJPP.
	solver := GEOInertiaMatrixSolver new.
	solver m: m1.
	solver aJPP: aJPP.
	solver rPcmP: rPcP.
	solver calc.
	aJpp := solver aJpp.
	aAPp := solver aAPp.
]

{ #category : #calc }
GEOMomentsOfVolume >> calcaJPP [
	aJPP := FullMatrix new: 3 by: 3.
	aJPP at: 1 and: 1 put: mYY + mZZ.
	aJPP at: 2 and: 2 put: mXX + mZZ.
	aJPP at: 3 and: 3 put: mXX + mYY.
	aJPP at: 1 and: 2 put: mXY negated.
	aJPP at: 1 and: 3 put: mXZ negated.
	aJPP at: 2 and: 3 put: mYZ negated.
	aJPP symLowerWithUpper
]

{ #category : #calc }
GEOMomentsOfVolume >> calcrPcP [
	"P to centroid in P components."

	rPcP := FullColumn
				with: mX / m1
				with: mY / m1
				with: mZ / m1
]

{ #category : #accessing }
GEOMomentsOfVolume >> magnifySelf: aDouble [ 
	| sq |
	mX := mX * aDouble.
	mY := mY * aDouble.
	mZ := mZ * aDouble.
	sq := aDouble squared.
	mXX := mXX * sq.
	mYY := mYY * sq.
	mZZ := mZZ * sq.
	mXY := mXY * sq.
	mXZ := mXZ * sq.
	mYZ := mYZ * sq.
	rPcP magnifySelf: aDouble.
	aJPP := aJPP * sq.
	aJpp := aJpp * sq
]

{ #category : #accessing }
GEOMomentsOfVolume >> moments: col [ 
	m1 := col at: 1.
	mX := col at: 2.
	mY := col at: 3.
	mZ := col at: 4.
	mXX := col at: 5.
	mYY := col at: 6.
	mZZ := col at: 7.
	mXY := col at: 8.
	mXZ := col at: 9.
	mYZ := col at: 10.
	self calc
]

{ #category : #accessing }
GEOMomentsOfVolume >> rPcP [
	^rPcP
]

{ #category : #accessing }
GEOMomentsOfVolume >> vJpp [
	^aJpp
]

{ #category : #accessing }
GEOMomentsOfVolume >> volume [
	^m1
]
