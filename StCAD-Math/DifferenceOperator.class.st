"
Difference operators. Good for variable step sizes.
Taylor series is used to obtain the difference formulas.
Let  t4 < t3 < t2 < t1.
q(t) 	= q(t)
q(t1) 	= q(t) + qd(t)(t1 - t) + qdd(t)(t1 - t)^2/2! + qddd(t)(t1 - t)^3/3! +... + O((t1 - t)^n)
q(t2) 	= q(t) + qd(t)(t2 - t) + qdd(t)(t2 - t)^2/2! + qddd(t)(t2 - t)^3/3! +... + O((t2 - t)^n)
q(t3) 	= q(t) + qd(t)(t3 - t) + qdd(t)(t3 - t)^2/2! + qddd(t)(t3 - t)^3/3! +... + O((t3 - t)^n)
...
q(tm) 	= q(t) + qd(t)(tm - t) + qdd(t)(tm - t)^2/2! + qddd(t)(tm - t)^3/3! +... + O((tm - t)^n)
In matrix form:
|	1		0		0				0		|	|q(t)	|	=	|q(t)	|
|	1	(t1 - t)	(t1 - t)^2/2!		(t1 - t)^3/3!	|	|qd(t)	|		|q(t1)	|
|	1	(t2 - t)	(t2 - t)^2/2!		(t2 - t)^3/3!	|	|qdd(t)	|		|q(t2)	|
|	1	(t3 - t)	(t3 - t)^2/2!		(t3 - t)^3/3!	|	|qddd(t)|		|q(t3)	|
|	1	(t4 - t)	(t4 - t)^2/2!		(t4 - t)^3/3!	|					|q(t4)	|

For extrapolation and interpolation use the lower four equations and solve for q(t),...,qddd(t) from q(t1),...,q(t4).
For method order 3:
|	1	(t1 - t)	(t1 - t)^2/2!		(t1 - t)^3/3!	|	|q(t)	|	=	|q(t1)	|
|	1	(t2 - t)	(t2 - t)^2/2!		(t2 - t)^3/3!	|	|qd(t)	|		|q(t2)	|
|	1	(t3 - t)	(t3 - t)^2/2!		(t3 - t)^3/3!	|	|qdd(t)	|		|q(t3)	|
|	1	(t4 - t)	(t4 - t)^2/2!		(t4 - t)^3/3!	|	|qddd(t)|		|q(t4)	|

For numerical differentiation, use the upper four equations and solver for qd(t),...,qddd(t) from q(t),...,q(t4).
For method order 3:
|	1		0		0				0		|	|q(t)	|	=	|q(t)	|
|	1	(t1 - t)	(t1 - t)^2/2!		(t1 - t)^3/3!	|	|qd(t)	|		|q(t1)	|
|	1	(t2 - t)	(t2 - t)^2/2!		(t2 - t)^3/3!	|	|qdd(t)	|		|q(t2)	|
|	1	(t3 - t)	(t3 - t)^2/2!		(t3 - t)^3/3!	|	|qddd(t)|		|q(t3)	|
or
|   (t1 - t)	(t1 - t)^2/2!		(t1 - t)^3/3!	|	|qd(t)	|	=	|q(t1) - q(t)	|
|   (t2 - t)	(t2 - t)^2/2!		(t2 - t)^3/3!	|	|qdd(t)	|		|q(t2) - q(t)	|
|	1			(t2 - t)		(t2 - t)^2/2!	|	|qddd(t)|		|qd(t2)		|

Instance Variables:

iStep	<Integer>	step number for present time in integration process.
nStep	<Integer>	number of steps used by formula.
order	<Integer>	method order of formula, i.e. truncation error is O(h^order+1).
coeffs	<StMFullMatrix>	inverse matrix to operation on input series to give answer.
time	<Double>	present time for answer.
timeNodes	<OrderedCollection>	past times in increasing past. t4 < t3 < t2 < t1.

Class Variables:

OneOverFactorials	<ClassOfVariable>	description of variable''s function
VectorFactorial	<ClassOfVariable>	description of variable''s function
"
Class {
	#name : #DifferenceOperator,
	#superclass : #Object,
	#instVars : [
		'iStep',
		'order',
		'taylorMatrix',
		'operatorMatrix',
		'time',
		'timeNodes'
	],
	#classVars : [
		'Math'
	],
	#category : #'StCAD-Math-StMathDifferenceOperator'
}

{ #category : #'class initialization' }
DifferenceOperator class >> initialize [
	"StMDifferenceOperator initialize."

	OneOverFactorials := FullRow new: 10.
	1 to: OneOverFactorials size do: [:i | OneOverFactorials at: i put: 1.0d / i factorial]
]

{ #category : #'instance creation' }
DifferenceOperator class >> new [
	^super new initialize
]

{ #category : #'VisualWorks metadata' }
DifferenceOperator class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
	)

]

{ #category : #calc }
DifferenceOperator >> calcOperatorMatrix [
	"Compute operatorMatrix such that 
	value?(time) := (operatorMatrix at: 1) timesColumn: series. 
	value?dot(time) := (operatorMatrix at: 2) timesColumn: series. 
	value?ddot(time) := (operatorMatrix at: 3) timesColumn: series."

	self formTaylorMatrix.
	operatorMatrix := [LDUFullMatParPv new inverse: taylorMatrix saveOriginal: false]
				on: SingularMatrixError do: [:ex | ex resume]
]

{ #category : #accessing }
DifferenceOperator >> currentStepSize [
	^time - (timeNodes at: 1)
]

{ #category : #calc }
DifferenceOperator >> derivative: i with: series [ 
	"Answer ith derivative given past values in series."

	^(operatorMatrix at: i + 1)
		dot: series
]

{ #category : #accessing }
DifferenceOperator >> direction [
	^(timeNodes at: 1)
		< time
		ifTrue: [1.0d]
		ifFalse: [-1.0d]
]

{ #category : #calc }
DifferenceOperator >> formDegenerateTaylorRow: i [ 
	| rowi |
	rowi := taylorMatrix at: i.
	rowi at: 1 put: 1.0d.
	2 to: order + 1 do: [:j | rowi at: j put: 0.0d]
]

{ #category : #calc }
DifferenceOperator >> formTaylorMatrix [
	self subclassResponsibility
]

{ #category : #calc }
DifferenceOperator >> formTaylorRow: i withTimeNode: ii derivative: k [ 
	| rowi hi hipower aij |
	rowi := taylorMatrix at: i.
	1 to: k do: [:j | rowi at: j put: 0.0d].
	rowi at: k + 1 put: 1.0d.
	hi := (timeNodes at: ii)
				- time.
	hipower := 1.0d.
	k + 2 to: order + 1
		do: 
			[:j | 
			hipower := hipower * hi.
			aij := hipower * (OneOverFactorials at: j - k - 1).
			rowi at: j put: aij]
]

{ #category : #accessing }
DifferenceOperator >> iStep: integer [ 
	"iStep is the current step of interest."

	iStep := integer
]

{ #category : #'initialize-release' }
DifferenceOperator >> initialize [
	"Do nothing."
]

{ #category : #calc }
DifferenceOperator >> instanciateTaylorMatrix [
	(taylorMatrix isNil or: [taylorMatrix nrow ~= (order + 1)])
		ifTrue: [taylorMatrix := FullMatrix new: order + 1 by: order + 1]
]

{ #category : #testing }
DifferenceOperator >> isConstantStepFor: nsteps [ 
	| nPastNodes dt tol dti |
	nPastNodes := timeNodes size.
	nPastNodes < nsteps ifTrue: [^false].
	dt := time - (timeNodes at: 1).
	tol := 1.0d-6 * dt abs.
	2 to: nsteps
		do: 
			[:i | 
			dti := (timeNodes at: i - 1)
						- (timeNodes at: i).
			(dti - dt) abs > tol ifTrue: [^false]].
	^true
]

{ #category : #testing }
DifferenceOperator >> isDecreasingStepFor: nsteps [ 
	| nPastNodes oneMinusTolFactor dtPast dtNow |
	nPastNodes := timeNodes size.
	nPastNodes < nsteps ifTrue: [^false].
	oneMinusTolFactor := 1.0d - 1.0d-6.
	dtPast := time - (timeNodes at: 1).
	dtPast := dtPast abs.
	2 to: nsteps
		do: 
			[:i | 
			dtNow := dtPast.
			dtPast := (timeNodes at: i - 1)
						- (timeNodes at: i).
			dtPast := dtPast abs.
			dtNow > oneMinusTolFactor * dtPast ifTrue: [^false]].
	^true
]

{ #category : #testing }
DifferenceOperator >> isIncreasingStepFor: nsteps [ 
	| nPastNodes onePlusTolFactor dtPast dtNow |
	nPastNodes := timeNodes size.
	nPastNodes < (nsteps + 1) ifTrue: [^false].
	onePlusTolFactor := 1.0d + 1.0d-6.
	dtPast := time - (timeNodes at: 1).
	dtPast := dtPast abs.
	2 to: nsteps + 1
		do: 
			[:i | 
			dtNow := dtPast.
			dtPast := (timeNodes at: i - 1)
						- (timeNodes at: i).
			dtPast := dtPast abs.
			dtNow < (onePlusTolFactor * dtPast) ifTrue: [^false]].
	^true
]

{ #category : #accessing }
DifferenceOperator >> nStep [
	^order
]

{ #category : #accessing }
DifferenceOperator >> operatorMatrix [
	^operatorMatrix
]

{ #category : #accessing }
DifferenceOperator >> order [
	^order
]

{ #category : #accessing }
DifferenceOperator >> order: integer [ 
	"Method order of formula."

	order := integer
]

{ #category : #accessing }
DifferenceOperator >> time [
	^time
]

{ #category : #accessing }
DifferenceOperator >> time: double [ 
	time := double
]

{ #category : #accessing }
DifferenceOperator >> timeNodes [
	^timeNodes
]

{ #category : #accessing }
DifferenceOperator >> timeNodes: row [ 
	"Row of past times in order of increasing past."

	timeNodes := row
]

{ #category : #calc }
DifferenceOperator >> valueWith: series [ 
	"series stores past values for Extrapolator."
	"series stores present and past values for BackwardDifference."

	^self derivative: 0 with: series
]

{ #category : #calc }
DifferenceOperator >> valueddddotWith: series [ 
	"series stores past values for Extrapolator."
	"series stores present and past values for BackwardDifference."

	^self derivative: 4 with: series
]

{ #category : #calc }
DifferenceOperator >> valuedddotWith: series [ 
	"series stores past values for Extrapolator."
	"series stores present and past values for BackwardDifference."

	^self derivative: 3 with: series
]

{ #category : #calc }
DifferenceOperator >> valueddotWith: series [ 
	"series stores past values for Extrapolator."
	"series stores present and past values for BackwardDifference."

	^self derivative: 2 with: series
]

{ #category : #calc }
DifferenceOperator >> valuedotWith: series [ 
	"series stores past values for Extrapolator."
	"series stores present and past values for BackwardDifference."

	^self derivative: 1 with: series
]
