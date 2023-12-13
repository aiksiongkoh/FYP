Class {
	#name : #StableBackwardDifference,
	#superclass : #LinearMultiStepMethod,
	#category : #'StCAD-Math-StMathDifferenceOperator'
}

{ #category : #'VisualWorks metadata' }
StableBackwardDifference class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #calc }
StableBackwardDifference >> derivative: n at: t present: y past: ypast [ 
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
StableBackwardDifference >> derivative: i present: y past1: ypast [ 
	"Answer ith derivative given present value and past values."

	| series |
	i == 0 ifTrue: [^y copy].
	series := MathArray new: order.
	1 to: order do: [:j | series at: j put: (ypast at: j)
				- y].
	^(operatorMatrix at: i)
		dot: series
]

{ #category : #calc }
StableBackwardDifference >> derivative: i present: y past: ypast [ 
	"Answer ith derivative given present value and past values."

	| series |
	^i == 0
		ifTrue: [y copy]
		ifFalse: [i <= order
				ifTrue: 
					[series := MathArray new: order.
					1 to: order do: [:j | series at: j put: (ypast at: j)
								- y].
					(operatorMatrix at: i)
						dot: series]
				ifFalse: [y zeroCopy]]
]

{ #category : #calc }
StableBackwardDifference >> derivative: n present: y past: ypast presentDerivative: ydot pastDerivative: ydotpast [ 
	^self
		derivative: n
		present: y
		past: ypast
]

{ #category : #calc }
StableBackwardDifference >> derivative: i with: series [ 
	| y ypast |
	y := series at: 1.
	ypast := series copyFrom: 2 to: order + 1.
	^self
		derivative: i
		present: y
		past: ypast
]

{ #category : #calc }
StableBackwardDifference >> formSmallerTaylorMatrix [
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
StableBackwardDifference >> formTaylorMatrix [
	"
	This form is numerically more stable and is prefered over the full Taylor Matrix. 
	For method order 3: 
	|	(t1 - t)	(t1 - t)^2/2!		(t1 - t)^3/3!	|	|qd(t)	|	=	|q(t1) - q(t)	| 
	|	(t2 - t)	(t2 - t)^2/2!		(t2 - t)^3/3!	|	|qdd(t)	|		|q(t2) - q(t)	| 
	|	(t3 - t)	(t3 - t)^2/2!		(t3 - t)^3/3!	|	|qddd(t)|		|q(t3) - q(t)	| 
	"

	self instanciateTaylorMatrix.
	1 to: order do: [:i | self
			formTaylorRow: i
			withTimeNode: i
			derivative: 0]
]

{ #category : #calc }
StableBackwardDifference >> formTaylorRow: i withTimeNode: ii derivative: k [ 
	| rowi hi hipower aij |
	rowi := taylorMatrix at: i.
	k > 0
		ifTrue: 
			[1 to: k - 1 do: [:j | rowi at: j put: 0.0d].
			rowi at: k put: 1.0d].
	hi := (timeNodes at: ii)
				- time.
	hipower := 1.0d.
	k + 1 to: order
		do: 
			[:j | 
			hipower := hipower * hi.
			aij := hipower * (OneOverFactorials at: j - k).
			rowi at: j put: aij]
]

{ #category : #calc }
StableBackwardDifference >> instanciateTaylorMatrix [
	(taylorMatrix isNil or: [taylorMatrix nrow ~= order])
		ifTrue: [taylorMatrix := FullMatrix new: order by: order]
]

{ #category : #accessing }
StableBackwardDifference >> order: integer [ 
	"Method order of formula."

	order := integer
]

{ #category : #calc }
StableBackwardDifference >> pvdotpv [
	"pvdotpv := operatorMatrix timesColumn: #(-1.0d ... -1.0d)."

	| row1 sum |
	row1 := operatorMatrix at: 1.
	sum := 0.0d.
	1 to: order do: [:i | sum := sum - (row1 at: i)].
	^sum
]
