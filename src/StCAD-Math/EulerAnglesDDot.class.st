Class {
	#name : #EulerAnglesDDot,
	#superclass : #EulerArray,
	#type : #variable,
	#instVars : [
		'aEulerAnglesDot',
		'cAddot',
		'aAddot',
		'alpF',
		'alpf'
	],
	#category : #'StCAD-Math-StMathArray'
}

{ #category : #accessing }
EulerAnglesDDot >> aAddot [
	^aAddot
]

{ #category : #accessing }
EulerAnglesDDot >> aEulerAngles [
	^aEulerAnglesDot aEulerAngles
]

{ #category : #accessing }
EulerAnglesDDot >> aEulerAnglesDot [
	^aEulerAnglesDot
]

{ #category : #accessing }
EulerAnglesDDot >> aTime [
	^aEulerAnglesDot aTime
]

{ #category : #accessing }
EulerAnglesDDot >> alpF [
	^alpF
]

{ #category : #accessing }
EulerAnglesDDot >> alpF: anObject [
	alpF := anObject
]

{ #category : #accessing }
EulerAnglesDDot >> alpf [
	^alpf
]

{ #category : #accessing }
EulerAnglesDDot >> alpf: anObject [
	^alpf := anObject
]

{ #category : #accessing }
EulerAnglesDDot >> cAddot [
	^cAddot
]

{ #category : #calc }
EulerAnglesDDot >> calc [
	| rotOrder cA cAdot |
	aEulerAnglesDot calc.
	rotOrder := aEulerAnglesDot rotOrder.
	cA := aEulerAnglesDot cA.
	cAdot := aEulerAnglesDot cAdot.
	cAddot := Array new: 3.
	1 to: 3
		do: 
			[:i | 
			| axis angle angleDot angleDDot matAddot |
			axis := rotOrder at: i.
			angle := (aEulerAnglesDot aEulerAngles at: i) value.
			angleDot := (aEulerAnglesDot at: i) value.
			angleDDot := (self at: i) value.
			matAddot := axis == 1 
						ifTrue: 
							[FullMatrix 
								rotatex: angle
								rotDot: angleDot
								rotDDot: angleDDot]
						ifFalse: 
							[axis == 2 
								ifTrue: 
									[FullMatrix 
										rotatey: angle
										rotDot: angleDot
										rotDDot: angleDDot]
								ifFalse: 
									[axis == 3 
										ifTrue: 
											[FullMatrix 
												rotatez: angle
												rotDot: angleDot
												rotDDot: angleDDot]
										ifFalse: 
											[self 
												error: 'Euler angle rotation order must be any permutation of 1,2,3 without consecutive repeats.']]].
			cAddot at: i put: matAddot].
	aAddot := ((cAddot at: 1) 
				timesFullMatrix: ((cA at: 2) timesFullMatrix: (cA at: 3))) 
					+ ((cAdot at: 1) 
							timesFullMatrix: ((cAdot at: 2) timesFullMatrix: (cA at: 3))) 
					+ ((cAdot at: 1) 
							timesFullMatrix: ((cA at: 2) timesFullMatrix: (cAdot at: 3))) 
					+ ((cAdot at: 1) 
							timesFullMatrix: ((cAdot at: 2) timesFullMatrix: (cA at: 3))) 
					+ ((cA at: 1) timesFullMatrix: ((cAddot at: 2) timesFullMatrix: (cA at: 3))) 
					+ ((cA at: 1) 
							timesFullMatrix: ((cAdot at: 2) timesFullMatrix: (cAdot at: 3))) 
					+ ((cAdot at: 1) 
							timesFullMatrix: ((cA at: 2) timesFullMatrix: (cAdot at: 3))) 
					+ ((cA at: 1) 
							timesFullMatrix: ((cAdot at: 2) timesFullMatrix: (cAdot at: 3))) 
					+ ((cA at: 1) timesFullMatrix: ((cA at: 2) timesFullMatrix: (cAddot at: 3)))
]

{ #category : #calc }
EulerAnglesDDot >> calcSymbolic [
	| rotOrder cA cAdot aTime |
	aEulerAnglesDot calcSymbolic.
	rotOrder := aEulerAnglesDot rotOrder.
	cA := aEulerAnglesDot cA.
	cAdot := aEulerAnglesDot cAdot.
	cAddot := Array new: 3.
	1 to: 3
		do: 
			[:i | 
			| axis angle angleDot angleDDot matAddot |
			axis := rotOrder at: i.
			angle := aEulerAnglesDot aEulerAngles at: i.
			angleDot := aEulerAnglesDot at: i.
			angleDDot := self at: i.
			matAddot := axis == 1 
						ifTrue: 
							[FullMatrix 
								rotateSymbolicx: angle
								rotDot: angleDot
								rotDDot: angleDDot]
						ifFalse: 
							[axis == 2 
								ifTrue: 
									[FullMatrix 
										rotateSymbolicy: angle
										rotDot: angleDot
										rotDDot: angleDDot]
								ifFalse: 
									[axis == 3 
										ifTrue: 
											[FullMatrix 
												rotateSymbolicz: angle
												rotDot: angleDot
												rotDDot: angleDDot]
										ifFalse: 
											[self 
												error: 'Euler angle rotation order must be any permutation of 1,2,3 without consecutive repeats.']]].
			cAddot at: i put: matAddot].
	aAddot := ((cAddot at: 1) 
				timesFullMatrix: ((cA at: 2) timesFullMatrix: (cA at: 3))) 
					+ ((cAdot at: 1) 
							timesFullMatrix: ((cAdot at: 2) timesFullMatrix: (cA at: 3))) 
					+ ((cAdot at: 1) 
							timesFullMatrix: ((cA at: 2) timesFullMatrix: (cAdot at: 3))) 
					+ ((cAdot at: 1) 
							timesFullMatrix: ((cAdot at: 2) timesFullMatrix: (cA at: 3))) 
					+ ((cA at: 1) timesFullMatrix: ((cAddot at: 2) timesFullMatrix: (cA at: 3))) 
					+ ((cA at: 1) 
							timesFullMatrix: ((cAdot at: 2) timesFullMatrix: (cAdot at: 3))) 
					+ ((cAdot at: 1) 
							timesFullMatrix: ((cA at: 2) timesFullMatrix: (cAdot at: 3))) 
					+ ((cA at: 1) 
							timesFullMatrix: ((cAdot at: 2) timesFullMatrix: (cAdot at: 3))) 
					+ ((cA at: 1) timesFullMatrix: ((cA at: 2) timesFullMatrix: (cAddot at: 3))).
	aTime := self aTime.
	aTime ifNil: 
			[| zero zeroCol |
			zero := 0 asConstant.
			zeroCol := FullColumn 
						with: zero
						with: zero
						with: zero.
			alpF := zeroCol.
			alpf := zeroCol]
		ifNotNil: 
			[alpF := aEulerAnglesDot omeF differentiateWRT: aTime.
			alpf := aEulerAnglesDot omef differentiateWRT: aTime]
]

{ #category : #'initialize-release' }
EulerAnglesDDot >> initialize: angledot [ 
	aEulerAnglesDot := angledot
]

{ #category : #accessing }
EulerAnglesDDot >> rotOrder [
	^aEulerAnglesDot rotOrder
]

{ #category : #'basic ops' }
EulerAnglesDDot >> simplified [
	| answer |
	answer := super simplified.
	answer initialize: aEulerAnglesDot.
	^answer
]
