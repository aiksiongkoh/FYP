Class {
	#name : #GEOMotion,
	#superclass : #GEORelativeConstraintSet,
	#instVars : [
		'xIJ',
		'yIJ',
		'zIJ',
		'phiIJ',
		'theIJ',
		'psiIJ'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOMotion >> cut [
	container cutMotion: self.
	super cut
]

{ #category : #accessing }
GEOMotion >> functionParser [
	| parser |
	parser := MotionFunctionParser new.
	parser container: self.
	parser initVariables.
	^parser
]

{ #category : #testing }
GEOMotion >> isMotion [
	^true
]

{ #category : #'ops on self' }
GEOMotion >> magnifySelf: aDouble [ 
	xIJ ifNotNil: [xIJ magnifySelf: aDouble].
	yIJ ifNotNil: [xIJ magnifySelf: aDouble].
	zIJ ifNotNil: [xIJ magnifySelf: aDouble]
]

{ #category : #accessing }
GEOMotion >> phiIJ [
	^phiIJ
]

{ #category : #accessing }
GEOMotion >> phiIJ1 [
	| coeffs phiIJcopy |
	^phiIJ isNil
		ifTrue: ['']
		ifFalse: [phiIJ isCharacters
				ifTrue: [phiIJ]
				ifFalse: 
					["For backward compatibility"
					phiIJcopy := phiIJ copy.
					coeffs := phiIJcopy coeffs collect: [:coeff | coeff value radiansToDegrees].
					phiIJcopy coeffs: coeffs.
					phiIJcopy displayString]]
]

{ #category : #accessing }
GEOMotion >> phiIJ: function [ 
	phiIJ := function
]

{ #category : #accessing }
GEOMotion >> psiIJ [
	^psiIJ
]

{ #category : #accessing }
GEOMotion >> psiIJ: function [ 
	psiIJ := function
]

{ #category : #accessing }
GEOMotion >> theIJ [
	^theIJ
]

{ #category : #accessing }
GEOMotion >> theIJ: function [ 
	theIJ := function
]

{ #category : #accessing }
GEOMotion >> uncut [
	container addMotion: self
]

{ #category : #accessing }
GEOMotion >> xIJ [
	^xIJ
]

{ #category : #accessing }
GEOMotion >> xIJ: function [ 
	xIJ := function
]

{ #category : #accessing }
GEOMotion >> yIJ [
	^yIJ
]

{ #category : #accessing }
GEOMotion >> yIJ: function [ 
	yIJ := function
]

{ #category : #accessing }
GEOMotion >> zIJ [
	^zIJ
]

{ #category : #accessing }
GEOMotion >> zIJ1 [
	^zIJ isNil
		ifTrue: ['']
		ifFalse: ["For backward compatibility"
			zIJ displayString]
]

{ #category : #accessing }
GEOMotion >> zIJ: function [ 
	zIJ := function
]
