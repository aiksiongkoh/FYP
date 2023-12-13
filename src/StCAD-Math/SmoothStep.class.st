Class {
	#name : #SmoothStep,
	#superclass : #PiecewiseFunction,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #'VisualWorks metadata' }
SmoothStep class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
SmoothStep class >> with: variable x1: xx1 y1: yy1 x2: xx2 y2: yy2 [ 
	^super new
		x: variable
		x1: xx1
		y1: yy1
		x2: xx2
		y2: yy2
]

{ #category : #'initialize-release' }
SmoothStep >> x: arg x1: argx1 y1: argy1 x2: argx2 y2: argy2 [ 
	| x1 y1 x2 y2 |
	x := self conditionArgument: arg.
	x1 := self conditionArgument: argx1.
	y1 := self conditionArgument: argy1.
	x2 := self conditionArgument: argx2.
	y2 := self conditionArgument: argy2.
	functions := Array new: 3.
	functions at: 1 put: y1.
	functions at: 2 put: (self
			transitionFunctionx1: x1
			y1: y1
			x2: x2
			y2: y2).
	functions at: 3 put: y2.
	transitions := Array new: 2.
	transitions at: 1 put: x1.
	transitions at: 2 put: x2
]
