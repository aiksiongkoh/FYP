"
SmoothAbs fits a parabola near the origin (-epsilon < x < epsilon) to avoid discontinuous first derivative.
f(x) = |x| 				x < -epsilon, x > epsilon.
f(x) = a + c*x*x.		-epsilon < x < epsilon
a + c*eps*eps = eps
2*c*eps = 1
c = 1/(2*eps)
a = eps - (eps/2) = eps/2

Instance Variables:

epsilon	<StMConstant>	f(x) = a + c*x*x.		-epsilon < x < epsilon
"
Class {
	#name : #SmoothAbs,
	#superclass : #PiecewiseFunction,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #'VisualWorks metadata' }
SmoothAbs class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
SmoothAbs class >> with: var epsilon: xx1 [ 
	^super new x: var epsilon: xx1
]

{ #category : #'initialize-release' }
SmoothAbs >> x: arg epsilon: eps [ 
	| a b c coeffs epsilon |
	x := self conditionArgument: arg.
	epsilon := self conditionArgument: eps.
	a := epsilon times: 0.5d.
	b := Constant with: 0.0d.
	c := (epsilon times: 2.0d) reciprocal.
	coeffs := Array
				with: a
				with: b
				with: c.
	functions := Array new: 3.
	functions at: 1 put: (Abs with: x).
	functions at: 2 put: (Polynomial with: x coeffs: coeffs).
	functions at: 3 put: (Abs with: x).
	transitions := Array new: 2.
	transitions at: 1 put: epsilon negated.
	transitions at: 2 put: epsilon
]
