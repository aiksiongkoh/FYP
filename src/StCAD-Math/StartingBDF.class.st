Class {
	#name : #StartingBDF,
	#superclass : #BackwardDifference,
	#category : #'StCAD-Math-StMathDifferenceOperator'
}

{ #category : #'VisualWorks metadata' }
StartingBDF class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #calc }
StartingBDF >> derivative: i present: y past: ypast presentDerivative: ydot pastDerivative: ydotpast [ 
	| series |
	i == 0 ifTrue: [^y copy].
	series := MathArray new: order + 1.
	series at: 1 put: y.
	2 to: order do: [:j | series at: j put: (ypast at: j - 1)].
	series at: order + 1 put: (ydotpast at: order - 1).
	^(operatorMatrix at: i + 1)
		dot: series
]

{ #category : #calc }
StartingBDF >> formSmallerTaylorMatrix [
	"
	This form is numerically more stable and is prefered over the full Taylor Matrix. 
	For method order 3: 
	|	(t1 - t)	(t1 - t)^2/2!		(t1 - t)^3/3!	|	|qd(t)	|		|q(t1) - q(t)	| 
	|	(t2 - t)	(t2 - t)^2/2!		(t2 - t)^3/3!	|	|qdd(t)	|		|q(t2) - q(t)	| 
	|		1		(t2 - t)		(t2 - t)^2/2!	|	|qddd(t)|		|qd(t2) 	| 
	"

	self instanciateSmallerTaylorMatrix.
	1 to: order - 1 do: [:i | self
			formSmallerTaylorRow: i
			withTimeNode: i
			derivative: 0].
	self
		formSmallerTaylorRow: order
		withTimeNode: order - 1
		derivative: 1
]

{ #category : #calc }
StartingBDF >> formTaylorMatrix [
	"
	For method order 3: 
	|	1		0		0				0		|	|q(t)	|	=	|q(t)	| 
	|	1	(t1 - t)	(t1 - t)^2/2!		(t1 - t)^3/3!	|	|qd(t)	|		|q(t1)	| 
	|	1	(t2 - t)	(t2 - t)^2/2!		(t2 - t)^3/3!	|	|qdd(t)	|		|q(t2)	| 
	|	0		1		(t2 - t)		(t2 - t)^2/2!	|	|qddd(t)|		|qd(t2)	| 
	"

	self instanciateTaylorMatrix.
	self formDegenerateTaylorRow: 1.
	2 to: order do: [:i | self
			formTaylorRow: i
			withTimeNode: i - 1
			derivative: 0].
	self
		formTaylorRow: order + 1
		withTimeNode: order - 1
		derivative: 1
]

{ #category : #accessing }
StartingBDF >> iStep: integer [ 
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
StartingBDF >> initialize [
	super initialize.
	iStep := 0.
	order := iStep + 1
]

{ #category : #'initialize-release' }
StartingBDF >> initializeLocally [
	iStep := 0.
	order := iStep + 1.
]

{ #category : #accessing }
StartingBDF >> order: integer [ 
	"order is controlled by iStep."

	order == integer ifFalse: [self error: 'iStep and order must be consistent.']
]
