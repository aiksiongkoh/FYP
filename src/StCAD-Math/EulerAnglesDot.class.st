Class {
	#name : #EulerAnglesDot,
	#superclass : #EulerArray,
	#type : #variable,
	#instVars : [
		'aEulerAngles',
		'cAdot',
		'aAdot',
		'omeF',
		'omef'
	],
	#category : #'StCAD-Math-StMathArray'
}

{ #category : #accessing }
EulerAnglesDot >> aAdot [
	^aAdot
]

{ #category : #accessing }
EulerAnglesDot >> aEulerAngles [
	^aEulerAngles
]

{ #category : #accessing }
EulerAnglesDot >> aTime [
	^aEulerAngles aTime
]

{ #category : #accessing }
EulerAnglesDot >> cA [
	^aEulerAngles cA
]

{ #category : #accessing }
EulerAnglesDot >> cAdot [
	^cAdot
]

{ #category : #calc }
EulerAnglesDot >> calc [
	| rotOrder cA |
	aEulerAngles calc.
	rotOrder := aEulerAngles rotOrder.
	cA := aEulerAngles cA.
	cAdot := Array new: 3.
	1 to: 3
		do: 
			[:i | 
			| axis angle angleDot matAdot |
			axis := rotOrder at: i.
			angle := (aEulerAngles at: i) value.
			angleDot := (self at: i) value.
			matAdot := axis == 1 
						ifTrue: [FullMatrix rotatex: angle rotDot: angleDot]
						ifFalse: 
							[axis == 2 
								ifTrue: [FullMatrix rotatey: angle rotDot: angleDot]
								ifFalse: 
									[axis == 3 
										ifTrue: [FullMatrix rotatez: angle rotDot: angleDot]
										ifFalse: 
											[self 
												error: 'Euler angle rotation order must be any permutation of 1,2,3 without consecutive repeats.']]].
			cAdot at: i put: matAdot].
	aAdot := ((cAdot at: 1) 
				timesFullMatrix: ((cA at: 2) timesFullMatrix: (cA at: 3))) 
					+ ((cA at: 1) timesFullMatrix: ((cAdot at: 2) timesFullMatrix: (cA at: 3))) 
					+ ((cA at: 1) timesFullMatrix: ((cA at: 2) timesFullMatrix: (cAdot at: 3))).
	omeF := ((((cA at: 1) column: 1) times: (self at: 1)) 
				+ ((((cA at: 1) timesFullMatrix: (cA at: 2)) column: 2) times: (self at: 2)) 
					+ ((aEulerAngles aA column: 3) times: (self at: 3))) simplified.
	omef := (aEulerAngles aA transposeTimesFullColumn: omeF) simplified
]

{ #category : #calc }
EulerAnglesDot >> calcSymbolic [
	| rotOrder cA |
	aEulerAngles calcSymbolic.
	rotOrder := aEulerAngles rotOrder.
	cA := aEulerAngles cA.
	cAdot := Array new: 3.
	1 to: 3
		do: 
			[:i | 
			| axis angle angleDot matAdot |
			axis := rotOrder at: i.
			angle := aEulerAngles at: i.
			angleDot := self at: i.
			matAdot := axis == 1 
						ifTrue: [FullMatrix rotateSymbolicx: angle rotDot: angleDot]
						ifFalse: 
							[axis == 2 
								ifTrue: [FullMatrix rotateSymbolicy: angle rotDot: angleDot]
								ifFalse: 
									[axis == 3 
										ifTrue: [FullMatrix rotateSymbolicz: angle rotDot: angleDot]
										ifFalse: 
											[self 
												error: 'Euler angle rotation order must be any permutation of 1,2,3 without consecutive repeats.']]].
			cAdot at: i put: matAdot].
	aAdot := ((cAdot at: 1) 
				timesFullMatrix: ((cA at: 2) timesFullMatrix: (cA at: 3))) 
					+ ((cA at: 1) timesFullMatrix: ((cAdot at: 2) timesFullMatrix: (cA at: 3))) 
					+ ((cA at: 1) timesFullMatrix: ((cA at: 2) timesFullMatrix: (cAdot at: 3))).
	omeF := ((((cA at: 1) column: 1) times: (self at: 1)) 
				+ ((((cA at: 1) timesFullMatrix: (cA at: 2)) column: 2) times: (self at: 2)) 
					+ ((aEulerAngles aA column: 3) times: (self at: 3))) simplified.
	omef := (aEulerAngles aA transposeTimesFullColumn: omeF) simplified
]

{ #category : #calc }
EulerAnglesDot >> differentiateWRT: var [ 
	| answer |
	answer := EulerAnglesDDot with: self.
	1 to: 3
		do: 
			[:i | 
			| angleVel angleAcc |
			angleVel := self at: i.
			angleAcc := (angleVel differentiateWRT: var) simplified.
			answer at: i put: angleAcc].
	^answer
]

{ #category : #'initialize-release' }
EulerAnglesDot >> initialize: angle [ 
	aEulerAngles := angle
]

{ #category : #accessing }
EulerAnglesDot >> omeF [
	^omeF
]

{ #category : #accessing }
EulerAnglesDot >> omef [
	^omef
]

{ #category : #accessing }
EulerAnglesDot >> rotOrder [
	^aEulerAngles rotOrder
]

{ #category : #'basic ops' }
EulerAnglesDot >> simplified [
	| answer |
	answer := super simplified.
	answer initialize: aEulerAngles.
	^answer
]
