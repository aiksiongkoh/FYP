Class {
	#name : #BackwardDifference,
	#superclass : #LinearMultiStepMethod,
	#category : #'StCAD-Math-StMathDifferenceOperator'
}

{ #category : #'VisualWorks metadata' }
BackwardDifference class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #calc }
BackwardDifference >> derivative: n at: t present: y past: ypast [ 
	"Interpolate or extrapolate."
	"dfdt(t) = df0dt + d2f0dt2*(t - t0) + d3f0dt3*(t - t0)^2 / 2! + ..."

	| answer dt dtpower diydti |
	answer := self
				derivative: n
				present: y
				past: ypast.
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
								past: ypast.
					dtpower := dtpower * dt.
					answer isReal
						ifTrue: [answer := answer + (diydti * dtpower * (OneOverFactorials at: i - n))]
						ifFalse: [answer equalSelfPlus: diydti times: dtpower * (OneOverFactorials at: i - n)]]].
	^answer
]

{ #category : #calc }
BackwardDifference >> derivative: i present: y past: ypast [ 
	"Answer ith derivative given present value and past values."

	| series |
	i == 0 ifTrue: [^y copy].
	series := MathArray new: order + 1.
	series at: 1 put: y.
	2 to: order + 1 do: [:j | series at: j put: (ypast at: j - 1)].
	^(operatorMatrix at: i + 1)
		dot: series
]

{ #category : #calc }
BackwardDifference >> derivative: n present: y past: ypast presentDerivative: ydot pastDerivative: ydotpast [ 
	^self
		derivative: n
		present: y
		past: ypast
]

{ #category : #calc }
BackwardDifference >> derivative: i with: series [ 
	"Answer ith derivative given present value and past values in series."

	i == 0 ifTrue: [^(series at: 1) copy].
	^super derivative: i with: series
]

{ #category : #calc }
BackwardDifference >> formSmallerTaylorMatrix [
	"
	This form is numerically more stable and is prefered over the full Taylor Matrix. 
	For method order 3: 
	|	(t1 - t)	(t1 - t)^2/2!		(t1 - t)^3/3!	|	|qd(t)	|	=	|q(t1) - q(t)	| 
	|	(t2 - t)	(t2 - t)^2/2!		(t2 - t)^3/3!	|	|qdd(t)	|		|q(t2) - q(t)	| 
	|	(t3 - t)	(t3 - t)^2/2!		(t3 - t)^3/3!	|	|qddd(t)|		|q(t3) - q(t)	| 
	"

	self instanciateSmallerTaylorMatrix.
	1 to: order do: [:i | self
			formSmallerTaylorRow: i
			withTimeNode: i
			derivative: 0]
]

{ #category : #calc }
BackwardDifference >> formTaylorMatrix [
	"
	For method order 3: 
	|	1		0		0				0		|	|q(t)	|	=	|q(t)	| 
	|	1	(t1 - t)	(t1 - t)^2/2!		(t1 - t)^3/3!	|	|qd(t)	|		|q(t1)	| 
	|	1	(t2 - t)	(t2 - t)^2/2!		(t2 - t)^3/3!	|	|qdd(t)	|		|q(t2)	| 
	|	1	(t3 - t)	(t3 - t)^2/2!		(t3 - t)^3/3!	|	|qddd(t)|		|q(t3)	| 
	"

	self instanciateTaylorMatrix.
	self formDegenerateTaylorRow: 1.
	2 to: order + 1 do: [:i | self
			formTaylorRow: i
			withTimeNode: i - 1
			derivative: 0]
]

{ #category : #calc }
BackwardDifference >> pvdotpv [
	^operatorMatrix at: 2 and: 1
]

{ #category : #calc }
BackwardDifference >> valueAt: t present: y past: ypast [ 
	^self
		derivative: 0
		at: t
		present: y
		past: ypast
]

{ #category : #calc }
BackwardDifference >> valuedotWith: y past: ypast [ 
	^self
		derivative: 1
		present: y
		past: ypast
]
