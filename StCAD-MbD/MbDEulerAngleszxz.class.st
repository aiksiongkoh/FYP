Class {
	#name : #MbDEulerAngleszxz,
	#superclass : #EulerArray,
	#type : #variable,
	#instVars : [
		'phiA',
		'theA',
		'psiA',
		'aA'
	],
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #'instance creation' }
MbDEulerAngleszxz class >> new [
	^(super new: 3) initialize
]

{ #category : #'VisualWorks metadata' }
MbDEulerAngleszxz class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #accessing }
MbDEulerAngleszxz >> aA [
	^aA
]

{ #category : #calc }
MbDEulerAngleszxz >> calc [
	| zero phi sphi cphi the sthe cthe psi spsi cpsi |
	zero := 0.0d.
	phi := self at: 1.
	sphi := phi sin.
	cphi := phi cos.
	the := self at: 2.
	sthe := the sin.
	cthe := the cos.
	psi := self at: 3.
	spsi := psi sin.
	cpsi := psi cos.
	(phiA at: 1) at: 1 put: cphi; at: 2 put: zero - sphi.
	(phiA at: 2) at: 1 put: sphi; at: 2 put: cphi.

	(theA at: 2) at: 2 put: cthe; at: 3 put: zero - sthe.
	(theA at: 3) at: 2 put: sthe; at: 3 put: cthe.

	(psiA at: 1) at: 1 put: cpsi; at: 2 put: zero - spsi.
	(psiA at: 2) at: 1 put: spsi; at: 2 put: cpsi.

	aA := phiA timesFullMatrix: (theA timesFullMatrix: psiA)
]

{ #category : #calc }
MbDEulerAngleszxz >> calcphiAtheApsiA [
	| zero phi sphi cphi the sthe cthe psi spsi cpsi |
	zero := 0.0d.
	phi := self at: 1.
	sphi := phi sin.
	cphi := phi cos.
	the := self at: 2.
	sthe := the sin.
	cthe := the cos.
	psi := self at: 3.
	spsi := psi sin.
	cpsi := psi cos.
	(phiA at: 1) at: 1 put: cphi; at: 2 put: zero - sphi.
	(phiA at: 2) at: 1 put: sphi; at: 2 put: cphi.

	(theA at: 2) at: 2 put: cthe; at: 3 put: zero - sthe.
	(theA at: 3) at: 2 put: sthe; at: 3 put: cthe.

	(psiA at: 1) at: 1 put: cpsi; at: 2 put: zero - spsi.
	(psiA at: 2) at: 1 put: spsi; at: 2 put: cpsi
]

{ #category : #'initialize-release' }
MbDEulerAngleszxz >> initialize [
	phiA := (FullMatrix identity: 3).
	theA := (FullMatrix identity: 3).
	psiA := (FullMatrix identity: 3)
]

{ #category : #accessing }
MbDEulerAngleszxz >> phiA [
	^phiA
]

{ #category : #accessing }
MbDEulerAngleszxz >> psiA [
	^psiA
]

{ #category : #accessing }
MbDEulerAngleszxz >> theA [
	^theA
]
