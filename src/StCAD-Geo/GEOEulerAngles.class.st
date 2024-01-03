Class {
	#name : #GEOEulerAngles,
	#superclass : #EulerArray,
	#type : #variable,
	#instVars : [
		'aA'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOEulerAngles >> aA [
	aA == nil ifTrue: [self calc].
	^aA
]

{ #category : #calc }
GEOEulerAngles >> rotatex: the [ 
	| sthe cthe answer |
	sthe := the sin.
	cthe := the cos.
	answer := FullMatrix new: 3 by: 3.
	(answer at: 1)
		at: 1 put: 1.0d;
		at: 2 put: 0.0d;
		at: 3 put: 0.0d.
	(answer at: 2)
		at: 1 put: 0.0d;
		at: 2 put: cthe;
		at: 3 put: 0.0d - sthe.
	(answer at: 3)
		at: 1 put: 0.0d;
		at: 2 put: sthe;
		at: 3 put: cthe.
	^answer
]

{ #category : #calc }
GEOEulerAngles >> rotatey: the [ 
	| sthe cthe answer |
	sthe := the sin.
	cthe := the cos.
	answer := FullMatrix new: 3 by: 3.
	(answer at: 1)
		at: 1 put: cthe;
		at: 2 put: 0.0d;
		at: 3 put: sthe.
	(answer at: 2)
		at: 1 put: 0.0d;
		at: 2 put: 1.0d;
		at: 3 put: 0.0d.
	(answer at: 3)
		at: 1 put: 0.0d - sthe;
		at: 2 put: 0.0d;
		at: 3 put: cthe.
	^answer
]

{ #category : #calc }
GEOEulerAngles >> rotatez: the [ 
	| sthe cthe answer |
	sthe := the sin.
	cthe := the cos.
	answer := FullMatrix new: 3 by: 3.
	(answer at: 1)
		at: 1 put: cthe;
		at: 2 put: 0.0d - sthe;
		at: 3 put: 0.0d.
	(answer at: 2)
		at: 1 put: sthe;
		at: 2 put: cthe;
		at: 3 put: 0.0d.
	(answer at: 3)
		at: 1 put: 0.0d;
		at: 2 put: 0.0d;
		at: 3 put: 1.0d.
	^answer
]
