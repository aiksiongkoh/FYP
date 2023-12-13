Class {
	#name : #Motion,
	#superclass : #RelativeConstraintSet,
	#instVars : [
		'xIJ',
		'yIJ',
		'zIJ',
		'phiIJ',
		'theIJ',
		'psiIJ'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #'VisualWorks metadata' }
Motion class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
Motion >> cut [
	aSup cutMotion: self.
	super cut
]

{ #category : #accessing }
Motion >> functionParser [
	| parser |
	parser := MotionFunctionParser new.
	parser container: self.
	parser initVariables.
	^parser.
]

{ #category : #testing }
Motion >> isMotion [
	^true
]

{ #category : #accessing }
Motion >> phiIJ [
	^phiIJ
]

{ #category : #accessing }
Motion >> phiIJ1 [
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
Motion >> phiIJ: function [ 
	phiIJ := function
]

{ #category : #accessing }
Motion >> psiIJ [
	^psiIJ
]

{ #category : #accessing }
Motion >> psiIJ: function [ 
	psiIJ := function
]

{ #category : #accessing }
Motion >> theIJ [
	^theIJ
]

{ #category : #accessing }
Motion >> theIJ: function [ 
	theIJ := function
]

{ #category : #accessing }
Motion >> uncut [
	aSup addMotion: self
]

{ #category : #accessing }
Motion >> xIJ [
	^xIJ
]

{ #category : #accessing }
Motion >> xIJ: function [ 
	xIJ := function
]

{ #category : #accessing }
Motion >> yIJ [
	^yIJ
]

{ #category : #accessing }
Motion >> yIJ: function [ 
	yIJ := function
]

{ #category : #accessing }
Motion >> zIJ [
	^zIJ
]

{ #category : #accessing }
Motion >> zIJ1 [
	^zIJ isNil
		ifTrue: ['']
		ifFalse: ["For backward compatibility"
			zIJ displayString]
]

{ #category : #accessing }
Motion >> zIJ: function [ 
	zIJ := function
]
