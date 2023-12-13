Class {
	#name : #StableStartingBDF,
	#superclass : #StableBackwardDifference,
	#category : #'StCAD-Math-StMathDifferenceOperator'
}

{ #category : #'VisualWorks metadata' }
StableStartingBDF class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #calc }
StableStartingBDF >> derivative: i present: y past: ypast presentDerivative: ydot pastDerivative: ydotpast [ 
	| series |
	i == 0 ifTrue: [^y copy].
	series := MathArray new: order.
	1 to: order - 1 do: [:j | series at: j put: (ypast at: j)
				- y].
	series at: order put: (ydotpast at: order - 1).
	^(operatorMatrix at: i)
		dot: series
]

{ #category : #calc }
StableStartingBDF >> derivative: i with: series [ 
	self shouldNotImplement
]

{ #category : #calc }
StableStartingBDF >> formTaylorMatrix [
	"
	This form is numerically more stable and is prefered over the full Taylor Matrix. 
	For method order 3: 
	|	(t1 - t)	(t1 - t)^2/2!		(t1 - t)^3/3!	|	|qd(t)	|		|q(t1) - q(t)	| 
	|	(t2 - t)	(t2 - t)^2/2!		(t2 - t)^3/3!	|	|qdd(t)	|		|q(t2) - q(t)	| 
	|		1		(t2 - t)		(t2 - t)^2/2!	|	|qddd(t)|		|qd(t2) 	| 
	"

	self instanciateTaylorMatrix.
	1 to: order - 1 do: [:i | self
			formTaylorRow: i
			withTimeNode: i
			derivative: 0].
	self
		formTaylorRow: order
		withTimeNode: order - 1
		derivative: 1
]

{ #category : #accessing }
StableStartingBDF >> iStep: integer [ 
	"iStep is the current step of interest."
	"iStep must increase consecutively."

	| iStepNew |
	iStepNew := iStep + 1.
	iStepNew == integer
		ifTrue: 
			[iStep := iStepNew.
			order := iStep + 1]
		ifFalse: [self error: 'Not appropriate iStep.']
]

{ #category : #'initialize-release' }
StableStartingBDF >> initialize [
	super initialize.
	iStep := 0.
	order := iStep + 1
]

{ #category : #'initialize-release' }
StableStartingBDF >> initializeLocally [
	self initialize
]

{ #category : #accessing }
StableStartingBDF >> nStep [
	^order - 1
]

{ #category : #accessing }
StableStartingBDF >> order: integer [ 
	"order is controlled by iStep."

	order == integer ifFalse: [self error: 'iStep and order must be consistent.']
]

{ #category : #calc }
StableStartingBDF >> pvdotpv [
	"pvdotpv := operatorMatrix timesColumn: #(-1.0d ... -1.0d, 0.0d)."

	| row1 sum |
	row1 := operatorMatrix at: 1.
	sum := 0.0d.
	1 to: order - 1 do: [:i | sum := sum - (row1 at: i)].
	^sum
]
