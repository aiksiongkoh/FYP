Class {
	#name : #ArcTan2,
	#superclass : #FunctionXY,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #evaluating }
ArcTan2 >> differentiateWRT: variable [ 
	| arg dargdvar dfuncdarg |
	self == variable ifTrue: [^Constant with: 1].
	arg := y copy times: x copy reciprocal.
	dargdvar := arg differentiateWRT: variable.
	dfuncdarg := ((arg raisedTo: 2)
				plus: 1) reciprocal.
	^dfuncdarg times: dargdvar
]

{ #category : #evaluating }
ArcTan2 >> partialDifferentiateWRT: variable [ 
	| arg dargdvar dfuncdarg |
	self == variable ifTrue: [^Constant with: 1].
	arg := y copy times: x copy reciprocal.
	dargdvar := arg partialDifferentiateWRT: variable.
	dfuncdarg := ((arg raisedTo: 2)
				plus: 1) reciprocal.
	^dfuncdarg times: dargdvar
]

{ #category : #evaluating }
ArcTan2 >> simplifyUntil: set [ 
	| xx yy copy |
	(set includes: self)
		ifTrue: [^self].
	xx := x simplifyUntil: set.
	yy := y simplifyUntil: set.
	copy := self class with: xx with: yy.
	xx isConstant
		ifTrue: [yy isConstant ifTrue: [^Constant with: copy value]]
		ifFalse: [yy isConstant ifTrue: [yy isZero ifTrue: [^Constant with: 0]]].
	^copy
]

{ #category : #evaluating }
ArcTan2 >> value [
	^Double arcTanMpiTOpiY: y value overX: x value
]
