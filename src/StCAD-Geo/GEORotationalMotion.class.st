Class {
	#name : #GEORotationalMotion,
	#superclass : #GEOMotion,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #DYN }
GEORotationalMotion >> createMbD [
	| phiFunc parser stack func mbdZRotation |
	super createMbD.
	phiFunc := phiIJ isNil
				ifTrue: [Constant with: 0]
				ifFalse: [phiIJ isUserFunction
						ifTrue: 
							[parser := self functionParser.
							stack := parser
										parseUserFunction: phiIJ
										notifying: nil
										ifFail: nil.
							func := stack last.
							func]
						ifFalse: [phiIJ]].
	phiFunc := (phiFunc / self mbdUnits angle) createMbD simplified.
	mbdZRotation := self mbdObject.
	mbdZRotation phiBlk: phiFunc
]

{ #category : #accessing }
GEORotationalMotion >> eqnLabel [
	^'Rotation Motion Function'
]

{ #category : #accessing }
GEORotationalMotion >> explainText [
	^#'The motion constraint takes a prescribed function of time. It can accept a smooth expression created with the following operators or functions: +, -, *, /, ^ (raised to), pi, (-pi/2 <= arctan(x) <= pi/2), (-pi <= arctan2(x,y) <= pi), cos(x), exp(x), lg(x) (log base 10), ln(x) (natural log), sin(x), sqrt(x), tan(x).

You can cut, paste and modify the example functions below for use in the User Function Dialog.

Constant value function:
60.0d

Linear function with offset, 60.0d, and slope, 2.0d:
60.0d + 2.0d*time

Polynomial expression:
60.0d + 2.0d*time + 1.0d*time^2 + 0.1d*time^3

Simple harmonic motion with offset, 60.0d, amplitude, 2.0d, angular velocity, 6.0d*pi, phase lag, pi/4.0d:
60.0d + 2.0d*sin(6.0d*pi*time - pi/4.0d)

Exponential decay with initial value, 10.0d, time constant, 1.0d2:
10.0d*exp(-time/1.0d2)

CAD: Copyright (C) 2001, Aik-Siong Koh, All Rights Reserved.
'
]

{ #category : #accessing }
GEORotationalMotion >> explainTitle [
	^'Rotation Motion Function'
]

{ #category : #accessing }
GEORotationalMotion >> joint [
	^self interface jointList detect: [:joint | ((joint isMemberOf: GEORevoluteJoint)
			or: [joint isMemberOf: GEOCylindricalJoint])
			and: [joint aMarkerI == markerI and: [joint aMarkerJ == markerJ]]]
]

{ #category : #DYN }
GEORotationalMotion >> phiFunc [
	| parser stack func |
	^phiIJ isNil
		ifTrue: [Constant with: 0]
		ifFalse: [phiIJ isUserFunction
				ifTrue: 
					[parser := self functionParser.
					stack := parser
								parseUserFunction: phiIJ
								notifying: nil
								ifFail: nil.
					func := stack last.
					func]
				ifFalse: [phiIJ]]
]

{ #category : #printing }
GEORotationalMotion >> storeOn: aStream level: level [ 
	aStream storeLevel: level title: self nameString.
	aStream
		storeLevel: level + 1
		title: 'Name'
		object: self name.
	aStream
		storeLevel: level + 1
		title: 'MotionJoint'
		object: self joint fullName.
	aStream
		storeLevel: level + 1
		title: 'RotationZ'
		object: phiIJ
]

{ #category : #DYN }
GEORotationalMotion >> validateFormulas [
	self phiFunc
]
