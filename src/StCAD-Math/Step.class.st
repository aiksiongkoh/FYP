Class {
	#name : #Step,
	#superclass : #PiecewiseFunction,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #'initialize-release' }
Step >> x: arg x1: argx1 y1: argy1 y2: argy2 [ 
	| x1 y1 y2 |
	x := self conditionArgument: arg.
	x1 := self conditionArgument: argx1.
	y1 := self conditionArgument: argy1.
	y2 := self conditionArgument: argy2.
	functions := OrderedCollection new.
	functions add: y1.
	functions add: y2.
	transitions := OrderedCollection new.
	transitions add: x1
]
