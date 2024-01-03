Class {
	#name : #LinearMultiStepMethod,
	#superclass : #DifferenceOperator,
	#category : #'StCAD-Math-StMathDifferenceOperator'
}

{ #category : #calc }
LinearMultiStepMethod >> derivative: n at: t present: y past: ypast presentDerivative: ydot pastDerivative: ydotpast [ 
	"Interpolate or extrapolate."
	"dfdt(t) = df0dt + d2f0dt2*(t - t0) + d3f0dt3*(t - t0)^2 / 2! + ..."

	| answer dt dtpower diydti |
	answer := self
				derivative: n
				present: y
				past: ypast
				presentDerivative: ydot
				pastDerivative: ydotpast.
	t = time
		ifFalse: 
			[dt := t - time.
			dtpower := 1.0d.
			n + 1 to: self order
				do: 
					[:i | 
					diydti := self
								derivative: i
								present: y
								past: ypast
								presentDerivative: ydot
								pastDerivative: ydotpast.
					dtpower := dtpower * dt.
					answer isReal
						ifTrue: [answer := answer + (diydti * dtpower * (OneOverFactorials at: i - n))]
						ifFalse: [answer equalSelfPlus: diydti times: dtpower * (OneOverFactorials at: i - n)]]].
	^answer
]

{ #category : #calc }
LinearMultiStepMethod >> derivative: n present: y past: ypast presentDerivative: ydot pastDerivative: ydotpast [ 
	"Answer nth derivative given present value, past values, present first derivative and past first 
	derivatives"

	self subclassResponsibility
]

{ #category : #accessing }
LinearMultiStepMethod >> firstPastTimeNode [
	^timeNodes at: 1
]

{ #category : #calc }
LinearMultiStepMethod >> valueAt: t present: y past: ypast presentDerivative: ydot pastDerivative: ydotpast [ 
	^self
		derivative: 0
		at: t
		present: y
		past: ypast
		presentDerivative: ydot
		pastDerivative: ydotpast
]
