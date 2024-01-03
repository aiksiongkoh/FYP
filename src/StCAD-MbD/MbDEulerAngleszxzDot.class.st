Class {
	#name : #MbDEulerAngleszxzDot,
	#superclass : #EulerArray,
	#type : #variable,
	#instVars : [
		'phiThePsi',
		'phiAdot',
		'theAdot',
		'psiAdot',
		'aAdot'
	],
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #accessing }
MbDEulerAngleszxzDot >> aAdot [
	^aAdot
]

{ #category : #calc }
MbDEulerAngleszxzDot >> calc [
	| zero phi sphi cphi phidot minussphiTimesphidot cphiTimesphidot the sthe cthe thedot minusstheTimesthedot ctheTimesthedot psi spsi cpsi psidot minusspsiTimespsidot cpsiTimespsidot phiA theA psiA |
	zero := 0.0d.
	phi := phiThePsi at: 1.
	sphi := phi sin.
	cphi := phi cos.
	phidot := self at: 1.
	minussphiTimesphidot := zero - (sphi * phidot).
	cphiTimesphidot := cphi * phidot.
	the := phiThePsi at: 2.
	sthe := the sin.
	cthe := the cos.
	thedot := self at: 2.
	minusstheTimesthedot := zero - (sthe * thedot).
	ctheTimesthedot := cthe * thedot.
	psi := phiThePsi at: 3.
	spsi := psi sin.
	cpsi := psi cos.
	psidot := self at: 3.
	minusspsiTimespsidot := zero - (spsi * psidot).
	cpsiTimespsidot := cpsi * psidot.
	(phiAdot at: 1) at: 1 put: minussphiTimesphidot; at: 2 put: zero - cphiTimesphidot.
	(phiAdot at: 2) at: 1 put: cphiTimesphidot; at: 2 put: minussphiTimesphidot.
	(theAdot at: 2) at: 2 put: minusstheTimesthedot; at: 3 put: zero - ctheTimesthedot.
	(theAdot at: 3) at: 2 put: ctheTimesthedot; at: 3 put: minusstheTimesthedot.
	(psiAdot at: 1) at: 1 put: minusspsiTimespsidot; at: 2 put: zero - cpsiTimespsidot.
	(psiAdot at: 2) at: 1 put: cpsiTimespsidot; at: 2 put: minusspsiTimespsidot.
	phiA := phiThePsi phiA.
	theA := phiThePsi theA.
	psiA := phiThePsi psiA.
	aAdot := (phiAdot timesFullMatrix: (theA timesFullMatrix: psiA))
			+ (phiA timesFullMatrix: (theAdot timesFullMatrix: psiA))
			+ (phiA timesFullMatrix: (theA timesFullMatrix: psiAdot))
]

{ #category : #'initialize-release' }
MbDEulerAngleszxzDot >> initialize [
	phiAdot := (FullMatrix zero: 3 by: 3).
	theAdot := (FullMatrix zero: 3 by: 3).
	psiAdot := (FullMatrix zero: 3 by: 3)
]

{ #category : #accessing }
MbDEulerAngleszxzDot >> phiAdot [
	^phiAdot
]

{ #category : #accessing }
MbDEulerAngleszxzDot >> phiThePsi [
	^phiThePsi
]

{ #category : #accessing }
MbDEulerAngleszxzDot >> phiThePsi: col [ 
	phiThePsi := col
]

{ #category : #accessing }
MbDEulerAngleszxzDot >> psiAdot [
	^psiAdot
]

{ #category : #accessing }
MbDEulerAngleszxzDot >> theAdot [
	^theAdot
]
