"
f(x) = 0								x < x1
f(x) = c + Asin(ome*x + phi)		x1 <= x < x2
f(x) = 0								x2 <= x

c + A*sin(ome*x1 + phi) = y1
c + A*sin(ome*x2 + phi) = y2
A*ome*cos(ome*x1 + phi) = 0
A*ome*cos(ome*x2 + phi) = 0

ome*x1 + phi = -pi/2
ome*x2 + phi = +pi/2
ome = pi/(x2 - x1)
phi = pi/2 - pi*x2/(x2-x1) = pi*(x2 - x1 - 2*x2)/2*(x2 - x1) = pi*(x1 + x2)/2*(x1 - x2)
c - A = y1
c + A = y2
c = (y1 + y2)/2
A = (y2 - y1)/2

Instance Variables:

sineFunction	<ClassOfVariable>	description of variable's function
"
Class {
	#name : #SmoothSineStep,
	#superclass : #SmoothStep,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #calc }
SmoothSineStep >> transitionFunctionx1: x1 y1: y1 x2: x2 y2: y2 [ 
	| c A ome phi |
	c := (y1 plus: y2)
				times: 0.5d.
	A := (y2 plus: y1 negated)
				times: 0.5d.
	ome := (x2 plus: x1 negated) reciprocal times: Double pi.
	phi := ((x1 plus: x2)
				times: (x1 plus: x2 negated) reciprocal)
				times: Double pi / 2.0d.
	^(c plus: (A times: (Sin with: ((ome times: x)
					plus: phi)))) simplified
]
