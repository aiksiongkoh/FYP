Class {
	#name : #MbDEulerAngleszxzDdot,
	#superclass : #EulerArray,
	#type : #variable,
	#instVars : [
		'phiThePsiDot',
		'phiAddot',
		'theAddot',
		'psiAddot',
		'aAddot'
	],
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #accessing }
MbDEulerAngleszxzDdot >> aAddot [
	^aAddot
]

{ #category : #calc }
MbDEulerAngleszxzDdot >> calc [
	| zero phiThePsi phi sphi cphi phidot phiddot cphiddot sphiddot the sthe cthe thedot theddot ctheddot stheddot psi spsi cpsi psidot psiddot cpsiddot spsiddot phiA theA psiA phiAdot theAdot psiAdot |
	zero := 0.0d.
	phiThePsi := phiThePsiDot phiThePsi.
	phi := phiThePsi at: 1.
	sphi := phi sin.
	cphi := phi cos.
	phidot := phiThePsiDot at: 1.
	phiddot := self at: 1.
	cphiddot := zero - (sphi * phiddot) - (cphi * phidot * phidot).
	sphiddot := cphi * phiddot - (sphi * phidot * phidot).
	the := phiThePsi at: 2.
	sthe := the sin.
	cthe := the cos.
	thedot := phiThePsiDot at: 2.
	theddot := self at: 2.
	ctheddot := zero - (sthe * theddot) - (cthe * thedot * thedot).
	stheddot := cthe * theddot - (sthe * thedot * thedot).
	psi := phiThePsi at: 3.
	spsi := psi sin.
	cpsi := psi cos.
	psidot := phiThePsiDot at: 3.
	psiddot := self at: 3.
	cpsiddot := zero - (spsi * psiddot) - (cpsi * psidot * psidot).
	spsiddot := cpsi * psiddot - (spsi * psidot * psidot).
	(phiAddot at: 1) at: 1 put: cphiddot; at: 2 put: zero - sphiddot.
	(phiAddot at: 2) at: 1 put: sphiddot; at: 2 put: cphiddot.
	(theAddot at: 2) at: 2 put: ctheddot; at: 3 put: zero - stheddot.
	(theAddot at: 3) at: 2 put: stheddot; at: 3 put: ctheddot.
	(psiAddot at: 1) at: 1 put: cpsiddot; at: 2 put: zero - spsiddot.
	(psiAddot at: 2) at: 1 put: spsiddot; at: 2 put: cpsiddot.
	phiA := phiThePsi phiA.
	theA := phiThePsi theA.
	psiA := phiThePsi psiA.
	phiAdot := phiThePsiDot phiAdot.
	theAdot := phiThePsiDot theAdot.
	psiAdot := phiThePsiDot psiAdot.
	aAddot := (phiAddot timesFullMatrix: (theA timesFullMatrix: psiA))
			+ (phiAdot timesFullMatrix: (theAdot timesFullMatrix: psiA))
			+ (phiAdot timesFullMatrix: (theA timesFullMatrix: psiAdot))
			+ (phiAdot timesFullMatrix: (theAdot timesFullMatrix: psiA))
			+ (phiA timesFullMatrix: (theAddot timesFullMatrix: psiA))
			+ (phiA timesFullMatrix: (theAdot timesFullMatrix: psiAdot))
			+ (phiAdot timesFullMatrix: (theA timesFullMatrix: psiAdot))
			+ (phiA timesFullMatrix: (theAdot timesFullMatrix: psiAdot))
			+ (phiA timesFullMatrix: (theA timesFullMatrix: psiAddot))
]

{ #category : #'initialize-release' }
MbDEulerAngleszxzDdot >> initialize [
	phiAddot := (FullMatrix zero: 3 by: 3).
	theAddot := (FullMatrix zero: 3 by: 3).
	psiAddot := (FullMatrix zero: 3 by: 3)
]

{ #category : #accessing }
MbDEulerAngleszxzDdot >> phiThePsiDot [
	^phiThePsiDot
]

{ #category : #accessing }
MbDEulerAngleszxzDdot >> phiThePsiDot: col [ 
	phiThePsiDot := col
]
