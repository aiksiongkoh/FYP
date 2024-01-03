Class {
	#name : #FunctionFromData,
	#superclass : #FunctionXcParameter,
	#instVars : [
		'xvalue',
		'xs',
		'ys'
	],
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #comparing }
FunctionFromData >> = anObject [ 
	^super = anObject and: [xs = anObject xs and: [ys = anObject ys]]
]

{ #category : #evaluating }
FunctionFromData >> differentiateWRT: variable [ 
	| dfdx dxdvar |
	self == variable ifTrue: [^Constant with: 1].
	dfdx := self differentiateWRTx.
	dxdvar := x differentiateWRT: variable.
	^dfdx times: dxdvar
]

{ #category : #evaluating }
FunctionFromData >> expandUntil: set [ 
	| xx copy |
	^(set includes: self)
		ifTrue: [self]
		ifFalse: 
			[xx := x expandUntil: set.
			copy := self shallowCopy.
			copy x: xx.
			xx isConstant
				ifTrue: [Constant with: copy value]
				ifFalse: [copy]]
]

{ #category : #evaluating }
FunctionFromData >> partialDifferentiateWRT: variable [ 
	| dfuncdx dxdvar |
	self == variable ifTrue: [^Constant with: 1].
	dfuncdx := self differentiateWRTx.
	dxdvar := x partialDifferentiateWRT: variable.
	^dfuncdx times: dxdvar
]

{ #category : #copying }
FunctionFromData >> postCopy [
	super postCopy.
	xvalue := xvalue copy.
	xs := xs isSequenceable
				ifTrue: [xs collect: [:item | item copy]]
				ifFalse: [xs copy].
	ys := ys isSequenceable
				ifTrue: [ys collect: [:item | item copy]]
				ifFalse: [ys copy]
]

{ #category : #evaluating }
FunctionFromData >> simplifyUntil: set [ 
	| xx copy |
	^(set includes: self)
		ifTrue: [self]
		ifFalse: 
			[xx := x simplifyUntil: set.
			copy := self shallowCopy.
			copy x: xx.
			xx isConstant
				ifTrue: [Constant with: copy value]
				ifFalse: [copy]]
]

{ #category : #accessing }
FunctionFromData >> xs [
	^xs
]

{ #category : #accessing }
FunctionFromData >> ys [
	^ys
]
