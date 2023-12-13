Class {
	#name : #NonlinearEquationSolver,
	#superclass : #Solver,
	#instVars : [
		'n',
		'vars',
		'eqns',
		'jacobian'
	],
	#category : #'StCAD-Math-StMathNewtonRaphson'
}

{ #category : #'instance creation' }
NonlinearEquationSolver class >> new: size [ 
	^super new initialize: size
]

{ #category : #'VisualWorks metadata' }
NonlinearEquationSolver class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #solving }
NonlinearEquationSolver >> dx: dx x: x [ 
	n == 1
		ifTrue: [(vars at: 1)
				value: x]
		ifFalse: [1 to: n do: [:i | (vars at: i)
					value: (x at: i)]]
]

{ #category : #accessing }
NonlinearEquationSolver >> eqnAt: i put: eqn [ 
	eqns at: i put: eqn
]

{ #category : #solving }
NonlinearEquationSolver >> fillErrorVector: y [ 
	1 to: n do: [:i | y at: i put: (eqns at: i) value asDouble]
]

{ #category : #solving }
NonlinearEquationSolver >> fillJacobian: pypx [ 
	| pypxrow jacobianrow |
	1 to: n
		do: 
			[:i | 
			pypxrow := pypx at: i.
			jacobianrow := jacobian at: i.
			1 to: n do: [:j | pypxrow at: j put: (jacobianrow at: j) value asDouble]]
]

{ #category : #solving }
NonlinearEquationSolver >> fillVarVector: x [ 
	1 to: n do: [:i | x at: i put: (vars at: i) value asDouble]
]

{ #category : #'initialize-release' }
NonlinearEquationSolver >> initialize: size [ 
	n := size.
	vars := FullColumn new: size.
	eqns := FullColumn new: size.
	jacobian := FullMatrix new: size by: size
]

{ #category : #accessing }
NonlinearEquationSolver >> n [
	^n
]

{ #category : #solving }
NonlinearEquationSolver >> postNewtonRaphson [
	"Do nothing."
]

{ #category : #solving }
NonlinearEquationSolver >> postNewtonRaphsonIteration [
	"Do nothing."
]

{ #category : #solving }
NonlinearEquationSolver >> preNewtonRaphson [
	| rowi eqni partialij |
	(vars detect: [:var | var value isReal not]
		ifNone: [false])
		ifTrue: [self error: 'Variables must have initial values.'].
	(eqns detect: [:eqn | eqn value isReal not]
		ifNone: [false])
		ifTrue: [self error: 'Equations must be valid.'].
	1 to: n
		do: 
			[:i | 
			rowi := jacobian at: i.
			eqni := eqns at: i.
			1 to: n
				do: 
					[:j | 
					partialij := (eqni partialDifferentiateWRT: (vars at: j)) simplified.
					rowi at: j put: partialij]]
]

{ #category : #solving }
NonlinearEquationSolver >> preNewtonRaphsonIteration [
	"Do nothing."
]

{ #category : #solving }
NonlinearEquationSolver >> pypx [
	^n == 1
		ifTrue: [(jacobian at: 1 and: 1) value asDouble]
		ifFalse: [jacobian collect: [:row | row collect: [:aij | aij value asDouble]]]
]

{ #category : #solving }
NonlinearEquationSolver >> run [
	| newtonRaphson |
	n == 1
		ifTrue: [newtonRaphson := ScalarNewtonRaphson new]
		ifFalse: 
			[newtonRaphson := VectorNewtonRaphson new.
			newtonRaphson x: (FullColumn new: n).
			newtonRaphson y: (FullColumn new: n).
			newtonRaphson pypx: (FullMatrix new: n by: n).
			newtonRaphson matrixSolver: GEFullMatParPv new].
	newtonRaphson system: self.
	newtonRaphson run
]

{ #category : #solving }
NonlinearEquationSolver >> runWithBackTracking [
	| newtonRaphson |
	n == 1
		ifTrue: [newtonRaphson := ScalarNewtonRaphson new]
		ifFalse: 
			[newtonRaphson := VectorNewtonRaphson new.
			newtonRaphson x: (FullColumn new: n).
			newtonRaphson y: (FullColumn new: n).
			newtonRaphson pypx: (FullMatrix new: n by: n).
			newtonRaphson matrixSolver: GEFullMatParPv new].
	newtonRaphson system: self.
	newtonRaphson runWithBackTracking
]

{ #category : #solving }
NonlinearEquationSolver >> updateForNewtonRaphson [
	"Do nothing."
]

{ #category : #solving }
NonlinearEquationSolver >> updateNewtonRaphsonErrorVectorOnly [
	"Do nothing."
]

{ #category : #solving }
NonlinearEquationSolver >> useNewtonRaphsonStats: stats [ 
	"Do nothing."
]

{ #category : #accessing }
NonlinearEquationSolver >> varAt: i put: var [ 
	vars at: i put: var
]

{ #category : #solving }
NonlinearEquationSolver >> x [
	^n == 1
		ifTrue: [(vars at: 1) value asDouble]
		ifFalse: [vars collect: [:var | var value asDouble]]
]

{ #category : #solving }
NonlinearEquationSolver >> y [
	^n == 1
		ifTrue: [(eqns at: 1) value asDouble]
		ifFalse: [eqns collect: [:eqn | eqn value asDouble]]
]
